import 'dart:async';

import 'package:anime_discovery_app/core/constants/const.dart';
import 'package:anime_discovery_app/core/enums/category_filter.dart';
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
        () => mockDio.get(
          '/anime',
          queryParameters: {'filter[text]': tQuery, 'sort': '-user_count'},
        ),
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
          () => mockDio.get(
            '/anime',
            queryParameters: {'filter[text]': tQuery, 'sort': '-user_count'},
          ),
        ).called(1);
      },
    );
  });

  group('getPopularAnime with pagination', () {
    final tLimitPagination = kLimitPagination;
    final tOffsetPaginationIncreasingRatio = kOffsetPaginationIncreasingRatio;
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

    test(
      'should perform GET request with correct parameters and return list of animeDTOs when request is succeful',
      () async {
        // arrange
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        );

        // act
        final result = await dataSource.getPopularAnime(
          offset: tOffsetPaginationIncreasingRatio,
        );

        // assert
        expect(result, hasLength(1));
        expect(result.first.id, '1');
        verify(
          () => mockDio.get(
            '/anime',
            queryParameters: {
              'sort': '-user_count',
              'page[limit]': '$tLimitPagination',
              'page[offset]': '$tOffsetPaginationIncreasingRatio',
            },
          ),
        ).called(1);
      },
    );

    test('should return list animeDTOs when request is succeful', () async {
      // arrange
      final baseData = List<Map<String, dynamic>>.from(
        tResponseData['data'] as List,
      );
      final tMultipleResponse = {
        'data': [
          ...baseData,
          {
            'id': '2',
            'type': 'anime',
            'attributes': {
              'synopsis': '',
              'canonicalTitle': 'One Piece',
              'posterImage': {
                'original': 'https://example.com/one_piece.jpg',
                'large': 'https://example.com/one_piece_large.jpg',
              },
              'averageRating': '9.0',
            },
          },
        ],
      };

      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: tMultipleResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        ),
      );

      // act
      final result = await dataSource.getPopularAnime(
        offset: tOffsetPaginationIncreasingRatio,
      );

      // assert
      expect(result, hasLength(2));
      expect(result.last.attributes.canonicalTitle, 'One Piece');
    });

    test('should throw exception when requests fails', () async {
      // arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/anime'),
          response: Response(
            data: null,
            statusCode: 500,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        ),
      );

      // act & assert
      expect(
        () => dataSource.getPopularAnime(
          offset: tOffsetPaginationIncreasingRatio,
        ),
        throwsA(isA<DioException>()),
      );
    });

    test('should throw timeout exception when request times out', () async {
      // arrange
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(TimeoutException('Request timed out'));

      // act & assert
      expect(
        () => dataSource.getPopularAnime(
          offset: tOffsetPaginationIncreasingRatio,
        ),
        throwsException,
      );
    });
    test('should throw exception when response data is malformed', () async {
      // arrange
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

      // act & assert
      expect(
        () => dataSource.getPopularAnime(
          offset: tOffsetPaginationIncreasingRatio,
        ),
        throwsException,
      );
    });
    test('should skip the object if type is not anime', () async {
      // arrange
      final baseData = List<Map<String, dynamic>>.from(
        tResponseData['data'] as List,
      );
      final tMixedResponse = {
        'data': [
          ...baseData,
          {
            'id': 'manga-id',
            'type': 'manga',
            'attributes': baseData.first['attributes'],
          },
        ],
      };

      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: tMixedResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        ),
      );

      // act
      final result = await dataSource.getPopularAnime(
        offset: tOffsetPaginationIncreasingRatio,
      );

      // assert
      expect(result, hasLength(1));
      expect(result.first.id, '1');
    });
    test(
      'should get the amount of animeDTOs specified in the const kLimitPagination',
      () async {
        // arrange
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        );

        // act
        await dataSource.getPopularAnime(
          offset: tOffsetPaginationIncreasingRatio,
        );

        // assert
        expect(
          dataSource.paginationParameters['page[limit]'],
          '$tLimitPagination',
        );
      },
    );
    test('should skip the animeDTOs specified in the offset', () async {
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
      await dataSource.getPopularAnime(
        offset: tOffsetPaginationIncreasingRatio,
      );

      // assert
      expect(
        dataSource.paginationParameters['page[offset]'],
        '$tOffsetPaginationIncreasingRatio',
      );
    });
    test('should throw error if offset is negative', () async {
      // arrange
      final negativeOffset = -tOffsetPaginationIncreasingRatio;
      when(
        () =>
            mockDio.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenThrow(
        DioException(
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
        () => dataSource.getPopularAnime(offset: negativeOffset),
        throwsA(isA<DioException>()),
      );
    });
    test(
      'should override pagination limit even if previous value was negative',
      () async {
        // arrange
        dataSource.paginationParameters = {
          'page[limit]': '-1',
          'page[offset]': '0',
        };

        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        );

        // act
        await dataSource.getPopularAnime(
          offset: tOffsetPaginationIncreasingRatio,
        );

        // assert
        expect(
          dataSource.paginationParameters['page[limit]'],
          '$tLimitPagination',
        );
      },
    );
    test('should perform GET request if limit and offset are null', () async {
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
    });
  });
  group('searchAnime with pagination', () {
    final tLimitPagination = kLimitPagination;
    final tOffsetPaginationIncreasingRatio = kOffsetPaginationIncreasingRatio;
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
      Map<String, dynamic>? receivedQueryParameters;
      when(
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((invocation) async {
        receivedQueryParameters = Map<String, dynamic>.from(
          invocation.namedArguments[#queryParameters] as Map,
        );
        return Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        );
      });

      // act
      await dataSource.searchAnime(
        tQuery,
        offset: tOffsetPaginationIncreasingRatio,
      );

      // assert
      expect(receivedQueryParameters, isNotNull);
      expect(receivedQueryParameters!['filter[text]'], tQuery);
      expect(receivedQueryParameters!['sort'], '-user_count');
      expect(receivedQueryParameters!['page[limit]'], '$tLimitPagination');
      expect(
        receivedQueryParameters!['page[offset]'],
        '$tOffsetPaginationIncreasingRatio',
      );
      verify(
        () => mockDio.get(
          '/anime',
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
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
          () => dataSource.searchAnime(
            tQuery,
            cancelToken: cancelToken,
            offset: tOffsetPaginationIncreasingRatio,
          ),
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
            cancelToken: any(named: 'cancelToken'),
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
          () => dataSource.searchAnime(
            tQuery,
            offset: tOffsetPaginationIncreasingRatio,
          ),
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
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {'data': []},
            statusCode: 200,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        );

        // act
        final result = await dataSource.searchAnime(
          tQuery,
          offset: tOffsetPaginationIncreasingRatio,
        );

        // assert
        expect(result, isEmpty);
      },
    );
    test(
      'should get the amount of animeDTOs specified in the const tLimitPagination',
      () async {
        // arrange
        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        );

        // act
        await dataSource.searchAnime(
          tQuery,
          offset: tOffsetPaginationIncreasingRatio,
        );

        // assert
        expect(
          dataSource.paginationParameters['page[limit]'],
          '$tLimitPagination',
        );
      },
    );
    test('should skip the animeDTOs specified in the offset', () async {
      // arrange
      when(
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        ),
      );

      // act
      await dataSource.searchAnime(
        tQuery,
        offset: tOffsetPaginationIncreasingRatio,
      );

      // assert
      expect(
        dataSource.paginationParameters['page[offset]'],
        '$tOffsetPaginationIncreasingRatio',
      );
    });
    test('should throw error if offset is negative', () async {
      // arrange
      final negativeOffset = -tOffsetPaginationIncreasingRatio;
      when(
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenThrow(
        DioException(
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
        () => dataSource.searchAnime(tQuery, offset: negativeOffset),
        throwsA(isA<DioException>()),
      );
    });
    test(
      'should override pagination limit even if previous value was negative',
      () async {
        // arrange
        dataSource.paginationParameters = {
          'page[limit]': '-1',
          'page[offset]': '0',
        };

        when(
          () => mockDio.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            cancelToken: any(named: 'cancelToken'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: tResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/anime'),
          ),
        );

        // act
        await dataSource.searchAnime(
          tQuery,
          offset: tOffsetPaginationIncreasingRatio,
        );

        // assert
        expect(
          dataSource.paginationParameters['page[limit]'],
          '$tLimitPagination',
        );
      },
    );
    test('should perform GET request if limit and offset are null', () async {
      // arrange
      Map<String, dynamic>? receivedQueryParameters;
      when(
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).thenAnswer((invocation) async {
        receivedQueryParameters = Map<String, dynamic>.from(
          invocation.namedArguments[#queryParameters] as Map,
        );
        return Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        );
      });

      // act
      await dataSource.searchAnime(tQuery);

      // assert
      expect(receivedQueryParameters, isNotNull);
      expect(receivedQueryParameters, {
        'filter[text]': tQuery,
        'sort': '-user_count',
      });
      verify(
        () => mockDio.get(
          '/anime',
          queryParameters: any(named: 'queryParameters'),
          cancelToken: any(named: 'cancelToken'),
        ),
      ).called(1);
    });
  });
  group('category filters', () {
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

    test('get filtered list with the correct parameters', () async {
      // arrange
      const categoryFilter = CategoryFilters.action;
      Map<String, dynamic>? receivedQueryParameters;
      when(
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((invocation) async {
        receivedQueryParameters = Map<String, dynamic>.from(
          invocation.namedArguments[#queryParameters] as Map,
        );
        return Response(
          data: tResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/anime'),
        );
      });

      // act
      final result = await dataSource.getPopularAnime(
        categoryFilter: categoryFilter,
      );

      // assert
      expect(result, hasLength(1));
      expect(receivedQueryParameters, isNotNull);
      expect(receivedQueryParameters!['sort'], '-user_count');
      expect(
        receivedQueryParameters!['filter[categories]'],
        categoryFilter.name,
      );
      verify(
        () => mockDio.get(
          '/anime',
          queryParameters: {
            'sort': '-user_count',
            'filter[categories]': categoryFilter.name,
          },
        ),
      ).called(1);
    });

    test('should throw get incorrect parameters', () async {
      // arrange
      const categoryFilter = CategoryFilters.action;
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
        () => dataSource.getPopularAnime(categoryFilter: categoryFilter),
        throwsA(isA<DioException>()),
      );
    });
  });
}
