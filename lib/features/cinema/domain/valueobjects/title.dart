/// ### Title
/// Value object for the title of the movie.
///
/// #### Properties:
/// - [value]: Is a String that represents the title of the movie.
///
/// #### Constraints:
/// - [value] can't be empty.
///
/// #### Methods:
/// - [toString]: Returns the value of the title.
///
/// #### Author:
/// Gonzalo Quedena
class Title {
  final String value;

  /// The constructor requires a non-empty String.
  Title(this.value) : assert(value.isNotEmpty, "Title can't be empty");

  /// Returns the value of the title.
  @override
  String toString() => value;
}
