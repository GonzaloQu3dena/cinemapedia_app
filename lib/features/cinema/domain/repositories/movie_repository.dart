import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

/// ### Movie repository
/// This class is an abstract class that will be implemented by the data layer.
///
/// #### Methods:
/// - [getMoviesByPage] - This method will be implemented by the data layer to get the list of movies by page.
///
/// #### Author:
/// Gonzalo Quedena
abstract class MoviesRepository {
  /// ### Get the list of movies by page.
  /// This method will be implemented by the data layer to get the list of movies by page.
  ///
  /// #### Parameters:
  /// - [pageNumber]: The page number to get the list of movies.
  ///
  /// #### Returns:
  /// - A list of movies.
  ///
  /// #### Author:
  /// Gonzalo Quedena
  Future<List<Movie>> getNowPlaying(int pageNumber);

  /// ### Get the list of upcoming movies by page.
  /// This method will be implemented by the data layer to get the list of upcoming movies by page.
  /// 
  /// #### Parameters:
  /// - [pageNumber]: The page number to get the list of movies.
  /// 
  /// #### Returns:
  /// - A list of movies.
  /// 
  /// #### Author:
  /// Gonzalo Quedena
  Future<List<Movie>> getUpcoming(int pageNumber);

  /// ### Get the list of popular movies by page.
  /// This method will be implemented by the data layer to get the list of popular movies by page.
  /// 
  /// #### Parameters:
  /// - [pageNumber]: The page number to get the list of movies.
  /// 
  /// #### Returns:
  /// - A list of movies.
  /// 
  /// #### Author:
  /// Gonzalo Quedena
  Future<List<Movie>> getPopular(int pageNumber);
}
