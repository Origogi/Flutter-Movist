import 'package:json_annotation/json_annotation.dart';

//flutter pub run build_runner build

part 'models.g.dart';

final IMAGE_URL = "https://image.tmdb.org/t/p/w500";

@JsonSerializable()
class MovieResult {
  @JsonKey(name: 'results')
  List<Movie> movies;

  MovieResult(this.movies);

  factory MovieResult.fromJson(Map<String, dynamic> json) =>
      _$MovieResultFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResultToJson(this);
}

@JsonSerializable()
class MovieCredits {
  @JsonKey(name: 'cast')
  List<Movie> movies;

  MovieCredits(this.movies);

  factory MovieCredits.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCreditsToJson(this);
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

  String get posterUrl {
    if (posterPath == null) {
      return '';
    }

    return IMAGE_URL + posterPath;
  }

  String get backDropUrl {
    if (backdropPath == null) {
      return '';
    }

    return IMAGE_URL + backdropPath;
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

@JsonSerializable()
class CreaditResult {
  @JsonKey(name: 'cast')
  List<Cast> casts;

  @JsonKey(name: 'crew')
  List<Crew> crews;

  CreaditResult(this.casts);

  factory CreaditResult.fromJson(Map<String, dynamic> json) =>
      _$CreaditResultFromJson(json);

  Map<String, dynamic> toJson() => _$CreaditResultToJson(this);
}

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

  String get profileUrl {
    if (profilePath == null) {
      return '';
    }

    return IMAGE_URL + profilePath;
  }

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

@JsonSerializable()
class Crew {
  @JsonKey(name: 'credit_id')
  final creditID;

  final department;
  final gender;
  final id;
  final job;
  final name;

  @JsonKey(name: 'profile_path')
  final profilePath;

  String get profileUrl {
    if (profilePath == null) {
      return '';
    }

    return IMAGE_URL + profilePath;
  }

  Crew(this.creditID, this.department, this.gender, this.id, this.job,
      this.name, this.profilePath);

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
}

@JsonSerializable()
class Person {
  final creditID;
  final birthday;

  @JsonKey(name: 'known_for_department')
  final knownForDepartment;

  final id;
  final name;

  @JsonKey(name: 'also_known_as')
  final List<String> alsoKnownAs;
  final gender;
  final biography;
  final popularity;

  @JsonKey(name: 'place_of_birth')
  final placeOfBirth;

  @JsonKey(name: 'profile_path')
  final profilePath;

  @JsonKey(name: 'imdb_id')
  final imdbID;
  final homepage;

  Person(
      this.creditID,
      this.birthday,
      this.knownForDepartment,
      this.id,
      this.name,
      this.alsoKnownAs,
      this.gender,
      this.biography,
      this.popularity,
      this.placeOfBirth,
      this.profilePath,
      this.imdbID,
      this.homepage);

  String get profileUrl {
    if (profilePath == null) {
      return '';
    }

    return IMAGE_URL + profilePath;
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
