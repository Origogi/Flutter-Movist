
 import 'package:flutter_list/model/models.dart';

class CacheData {

  static Map<int, Movie> movieCache = {};
  static Map<int, String> genreCache = {};


  static void setMovieCache(Movie movie) {
    movieCache[movie.id] = movie;
  }

  static Movie getMovieCache(int id) {
    return movieCache[id];  
  }

    static void setGanreCache(Map<int, String> genres) {
    genreCache = genres;
  }

  static Map<int, String> getGanreCache() {
    return genreCache;  
  }

}