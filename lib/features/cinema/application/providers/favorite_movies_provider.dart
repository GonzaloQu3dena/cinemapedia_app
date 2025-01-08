import 'package:cinemapedia_app/features/cinema/application/providers/local_storage_provider.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return FavoriteMoviesNotifier(localStorageRepository: localStorageRepository);
});

class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  FavoriteMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(
      offset: page * 10,
      limit: 20,
    );
    page++;

    final tempMoviesMap = <int, Movie>{};

    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async{
    await localStorageRepository.toggleFavoriteMovie(movie);

    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    }
    else {
      state = {...state, movie.id: movie};
    }
  }
}
