/// ### GenderId
/// Value object for GenderId
/// 
/// #### Properties:
/// - [value]: Is a String that represents the genderId of the movie.
/// 
/// #### Constraints:
/// - [value] must not be empty.
/// 
/// #### Author:
/// Gonzalo Quedena
class GenderId {
  final String value;

  /// The constructor requires a non-empty String.
  GenderId(this.value) : assert(value.isNotEmpty, 'GenderId cannot be empty');
}