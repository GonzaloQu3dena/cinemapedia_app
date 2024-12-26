import 'package:cinemapedia_app/features/cinema/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/movie_repository.dart';

/// ### Movie Repository Implementation
/// It is the implementation of the [MoviesRepository] interface.
///
/// #### Methods:
/// - [getNowPlaying] : It is used to get the list of movies that are now playing in the cinema.
///
/// #### Author:
/// Gonzalo Quedena
class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  /// Refer to [MoviesRepository.getNowPlaying]
  Future<List<Movie>> getNowPlaying(int pageNumber) {
    return datasource.getNowPlaying(pageNumber: pageNumber);
  }
}
