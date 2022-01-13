import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    TextTheme txtTheme = const TextTheme(
      bodyText1: TextStyle(
        fontSize: 14,
        color: Color.fromRGBO(121, 121, 121, 1),
      ),
    );

    InputDecorationTheme textFieldTheme = const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide:
            BorderSide(color: Color.fromRGBO(121, 121, 121, 1.0), width: 2.7),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide:
            BorderSide(color: Color.fromRGBO(121, 121, 121, 1.0), width: 2.7),
      ),
    );

    ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(75, 29, 82, 1),
      secondary: Color.fromRGBO(134, 194, 50, 1),
      secondaryVariant: Color.fromRGBO(185, 61, 25, 1),
      background: Color.fromRGBO(18, 19, 20, 1.0),
      onSurface: Color.fromRGBO(255, 255, 255, 1.0),
      onPrimary: Color.fromRGBO(0, 0, 0, 1.0),
      surface: Color.fromRGBO(0, 0, 0, 1.0),
      primaryVariant: Color.fromRGBO(121, 121, 121, 1.0),
      error: Color.fromRGBO(0, 0, 0, 1.0),
      onError: Color.fromRGBO(0, 0, 0, 1.0),
      onSecondary: Color.fromRGBO(0, 0, 0, 1.0),
      onBackground: Color.fromRGBO(0, 0, 0, 1.0),
    );

    var t = ThemeData.from(colorScheme: colorScheme, textTheme: txtTheme)
        .copyWith(inputDecorationTheme: textFieldTheme);

    return t;
  }
}
