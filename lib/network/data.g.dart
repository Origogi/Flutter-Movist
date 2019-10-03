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
      json['title'] as String,
      json['poster_path'] as String,
      json['backdrop_path'] as String,
      json['vote_average'] as num,
      json['vote_count'] as int,
      json['overview'] as String);
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'title': instance.title,
      'poster_path': instance.poster_path,
      'backdrop_path': instance.backdrop_path,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
      'overview': instance.overview
    };
