import 'package:intl/intl.dart';

/// ### Human Formats
/// This class contains methods to format numbers in a human-readable way.
/// 
/// #### Methods:
/// - [number] - Formats a number to a human-readable format. It uses the [NumberFormat.compactCurrency] method from the `intl` package.
/// 
/// #### Author:
/// Gonzalo Quedena
class HumanFormats {

  /// Formats a number to a human-readable format. It uses the [NumberFormat.compactCurrency] method from the `intl` package.
  static String number( double number, [int decimals = 0] ) {

    /// Formats the number to a human-readable format.
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en'
    ).format(number);

    return formattedNumber;
  }

}