import 'dart:convert';

import 'package:flutter_list/network/data.dart';
import 'package:http/http.dart' as http;

class MovieDBApi {
  static final _KEY = '2bafb8eb9137df7d37ed1fe043ad7596';
  static final _URL_MOVIE_LIST =
      "https://api.themoviedb.org/3/movie/now_playing";
  static final _URL_GENRE_LIST =
      "https://api.themoviedb.org/3/genre/movie/list";

  static MovieDBApiResponse _cachedMovieDBApiResponse;

  static String getMoviesForGenre(int genreId, int page) {
    return 'https://api.themoviedb.org/3/discover/movie?api_key=$_KEY'
        '&language=ko-KR'
        '&sort_by=popularity.desc'
        '&include_adult=false'
        '&include_video=false'
        '&page=$page'
        '&with_genres=$genreId';
  }

  static Future<List<Movie>> getRelatedGenreMovies(int id) async {

    http.Response response = await http.get(
        Uri.encodeFull(getMoviesForGenre(id, 1)),
        headers: {
          "Content-type": "application/json",
        });
    Map responseMap = jsonDecode(response.body);
    var apiResponse = MovieDBApiResponse.fromJson(responseMap);

    return apiResponse.results;
  }

  static Future<List<Movie>> getPlayNow() async {

    http.Response response = await http.get(
        Uri.encodeFull('$_URL_MOVIE_LIST?api_key=$_KEY&language=ko-KR&page=1/'),
        headers: {
          "Content-type": "application/json",
        });
    Map responseMap = jsonDecode(response.body);
    var apiResponse = MovieDBApiResponse.fromJson(responseMap);

    return apiResponse.results;
  }


  static Future<MovieDBApiResponse> getData() async {
    if (_cachedGenresApiResponse != null) {
      return _cachedMovieDBApiResponse;
    }

    http.Response response = await http.get(
        Uri.encodeFull('$_URL_MOVIE_LIST?api_key=$_KEY&language=ko-KR&page=1/'),
        headers: {
          "Content-type": "application/json",
        });
    Map responseMap = jsonDecode(response.body);
    var apiResponse = MovieDBApiResponse.fromJson(responseMap);

    _cachedMovieDBApiResponse = apiResponse;

    return apiResponse;
  }

  static GenresApiResponse _cachedGenresApiResponse;

  static Future<GenresApiResponse> getGenres() async {
    if (_cachedGenresApiResponse != null) {
      return _cachedGenresApiResponse;
    }

    http.Response response = await http.get(
        Uri.encodeFull('$_URL_GENRE_LIST?api_key=$_KEY&language=ko-KR&page=1/'),
        headers: {
          "Content-type": "application/json",
        });

    Map responseMap = jsonDecode(response.body);
    var apiResponse = GenresApiResponse.fromJson(responseMap);
    _cachedGenresApiResponse = apiResponse;

    return apiResponse;
  }
}
