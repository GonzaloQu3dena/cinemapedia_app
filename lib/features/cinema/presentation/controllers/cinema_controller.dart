import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/movies_provider.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/actors_provider.dart';

/// ### Cinema Controller Provider
/// It is a StateNotifierProvider that provides an instance of CinemaController.
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
/// - [slideShowMovies]: The list of movies for the slide show.
/// - [upcomingMovies]: The list of upcoming movies.
/// - [popularMovies]: The list of popular movies.
/// - [selectedMovie]: The movie that is currently selected.
/// - [actorsByMovie]: The list of actors for the selected movie.
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
  final List<Actor> actorsByMovie;

  CinemaState({
    this.nowPlayingMovies = const [],
    this.slideShowMovies = const [],
    this.upcomingMovies = const [],
    this.popularMovies = const [],
    this.selectedMovie,
    this.actorsByMovie = const [],
  });

  /// Creates a copy of the current state with the given new values.
  CinemaState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? slideShowMovies,
    List<Movie>? upcomingMovies,
    List<Movie>? popularMovies,
    Movie? selectedMovie,
    List<Actor>? actorsByMovie,
  }) {
    return CinemaState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      slideShowMovies: slideShowMovies ?? this.slideShowMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      selectedMovie: selectedMovie ?? this.selectedMovie,
      actorsByMovie: actorsByMovie ?? this.actorsByMovie,
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
/// - [loadSlideMovies]: It loads the movies for the slide show.
/// - [loadUpcomingMovies]: It loads the upcoming movies.
/// - [loadPopularMovies]: It loads the popular movies.
/// - [loadNextPageNowPlayingMovies]: It loads the next page of movies that are currently playing in theaters.
/// - [loadNextPageUpcomingMovies]: It loads the next page of upcoming movies.
/// - [loadNextPagePopularMovies]: It loads the next page of popular movies.
/// - [loadMovieById]: It loads a movie by its ID and updates the state with the selected movie.
/// - [loadActorsByMovie]: It loads the actors for a movie by its ID and updates the state with the actors.
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

  /// Loads the movies that are currently playing in theaters.
  Future<void> loadMovies() async {
    await _ref.read(nowPlayingMoviesProvider.notifier).loadMovies();
    final nowPlayingMovies = _ref.read(nowPlayingMoviesProvider);
    state = state.copyWith(nowPlayingMovies: nowPlayingMovies);
  }

  /// Loads the movies for the slide show.
  Future<void> loadSlideMovies() async {
    await _ref.read(slideShowMoviesProvider.notifier).loadMovies();
    final slideShowMovies = _ref.read(slideShowMoviesProvider);
    state = state.copyWith(slideShowMovies: slideShowMovies);
  }

  /// Loads the upcoming movies.
  Future<void> loadUpcomingMovies() async {
    await _ref.read(upcomingMoviesProvider.notifier).loadMovies();
    final upcomingMovies = _ref.read(upcomingMoviesProvider);
    state = state.copyWith(upcomingMovies: upcomingMovies);
  }

  /// Loads the popular movies.
  Future<void> loadPopularMovies() async {
    await _ref.read(popularMoviesProvider.notifier).loadMovies();
    final popularMovies = _ref.read(popularMoviesProvider);
    state = state.copyWith(popularMovies: popularMovies);
  }

  /// Loads the next page of movies that are currently playing in theaters.
  Future<void> loadNextPageNowPlayingMovies() async {
    await _ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    final nowPlayingMovies = _ref.read(nowPlayingMoviesProvider);
    state = state.copyWith(nowPlayingMovies: nowPlayingMovies);
  }

  /// Loads the next page of upcoming movies.
  Future<void> loadNextPageUpcomingMovies() async {
    await _ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    final upcomingMovies = _ref.read(upcomingMoviesProvider);
    state = state.copyWith(upcomingMovies: upcomingMovies);
  }

  /// Loads the next page of popular movies.
  Future<void> loadNextPagePopularMovies() async {
    await _ref.read(popularMoviesProvider.notifier).loadNextPage();
    final popularMovies = _ref.read(popularMoviesProvider);
    state = state.copyWith(popularMovies: popularMovies);
  }

  /// Loads a movie by its ID and updates the state with the selected movie.
  ///
  /// #### Parameters:
  /// - [movieId]: The ID of the movie to load.
  Future<void> loadMovieById(String movieId) async {
    final movieNotifier = _ref.read(movieByIdProvider(movieId).notifier);
    await movieNotifier.loadMovie();
    final movie = _ref.read(movieByIdProvider(movieId));
    state = state.copyWith(selectedMovie: movie);
  }

  /// Loads the actors for a movie by its ID and updates the state with the actors.
  ///
  /// #### Parameters:
  /// - [movieId]: The ID of the movie to load actors for.
  Future<void> loadActorsByMovie(int movieId) async {
    final actorNotifier = _ref.read(actorsByMovieProvider.notifier);
    await actorNotifier.getActorsByMovie(movieId.toString());

    final actors = _ref.read(actorsByMovieProvider)[movieId.toString()] ?? [];
    state = state.copyWith(actorsByMovie: actors);
  }
}