import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_list/constant/constant.dart';
import 'package:flutter_list/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteState extends ChangeNotifier {
  List<Movie> _movies = [];
  bool isLoaded = false;

  FavoriteState() {
    readPreference().then((List<Movie> movies) {
      if (movies.isNotEmpty) {
        _movies = movies;
        isLoaded = true;

        notifyListeners();
      } else {
        isLoaded = true;
        notifyListeners();
      }
    });
  }

  Future<List<Movie>> readPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('favorite')) {
      var moviesJson = jsonDecode(prefs.getString('favorite'));
      return MovieResult.fromJson(moviesJson).movies;
    } else {
      return [];
    }
  }

  Future<void> writePreference(List<Movie> movies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String moviesJson = jsonEncode(MovieResult(movies));

    prefs.setString('favorite', moviesJson);
  }

  void addMovie(Movie movie) {
    _movies.add(movie);

    print(_movies.length);

    writePreference(_movies).then((_) {
      notifyListeners();
    });
  }

  void removeMovie(int id) {
    print('remove id : $id');

    Movie target;

    for (Movie movie in _movies) {
      if (movie.id == id) {
        target = movie;
      }
    }

    if (target != null) {
      _movies.remove(target);

      writePreference(_movies).then((_) {
        notifyListeners();
      });
    }
  }

  List<Movie> getMovies() {
    print(_movies.length);
    return _movies;
  }

  bool containMovie(int id) {
    for (Movie movie in _movies) {
      if (movie.id == id) {
        return true;
      }
    }

    return false;
  }

  bool isEmpty() {
    return _movies.isEmpty;
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

  ThemeState() {
    readPreference().then((theme) {
      _key = theme;
      notifyListeners();
    });
  }

  void changeTheme(String key) {
    _key = key;
    writePreference(_key).then((_) {
      notifyListeners();
    });
  }

  Future<String> readPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('theme')) {
      return prefs.getString('theme');
    }
    return 'Dark';
  }

  Future<void> writePreference(String theme) async {
    print('write preference : ' + theme);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
  }
}
