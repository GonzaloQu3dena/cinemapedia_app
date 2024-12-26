import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/models/movie_model.dart';

/// ### Movie Mapper
/// It is a class that contains a static method that converts a [MovieModel] to a [Movie] entity. This class is used to convert the data from the API to the data that the application uses.
/// 
/// #### Methods:
/// - [movieModelToEntity] : Converts a [MovieModel] to a [Movie] entity.
/// 
/// #### Author:
/// Gonzalo Quedena
class MovieMapper {

  /// Converts a [MovieModel] to a [Movie] entity.
  static Movie movieModelToEntity(MovieModel movie) => Movie(
        isAdult: false,
        backdropPath: (movie.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
            : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
        genreIds: movie.genreIds.map((e) => e.toString()).toList(),
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: (movie.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : 'no-poster',
        releaseDate: movie.releaseDate,
        title: movie.title,
        hasVideo: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );
}
