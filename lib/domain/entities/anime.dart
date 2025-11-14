import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime.freezed.dart';
part 'anime.g.dart';

@freezed
abstract class Anime with _$Anime {
  const factory Anime({
    required String id,
    required String canonicalTitle,
    required String synopsis,
    String? description,
    String? posterImageUrl,
    String? coverImageUrl,
    String? averageRating,
    int? episodeCount,
    String? showType,
    String? status,
  }) = _Anime;

  factory Anime.fromJson(Map<String, Object?> json) => _$AnimeFromJson(json);
}
