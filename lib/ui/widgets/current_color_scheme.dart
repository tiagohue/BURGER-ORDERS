import 'package:flutter/material.dart';

class CurrentColorScheme extends ChangeNotifier {
  ColorScheme current = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.red,
    onSecondary: Colors.red,
    error: Colors.red,
    onError: Colors.red,
    surface: const Color.fromARGB(255, 255, 226, 147),
    onSurface: Colors.black,
  );

  void change() {
    if (current.brightness == Brightness.light) {
      // change to dark theme:
      current = ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffFFC107),
        onPrimary: Colors.white,
        secondary: Colors.red,
        onSecondary: Colors.red,
        error: Colors.red,
        onError: Colors.red,
        surface: Color.fromARGB(255, 12, 12, 12),
        onSurface: Color(0xffFFC107),
      );
    } else {
      // change to light theme:
      current = ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.red,
        onSecondary: Colors.red,
        error: Colors.red,
        onError: Colors.red,
        surface: Color.fromARGB(255, 255, 226, 147),
        onSurface: Colors.black,
      );
    }

    notifyListeners();
  }
}
