import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

/// ### Movie repository
/// This class is an abstract class that will be implemented by the data layer.
///
/// #### Methods:
/// - [getNowPlayingMovies]: Get the list of movies by page.
/// - [getUpcomingMovies]: Get the list of upcoming movies by page.
/// - [getPopularMovies]: Get the list of popular movies by page.
/// - [getMovieById]: Get the movie by id.
/// - [searchMovies]: Search movies.
/// 
/// #### Author:
/// Gonzalo Quedena
abstract class MoviesRepository {
  /// Refer to [MovieDataSources.getNowPlayingMovies]
  Future<List<Movie>> getNowPlayingMovies(int pageNumber);

  /// Refer to [MovieDataSources.getUpcomingMovies]
  Future<List<Movie>> getUpcomingMovies(int pageNumber);

  /// Refer to [MovieDataSources.getPopularMovies]
  Future<List<Movie>> getPopularMovies(int pageNumber);

  /// Refer to [MovieDataSources.getMovieById]
  Future<Movie> getMovieById(String movieId);

  /// Refer to [MovieDataSources.searchMovies]
  Future<List<Movie>> searchMovies(String query);
}
