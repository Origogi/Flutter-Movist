import 'dart:convert';

import 'package:flutter_list/network/data.dart';
import 'package:http/http.dart' as http;

class MovieDBApi {
  static final _KEY = '2bafb8eb9137df7d37ed1fe043ad7596';
  static final _URL = "https://api.themoviedb.org/3/movie/upcoming";

static Future<MovieDBApiResponse> getData() async {

    print('HTTP GET ');
    http.Response response =
        await http.get(Uri.encodeFull('$_URL?api_key=$_KEY&language=ko-KR&page=1/'), headers: {
      "Content-type": "application/json",
    });
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    var apiResponse = MovieDBApiResponse.fromJson(responseMap);

    return apiResponse;    
  }
}

