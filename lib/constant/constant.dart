import 'package:flutter/material.dart';

final String fontFamilty = 'Calibre-Semibold';

final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  final TextTheme textTheme = TextTheme(
    headline: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24),
    body1: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 18),
    body2: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        fontSize: 14),
    caption: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 14),
  );

  return base.copyWith(
      cursorColor: Color(0xFF2d3447),
      scaffoldBackgroundColor: Color(0xFF2d3447),
      primaryColor: Color(0xff8468DD),
      accentColor: Color(0xff8468DD),
      canvasColor: Colors.transparent,
      highlightColor: Color(0xFF2d3447),
      backgroundColor: Color(0xFF2d3447),
      splashColor: Color(0xFF2d3447),
      primaryIconTheme: IconThemeData(color: Colors.black),
      focusColor: Color(0xFF2d3447),
      appBarTheme: AppBarTheme(
          textTheme: textTheme,
          color: Color(0xFF2d3447),
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: textTheme,
      iconTheme: IconThemeData(color: Colors.white));
}

final ThemeData kLightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();

  TextTheme textTheme = TextTheme(
    
    
    headline: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 24),

        title: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 20),    
    body1: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 18),
    body2: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 16),
    caption: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 14),
  );

  return base.copyWith(
      primaryColor: Colors.white,
      accentColor: Color(0xff8468DD),
      canvasColor: Colors.white,
      primaryIconTheme: IconThemeData(color: Colors.black),
      primaryTextTheme: textTheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        textTheme: textTheme,
        color: Colors.white
      ));
}
