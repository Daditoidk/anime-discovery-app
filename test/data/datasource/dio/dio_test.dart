import 'package:anime_discovery_app/data/datasources/kitsu_anime_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dio_test.mocks.dart';

@GenerateMocks([Dio])
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
        mockDio.get(any, queryParameters: anyNamed('queryParameters')),
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
        mockDio.get('/anime', queryParameters: {'sort': '-user_count'}),
      ).called(1);
    }); // GET: happy path with correct parameters

    test('should return list animeDTOs when request is succeful', () async {
      //arrange
      when(
        mockDio.get(any, queryParameters: anyNamed('queryParameters')),
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
        mockDio.get(any, queryParameters: anyNamed('queryParameters')),
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
        mockDio.get(any, queryParameters: anyNamed('queryParameters')),
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
  }); //group
}
