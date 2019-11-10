import 'package:json_annotation/json_annotation.dart';

//flutter pub run build_runner build

part 'models.g.dart';

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
class CreaditResult {
  @JsonKey(name: 'cast')
  List<Cast> casts;

  @JsonKey(name: 'crew')
  List<Crew> crews;

  // @JsonKey(name: 'cast')
  // List<Cast> casts;

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

  static final URL = "https://image.tmdb.org/t/p/w500";

  String get profileUrl {
    if (profilePath == null) {
      return '';
    }

    return URL + profilePath;
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

//  "credit_id": "52fe4250c3a36847f8014a47",
//       "department": "Directing",
//       "gender": 2,
//       "id": 7467,
//       "job": "Director",
//       "name": "David Fincher",
//       "profile_path": "/dcBHejOsKvzVZVozWJAPzYthb8X.jpg"
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

  static final URL = "https://image.tmdb.org/t/p/w500";

  String get profileUrl {
    if (profilePath == null) {
      return '';
    }

    return URL + profilePath;
  }

  Crew(this.creditID, this.department, this.gender, this.id, this.job,
      this.name, this.profilePath);

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);
}

//  "birthday": "1963-12-18",
//   "known_for_department": "Acting",
//   "deathday": null,
//   "id": 287,
//   "name": "Brad Pitt",
//   "also_known_as": [
//     "برد پیت",
//     "Бред Питт",
//     "Бред Пітт",
//     "Buratto Pitto",
//     "Брэд Питт",
//     "畢·彼特",
//     "ブラッド・ピット",
//     "브래드 피트",
//     "براد بيت",
//     "แบรด พิตต์"
//   ],
//   "gender": 2,
//   "biography": "William Bradley \"Brad\" Pitt (born December 18, 1963) is an American actor and film producer. Pitt has received two Academy Award nominations and four Golden Globe Award nominations, winning one. He has been described as one of the world's most attractive men, a label for which he has received substantial media attention. Pitt began his acting career with television guest appearances, including a role on the CBS prime-time soap opera Dallas in 1987. He later gained recognition as the cowboy hitchhiker who seduces Geena Davis's character in the 1991 road movie Thelma & Louise. Pitt's first leading roles in big-budget productions came with A River Runs Through It (1992) and Interview with the Vampire (1994). He was cast opposite Anthony Hopkins in the 1994 drama Legends of the Fall, which earned him his first Golden Globe nomination. In 1995 he gave critically acclaimed performances in the crime thriller Seven and the science fiction film 12 Monkeys, the latter securing him a Golden Globe Award for Best Supporting Actor and an Academy Award nomination.\n\nFour years later, in 1999, Pitt starred in the cult hit Fight Club. He then starred in the major international hit as Rusty Ryan in Ocean's Eleven (2001) and its sequels, Ocean's Twelve (2004) and Ocean's Thirteen (2007). His greatest commercial successes have been Troy (2004) and Mr. & Mrs. Smith (2005).\n\nPitt received his second Academy Award nomination for his title role performance in the 2008 film The Curious Case of Benjamin Button. Following a high-profile relationship with actress Gwyneth Paltrow, Pitt was married to actress Jennifer Aniston for five years. Pitt lives with actress Angelina Jolie in a relationship that has generated wide publicity. He and Jolie have six children—Maddox, Pax, Zahara, Shiloh, Knox, and Vivienne.\n\nSince beginning his relationship with Jolie, he has become increasingly involved in social issues both in the United States and internationally. Pitt owns a production company named Plan B Entertainment, whose productions include the 2007 Academy Award winning Best Picture, The Departed.",
//   "popularity": 10.647,
//   "place_of_birth": "Shawnee, Oklahoma, USA",
//   "profile_path": "/kU3B75TyRiCgE270EyZnHjfivoq.jpg",
//   "adult": false,
//   "imdb_id": "nm0000093",
//   "homepage": null
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

  static final URL = "https://image.tmdb.org/t/p/w500";

  Person(this.creditID, this.birthday, this.knownForDepartment, this.id, this.name, this.alsoKnownAs, this.gender, this.biography, this.popularity, this.placeOfBirth, this.profilePath, this.imdbID, this.homepage);


  String get profileUrl {
    if (profilePath == null) {
      return '';
    }

    return URL + profilePath;
  }

    factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

}
