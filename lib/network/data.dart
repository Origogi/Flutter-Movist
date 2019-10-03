import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';
//flutter pub run build_runner build 

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
  String backdrop_path;
  num vote_average;
  int vote_count;
  String overview;


  Movie(this.title, this.poster_path, this.backdrop_path, this.vote_average, this.vote_count, this.overview);

  static final URL = "https://image.tmdb.org/t/p/w500";
  String get posterUrl => URL + poster_path;
  String get backDropUrl => URL + backdrop_path;

    factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  @override
  String toString() {
    return "[ $title, $poster_path, $backdrop_path, $vote_average, $vote_count, $overview";
  }
}