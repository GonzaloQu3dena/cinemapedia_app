import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/datasources/local_storage_datasource.dart';

/// ### Local Storage Datasource Implementation
/// This class implements the [LocalStorageDatasource] abstract class.
///
/// #### Methods:
/// - [openDB]: Opens the database.
/// - [loadMovies]: Refer to [LocalStorageDatasource.loadMovies].
/// - [isMovieFavorite]: Refer to [LocalStorageDatasource.isMovieFavorite].
/// - [toggleFavoriteMovie]: Refer to [LocalStorageDatasource.toggleFavoriteMovie].
///
/// #### Author:
/// Gonzalo Quedena
class LocalStorageDatasourceImpl extends LocalStorageDatasource {
  late Future<Isar> db;

  LocalStorageDatasourceImpl() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    /// Get the directory where the database will be stored.
    final dir = await getApplicationDocumentsDirectory();

    /// Verify if the database is already open.
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema],
          inspector: true, directory: dir.path);
    }

    /// Return the instance of the database.
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    /// Get the movie from the database.
    final Movie? isFavoriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.idIsar!));
      return;
    }

    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
