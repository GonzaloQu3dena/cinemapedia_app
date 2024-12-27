import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movie_repository_provider.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/application/usecases/get_now_playing_movies.dart';

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

/// ### MoviesNotifier
/// It is a StateNotifier class that manages the state of the movies. It has a method to load the next page of movies.
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
