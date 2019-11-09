import 'package:json_annotation/json_annotation.dart';

//flutter pub run build_runner build

part 'models.g.dart';

@JsonSerializable()
class MovieResult {
  @JsonKey(name: 'results')
  List<Movie> movies;

  // @JsonKey(name: 'cast')
  // List<Cast> casts;

  MovieResult(this.movies);

  factory MovieResult.fromJson(Map<String, dynamic> json) =>
      _$MovieResultFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResultToJson(this); 

}

@JsonSerializable()
class Movie {
  final int id;
  final String title;

  @JsonKey(name: 'poster_path')
  final String posterPath;

  @JsonKey(name: 'backdrop_path')
  final String backdropPath;

  @JsonKey(name: 'vote_average')
  final num voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;
  final String overview;

  @JsonKey(name: 'genre_ids')
  final List<int> genreIDs;

  final List<Genre> genres;

  @JsonKey(name: 'release_date')
  final String releaseDate;

  Movie(
      {this.id,
      this.title,
      this.posterPath,
      this.backdropPath,
      this.voteAverage,
      this.voteCount,
      this.overview,
      this.genreIDs,
      this.genres,
      this.releaseDate});

  static final URL = "https://image.tmdb.org/t/p/w500";
  String get posterUrl {
    if (posterPath == null) {
      return '';
    }

    return URL + posterPath;
  }

  String get backDropUrl {
    if (backdropPath == null) {
      return '';
    }

    return URL + backdropPath;
  }

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this); 

  @override
  String toString() {
    return "[ $id, $title, $posterPath, $backdropPath, $voteAverage, $voteCount, $overview, ${genreIDs.toString()} ]";
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

// "cast_id": 4,
//       "character": "The Narrator",
//       "credit_id": "52fe4250c3a36847f80149f3",
//       "gender": 2,
//       "id": 819,
//       "name": "Edward Norton",
//       "order": 0,
//       "profile_path":
@JsonSerializable()
class Cast {
  @JsonKey(name: 'cast_id')
  final castID;
  final character;
  final gender;
  final id;
  final name;
  final order;

  @JsonKey(name: 'profile_path')
  final profilePath;

  Cast(
      {this.castID,
      this.character,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath});

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}
