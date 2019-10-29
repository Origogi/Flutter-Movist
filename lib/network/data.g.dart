// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDBApiResponse _$MovieDBApiResponseFromJson(Map<String, dynamic> json) {
  return MovieDBApiResponse((json['results'] as List)
      ?.map((e) => e == null ? null : Movie.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$MovieDBApiResponseToJson(MovieDBApiResponse instance) =>
    <String, dynamic>{'results': instance.results};

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
      json['id'] as int,
      json['title'] as String,
      json['poster_path'] as String,
      json['backdrop_path'] as String,
      json['vote_average'] as num,
      json['vote_count'] as int,
      json['overview'] as String)
    ..genre_ids = (json['genre_ids'] as List)?.map((e) => e as int)?.toList()
    ..genres = (json['genres'] as List)
        ?.map(
            (e) => e == null ? null : Genre.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..release_date = json['release_date'] as String;
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.poster_path,
      'backdrop_path': instance.backdrop_path,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
      'overview': instance.overview,
      'genre_ids': instance.genre_ids,
      'genres': instance.genres,
      'release_date': instance.release_date
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
