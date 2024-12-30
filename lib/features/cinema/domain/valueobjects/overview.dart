/// ### Overview
/// Value object for the overview of the movie.
/// 
/// #### Properties:
/// - [value]: Is a String that represents the overview of the movie.
/// 
/// #### Methods:
/// - [toString]: Returns the value of the overview.
/// 
/// #### Author:
/// Gonzalo Quedena
class Overview {
  final String value;

  /// The constructor requires a non-empty String.
  Overview(this.value);

  /// Returns the value of the overview.
  @override
  String toString() => value;
}