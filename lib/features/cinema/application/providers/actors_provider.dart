import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';
import 'package:cinemapedia_app/features/cinema/application/usecases/get_actors_by_movie.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/actors_repository_provider.dart';

final actorByMovieProvicer =
    StateNotifierProvider<ActorByMovieNotifier, List<Actor>>(
  (ref) {
    final repository = ref.read(actorsRepositoryProvider);
    final getActorByMovie = GetActorsByMovie(repository);

    return ActorByMovieNotifier(getActorByMovie: getActorByMovie);
  },
);

class ActorByMovieNotifier extends StateNotifier<List<Actor>> {
  final GetActorsByMovie getActorByMovie;

  ActorByMovieNotifier({required this.getActorByMovie}) : super([]);

  void getActorsByMovie(int movieId) async {
    final actorByMovie = await getActorByMovie(movieId.toString());
    state = actorByMovie;
  }
}
