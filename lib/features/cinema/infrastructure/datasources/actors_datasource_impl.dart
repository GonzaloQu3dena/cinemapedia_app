import 'package:cinemapedia_app/features/cinema/infrastructure/mappers/actor_mapper.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia_app/core/constants/api_constants.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';
import 'package:cinemapedia_app/features/cinema/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_app/features/cinema/infrastructure/models/credit_response.dart';

class ActorsDatasourceImpl extends ActorsDatasource {

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
  Future<List<Actor>> getActorsByMovie(String movieId) async {

    final response = await dio.get(
      '/movie/$movieId/credits',
    );

    final castResponse = CreditResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
    
    return actors;
  }
}
