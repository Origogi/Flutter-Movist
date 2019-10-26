import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';

class FavoriteState extends ChangeNotifier  {

  List<int> movieIDs = [];

  void addMovie(int id) {
    movieIDs.add(id);
    notifyListeners();
  }

  void removeMovieID(int id) {
    movieIDs.remove(id);
    notifyListeners();
  }

  bool containMovieID(int id) {
    return movieIDs.contains(id);
  }

  bool isEmpty() {
    return movieIDs.isEmpty;
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
