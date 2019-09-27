import 'dart:convert';

import 'package:flutter_list/network/data.dart';
import 'package:http/http.dart' as http;

class NaverApi {
  static final _NAVER_CLIENT_ID = "mtmtWRcB2f2_xXOoBOE5";
  static final _NAVER_CLIENT_KEY = "0hjx2Vr4yY";

  static final _URL = "https://openapi.naver.com/v1/search/movie.json";

  static Map<String, NaverApiResponse> _cache = {};

  static Future<NaverApiResponse> getData({String query}) async {

    http.Response response =
        await http.get(Uri.encodeFull('$_URL?query=$query/'), headers: {
      "Content-type": "application/json",
      "X-Naver-Client-Id": _NAVER_CLIENT_ID,
      "X-Naver-Client-Secret": _NAVER_CLIENT_KEY
    });

    Map responseMap = jsonDecode(response.body);

    var naverApiResponse = NaverApiResponse.fromJson(responseMap);
    return naverApiResponse;
  }
}

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

    return null;    
  }
}

