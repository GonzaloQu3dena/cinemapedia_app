import 'package:cinemapedia_app/features/cinema/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/movie_repository.dart';

/// ### Movie Repository Implementation
/// It is the implementation of the [MoviesRepository] interface.
///
/// #### Properties:
/// - [datasource] : It is the datasource that is used to get the data.
///
/// #### Author:
/// Gonzalo Quedena
class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDataSource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  /// Refer to [MoviesRepository.getNowPlayingMovies]
  Future<List<Movie>> getNowPlayingMovies(int pageNumber) {
    return datasource.getNowPlayingMovies(pageNumber: pageNumber);
  }
  
  @override
  /// Refer to [MoviesRepository.getUpcomingMovies]
  Future<List<Movie>> getUpcomingMovies(int pageNumber) {
    return datasource.getUpcomingMovies(pageNumber: pageNumber);
  }

  @override
  /// Refer to [MoviesRepository.getPopularMovies]
  Future<List<Movie>> getPopularMovies(int pageNumber) {
    return datasource.getPopularMovies(pageNumber: pageNumber);
  }
  
  @override
  /// Refer to [MoviesRepository.getMovieById]
  Future<Movie> getMovieById(String movieId) {
    return datasource.getMovieById(movieId);
  }
  
  @override
  /// Refer to [MoviesRepository.searchMovies]
  Future<List<Movie>> searchMovies(String query) {
    return datasource.searchMovies(query);
  }
}
