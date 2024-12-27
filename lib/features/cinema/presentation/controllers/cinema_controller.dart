import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/movies_provider.dart';

/// ### Cinema Controller
/// It is a controller that manages the state of the cinema page.
/// 
/// #### Author:
/// Gonzalo Quedena
final cinemaControllerProvider =
    StateNotifierProvider<CinemaController, List<Movie>>(
  (ref) {
    return CinemaController(ref);
  },
);

/// ### Cinema Controller
/// It is a controller that manages the state of the cinema page.
/// 
/// #### Properties:
/// - [_ref]: The reference to the provider.
/// 
/// #### Methods:
/// - [loadMovies]: Loads the movies from the API.
/// 
/// #### Author:
/// Gonzalo Quedena
class CinemaController extends StateNotifier<List<Movie>> {
  final Ref _ref;

  CinemaController(this._ref) : super([]) {
    loadMovies();
  }

  /// Loads the movies from the API.
  Future<void> loadMovies() async {
    print('Loading movies...');
    await _ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    state = _ref.read(nowPlayingMoviesProvider);
    print('Movies loaded: ${state.length}');
  }

  /// Loads the slide movies from the API.
  Future<void> loadSlideMovies() async {
    print('Loading slide movies...');
    await _ref.read(slideShowMoviesProvider.notifier).loadSlideShowMovies();
    state = _ref.read(slideShowMoviesProvider);
    print('Slide movies loaded: ${state.length}');
  }
}