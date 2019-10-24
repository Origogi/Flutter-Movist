import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';

class FavoriteState extends ChangeNotifier  {

  Set<int> _movieIDs = {};

  void addMovieID(int id) {
    _movieIDs.add(id);
    notifyListeners();
  }

  void removeMovieID(int id) {
    _movieIDs.remove(id);
    notifyListeners();
  }

  bool containMovieID(int id) {
    return _movieIDs.contains(id);
  }

  bool isEmpty() {
    return _movieIDs.isEmpty;
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
