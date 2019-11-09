// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResult _$MovieResultFromJson(Map<String, dynamic> json) {
  return MovieResult((json['results'] as List)
      ?.map((e) => e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$MovieResultToJson(MovieResult instance) =>
    <String, dynamic>{'results': instance.movies};

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String,
      backdropPath: json['backdrop_path'] as String,
      voteAverage: json['vote_average'] as num,
      voteCount: json['vote_count'] as int,
      overview: json['overview'] as String,
      genreIDs: (json['genre_ids'] as List)?.map((e) => e as int)?.toList(),
      genres: (json['genres'] as List)
          ?.map((e) =>
              e == null ? null : Genre.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      releaseDate: json['release_date'] as String);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'overview': instance.overview,
      'genre_ids': instance.genreIDs,
      'genres': instance.genres,
      'release_date': instance.releaseDate
    };

GenresApiResponse _$GenresApiResponseFromJson(Map<String, dynamic> json) {
  return GenresApiResponse((json['genres'] as List)
      ?.map((e) => e == null ? null : Genre.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$GenresApiResponseToJson(GenresApiResponse instance) =>
    <String, dynamic>{'genres': instance.genres};

Genre _$GenreFromJson(Map<String, dynamic> json) {
  return Genre(id: json['id'] as int, name: json['name'] as String);
}

Map<String, dynamic> _$GenreToJson(Genre instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

Cast _$CastFromJson(Map<String, dynamic> json) {
  return Cast(
      castID: json['cast_id'],
      character: json['character'],
      gender: json['gender'],
      id: json['id'],
      name: json['name'],
      order: json['order'],
      profilePath: json['profile_path']);
}

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'cast_id': instance.castID,
      'character': instance.character,
      'gender': instance.gender,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'profile_path': instance.profilePath
    };
