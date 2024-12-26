import 'package:flutter/material.dart';

/// ### Dark theme
///
/// This class contains the dark theme configuration.
/// 
/// #### Properties:
/// - theme: Returns the dark theme configuration.
/// 
/// #### Author: 
/// Gonzalo Quedena
class DarkTheme {
  
  /// Returns the dark theme configuration
  static ThemeData get theme {
    return ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
        bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
    );
  }
}
