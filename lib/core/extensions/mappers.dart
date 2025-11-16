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
          attributes.posterImage?.original ?? attributes.posterImage?.medium,
      coverImageUrl:
          attributes.coverImage?.large ?? attributes.coverImage?.original,
      averageRating: double.tryParse(attributes.averageRating ?? '') ?? 0.0,
      episodeCount: attributes.episodeCount,
      showType: attributes.showType,
      status: attributes.status,
    );
  }
}
