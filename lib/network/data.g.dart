// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaverApiResponse _$NaverApiResponseFromJson(Map<String, dynamic> json) {
  return NaverApiResponse(
      json['lastBuildDate'] as String,
      (json['items'] as List)
          ?.map((e) =>
              e == null ? null : MovieData.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NaverApiResponseToJson(NaverApiResponse instance) =>
    <String, dynamic>{
      'lastBuildDate': instance.lastBuildDate,
      'items': instance.items
    };

MovieData _$MovieDataFromJson(Map<String, dynamic> json) {
  return MovieData(
      json['title'] as String,
      json['link'] as String,
      json['image'] as String,
      json['subtitle'] as String,
      json['pubDate'] as String,
      json['director'] as String,
      json['actor'] as String,
      json['userRating'] as String);
}

Map<String, dynamic> _$MovieDataToJson(MovieData instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'image': instance.image,
      'subtitle': instance.subtitle,
      'pubDate': instance.pubDate,
      'director': instance.director,
      'actor': instance.actor,
      'userRating': instance.userRating
    };
