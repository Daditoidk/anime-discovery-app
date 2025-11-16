// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnimeDto _$AnimeDtoFromJson(Map<String, dynamic> json) => _AnimeDto(
  id: json['id'] as String,
  type: json['type'] as String,
  attributes: AnimeAttributesDto.fromJson(
    json['attributes'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AnimeDtoToJson(_AnimeDto instance) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'attributes': instance.attributes,
};

_AnimeAttributesDto _$AnimeAttributesDtoFromJson(Map<String, dynamic> json) =>
    _AnimeAttributesDto(
      canonicalTitle: json['canonicalTitle'] as String,
      synopsis: json['synopsis'] as String,
      description: json['description'] as String?,
      posterImage: json['posterImage'] == null
          ? null
          : PosterImageDto.fromJson(
              json['posterImage'] as Map<String, dynamic>,
            ),
      coverImage: json['coverImage'] == null
          ? null
          : CoverImageDto.fromJson(json['coverImage'] as Map<String, dynamic>),
      averageRating: json['averageRating'] as String?,
      episodeCount: (json['episodeCount'] as num?)?.toInt(),
      showType: json['showType'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AnimeAttributesDtoToJson(_AnimeAttributesDto instance) =>
    <String, dynamic>{
      'canonicalTitle': instance.canonicalTitle,
      'synopsis': instance.synopsis,
      'description': instance.description,
      'posterImage': instance.posterImage,
      'coverImage': instance.coverImage,
      'averageRating': instance.averageRating,
      'episodeCount': instance.episodeCount,
      'showType': instance.showType,
      'status': instance.status,
    };

_PosterImageDto _$PosterImageDtoFromJson(Map<String, dynamic> json) =>
    _PosterImageDto(
      tiny: json['tiny'] as String?,
      small: json['small'] as String?,
      medium: json['medium'] as String?,
      large: json['large'] as String?,
      original: json['original'] as String?,
    );

Map<String, dynamic> _$PosterImageDtoToJson(_PosterImageDto instance) =>
    <String, dynamic>{
      'tiny': instance.tiny,
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
      'original': instance.original,
    };

_CoverImageDto _$CoverImageDtoFromJson(Map<String, dynamic> json) =>
    _CoverImageDto(
      tiny: json['tiny'] as String?,
      small: json['small'] as String?,
      large: json['large'] as String?,
      original: json['original'] as String?,
    );

Map<String, dynamic> _$CoverImageDtoToJson(_CoverImageDto instance) =>
    <String, dynamic>{
      'tiny': instance.tiny,
      'small': instance.small,
      'large': instance.large,
      'original': instance.original,
    };
