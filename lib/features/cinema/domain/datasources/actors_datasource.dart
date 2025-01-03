import 'package:cinemapedia_app/features/cinema/domain/entities/actor.dart';

/// ### Actors Data Source
/// This class is an abstract class that will be implemented by the data source layer.
/// 
/// #### Methods:
/// - [getActorsByMovie] - This method will be implemented by the data source layer to get the list of actors by movie.
/// 
/// #### Author:
/// Gonzalo Quedena
abstract class ActorsDatasource {

  /// This method will be implemented by the data source layer to get the list of actors by movie.
  Future<List<Actor>> getActorsByMovie( String movieId );
}