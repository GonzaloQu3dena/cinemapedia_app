import 'package:cinemapedia_app/features/cinema/application/providers/providers.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ### Search Query Provider
/// This provider will store the search query.
///
/// ### Author:
/// Gonzalo Quedena
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
      ref: ref, searchMovies: movieRepository.searchMovies);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

/// ### Searched Movies Notifier
/// This notifier will store the searched movies.
/// 
/// #### Properties:
/// - [searchMovies]: A function that will search movies by query.
/// - [ref]: A reference to the provider.
/// 
/// #### Methods:
/// - [searchMoviesByQuery]: It will search movies by query.
/// 
/// #### Author:
/// Gonzalo Quedena 
class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.ref, required this.searchMovies})
      : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;

    return movies;
  }
}
