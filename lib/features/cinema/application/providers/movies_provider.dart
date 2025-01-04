import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movie_repository_provider.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/application/usecases/use_cases.dart';
import 'package:cinemapedia_app/features/cinema/application/usecases/get_movie_by_id.dart';

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

/// ### Upcoming Movies Provider
/// It is a StateNotifierProvider that provides a list of upcoming movies. It uses the UpcomingMoviesNotifier class to manage the state of the movies.
///
/// #### Author:
/// Gonzalo Quedena
final upcomingMoviesProvider =
    StateNotifierProvider<UpcomingMoviesNotifier, List<Movie>>(
  (ref) {
    final repository = ref.read(movieRepositoryProvider);
    final getUpcomingMovies = GetUpcomingMovies(repository);

    return UpcomingMoviesNotifier(getUpcomingMovies: getUpcomingMovies);
  },
);

final popularMoviesProvider =
    StateNotifierProvider<PopularMoviesNotifier, List<Movie>>(
  (ref) {
    final repository = ref.read(movieRepositoryProvider);
    final getPopularMovies = GetPopularMovies(repository);

    return PopularMoviesNotifier(getPopularMovies: getPopularMovies);
  },
);

/// ### Movie By Id Provider
/// It is a StateNotifierProvider that provides a movie by its ID. It uses the MovieByIdNotifier class to manage the state of the movie.
///
/// #### Author:
/// Gonzalo Quedena
final movieByIdProvider =
    StateNotifierProvider.family<MovieByIdNotifier, Movie?, String>(
  (ref, movieId) {
    final repository = ref.read(movieRepositoryProvider);
    final getMovieById = GetMovieById(repository);

    return MovieByIdNotifier(getMovieById: getMovieById, movieId: movieId);
  },
);

/// ### BaseMoviesNotifier
/// It is an abstract class that manages the common state and logic for loading movies.
///
/// #### Properties:
/// - [currentPage]: The current page of movies.
/// - [isLoading]: A flag to indicate if movies are being loaded.
///
/// #### Methods:
/// - [loadMovies]: An abstract method to load movies.
/// - [loadNextPage]: An abstract method to load the next page of movies.
///
/// #### Author:
/// Gonzalo Quedena
abstract class BaseMoviesNotifier extends StateNotifier<List<Movie>> {
  BaseMoviesNotifier() : super([]);

  int currentPage = 0;
  bool isLoading = false;

  Future<void> loadMovies();
  Future<void> loadNextPage();
}

/// ### MoviesNotifier
/// It is a StateNotifier class that manages the state of the now playing movies. It extends BaseMoviesNotifier to reuse the common logic.
///
/// #### Properties:
/// - [getNowPlayingMovies]: The use case to load the now playing movies.
///
/// #### Methods:
/// - [loadMovies]: It loads the now playing movies.
/// - [loadNextPage]: It loads the next page of now playing movies.
///
/// #### Author:
/// Gonzalo Quedena
class MoviesNotifier extends BaseMoviesNotifier {
  final GetNowPlayingMovies getNowPlayingMovies;

  MoviesNotifier({required this.getNowPlayingMovies}) : super();

  @override
  Future<void> loadMovies() async {
    if (isLoading) return;

    isLoading = true;

    currentPage = 1;
    final movies = await getNowPlayingMovies.call(pageNumber: currentPage);
    state = movies;

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  @override
  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;

    currentPage++;
    final movies = await getNowPlayingMovies.call(pageNumber: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}

/// ### SlideShowMoviesNotifier
/// It is a StateNotifier class that manages the state of the slide show movies.
///
/// #### Properties:
/// - [getSlideShowMovies]: The use case to load the slide show movies.
///
/// #### Methods:
/// - [loadMovies]: It loads the movies for the slide show.
///
/// #### Author:
/// Gonzalo Quedena
class SlideShowMoviesNotifier extends BaseMoviesNotifier {
  final GetSlideShowMovies getSlideShowMovies;

  SlideShowMoviesNotifier({required this.getSlideShowMovies}) : super();

  @override
  Future<void> loadMovies() async {
    final movies = await getSlideShowMovies.call(end: 6);
    state = movies;
  }

  @override
  Future<void> loadNextPage() async {
    // No-op: SlideShowMoviesNotifier does not support pagination
  }
}

/// ### UpcomingMoviesNotifier
/// It is a StateNotifier class that manages the state of the upcoming movies. It extends BaseMoviesNotifier to reuse the common logic.
///
/// #### Properties:
/// - [getUpcomingMovies]: The use case to load the upcoming movies.
///
/// #### Methods:
/// - [loadMovies]: It loads the upcoming movies.
/// - [loadNextPage]: It loads the next page of upcoming movies.
///
/// #### Author:
/// Gonzalo Quedena
class UpcomingMoviesNotifier extends BaseMoviesNotifier {
  final GetUpcomingMovies getUpcomingMovies;

  UpcomingMoviesNotifier({required this.getUpcomingMovies}) : super();

  @override
  Future<void> loadMovies() async {
    if (isLoading) return;

    isLoading = true;

    currentPage = 1;
    final movies = await getUpcomingMovies.call(pageNumber: currentPage);
    state = movies;

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  @override
  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;

    currentPage++;
    final movies = await getUpcomingMovies.call(pageNumber: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}

class PopularMoviesNotifier extends BaseMoviesNotifier {
  final GetPopularMovies getPopularMovies;

  PopularMoviesNotifier({required this.getPopularMovies}) : super();

  @override
  Future<void> loadMovies() async {
    if (isLoading) return;

    isLoading = true;

    currentPage = 1;
    final movies = await getPopularMovies.call(pageNumber: currentPage);
    state = movies;

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  @override
  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;

    currentPage++;
    final movies = await getPopularMovies.call(pageNumber: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}

/// ### MovieByIdNotifier
/// It is a StateNotifier class that manages the state of a single movie by its ID.
///
/// #### Properties:
/// - [getMovieById]: The use case to load the movie by its ID.
/// - [movieId]: The ID of the movie to load.
///
/// #### Methods:
/// - [loadMovie]: It loads the movie by its ID.
///
/// #### Author:
/// Gonzalo Quedena
class MovieByIdNotifier extends StateNotifier<Movie?> {
  final GetMovieById getMovieById;
  final String movieId;

  MovieByIdNotifier({required this.getMovieById, required this.movieId})
      : super(null) {
    loadMovie();
  }

  Future<void> loadMovie() async {
    final movie = await getMovieById.call(movieId);
    state = movie;
  }
}
