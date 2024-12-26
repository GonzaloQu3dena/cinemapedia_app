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
  final bool isDarkMode;
  final int selectedColor;

  /// The selectedColor must be greater than 0 and less than the length of the colorList and the isDarkMode must be a boolean.
  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  })  : assert(
          selectedColor >= 0,
          'selectedColor must be greater than 0',
        ),
        assert(
          selectedColor < colors.length,
          'selectedColor must be less than ${colors.length - 1}',
        );

  /// Returns the theme configuration. The theme is based on the selected color and the dark mode flag.
  ThemeData theme() {
    final baseTheme = isDarkMode ? DarkTheme.theme : LightTheme.theme;

    ThemeData newTheme = baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        primary: colors[selectedColor],
      ),
    );

    return newTheme;
  }

  /// Used to create a new instance of the AppTheme class with the new optional values.
  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) =>
      AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode,
        selectedColor: selectedColor ?? this.selectedColor,
      );
}
