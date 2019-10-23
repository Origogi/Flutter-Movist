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
    'light':  kLightTheme,
    'dark' : kDarkTheme,
    'amoled' : kAmoledTheme
  };

  ThemeData currentTheme = kLightTheme;

  void changedTheme(String key) {
    
    ThemeData updatedThemeData = _map[key];

    if (updatedThemeData != null) {
      currentTheme = updatedThemeData;
      notifyListeners();
    }
  }
}
