import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

/// ### Movies Data Source
/// This interface defines the methods that a data source for movies must implement.
///
/// #### Author:
/// Gonzalo Quedena
abstract class MoviesDataSource {
  /// ### Get Now Playing Movies
  /// This method will fetch the list of movies that are currently playing in theaters.
  ///
  /// #### Returns:
  /// - A Future that completes with a list of movies that are currently playing in theaters.
  Future<List<Movie>> getNowPlayingMovies({int pageNumber=1});

  /// ### Get Popular Movies
  /// This method will fetch the list of popular movies.
  ///
  /// #### Returns:
  /// - A Future that completes with a list of popular movies.
  Future<List<Movie>> getPopularMovies({int pageNumber=1});

  /// ### Get Upcoming Movies
  /// This method will fetch the list of upcoming movies.
  ///
  /// #### Returns:
  /// - A Future that completes with a list of upcoming movies.
  Future<List<Movie>> getUpcomingMovies({int pageNumber=1});

  /// ### Get Movie By ID
  /// This method will fetch the details of a movie by its ID.
  ///
  /// #### Parameters:
  /// - [movieId]: The ID of the movie to fetch.
  ///
  /// #### Returns:
  /// - A Future that completes with the details of the movie.
  Future<Movie> getMovieById(String movieId);

  /// ### Search Movies
  /// This method will search for movies based on a query string.
  ///
  /// #### Parameters:
  /// - [query]: The query string to search for movies.
  ///
  /// #### Returns:
  /// - A Future that completes with a list of movies that match the query.
  Future<List<Movie>> searchMovies(String query);
}