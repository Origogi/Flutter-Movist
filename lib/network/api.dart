import 'dart:convert';

import 'package:flutter_list/network/data.dart';
import 'package:http/http.dart' as http;

class MovieDBApi {
  static final _KEY = '2bafb8eb9137df7d37ed1fe043ad7596';
  static final _URL_MOVIE_LIST = "https://api.themoviedb.org/3/movie/upcoming";
  static final _URL_GENRE_LIST =
      "https://api.themoviedb.org/3/genre/movie/list";

  static Future<MovieDBApiResponse> getData() async {
    http.Response response = await http.get(
        Uri.encodeFull('$_URL_MOVIE_LIST?api_key=$_KEY&language=ko-KR&page=1/'),
        headers: {
          "Content-type": "application/json",
        });
    Map responseMap = jsonDecode(response.body);
    var apiResponse = MovieDBApiResponse.fromJson(responseMap);

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
