import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    TextTheme txtTheme = const TextTheme(
        bodyText1: TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(121, 121, 121, 1),
        ),
        bodyText2: TextStyle(
          fontSize: 17,
          color: Color.fromRGBO(121, 121, 121, 1),
        ),
        headline1: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto"),
        headline2: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        headline3: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(121, 121, 121, 1),
            fontWeight: FontWeight.w600));

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
      primary: Color.fromRGBO(98, 0, 238, 1),
      secondary: Color.fromRGBO(134, 194, 50, 1),
      secondaryVariant: Color.fromRGBO(185, 61, 25, 1),
      background: Color.fromRGBO(18, 19, 20, 1.0),
      onSurface: Color.fromRGBO(255, 255, 255, 1.0),
      onPrimary: Color.fromRGBO(0, 0, 0, 1.0),
      surface: Color.fromRGBO(0, 0, 0, 1.0),
      primaryVariant: Color.fromRGBO(121, 121, 121, 1.0),
      error: Color.fromRGBO(0, 0, 0, 1.0),
      onError: Color.fromRGBO(0, 0, 0, 1.0),
      onSecondary: Color.fromRGBO(121, 121, 121, 1.0),
      onBackground: Color.fromRGBO(47, 47, 47, 1.0),
    );

    var t = ThemeData.from(colorScheme: colorScheme, textTheme: txtTheme)
        .copyWith(inputDecorationTheme: textFieldTheme);

    return t;
  }

  static ThemeData get lightTheme {
    TextTheme txtTheme = const TextTheme(
        bodyText1: TextStyle(
          fontSize: 14,
          color: Color.fromRGBO(45, 45, 45, 1.0),
        ),
        bodyText2: TextStyle(
          fontSize: 17,
          color: Color.fromRGBO(45, 45, 45, 1.0),
        ),
        headline1: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        headline2: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        headline3: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(45, 45, 45, 1.0),
            fontWeight: FontWeight.w600));

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
      brightness: Brightness.light,
      primary: Color.fromRGBO(98, 0, 238, 1),
      secondary: Color.fromRGBO(134, 194, 50, 1),
      secondaryVariant: Color.fromRGBO(185, 61, 25, 1),
      background: Color.fromRGBO(221, 221, 221, 1.0),
      onSurface: Color.fromRGBO(169, 169, 169, 1.0),
      onPrimary: Color.fromRGBO(221, 221, 221, 1.0),
      surface: Color.fromRGBO(221, 221, 221, 1.0),
      primaryVariant: Color.fromRGBO(121, 121, 121, 1.0),
      error: Color.fromRGBO(221, 221, 221, 1.0),
      onError: Color.fromRGBO(221, 221, 221, 1.0),
      onSecondary: Color.fromRGBO(52, 52, 52, 1.0),
      onBackground: Color.fromRGBO(95, 95, 95, 1.0),
    );

    var t = ThemeData.from(colorScheme: colorScheme, textTheme: txtTheme)
        .copyWith(inputDecorationTheme: textFieldTheme);

    return t;
  }
}
