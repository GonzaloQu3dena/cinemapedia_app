import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/movie_repository.dart';

/// ### Get Slide Show Movies
/// It is a use case that gets the movies for the slide show.
/// 
/// #### Properties:
/// - [repository]: The repository to get the movies.
/// 
/// #### Methods:
/// - [call]: It gets the movies for the slide show between the [start] and [end] indexes.
/// 
/// #### Author:
/// Gonzalo Quedena
class GetSlideShowMovies {
  final MoviesRepository repository;

  GetSlideShowMovies(this.repository);

  /// It gets the movies for the slide show between the [start] and [end] indexes.
  Future<List<Movie>> call({int pageNumber = 1, int start = 0, required int end}) async {
    final movies = await repository.getNowPlaying(pageNumber);
    return movies.sublist(start, end);
  }
}