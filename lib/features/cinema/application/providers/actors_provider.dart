import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';
import 'package:cinemapedia_app/features/cinema/application/usecases/get_actors_by_movie.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>(
  (ref) {
    final repository = ref.read(actorsRepositoryProvider);
    final getActorByMovie = GetActorsByMovie(repository);

    return ActorByMovieNotifier(getActorByMovie: getActorByMovie);
  },
);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsByMovie getActorByMovie;

  ActorByMovieNotifier({required this.getActorByMovie}) : super({});

  Future<void> getActorsByMovie(String movieId) async {

    if (state[movieId] != null) return;

    final actorsByMovie = await getActorByMovie(movieId.toString());
    state = {...state, movieId: actorsByMovie};
  }
}