import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

/// ### Movie Data Source
/// This class is an abstract class that will be implemented by the data source layer.
/// 
/// #### Methods: 
/// - [getCinemasByPage] - This method will be implemented by the data source layer to get the list of movies by page.
/// 
/// #### Author:
/// Gonzalo Quedena
abstract class MovieDatasource {

  /// ### Get the list of movies by page.
  /// This method will be implemented by the data source layer to get the list of movies by page.
  /// 
  /// #### Parameters:
  /// - [pageNumber]: The page number to get the list of movies.
  /// 
  /// #### Returns:
  /// - A list of movies.
  /// 
  /// #### Author:
  /// Gonzalo Quedena
  Future<List<Movie>> getMoviesByPage(int pageNumber);
}