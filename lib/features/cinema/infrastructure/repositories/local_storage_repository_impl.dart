
import 'package:cinemapedia_app/features/cinema/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/local_storage_repository.dart';

/// ### Local Storage Repository Implementation
/// This class implements the [LocalStorageRepository] abstract class.
/// 
/// #### Properties:
/// - [datasource]: A [LocalStorageDatasource] instance.
/// 
/// #### Methods:
/// - [loadMovies]: Refer to [LocalStorageRepository.loadMovies].
/// - [isMovieFavorite]: Refer to [LocalStorageRepository.isMovieFavorite].
/// - [toggleFavoriteMovie]: Refer to [LocalStorageRepository.toggleFavoriteMovie].
/// 
/// #### Author:
/// Gonzalo Quedena
class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  /// Refer to [LocalStorageRepository.isMovieFavorite].
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  /// Refer to [LocalStorageRepository.loadMovies].
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  /// Refer to [LocalStorageRepository.toggleFavoriteMovie].
  Future<void> toggleFavoriteMovie(Movie movie) {
    return datasource.toggleFavoriteMovie(movie);
  }
}