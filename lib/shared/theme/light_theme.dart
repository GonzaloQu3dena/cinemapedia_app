import 'package:flutter/material.dart';

/// ### Light theme
///
/// This class contains the light theme configuration.
///
/// #### Properties:
/// - theme: Returns the light theme configuration.
/// 
/// #### Author: 
/// Gonzalo Quedena
class LightTheme {
  
  /// Returns the light theme configuration
  static ThemeData get theme {
    return ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
        bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
