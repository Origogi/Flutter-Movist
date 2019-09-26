import 'dart:convert';

import 'package:flutter_list/network/data.dart';
import 'package:http/http.dart' as http;

class NaverApi {
  static final _NAVER_CLIENT_ID = "mtmtWRcB2f2_xXOoBOE5";
  static final _NAVER_CLIENT_KEY = "0hjx2Vr4yY";

  static final _URL = "https://openapi.naver.com/v1/search/movie.json";

  static Map<String, NaverApiResponse> _cache = {};

  static Future<NaverApiResponse> getData({String query}) async {
    if (_cache[query] != null) {
      print('use cache : $query');
      return _cache[query];
    }

    print('HTTP GET : $query');
    http.Response response =
        await http.get(Uri.encodeFull('$_URL?query=$query/'), headers: {
      "Content-type": "application/json",
      "X-Naver-Client-Id": _NAVER_CLIENT_ID,
      "X-Naver-Client-Secret": _NAVER_CLIENT_KEY
    });

    Map responseMap = jsonDecode(response.body);

    var naverApiResponse = NaverApiResponse.fromJson(responseMap);
    _cache[query] = naverApiResponse;
    return _cache[query];
  }
}
