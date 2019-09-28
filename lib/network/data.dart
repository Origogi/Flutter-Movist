import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class MovieDBApiResponse {
  List<Movie> results;

  MovieDBApiResponse(this.results);

    factory MovieDBApiResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDBApiResponseFromJson(json);
}

@JsonSerializable()
class Movie {
  String title;
  String poster_path;

  Movie(this.title, this.poster_path);

  String get posterUrl => "https://image.tmdb.org/t/p/w500" + poster_path;

    factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);
}