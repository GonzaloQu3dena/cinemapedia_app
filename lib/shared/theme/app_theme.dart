import 'package:flutter/material.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

/// List of colors that can be used in the app.
const colors = <Color>[
  Colors.red,
  Colors.blue,
  Colors.green,
];

/// ### App Theme
///
/// Class to manage the app theme.
///
/// #### Parameters:
/// * isDarkMode: bool - Dark mode flag.
/// * selectedColor: int - Selected color index.
///
/// #### Author:
/// Gonzalo Quedena
class AppTheme {
  final int selectedColor;

  /// The selectedColor must be greater than 0 and less than the length of the colorList.
  AppTheme({
    this.selectedColor = 0,
  })  : assert(
          selectedColor >= 0,
          'selectedColor must be greater than 0',
        ),
        assert(
          selectedColor < colors.length,
          'selectedColor must be less than ${colors.length - 1}',
        );

  /// Returns the light theme configuration based on the selected color.
  ThemeData lightTheme() {
    final baseTheme = LightTheme.theme;

    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: colors[selectedColor],
      ),
    );
  }

  /// Returns the dark theme configuration based on the selected color.
  ThemeData darkTheme() {
    final baseTheme = DarkTheme.theme;

    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: colors[selectedColor],
      ),
    );
  }

  /// Used to create a new instance of the AppTheme class with the new optional values.
  AppTheme copyWith({
    int? selectedColor,
  }) =>
      AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
      );
}