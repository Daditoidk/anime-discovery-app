import 'package:anime_discovery_app/core/failures/failure.dart';
import 'package:anime_discovery_app/data/datasources/kitsu_anime_remote_datasource.dart';
import 'package:anime_discovery_app/data/models/anime_dto.dart';
import 'package:anime_discovery_app/data/repositories/anime_repo_impl.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIKitsuAPIRemoteDataSource extends Mock
    implements IKitsuAPIRemoteDataSource {}

void main() {
  late AnimeRepositoryImpl repository;
  late MockIKitsuAPIRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockIKitsuAPIRemoteDataSource();
    repository = AnimeRepositoryImpl(mockDataSource);
  });

  //Happy path
  //Error path

  group('getPopularAnime()', () {
    final tAnimeDto = AnimeDto(
      id: '1',
      attributes: AnimeAttributesDto(
        canonicalTitle: 'Naruto',
        posterImage: PosterImageDto(
          original: 'https://example.com/naruto.jpg',
          large: 'https://example.com/naruto_large.jpg',
        ),
        averageRating: '8.5',
        synopsis: '',
      ),
      type: 'anime',
    );

    final tAnimeList = [tAnimeDto];

    test(
      'should return list of Anime when call to data source is successful',
      () async {
        //arrange
        when(
          mockDataSource.getPopularAnime,
        ).thenAnswer((_) async => tAnimeList);
        //act
        final result = await repository.getPopularAnime();
        //assert
        expect(result, isA<Right<dynamic, List<Anime>>>());

        result.fold((failure) => fail('Should return Right'), (animeList) {
          expect(animeList.length, 1);
          expect(animeList[0].id, '1');
          expect(animeList[0].canonicalTitle, 'Naruto');
          expect(animeList[0].averageRating, 8.5);
        });
      },
    ); //test happy path

    test(
      'should return Left with error message when data source throws',
      () async {
        // arrange
        when(
          mockDataSource.getPopularAnime,
        ).thenThrow(Exception('Network error'));

        //act
        final result = await repository.getPopularAnime();

        //assert
        expect(result, isA<Left<dynamic, List<Anime>>>());

        result.fold((failure) {
          expect(failure, isA<ApiFailure>());
          expect(failure.message, contains('Network error'));
        }, (animeList) => fail('Should return left'));
      },
    ); //test error network

    test('should map multiple DTOs correctly', () async {
      // arrange
      final tMultipleDtos = [
        tAnimeDto,
        AnimeDto(
          id: '2',
          attributes: AnimeAttributesDto(
            canonicalTitle: 'One Piece',
            posterImage: PosterImageDto(original: 'url', large: 'url'),
            averageRating: '9.0',
            synopsis: '',
          ),
          type: 'anime',
        ),
      ];
      when(
        mockDataSource.getPopularAnime,
      ).thenAnswer((_) async => tMultipleDtos);

      // act
      final result = await repository.getPopularAnime();

      // assert
      result.fold((failure) => fail('Should succeed'), (animeList) {
        expect(animeList.length, 2);
        expect(animeList[1].canonicalTitle, 'One Piece');
        expect(animeList[1].averageRating, 9.0);
      });
    }); //multiple dtos

    test('return empty list', () async {
      // arrange
      when(mockDataSource.getPopularAnime).thenAnswer((_) async => []);

      //act
      final response = await repository.getPopularAnime();

      //assert
      expect(response, isA<Right<dynamic, List<Anime>>>());

      response.fold(
        (failure) => fail('should be Right'),
        (animeList) => expect(animeList.isEmpty, true),
      );
    });
  }); //group
}
