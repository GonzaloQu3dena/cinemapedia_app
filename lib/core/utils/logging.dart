import 'package:flutter/material.dart';

/// Print a warning message to the console.
/// 
/// The message will be printed in yellow.
/// 
/// Author: Gonzalo Quedena
void printWarning(String text) {
  debugPrint('\x1B[33m$text\x1B[0m');
}

/// Print an error message to the console.
/// 
/// The message will be printed in red.
/// 
/// Author: Gonzalo Quedena
void printError(String text) {
  debugPrint('\x1B[31m$text\x1B[0m');
}

/// Print an info message to the console.
/// 
/// The message will be printed in blue.
/// 
/// Author: Gonzalo Quedena
void printInfo(String text) {
  debugPrint('\x1B[34m$text\x1B[0m');
}

/// Print a success message to the console.
/// 
/// The message will be printed in green.
/// 
/// Author: Gonzalo Quedena
void printSuccess(String text) {
  debugPrint('\x1B[32m$text\x1B[0m');
}