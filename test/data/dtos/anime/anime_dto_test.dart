import 'package:anime_discovery_app/core/constants/const.dart';
import 'package:anime_discovery_app/core/extensions/mappers.dart';
import 'package:anime_discovery_app/data/models/anime_dto.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnimeDto', () {
    test('should create AnimeDto from JSON', () {
      //arrange
      final json = {
        'id': '1',
        'type': 'anime',
        'attributes': {
          'synopsis': '',
          'canonicalTitle': 'Naruto',
          'posterImage': {
            'original': 'https://example.com/naruto.jpg',
            'large': 'https://example.com/naruto_large.jpg',
          },
          'averageRating': '8.5',
        },
      };
      //act
      final result = AnimeDto.fromJson(json);

      //assert
      expect(result.id, '1');
      expect(result.type, kAnimeType);
      expect(result.attributes.canonicalTitle, 'Naruto');
      expect(result.attributes.posterImage?.large, contains('large.jpg'));
    });
    test('should convert AnimeDto to Anime entity', () {
      // arrange
      final dto = AnimeDto(
        id: '1',
        type: 'anime',
        attributes: AnimeAttributesDto(
          canonicalTitle: 'Naruto',
          posterImage: PosterImageDto(
            original: 'https://example.com/original.jpg',
            large: 'https://example.com/large.jpg',
          ),
          averageRating: '8.5',
          synopsis: '',
        ),
      );

      //act
      final result = dto.toEntity();

      //assert
      expect(result, isA<Anime>());
      expect(result.id, '1');
      expect(result.canonicalTitle, 'Naruto');
      expect(result.averageRating, 8.5);
      expect(result.posterImageUrl, contains('original.jpg'));
    });

    test(
      'should use medium poster image when original poster image is null',
      () {
        final dto = AnimeDto(
          id: '1',
          attributes: AnimeAttributesDto(
            canonicalTitle: 'Naruto',
            posterImage: PosterImageDto(
              medium: 'https://example.com/medium.jpg',
              original: null,
            ),
            averageRating: '8.5',
            synopsis: '',
          ),
          type: 'anime',
        );

        //act
        final result = dto.toEntity();

        //assert
        expect(result.posterImageUrl, contains('medium.jpg'));
      },
    );
    test('should use empty string when both poster images are null', () {
      final dto = AnimeDto(
        id: '1',
        attributes: AnimeAttributesDto(
          canonicalTitle: 'Naruto',
          posterImage: PosterImageDto(medium: null, original: null),
          averageRating: '8.5',
          synopsis: '',
        ),
        type: 'anime',
      );

      //act
      final result = dto.toEntity();

      //assert
      expect(result.posterImageUrl, null);
    });
    test('should handle invalid rating string', () {
      final dto = AnimeDto(
        id: '1',
        attributes: AnimeAttributesDto(
          canonicalTitle: 'Naruto',
          posterImage: PosterImageDto(medium: null, original: null),
          averageRating: 'invalid',
          synopsis: '',
        ),
        type: 'anime',
      );

      //act
      final result = dto.toEntity();

      //assert
      expect(result.averageRating, 0.0);
    });

    test('should handle null rating', () {
      final dto = AnimeDto(
        id: '1',
        attributes: AnimeAttributesDto(
          canonicalTitle: 'Naruto',
          posterImage: PosterImageDto(medium: null, original: null),
          averageRating: null,
          synopsis: '',
        ),
        type: 'anime',
      );

      //act
      final result = dto.toEntity();

      expect(result.averageRating, 0.0);
    });
  });
}
