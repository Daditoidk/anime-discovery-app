// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Anime _$AnimeFromJson(Map<String, dynamic> json) => _Anime(
  id: json['id'] as String,
  canonicalTitle: json['canonicalTitle'] as String,
  synopsis: json['synopsis'] as String,
  description: json['description'] as String?,
  posterImageUrl: json['posterImageUrl'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  episodeCount: (json['episodeCount'] as num?)?.toInt(),
  showType: json['showType'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$AnimeToJson(_Anime instance) => <String, dynamic>{
  'id': instance.id,
  'canonicalTitle': instance.canonicalTitle,
  'synopsis': instance.synopsis,
  'description': instance.description,
  'posterImageUrl': instance.posterImageUrl,
  'coverImageUrl': instance.coverImageUrl,
  'averageRating': instance.averageRating,
  'episodeCount': instance.episodeCount,
  'showType': instance.showType,
  'status': instance.status,
};
