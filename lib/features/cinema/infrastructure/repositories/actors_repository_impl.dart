import 'package:cinemapedia_app/features/cinema/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;

  ActorsRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}