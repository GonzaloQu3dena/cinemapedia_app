/// ### Actor
/// It is the representation of the actor entity.
/// 
/// #### Properties:
/// - [id]: Is an integer that represents the ID of the actor.
/// - [name]: Is a string that represents the name of the actor.
/// - [profilePath]: Is a string that represents the path of the profile image of the actor.
/// - [character]: Is a string that represents the character that the actor plays in the movie.
/// 
/// #### Author:
/// Gonzalo Quedena
class Actor {

  final int id;
  final String name;
  final String profilePath;
  final String? character;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character
  });
}