import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/models/movie_detail.dart';
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
        genreIds: movie.genreIds,
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: (movie.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoWcWg0E8pSjBNi0TtiZsqu8uD2PAr_K11DA&s',
        releaseDate: movie.releaseDate,
        title: movie.title,
        hasVideo: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );

  /// Converts a [MovieDetails] to a [Movie] entity.
  static Movie movieDetailToEntity(MovieDetails moviedb) => Movie(
      isAdult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: moviedb.genres.map((e) => e.id).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      hasVideo: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
