import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/network/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteState extends ChangeNotifier {
  Map<String, Movie> _movieMap = {};

  FavoriteState() {
    readPreference();
  }

  void readPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.remove('ids');

    if (prefs.containsKey('ids')) {
      // List<String> ids = prefs.getStringList('ids');
      // print('ids : ' + ids.toString());

      List<int> ids = prefs.getStringList('ids').map(int.parse).toList();

      MovieDBApi.getDetailMovies(ids).then((List<Movie> movies) {
        print(movies.toString());
        movies.forEach((movie) {
          _movieMap[movie.id.toString()] = movie;
          });
        print(_movieMap.toString());
        notifyListeners();
      });
    }
  }

  void writePreperence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ids = _movieMap.keys.map((item) => item.toString()).toList();
    prefs.setStringList('ids', ids);
  }

  void addMovie(int id, Movie movie) {
    print('add id : $id');
    _movieMap[id.toString()] = movie;
    writePreperence();
    notifyListeners();
  }

  void removeMovie(int id) {
    print('remove id : $id');
    _movieMap[id.toString()] = null;
    writePreperence();
    notifyListeners();
  }

  List<Movie> getMovies() {
    return _movieMap.values.toList();
  }

  bool containMovie(int id) {
    return _movieMap[id.toString()] != null;
  }

  bool isEmpty() {
    return _movieMap.isEmpty;
  }
}

class ThemeState extends ChangeNotifier {
  Map<String, ThemeData> _map = {
    'Light': kLightTheme,
    'Dark': kDarkTheme,
    'Amoled': kAmoledTheme
  };

  ThemeData get themeData => _map[_key];
  String get themeKey => _key;

  String _key = 'Dark';

  void changeTheme(String key) {
    _key = key;
    notifyListeners();
  }
}
