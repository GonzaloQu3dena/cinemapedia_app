import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

/// ### Local Storage Datasource
/// This abstract class will be used to define the methods that will be used to
///
/// #### Methods:
/// - [loadMovies]: This method will load the movies from the local storage.
/// - [toggleFavoriteMovie]: This method will toggle the favorite status of a movie.
/// - [isMovieFavorite]: This method will return a boolean value that indicates if a movie is favorite or not.
/// 
/// #### Author:
/// Gonzalo Quedena
abstract class LocalStorageDatasource {

  /// ### Load Movies
  /// This method will load the movies from the local storage.
  /// 
  /// #### Parameters:
  /// - [limit]: The limit of movies to load.
  /// - [offset]: The offset of movies to load.
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0});

  /// ### Is Movie Favorite
  /// This method will return a boolean value that indicates if a movie is favorite or not.
  /// 
  /// #### Parameters:
  /// - [movieId]: The id of the movie.
  Future<bool> isMovieFavorite(int movieId);

  /// ### Toggle Favorite Movie
  /// This method will toggle the favorite status of a movie.
  /// 
  /// #### Parameters:
  /// - [movie]: The movie to toggle the favorite status.
  Future<void> toggleFavoriteMovie(Movie movie);

}
