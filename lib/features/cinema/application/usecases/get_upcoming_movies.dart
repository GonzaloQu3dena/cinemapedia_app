import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/movie_repository.dart';

/// ### Load Now Playing Movies
/// It is a use case that is used to get the list of now playing movies from the repository.
///
/// #### Properties:
/// - [repository]: A MoviesRepository object.
///
/// #### Methods:
/// - [call]: It is a method that is used to get the list of now playing movies from the repository.
///
/// #### Author:
/// Gonzalo Quedena
class GetUpcomingMovies {
  final MoviesRepository repository;

  GetUpcomingMovies(this.repository);

  /// It is a method that is used to get the list of now playing movies from the repository.
  Future<List<Movie>> call({int pageNumber = 1}) async {
    return await repository.getUpcomingMovies(pageNumber);
  }
}
