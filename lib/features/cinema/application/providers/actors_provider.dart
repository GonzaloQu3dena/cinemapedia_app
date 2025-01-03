import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';
import 'package:cinemapedia_app/features/cinema/application/usecases/get_actors_by_movie.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/actors_repository_provider.dart';

/// ### Actors By Movie Provider
/// It is a StateNotifierProvider that provides a map of movie IDs to lists of actors.
/// It uses the ActorByMovieNotifier class to manage the state of the actors.
///
/// #### Author:
/// Gonzalo Quedena
final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>(
  (ref) {
    final repository = ref.read(actorsRepositoryProvider);
    final getActorByMovie = GetActorsByMovie(repository);

    return ActorByMovieNotifier(getActorByMovie: getActorByMovie);
  },
);

/// ### Actor By Movie Notifier
/// It is a StateNotifier class that manages the state of actors for a specific movie.
/// The state is a map where the key is the movie ID and the value is a list of actors.
///
/// #### Properties:
/// - [getActorByMovie]: The use case to load the actors for a specific movie.
///
/// #### Methods:
/// - [getActorsByMovie]: It loads the actors for a specific movie and updates the state.
///
/// #### Author:
/// Gonzalo Quedena
class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsByMovie getActorByMovie;

  ActorByMovieNotifier({required this.getActorByMovie}) : super({});

  /// Loads the actors for a specific movie by its ID.
  /// If the actors for the movie are already loaded, it does nothing.
  ///
  /// #### Parameters:
  /// - [movieId]: The ID of the movie to load actors for.
  ///
  /// #### Returns:
  /// - A Future that completes when the actors are loaded.
  Future<void> getActorsByMovie(String movieId) async {
    if (state[movieId] != null) return;

    final actorsByMovie = await getActorByMovie(movieId);
    state = {...state, movieId: actorsByMovie};
  }
}