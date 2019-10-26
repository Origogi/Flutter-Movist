import 'dart:convert';

import 'package:flutter_list/network/data.dart';
import 'package:http/http.dart' as http;

class MovieDBApi {
  static final _KEY = '2bafb8eb9137df7d37ed1fe043ad7596';
  static final _URL_MOVIE_LIST =
      "https://api.themoviedb.org/3/movie/now_playing";
  static final _URL_GENRE_LIST =
      "https://api.themoviedb.org/3/genre/movie/list";

  static String moviesForGenreURL(int genreId, int page) {
    return 'https://api.themoviedb.org/3/discover/movie?api_key=$_KEY'
        '&language=ko-KR'
        '&sort_by=popularity.desc'
        '&page=$page'
        '&with_genres=$genreId';
  }

  static String movieDetailsUrl(int movieId) {
    return 'https://api.themoviedb.org/3/movie/$movieId?api_key=$_KEY&append_to_response=credits,'
        'images';
  }


 static Future<Movie> getDetailMovie(int id) async {

    http.Response response = await http.get(
        Uri.encodeFull(movieDetailsUrl(id)),
        headers: {
          "Content-type": "application/json",
        });
    Map responseMap = jsonDecode(response.body);
    var movie = Movie.fromJson(responseMap);

    return movie;
  }

   static Future<List<Movie>> getDetailMovies(List<int> IDs) async {

    List<Movie> movies = [];

    // bug
    for (int id in IDs) {
      http.Response response = await http.get(
        Uri.encodeFull(movieDetailsUrl(id)),
        headers: {
          "Content-type": "application/json",
        });
      Map responseMap = jsonDecode(response.body);
      var movie = Movie.fromJson(responseMap);
      movies.add(movie);
    }
    return movies;
  }

  static Future<List<Movie>> getRelatedGenreMovies(int id) async {

    http.Response response = await http.get(
        Uri.encodeFull(moviesForGenreURL(id, 1)),
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



  static Future<GenresApiResponse> getGenres() async {

    http.Response response = await http.get(
        Uri.encodeFull('$_URL_GENRE_LIST?api_key=$_KEY&language=ko-KR&page=1/'),
        headers: {
          "Content-type": "application/json",
        });

    Map responseMap = jsonDecode(response.body);
    var apiResponse = GenresApiResponse.fromJson(responseMap);

    return apiResponse;
  }
}
