import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_dto.freezed.dart';
part 'anime_dto.g.dart';

@freezed
abstract class AnimeDto with _$AnimeDto {
  const factory AnimeDto({
    required String id,
    required String type,
    required AnimeAttributesDto attributes,
  }) = _AnimeDto;

  factory AnimeDto.fromJson(Map<String, dynamic> json) =>
      _$AnimeDtoFromJson(json);
}

@freezed
abstract class AnimeAttributesDto with _$AnimeAttributesDto {
  const factory AnimeAttributesDto({
    required String canonicalTitle,
    required String synopsis,
    String? description,
    PosterImageDto? posterImage,
    CoverImageDto? coverImage,
    String? averageRating,
    int? episodeCount,
    String? showType,
    String? status,
  }) = _AnimeAttributesDto;

  factory AnimeAttributesDto.fromJson(Map<String, dynamic> json) =>
      _$AnimeAttributesDtoFromJson(json);
}

@freezed
abstract class PosterImageDto with _$PosterImageDto {
  const factory PosterImageDto({
    String? tiny,
    String? small,
    String? medium,
    String? large,
    String? original,
  }) = _PosterImageDto;

  factory PosterImageDto.fromJson(Map<String, dynamic> json) =>
      _$PosterImageDtoFromJson(json);
}

@freezed
abstract class CoverImageDto with _$CoverImageDto {
  const factory CoverImageDto({
    String? tiny,
    String? small,
    String? large,
    String? original,
  }) = _CoverImageDto;

  factory CoverImageDto.fromJson(Map<String, dynamic> json) =>
      _$CoverImageDtoFromJson(json);
}


