import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/movies_provider.dart';

/// ### Cinema Controller
/// It is a controller that manages the state of the cinema page.
/// 
/// #### Author:
/// Gonzalo Quedena
final cinemaControllerProvider =
    StateNotifierProvider<CinemaController, CinemaState>(
  (ref) {
    return CinemaController(ref);
  },
);

/// ### Cinema State
/// It is the state of the cinema page. This state contains the list of movies that are currently playing in theaters.
/// 
/// #### Properties:
/// - [nowPlayingMovies]: The list of movies that are currently playing in theaters.
/// - [slideShowMovies]: The list of movies that are currently playing in theaters.
/// - [upcomingMovies]: The list of movies that are currently playing in theaters.
/// - [popularMovies]: The list of movies that are currently playing in theaters.
/// 
/// #### Methods:
/// - [copyWith]: It returns a new instance of the state with the new values.
/// 
/// #### Author:
/// Gonzalo Quedena
class CinemaState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> slideShowMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> popularMovies;
  final Movie? selectedMovie;

  CinemaState({
    this.nowPlayingMovies = const [],
    this.slideShowMovies = const [],
    this.upcomingMovies = const [],
    this.popularMovies = const [],
    this.selectedMovie,
  });

  CinemaState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? slideShowMovies,
    List<Movie>? upcomingMovies,
    List<Movie>? popularMovies,
    Movie? selectedMovie,
  }) {
    return CinemaState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      slideShowMovies: slideShowMovies ?? this.slideShowMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      selectedMovie: selectedMovie ?? this.selectedMovie,
    );
  }
}

/// ### Cinema Controller
/// It is a controller that manages the state of the cinema page.
/// 
/// #### Properties:
/// - [_ref]: The reference to the provider container.
/// 
/// #### Methods:
/// - [loadMovies]: It loads the movies that are currently playing in theaters.
/// - [loadSlideMovies]: It loads the movies that are currently playing in theaters.
/// - [loadUpcomingMovies]: It loads the movies that are currently playing in theaters.
/// - [loadPopularMovies]: It loads the movies that are currently playing in theaters.
/// - [loadNextPageNowPlayingMovies]: It loads the next page of movies that are currently playing in theaters.
/// - [loadNextPageUpcomingMovies]: It loads the next page of movies that are currently playing in theaters.
/// - [loadNextPagePopularMovies]: It loads the next page of movies that are currently playing in theaters.
/// - [loadMovieById]: It loads a movie by its ID and updates the state with the selected movie.
/// 
/// #### Author:
/// Gonzalo Quedena
class CinemaController extends StateNotifier<CinemaState> {
  final Ref _ref;

  CinemaController(this._ref) : super(CinemaState()) {
    loadMovies();
    loadSlideMovies();
    loadUpcomingMovies();
    loadPopularMovies();
  }

  Future<void> loadMovies() async {
    await _ref.read(nowPlayingMoviesProvider.notifier).loadMovies();
    final nowPlayingMovies = _ref.read(nowPlayingMoviesProvider);
    state = state.copyWith(nowPlayingMovies: nowPlayingMovies);
  }

  Future<void> loadSlideMovies() async {
    await _ref.read(slideShowMoviesProvider.notifier).loadMovies();
    final slideShowMovies = _ref.read(slideShowMoviesProvider);
    state = state.copyWith(slideShowMovies: slideShowMovies);
  }

  Future<void> loadUpcomingMovies() async {
    await _ref.read(upcomingMoviesProvider.notifier).loadMovies();
    final upcomingMovies = _ref.read(upcomingMoviesProvider);
    state = state.copyWith(upcomingMovies: upcomingMovies);
  }

  Future<void> loadPopularMovies() async {
    await _ref.read(popularMoviesProvider.notifier).loadMovies();
    final popularMovies = _ref.read(popularMoviesProvider);
    state = state.copyWith(popularMovies: popularMovies);
  }

  Future<void> loadNextPageNowPlayingMovies() async {
    await _ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    final nowPlayingMovies = _ref.read(nowPlayingMoviesProvider);
    state = state.copyWith(nowPlayingMovies: nowPlayingMovies);
  }

  Future<void> loadNextPageUpcomingMovies() async {
    await _ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    final upcomingMovies = _ref.read(upcomingMoviesProvider);
    state = state.copyWith(upcomingMovies: upcomingMovies);
  }

  Future<void> loadNextPagePopularMovies() async {
    await _ref.read(popularMoviesProvider.notifier).loadNextPage();
    final popularMovies = _ref.read(popularMoviesProvider);
    state = state.copyWith(popularMovies: popularMovies);
  }

  Future<void> loadMovieById(int movieId) async {
    final movieNotifier = _ref.read(movieByIdProvider(movieId).notifier);
    await movieNotifier.loadMovie();
    final movie = _ref.read(movieByIdProvider(movieId));
    state = state.copyWith(selectedMovie: movie);
  }
}