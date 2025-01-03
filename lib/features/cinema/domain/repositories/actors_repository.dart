import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';

/// ### Actors Repository
/// This class is an abstract class that will be implemented by the repository layer.
/// 
/// #### Methods:
/// - [getActorsByMovie] - This method will be implemented by the repository layer to get the list of actors by movie.
/// 
/// #### Author:
/// Gonzalo Quedena
abstract class ActorsRepository {

  /// This method will be implemented by the repository layer to get the list of actors by movie.
  Future<List<Actor>> getActorsByMovie( String movieId );
}