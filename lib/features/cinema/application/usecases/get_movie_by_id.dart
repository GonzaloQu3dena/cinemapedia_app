import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/movie_repository.dart';

/// ### Get Movie By Id
/// This usecase is used to get a movie by its id.
/// 
/// #### Properties:
/// - [repository]: The repository that will be used to get the movie.
/// 
/// #### Methods:
/// - [call]: It will call the repository to get the movie by its id.
/// 
/// #### Author:
/// Gonzalo Quedena
class GetMovieById {
  final MoviesRepository repository;

  GetMovieById(this.repository);

  Future<Movie> call(String movieId) async {
    return await repository.getMovieById(movieId);
  }
}