import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class NaverApiResponse {
  String lastBuildDate;
  List<MovieData> items;

  NaverApiResponse(this.lastBuildDate, this.items);

  factory NaverApiResponse.fromJson(Map<String, dynamic> json) =>
      _$NaverApiResponseFromJson(json);

  @override
  String toString() {
    return '$lastBuildDate , ${items.toString()}';
  }
}

// title	string	검색 결과 영화의 제목을 나타낸다. 제목에서 검색어와 일치하는 부분은 태그로 감싸져 있다.
// link	string	검색 결과 영화의 하이퍼텍스트 link를 나타낸다.
// image	string	검색 결과 영화의 썸네일 이미지의 URL이다. 이미지가 있는 경우만 나타난다.
// subtitle	string	검색 결과 영화의 영문 제목이다.
// pubDate	date	검색 결과 영화의 제작년도이다.
// director	string	검색 결과 영화의 감독이다.
// actor	string	검색 결과 영화의 출연 배우이다.
// userRating	integer	검색 결과 영화에 대한 유저들의 평점이다.

@JsonSerializable()
class MovieData {
  String title;
  String link;
  String image;
  String subtitle;
  String pubDate;
  String director;
  String actor;
  String userRating;

  MovieData(this.title, this.link, this.image, this.subtitle, this.pubDate,
      this.director, this.actor, this.userRating);

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      _$MovieDataFromJson(json);

  @override
  String toString() {
    return '[ $title, $link, $image, $subtitle, $pubDate, $director, $actor, $userRating ]';
  }
}
