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
  int id;
  String title;
  String poster_path;
  String backdrop_path;
  num vote_average;
  int vote_count;
  String overview;
  List<int> genre_ids;
  List<Genre> genres;
  String release_date;

  Movie(this.id, this.title, this.poster_path, this.backdrop_path,
      this.vote_average, this.vote_count, this.overview);

  static final URL = "https://image.tmdb.org/t/p/w500";
  String get posterUrl {
    if (poster_path == null) {
      return '';
    }

    return URL + poster_path;
  }
  String get backDropUrl {
    if (backdrop_path == null) {
      return '';
    }

    return URL + backdrop_path;
  }

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  @override
  String toString() {
    return "[ $id, $title, $poster_path, $backdrop_path, $vote_average, $vote_count, $overview, ${genre_ids.toString()} ]";
  }
}

@JsonSerializable()
class GenresApiResponse {
  List<Genre> genres;

  Map<int, String> get genresMap {
    Map<int, String> map = {};

    genres.forEach((genre) {
      map[genre.id] = genre.name;
    });

    return map;
  }

  GenresApiResponse(this.genres);

  factory GenresApiResponse.fromJson(Map<String, dynamic> json) =>
      _$GenresApiResponseFromJson(json);
}

@JsonSerializable()
class Genre {
  int id;
  String name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  @override
  String toString() {
    return "[ $id, $name]";
  }
}
