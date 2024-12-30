import 'package:cinemapedia_app/features/cinema/infrastructure/mappers/movie_mapper.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia_app/core/constants/api_constants.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/models/movie_response.dart';

/// ### Movie Datasource Implementation
/// Is the implementation of the [MoviesDatasource] interface. This class is responsible for the communication with the API.
///
/// #### Properties:
/// - [dio]: Dio instance to make the HTTP requests to the API. This instance is created with the base URL and the query parameters like the API key and the language.
///
/// #### Methods:
/// - [getNowPlaying]: This method is responsible for fetching the movies from the API.
///
/// #### Author:
/// Gonzalo Quedena
class MovieDatasourceImpl extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      queryParameters: {
        'api_key': ApiConstants.apiKey,
        'language': 'en-US',
      },
    ),
  );

  @override
  /// Refer to [MoviesDatasource.getNowPlaying] for more information.
  Future<List<Movie>> getNowPlaying({int pageNumber = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': pageNumber,
      },
    );

    final movieResponse = MovieResponse.fromJson(response.data);

    final List<Movie> movies = movieResponse.results
        .where(
          (movie) => movie.posterPath != 'no-poster',
        )
        .map(
          (movie) => MovieMapper.movieModelToEntity(movie),
        )
        .toList();

    return movies;
  }
}
