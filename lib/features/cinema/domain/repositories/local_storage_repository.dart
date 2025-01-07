
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

/// ### Local Storage Repository
/// This abstract class will be used to define the methods that will be used to
/// 
/// #### Methods:
/// - [loadMovies]: Refer to [LocalStorageDatasource.loadMovies].
/// - [isMovieFavorite]: Refer to [LocalStorageDatasource.isMovieFavorite].
/// - [toggleFavoriteMovie]: Refer to [LocalStorageDatasource.toggleFavoriteMovie].
/// 
/// #### Author:
/// Gonzalo Quedena
abstract class LocalStorageRepository {

  /// Refer to [LocalStorageDatasource.loadMovies].
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});

  /// Refer to [LocalStorageDatasource.isMovieFavorite].
  Future<bool> isMovieFavorite(int movieId);

  /// Refer to [LocalStorageDatasource.toggleFavoriteMovie].
  Future<void> toggleFavoriteMovie(Movie movie);
}