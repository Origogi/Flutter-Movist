import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/network/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteState extends ChangeNotifier {
  Map<String, Movie> _movieMap = {};
  bool isLoaded = false;

  FavoriteState() {
    readPreference().then((List<int> ids) {
      if (ids.isNotEmpty) {
        MovieDBApi.getDetailMovies(ids).then((List<Movie> movies) {
          movies.forEach((movie) {
            _movieMap[movie.id.toString()] = movie;
            isLoaded = true;
            notifyListeners();
          });
        });
      } else {
        isLoaded = true;
        notifyListeners();
      }
    });
  }

  Future<List<int>> readPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('ids')) {
      List<int> ids = prefs.getStringList('ids').map(int.parse).toList();
      return ids;
    } else {
      return [];
    }
  }

  Future<void> writePreference(List<String> ids) async {
    print('write preference : ' + ids.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('ids', ids);
  }

  void addMovie(int id, Movie movie) {
    print('add id : $id');

    _movieMap[id.toString()] = movie;

    print(_movieMap.length);

    writePreference(_movieMap.keys.toList()).then((_) {
      notifyListeners();
    });
  }

  void removeMovie(int id) {
    print('remove id : $id');

    _movieMap.remove(id.toString());

    print(_movieMap.length);

    writePreference(_movieMap.keys.toList()).then((_) {
      notifyListeners();
    });
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
