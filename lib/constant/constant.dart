import 'package:flutter/material.dart';

final ThemeData kDarkTheme = _buildDarkTheme();

final String fontFamilty = 'Calibre-Semibold';

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
    scaffoldBackgroundColor: Color(0xFF2d3447),
    primaryColor: Color(0xff242248),
    accentColor: Color(0xff8468DD),
    canvasColor: Colors.transparent,
    backgroundColor: Color(0xFF2d3447),
    primaryIconTheme: IconThemeData(color: Colors.black),
    appBarTheme: AppBarTheme(
        textTheme: textTheme,
        color: Color(0xFF2d3447),
        iconTheme: IconThemeData(color: Colors.white)),
    textTheme: textTheme,
  );
}
