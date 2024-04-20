import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme:  ColorScheme.dark(
    onBackground: Colors.grey.shade800,
    background: Colors.black,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  splashFactory: NoSplash.splashFactory,
);