import 'dart:convert';

import 'package:flutter_list/logger/logger.dart';
import 'package:flutter_list/model/models.dart';
import 'package:http/http.dart' as http;

class MovieDBApi {
  static final _apiKey = '2bafb8eb9137df7d37ed1fe043ad7596';
  static var localeCode = "";

  static String moviesForGenreUrl(genreId, page) {
    return 'https://api.themoviedb.org/3/discover/movie'
        '?api_key=$_apiKey'
        '&language=$localeCode'
        '&sort_by=popularity.desc'
        '&page=$page'
        '&with_genres=$genreId';
  }

  static String movieDetailsUrl(movieId) {
    return 'https://api.themoviedb.org/3/movie/'
        '?api_key=$_apiKey'
        '$movieId'
        '&append_to_response=credits,'
        'images'
        '&language=$localeCode';
  }

  static String creditsUrl(id) {
    return 'https://api.themoviedb.org/3/movie/$id/credits'
        '?api_key=$_apiKey'
        '&language=$localeCode'
        '&page=1/';
  }

  static String moviePlayNowUrl() {
    return 'https://api.themoviedb.org/3/movie/now_playing'
        '?api_key=$_apiKey'
        '&language=$localeCode'
        '&page=1/';
  }

  static String popularUrl() {
    return 'https://api.themoviedb.org/3/movie/popular'
        '?api_key=$_apiKey'
        '&language=$localeCode'
        '&page=1/';
  }

  static String getGenresUrl() {
    return 'https://api.themoviedb.org/3/genre/movie/list'
        '?api_key=$_apiKey'
        '&language=$localeCode';
  }

  static String movieSearchUrl(String query) {
    return 'https://api.themoviedb.org/3/search/movie'
        '?query=$query'
        '&language=$localeCode'
        '&api_key=$_apiKey';
  }

  static String personDetailUrl(int id) {
    return 'https://api.themoviedb.org/3/person/$id'
        '?api_key=$_apiKey';
    // '&language=ko-KR';
  }

  static String movieCreditsUrl(int id) {
    return 'https://api.themoviedb.org/3/person/$id/movie_credits'
        '?api_key=$_apiKey'
        '&language=$localeCode';
  }

  static Future<Movie> getDetailMovie(int id, localeCode) async {
    http.Response response =
        await http.get(Uri.encodeFull(movieDetailsUrl(id)), headers: {
      "Content-type": "application/json",
    });

    DLog.d('getDetailMovie : ' + response.statusCode.toString());

    Map responseMap = jsonDecode(response.body);
    var movie = Movie.fromJson(responseMap);

    return movie;
  }

  static Future<List<Movie>> getRelatedGenreMovies(int id) async {
    http.Response response =
        await http.get(Uri.encodeFull(moviesForGenreUrl(id, 1)), headers: {
      "Content-type": "application/json",
    });

    DLog.d('getRelatedGenreMovies : ' + response.statusCode.toString());

    Map responseMap = jsonDecode(response.body);
    var apiResponse = MovieResult.fromJson(responseMap);

    return apiResponse.movies;
  }

  static Future<List<Movie>> getPlayNow() async {
    http.Response response =
        await http.get(Uri.encodeFull(moviePlayNowUrl()), headers: {
      "Content-type": "application/json",
    });
    DLog.d('getPlayNow : ' + response.statusCode.toString());

    Map responseMap = jsonDecode(response.body);

    var apiResponse = MovieResult.fromJson(responseMap);

    return apiResponse.movies;
  }

  static Future<List<Movie>> getTopRate() async {
    http.Response response =
        await http.get(Uri.encodeFull(popularUrl()), headers: {
      "Content-type": "application/json",
    });

    DLog.d('getTopRate : ' + response.statusCode.toString());

    Map responseMap = jsonDecode(response.body);
    var apiResponse = MovieResult.fromJson(responseMap);

    return apiResponse.movies;
  }

  static Future<List<Movie>> searchMovies(String query) async {
    http.Response response =
        await http.get(Uri.encodeFull(movieSearchUrl(query)), headers: {
      "Content-type": "application/json",
    });

    Map responseMap = jsonDecode(response.body);
    var apiResponse = MovieResult.fromJson(responseMap);

    return apiResponse.movies;
  }

  static Future<Map<int, String>> getGenres() async {
    http.Response response =
        await http.get(Uri.encodeFull(getGenresUrl()), headers: {
      "Content-type": "application/json",
    });
    DLog.d('getGenres : ' + response.statusCode.toString());

    Map responseMap = jsonDecode(response.body);
    var apiResponse = GenresApiResponse.fromJson(responseMap);

    return apiResponse.genresMap;
  }

  static Future<CreaditResult> getCasts(movieID) async {
    http.Response response =
        await http.get(Uri.encodeFull(creditsUrl(movieID)), headers: {
      "Content-type": "application/json",
    });
    DLog.d('getCasts : ' + response.statusCode.toString());

    Map responseMap = jsonDecode(response.body);

    var apiResponse = CreaditResult.fromJson(responseMap);

    return apiResponse;
  }

  static Future<Person> getPerson(personID) async {
    http.Response response =
        await http.get(Uri.encodeFull(personDetailUrl(personID)), headers: {
      "Content-type": "application/json",
    });

    DLog.d('getPerson : ' + response.statusCode.toString());

    Map responseMap = jsonDecode(response.body);

    var apiResponse = Person.fromJson(responseMap);

    return apiResponse;
  }

  static Future<List<Movie>> getMovieCredits(personID) async {
    http.Response response =
        await http.get(Uri.encodeFull(movieCreditsUrl(personID)), headers: {
      "Content-type": "application/json",
    });

    DLog.d('getMovieCredits : ' + response.statusCode.toString());

    Map responseMap = jsonDecode(response.body);

    var apiResponse = MovieCredits.fromJson(responseMap);

    return apiResponse.movies;
  }
}
