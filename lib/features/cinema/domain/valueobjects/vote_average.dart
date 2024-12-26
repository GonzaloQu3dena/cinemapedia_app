/// ### Vote Average
/// It is a value object that represents the average vote of a movie.
/// 
/// #### Properties:
/// - [value]: Is a double value that represents the average vote of a movie.
/// 
/// #### Constraints:
/// - [value] must be between 0 and 10.
/// 
/// #### Methods:
/// - [toString]: Returns the value as a string with one decimal.
/// 
/// #### Author
/// Gonzalo Quedena
/// 
class VoteAverage {
  final double value;

  VoteAverage(this.value)
      : assert(value >= 0 && value <= 10, 'Vote average must be between 0 and 10');

  @override
  String toString() => value.toStringAsFixed(1);
}