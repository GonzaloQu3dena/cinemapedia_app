/// ### Release Date
/// Value object for the release date of the movie.
///
/// #### Properties:
/// - [value]: Is a DateTime that represents the release date of the movie.
///
/// #### Constraints:
/// - [value] must be after the year 1888.
/// - [value] must be before the current date plus a year.
///
/// #### Methods:
/// - [toString]: Returns the value of the release date.
///
/// #### Author:
/// Gonzalo Quedena
class ReleaseDate {
  final DateTime value;

  ReleaseDate(this.value)
      : assert(
            value.isBefore(
              DateTime.now().add(const Duration(days: 365)),
            ),
            'Release date cannot be more than a year in the future'),
        assert(
            value.isAfter(
              DateTime(1888, 1, 1),
            ),
            'Release date must be after the year 1888, when movies were invented');

  /// Returns the value of the release date.
  @override
  String toString() => value.toIso8601String();
}
