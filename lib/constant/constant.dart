import 'package:flutter/material.dart';

final String fontFamilty = 'goyang-R';

final Color darkColor = Color(0xFF2d3447);
final Color purpleColor = Colors.blue[300];
final Color amoledColor = Colors.black;

final List<String> themes = ['Light', 'Dark', 'Amoled'];

final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  final TextTheme textTheme = TextTheme(
    headline: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24),
    title: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20),
    subhead: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 18),
    body1: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16),
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
      scaffoldBackgroundColor: darkColor,
      primaryColor: darkColor,
      accentColor: purpleColor,
      canvasColor: Colors.transparent,
      highlightColor: darkColor,
      backgroundColor: darkColor,
      splashColor: darkColor,
      primaryIconTheme: IconThemeData(color: Colors.white),
      focusColor: darkColor,
      appBarTheme: AppBarTheme(
          textTheme: textTheme,
          color: darkColor,
          iconTheme: IconThemeData(color: Colors.white)),
      textTheme: textTheme,
      iconTheme: IconThemeData(color: Colors.white));
}

final ThemeData kAmoledTheme = _buildAmoledTheme();

ThemeData _buildAmoledTheme() {
  final ThemeData base = ThemeData.dark();
  final TextTheme textTheme = TextTheme(
    headline: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24),
    title: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20),
    subhead: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 18),
    body1: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16),
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
      scaffoldBackgroundColor: amoledColor,
      primaryColor: amoledColor,
      accentColor: purpleColor,
      canvasColor: Colors.transparent,
      highlightColor: amoledColor,
      backgroundColor: amoledColor,
      splashColor: amoledColor,
      primaryIconTheme: IconThemeData(color: Colors.black),
      focusColor: amoledColor,
      appBarTheme: AppBarTheme(
          textTheme: textTheme,
          color: amoledColor,
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
    subhead: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 18),
    body1: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 16),
    body2: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontSize: 14),
    caption: TextStyle(
        fontFamily: fontFamilty,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 14),
  );

  return base.copyWith(
      backgroundColor: Colors.white,
      primaryColor: Colors.white,
      accentColor: purpleColor,
      canvasColor: Colors.white,
      primaryIconTheme: IconThemeData(color: Colors.black),
      primaryTextTheme: textTheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(textTheme: textTheme, color: Colors.white));
}
