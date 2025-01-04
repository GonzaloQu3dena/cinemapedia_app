/// ### Release Date
/// Value object for the release date of the movie.
///
/// #### Properties:
/// - [value]: A DateTime that represents the release date of the movie.
///
/// #### Methods:
/// - [toString]: Returns the value of the release date as an ISO 8601 string.
///
/// #### Author:
/// Gonzalo Quedena
class ReleaseDate {
  final DateTime value;

  /// Constructs a [ReleaseDate] object.
  ReleaseDate(this.value);

  /// Returns the value of the release date as an ISO 8601 string.
  @override
  String toString() => value.toIso8601String();
}