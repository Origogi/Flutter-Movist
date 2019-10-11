import 'package:flutter/material.dart';

class FavoriteModel extends ChangeNotifier  {

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
}
