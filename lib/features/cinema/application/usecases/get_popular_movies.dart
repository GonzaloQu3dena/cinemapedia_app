import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/movie_repository.dart';

/// ### Get Popular Movies
/// It is a use case that gets the list of popular movies.
///
/// #### Properties:
/// - [repository]: A MoviesRepository object.
///
/// #### Methods:
/// - [call]: It is a method that is used to get the list of popular movies from the repository.
///
/// #### Author:
/// Gonzalo Quedena
class GetPopularMovies {
  final MoviesRepository repository;

  GetPopularMovies(this.repository);

  /// It is a method that is used to get the list of popular movies from the repository.
  Future<List<Movie>> call({int pageNumber = 1}) async {
    return await repository.getPopularMovies(pageNumber);
  }
}
