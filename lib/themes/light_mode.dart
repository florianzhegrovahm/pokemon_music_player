import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    onBackground: Colors.grey.shade200,
    background: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    inversePrimary: Colors.grey.shade900,
    onPrimary: Colors.black,
  ),
  splashFactory: NoSplash.splashFactory,
);
