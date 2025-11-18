import 'package:anime_discovery_app/core/constants/const.dart';
import 'package:anime_discovery_app/core/failures/failure.dart';
import 'package:anime_discovery_app/data/datasources/kitsu_anime_remote_datasource.dart';
import 'package:anime_discovery_app/data/models/anime_dto.dart';
import 'package:anime_discovery_app/data/repositories/anime_repo_impl.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIKitsuAPIRemoteDataSource extends Mock
    implements IKitsuAPIRemoteDataSource {}

void main() {
  late AnimeRepositoryImpl repository;
  late MockIKitsuAPIRemoteDataSource mockDataSource;
    final tLimitPagination = kLimitPagination;
    final tOffsetPaginationIncreasingRatio = kOffsetPaginationIncreasingRatio;

  setUp(() {
    mockDataSource = MockIKitsuAPIRemoteDataSource();
    repository = AnimeRepositoryImpl(mockDataSource);
  });

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

  group('searchAnime', () {
    final tQuery = 'Naruto';
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
      'should return a list of Anime when call to data source is successful',
      () async {
        // arrange
        when(
          () => mockDataSource.searchAnime(
            tQuery,
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => tAnimeList);

        // act
        final result = await repository.searchAnime(tQuery);

        // assert
        expect(result, isA<Right<dynamic, List<Anime>>>());
        result.fold((failure) => fail('Should return Right'), (animeList) {
          expect(animeList.length, 1);
          expect(animeList[0].canonicalTitle, 'Naruto');
          expect(animeList[0].averageRating, 8.5);
        });
      },
    );

    test(
      'should return a empty list of Anime when call to data source and no results are found',
      () async {
        // arrange
        when(
          () => mockDataSource.searchAnime(
            tQuery,
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer((_) async => []);

        // act
        final result = await repository.searchAnime(tQuery);

        // assert
        expect(result, isA<Right<dynamic, List<Anime>>>());
        result.fold(
          (failure) => fail('Should return Right'),
          (animeList) => expect(animeList.isEmpty, true),
        );
      },
    );

    test(
      'should return a empty list of Anime when call to data source and CancelToken.cancel was triggered',
      () async {
        // arrange
        final cancelToken = CancelToken();
        cancelToken.cancel('user-cancelled');
        when(
          () => mockDataSource.searchAnime(tQuery, cancelToken: cancelToken),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/anime'),
            type: DioExceptionType.cancel,
            message: 'Cancelled',
          ),
        );

        // act
        final result = await repository.searchAnime(
          tQuery,
          cancelToken: cancelToken,
        );

        // assert
        expect(result, isA<Right<dynamic, List<Anime>>>());
        result.fold(
          (failure) => fail('Should return Right'),
          (animeList) => expect(animeList.isEmpty, true),
        );
      },
    );

    test('should throw a NetworkFailure when data source throws', () async {
      // arrange
      when(
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/anime'),
          type: DioExceptionType.connectionTimeout,
          message: 'Network error',
        ),
      );

      // act
      final result = await repository.searchAnime(tQuery);

      // assert
      expect(result, isA<Left<dynamic, List<Anime>>>());
      result.fold((failure) {
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'Network error');
      }, (animeList) => fail('Should return Left'));
    });

    test('should throw a ApiFailure when data source throws', () async {
      // arrange
      when(
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(Exception('Unexpected error'));

      // act
      final result = await repository.searchAnime(tQuery);

      // assert
      expect(result, isA<Left<dynamic, List<Anime>>>());
      result.fold((failure) {
        expect(failure, isA<ApiFailure>());
        expect(failure.message, contains('Unexpected error'));
      }, (animeList) => fail('Should return Left'));
    });

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
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((_) async => tMultipleDtos);

      // act
      final result = await repository.searchAnime(tQuery);

      // assert
      result.fold((failure) => fail('Should return Right'), (animeList) {
        expect(animeList.length, 2);
        expect(animeList[1].canonicalTitle, 'One Piece');
        expect(animeList[1].averageRating, 9.0);
      });
    });
  });


  group('getPopularAnime with pagination', () {

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

    test('should fetch first page when offset is null', () async {
      // arrange
      when(() => mockDataSource.getPopularAnime(offset: null))
          .thenAnswer((_) async => tAnimeList);

      // act
      final response = await repository.getPopularAnime();

      // assert
      expect(response, isA<Right<dynamic, List<Anime>>>());
      verify(() => mockDataSource.getPopularAnime(offset: null)).called(1);
    });

    test('should fetch second page using limit pagination offset', () async {
      // arrange
      final nextOffset = tLimitPagination;
      when(() => mockDataSource.getPopularAnime(offset: nextOffset))
          .thenAnswer((_) async => tAnimeList);

      // act
      final response = await repository.getPopularAnime(offset: nextOffset);

      // assert
      expect(response, isA<Right<dynamic, List<Anime>>>());
      verify(() => mockDataSource.getPopularAnime(offset: nextOffset)).called(1);
    });

    test('should fetch later pages increasing offset by ratio', () async {
      // arrange
      final thirdPageOffset =
          tLimitPagination + tOffsetPaginationIncreasingRatio;
      when(() => mockDataSource.getPopularAnime(offset: thirdPageOffset))
          .thenAnswer((_) async => tAnimeList);

      // act
      final response =
          await repository.getPopularAnime(offset: thirdPageOffset);

      // assert
      expect(response, isA<Right<dynamic, List<Anime>>>());
      verify(() => mockDataSource.getPopularAnime(offset: thirdPageOffset))
          .called(1);
    });

    test('should return empty list when paginated page has no data', () async {
      // arrange
      final emptyPageOffset = tLimitPagination * 3;
      when(() => mockDataSource.getPopularAnime(offset: emptyPageOffset))
          .thenAnswer((_) async => []);

      // act
      final response =
          await repository.getPopularAnime(offset: emptyPageOffset);

      // assert
      expect(response, isA<Right<dynamic, List<Anime>>>());
      response.fold(
        (failure) => fail('Should return Right'),
        (animeList) => expect(animeList, isEmpty),
      );
    });

    test('should return failure when paginated request throws DioException',
        () async {
      // arrange
      final errorOffset = tLimitPagination;
      when(() => mockDataSource.getPopularAnime(offset: errorOffset))
          .thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/anime'),
          type: DioExceptionType.connectionTimeout,
          message: 'Timeout',
        ),
      );

      // act
      final response = await repository.getPopularAnime(offset: errorOffset);

      // assert
      expect(response, isA<Left<dynamic, List<Anime>>>());
      response.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'Timeout');
        },
        (_) => fail('Should return Left'),
      );
    });
  });
  group('seachAnime with pagination', () {
    final tQuery = 'Naruto';
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

    test('should fetch first page search results when offset is null', () async {
      // arrange
      when(() => mockDataSource.searchAnime(
            tQuery,
            cancelToken: null,
            offset: null,
          )).thenAnswer((_) async => tAnimeList);

      // act
      final response = await repository.searchAnime(tQuery);

      // assert
      expect(response, isA<Right<dynamic, List<Anime>>>());
      verify(() => mockDataSource.searchAnime(
            tQuery,
            cancelToken: null,
            offset: null,
          )).called(1);
    });

    test('should fetch second page search results using limit offset',
        () async {
      // arrange
      final secondPageOffset = tLimitPagination;
      when(
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: null,
          offset: secondPageOffset,
        ),
      ).thenAnswer((_) async => tAnimeList);

      // act
      final response =
          await repository.searchAnime(tQuery, offset: secondPageOffset);

      // assert
      expect(response, isA<Right<dynamic, List<Anime>>>());
      verify(
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: null,
          offset: secondPageOffset,
        ),
      ).called(1);
    });

    test('should fetch later search pages increasing offset by ratio', () async {
      // arrange
      final laterOffset =
          tLimitPagination + tOffsetPaginationIncreasingRatio;
      when(
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: null,
          offset: laterOffset,
        ),
      ).thenAnswer((_) async => tAnimeList);

      // act
      final response = await repository.searchAnime(
        tQuery,
        offset: laterOffset,
      );

      // assert
      expect(response, isA<Right<dynamic, List<Anime>>>());
      verify(
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: null,
          offset: laterOffset,
        ),
      ).called(1);
    });

    test('should return empty list when paginated search finds no data',
        () async {
      // arrange
      final emptySearchOffset = tLimitPagination * 2;
      when(
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: null,
          offset: emptySearchOffset,
        ),
      ).thenAnswer((_) async => []);

      // act
      final response =
          await repository.searchAnime(tQuery, offset: emptySearchOffset);

      // assert
      expect(response, isA<Right<dynamic, List<Anime>>>());
      response.fold(
        (failure) => fail('Should return Right'),
        (animeList) => expect(animeList, isEmpty),
      );
    });

    test('should return NetworkFailure when paginated search throws DioException',
        () async {
      // arrange
      final errorOffset = tLimitPagination;
      when(
        () => mockDataSource.searchAnime(
          tQuery,
          cancelToken: null,
          offset: errorOffset,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/anime'),
          type: DioExceptionType.connectionTimeout,
          message: 'Timeout',
        ),
      );

      // act
      final response =
          await repository.searchAnime(tQuery, offset: errorOffset);

      // assert
      expect(response, isA<Left<dynamic, List<Anime>>>());
      response.fold(
        (failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'Timeout');
        },
        (_) => fail('Should return Left'),
      );
    });
  });
}
