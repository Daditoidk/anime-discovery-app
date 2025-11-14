import 'package:anime_discovery_app/data/models/anime_dto.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';

extension AnimeDtoMapper on AnimeDto {
  Anime toEntity() {
    return Anime(
      id: id,
      canonicalTitle: attributes.canonicalTitle,
      synopsis: attributes.synopsis,
      description: attributes.description,
      posterImageUrl:
          attributes.posterImageUrl?.medium ??
          attributes.posterImageUrl?.original,
      coverImageUrl:
          attributes.coverImageUrl?.large ?? attributes.coverImageUrl?.original,
      averageRating: double.tryParse(attributes.averageRating ?? '') ?? 0.0,
      episodeCount: attributes.episodeCount,
      showType: attributes.showType,
      status: attributes.status,
    );
  }
}
