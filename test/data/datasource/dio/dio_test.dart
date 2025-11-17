import 'dart:async';

import 'package:anime_discovery_app/data/datasources/kitsu_anime_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late KitsuAPIRemoteDataSourceImpl dataSource;

  setUp(() {
    mockDio = MockDio();
    dataSource = KitsuAPIRemoteDataSourceImpl(mockDio);
  });

  group('getPopularAnime()', () {
    final tResponseData = {
      'data': [
        {
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
        },
      ],
    };

    test('should perform GET request with correct parameters', () async {
      // arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        ),
      );

      // act
      await dataSource.getPopularAnime();

      // assert
      verify(
        () => mockDio.get('/anime', queryParameters: {'sort': '-user_count'}),
      ).called(1);
    }); // GET: happy path with correct parameters

    test('should return list animeDTOs when request is succeful', () async {
      //arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        ),
      );

      //Act
      final result = await dataSource.getPopularAnime();

      //Assert
      expect(result.length, 1);
      expect(result[0].id, '1');
      expect(result[0].attributes.canonicalTitle, 'Naruto');
    }); // GET: return list animeDTOs when succeful

    test('should throw exception when requests fails', () async {
      //arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        (_) => DioException(
          requestOptions: RequestOptions(path: '/anime'),
          response: Response(
            data: null,
            statusCode: 500,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        ),
      );

      //act & assert
      expect(() => dataSource.getPopularAnime(), throwsException);
    }); // Exception request fails

    test('should throw exception when response data is malformed', () async {
      //arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: {'data': 'invalid'},
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        ),
      );

      //act & assert
      expect(() => dataSource.getPopularAnime(), throwsException);
    });

    test('should throw timeout exception when request times out', () async {
      //arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow((_) => TimeoutException('Request timed out'));

      //act & assert
      expect(() => dataSource.getPopularAnime(), throwsException);
    });

    test('should skip the object if type is not anime', () async {
      //arrange
      final tFakeApiData = {
        'data': [
          {
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
          },
          {
            'id': '2',
            'type': 'manga',
            'attributes': {
              'synopsis': '',
              'canonicalTitle': 'Spiderman',
              'posterImage': {
                'original': 'https://example.com/naruto.jpg',
                'large': 'https://example.com/naruto_large.jpg',
              },
              'averageRating': '8.5',
            },
          },
          {
            'id': '3',
            'type': 'anime',
            'attributes': {
              'synopsis': '',
              'canonicalTitle': 'One piece',
              'posterImage': {
                'original': 'https://example.com/naruto.jpg',
                'large': 'https://example.com/naruto_large.jpg',
              },
              'averageRating': '8.5',
            },
          },
        ],
      };

      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: tFakeApiData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        ),
      );

      //act
      final response = await dataSource.getPopularAnime();

      //assert
      expect(response.length, 2);
      expect(response[0].id, '1');
      expect(response[1].id, '3');
    });
  }); //group

  group('searchAnime', () {
    final tQuery = 'Naruto';
    final tResponseData = {
      'data': [
        {
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
        },
      ],
    };

    test('should perform GET request with correct parameters', () async {
      // arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        ),
      );

      // act
      final response = await dataSource.searchAnime(tQuery);

      // assert
      expect(response.length, 1);
      expect(response[0].attributes.canonicalTitle, contains(tQuery));
      verify(
        () => mockDio.get('/anime', queryParameters: {'filter[text]': tQuery}),
      ).called(1);
    });

    test(
      'should throw DioExceptionType.cancel beacuse a CancelToken with GET request with correct parameters',
      () async {
        // arrange
        final cancelToken = CancelToken();
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenThrow(
          DioException(
            type: DioExceptionType.cancel,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        );

        // act & assert
        expect(
          () => dataSource.searchAnime(tQuery, cancelToken: cancelToken),
          throwsA(
            isA<DioException>().having(
              (error) => error.type,
              'type',
              DioExceptionType.cancel,
            ),
          ),
        );
      },
    );
    test(
      'should throw DioException GET request with incorrect parameters',
      () async {
        // arrange
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(
          DioException(
            type: DioExceptionType.badResponse,
            requestOptions: RequestOptions(path: '/anime'),
            response: Response(
              data: null,
              statusCode: 400,
              requestOptions: RequestOptions(path: '/anime'),
            ),
          ),
        );

        // act & assert
        expect(
          () => dataSource.searchAnime(tQuery),
          throwsA(isA<DioException>()),
        );
      },
    );
    test(
      'should perform GET request with correct parameters and return empty list',
      () async {
        // arrange
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {'data': []},
            statusCode: 200,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        );

        // act
        final result = await dataSource.searchAnime(tQuery);

        // assert
        expect(result, isEmpty);
        verify(
          () =>
              mockDio.get('/anime', queryParameters: {'filter[text]': tQuery}),
        ).called(1);
      },
    );
  });
}
