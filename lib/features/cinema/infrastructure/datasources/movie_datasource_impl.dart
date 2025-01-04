import 'package:dio/dio.dart';
import 'package:cinemapedia_app/core/constants/api_constants.dart';

import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/models/movie_detail.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/models/movie_response.dart';
import 'package:cinemapedia_app/features/cinema/domain/datasources/movies_datasource.dart';

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
class MovieDatasourceImpl extends MoviesDataSource {
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
  Future<List<Movie>> getNowPlayingMovies({int pageNumber = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': pageNumber,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  /// Refer to [MoviesDatasource.getPopular] for more information.
  Future<List<Movie>> getUpcomingMovies({int pageNumber = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': pageNumber,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  /// Refer to [MoviesDatasource.getPopular] for more information.
  Future<List<Movie>> getPopularMovies({int pageNumber = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': pageNumber,
      },
    );

    return _jsonToMovies(response.data);
  }

  @override
  /// Refer to [MoviesDatasource.getMovieById] for more information.
  Future<Movie> getMovieById(String movieId) async {
    final response = await dio.get('/movie/$movieId');

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch movie with id: $movieId');
    }

    final movieDetail = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailToEntity(movieDetail);

    return movie;
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) async {

    final response = await dio.get('/search/movie',
    queryParameters: {
      'query': query,
    });

    return _jsonToMovies(response.data);
  }

    /// ### JSON to Movies
  /// This method is responsible for converting the JSON response from the API to a list of [Movie] entities.
  ///
  /// #### Parameters:
  /// - [response]: JSON response from the API.
  ///
  /// #### Returns:
  /// - A list of [Movie] entities.
  List<Movie> _jsonToMovies(Map<String, dynamic> response) {
    final movieResponse = MovieResponse.fromJson(response);

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
