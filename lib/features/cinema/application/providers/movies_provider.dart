import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movie_repository_provider.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/application/usecases/get_now_playing_movies.dart';
import 'package:cinemapedia_app/features/cinema/application/usecases/get_slide_show_movies.dart';

/// ### Now Playing Movies Provider
/// It is a StateNotifierProvider that provides a list of movies that are currently playing in the cinema. It uses the MoviesNotifier class to manage the state of the movies.
///
/// #### Author:
/// Gonzalo Quedena
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final repository = ref.read(movieRepositoryProvider);
    final getNowPlayingMovies = GetNowPlayingMovies(repository);

    return MoviesNotifier(getNowPlayingMovies: getNowPlayingMovies);
  },
);

/// ### Slide Show Movies Provider
/// It is a StateNotifierProvider that provides a list of movies for the slide show. It uses the SlideShowMoviesNotifier class to manage the state of the movies.
///
/// #### Author:
/// Gonzalo Quedena
final slideShowMoviesProvider =
    StateNotifierProvider<SlideShowMoviesNotifier, List<Movie>>(
  (ref) {
    final repository = ref.read(movieRepositoryProvider);
    final getSlideShowMovies = GetSlideShowMovies(repository);

    return SlideShowMoviesNotifier(getSlideShowMovies: getSlideShowMovies);
  },
);

/// ### MoviesNotifier
/// It is a StateNotifier class that manages the state of the now playing movies. It has a method to load the next page of movies.
///
/// #### Properties:
/// - [currentPage]: The current page of movies.
/// - [getNowPlayingMovies]: The use case to load the now playing movies.
///
/// #### Methods:
/// - [loadNextPage]: It loads the next page of movies.
///
/// #### Author:
/// Gonzalo Quedena
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  final GetNowPlayingMovies getNowPlayingMovies;

  MoviesNotifier({required this.getNowPlayingMovies}) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final movies = await getNowPlayingMovies.call(pageNumber: currentPage);
    state = [...state, ...movies];
  }
}

/// ### SlideShowMoviesNotifier
/// It is a StateNotifier class that manages the state of the slide show movies. It has a method to load the movies for the slide show.
///
/// #### Properties:
/// - [getSlideShowMovies]: The use case to load the slide show movies.
///
/// #### Methods:
/// - [loadSlideShowMovies]: It loads the movies for the slide show.
///
/// #### Author:
/// Gonzalo Quedena
class SlideShowMoviesNotifier extends StateNotifier<List<Movie>> {
  final GetSlideShowMovies getSlideShowMovies;

  SlideShowMoviesNotifier({required this.getSlideShowMovies}) : super([]);

  Future<void> loadSlideShowMovies() async {
    final movies = await getSlideShowMovies.call(end: 6);
    state = movies;
  }
}