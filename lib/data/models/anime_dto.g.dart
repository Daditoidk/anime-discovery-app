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
      posterImageUrl: json['posterImageUrl'] == null
          ? null
          : PosterImageDto.fromJson(
              json['posterImageUrl'] as Map<String, dynamic>,
            ),
      coverImageUrl: json['coverImageUrl'] == null
          ? null
          : CoverageImageDto.fromJson(
              json['coverImageUrl'] as Map<String, dynamic>,
            ),
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
      'posterImageUrl': instance.posterImageUrl,
      'coverImageUrl': instance.coverImageUrl,
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

_CoverageImageDto _$CoverageImageDtoFromJson(Map<String, dynamic> json) =>
    _CoverageImageDto(
      tiny: json['tiny'] as String?,
      small: json['small'] as String?,
      large: json['large'] as String?,
      original: json['original'] as String?,
    );

Map<String, dynamic> _$CoverageImageDtoToJson(_CoverageImageDto instance) =>
    <String, dynamic>{
      'tiny': instance.tiny,
      'small': instance.small,
      'large': instance.large,
      'original': instance.original,
    };
