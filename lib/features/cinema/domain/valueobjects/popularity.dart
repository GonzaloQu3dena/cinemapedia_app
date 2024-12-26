/// ### Popularity
/// Value object that represents the popularity of a movie.
/// 
/// ### Properties:
/// - [value]: Is a double that represents the popularity of a movie.
/// 
/// ### Constraints:
/// - [value] must be greater than or equal to 0.
/// 
/// ### Author: 
/// Gonzalo Quedena
class Popularity {
  final double value;

  Popularity(this.value) : assert(value >= 0, 'Popularity cannot be negative');
}
