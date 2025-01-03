import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';
import 'package:cinemapedia_app/features/cinema/domain/repositories/actors_repository.dart';

class GetActorsByMovie {
  final ActorsRepository actorsRepository;

  GetActorsByMovie(this.actorsRepository);

  Future<List<Actor>> call(String movieId) async {
    return await actorsRepository.getActorsByMovie(movieId);
  }
}
