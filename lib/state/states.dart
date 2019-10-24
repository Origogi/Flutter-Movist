import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/network/data.dart';

class FavoriteState extends ChangeNotifier  {

  Map<int, Movie> _movieMap = {};

  void addMovie(int id, Movie movie) {
    _movieMap[id] = movie;
    notifyListeners();
  }

  void removeMovieID(int id) {
    _movieMap[id] = null;
    notifyListeners();
  }

  bool containMovieID(int id) {
    return _movieMap[id] != null;
  }

  bool isEmpty() {
    return _movieMap.isEmpty;
  }
}


class ThemeState extends ChangeNotifier  {

  Map<String, ThemeData> _map = {
    'Light':  kLightTheme,
    'Dark' : kDarkTheme,
    'Amoled' : kAmoledTheme
  };

  ThemeData _currentTheme = kLightTheme;

  ThemeData get themeData => _map[_key];
  String get themeKey => _key;

  String _key = 'Dark';  

  void changeTheme(String key) {
    _key = key;
    notifyListeners();
  }
}
