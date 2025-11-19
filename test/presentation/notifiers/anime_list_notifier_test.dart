import 'dart:async';

import 'package:anime_discovery_app/core/constants/const.dart';
import 'package:anime_discovery_app/core/enums/category_filter.dart';
import 'package:anime_discovery_app/core/failures/failure.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/domain/repositories/i_anime_repo.dart';
import 'package:anime_discovery_app/presentation/notifiers/popular_anime_list_notifier.dart';
import 'package:anime_discovery_app/presentation/notifiers/search_anime_notifier.dart';
import 'package:anime_discovery_app/presentation/providers/anime_providers.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Generic listener for tracking state changes
class Listener<T> {
  final List<T> states = [];
  void call(T? previous, T next) {
    states.add(next);
  }
}

class MockIAnimeRepository extends Mock implements IAnimeRepository {}

ProviderContainer _createContainer(MockIAnimeRepository repository) {
  return ProviderContainer.test(
    overrides: [animeRepositoryProvider.overrideWithValue(repository)],
    retry: (_, __) => null,
  );
}

ProviderContainer _createSearchContainer(MockIAnimeRepository repository) {
  final container = _createContainer(repository);
  container.listen<String>(
    searchQueryProvider,
    (_, __) {},
    fireImmediately: true,
  );
  return container;
}

Future<void> _waitForDebounce() =>
    Future<void>.delayed(const Duration(milliseconds: 350));

Future<void> _waitShort() =>
    Future<void>.delayed(const Duration(milliseconds: 100));

void main() {
  late MockIAnimeRepository mockRepository;

  // Register fallback values for matchers
  setUpAll(() {
    registerFallbackValue(const AsyncLoading<List<Anime>>());
    registerFallbackValue(CancelToken());
  });

  setUp(() {
    mockRepository = MockIAnimeRepository();
  });

  group('searchQueryProvider', () {
    test('setQuery should trim and update only when value changes', () {
      final container = _createContainer(mockRepository);
      final notifier = container.read(searchQueryProvider.notifier);

      notifier.setQuery('  Naruto  ');
      expect(container.read(searchQueryProvider), 'Naruto');

      notifier.setQuery('Naruto  ');
      expect(container.read(searchQueryProvider), 'Naruto');
    });

    test('clear should reset the query', () {
      final container = _createContainer(mockRepository);
      final notifier = container.read(searchQueryProvider.notifier);

      notifier.setQuery('Bleach');
      notifier.clear();

      expect(container.read(searchQueryProvider), '');
    });
  });

  group('getPopularAnime pagination', () {
    test('loads more anime on loadMore()', () async {
      final initialData = List.generate(kOffsetPaginationIncreasingRatio, (
        index,
      ) {
        final id = index;
        final title = 'Title $index';
        return Anime(
          id: id.toString(),
          canonicalTitle: title,
          synopsis: 'Test synopsis',
          posterImageUrl: 'url',
          averageRating: 8.5,
        );
      });

      final page2Data = List.generate(kOffsetPaginationIncreasingRatio, (
        index,
      ) {
        final id = index + kLimitPagination;
        final title = 'Title $id';
        return Anime(
          id: id.toString(),
          canonicalTitle: title,
          synopsis: 'Test synopsis',
          posterImageUrl: 'url',
          averageRating: 8.5,
        );
      });

      // Use when() with any() to handle any call pattern
      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((invocation) async {
        final offset = invocation.namedArguments[#offset] as int? ?? 0;
        if (offset == 0) {
          return Right(initialData);
        } else if (offset == kOffsetPaginationIncreasingRatio) {
          return Right(page2Data);
        }
        return const Right([]);
      });

      final container = _createContainer(mockRepository);

      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        popularAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );
      var count = 0;
      // Wait for initial load
      await container.read(popularAnimeListProvider.future);

      var state = container.read(popularAnimeListProvider).value!;
      count = state.length;
      expect(count, kLimitPagination); // 2 initial anime

      // Act: Load more
      await container.read(popularAnimeListProvider.notifier).loadMore();

      state = container.read(popularAnimeListProvider).value!;
      count = state.length;
      expect(count, 2 * kLimitPagination); // 2 initial anime
      // Assert: verify final state
      expect(state.length, count); // 2 initial + 2 from page 2
      expect(state[0].canonicalTitle, 'Title 0');
      expect(state[kLimitPagination].canonicalTitle, 'Title $kLimitPagination');

      // Verify both calls happened
      verify(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).called(2);
    });
  });

  group('PopularAnimeListNotifier', () {
    final tAnimeList = [
      const Anime(
        id: '1',
        canonicalTitle: 'Naruto',
        synopsis: 'Test synopsis',
        posterImageUrl: 'url',
        averageRating: 8.5,
      ),
    ];

    test('should load anime list successfully', () async {
      // arrange
      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((_) async => Right(tAnimeList));

      final container = _createSearchContainer(mockRepository);

      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        popularAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );

      // act - wait for build to complete
      await container.read(popularAnimeListProvider.future);

      // assert - verify state transitions
      expect(listener.states.length, 2);
      expect(listener.states[0], isA<AsyncLoading<List<Anime>>>());
      expect(listener.states[1], isA<AsyncData<List<Anime>>>());
      expect(listener.states[1].value, tAnimeList);

      verify(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).called(1);
    });

    test('should emit error when repo returns Left', () async {
      // arrange
      final failure = ApiFailure(message: 'API error');
      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((_) async => Left(failure));

      final container = ProviderContainer.test(
        overrides: [animeRepositoryProvider.overrideWithValue(mockRepository)],
        retry: (_, __) => null,
      );

      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        popularAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );

      // act & assert
      await expectLater(
        container.read(popularAnimeListProvider.future),
        throwsA(isA<ApiFailure>()),
      );

      // verify state transitions: loading → error
      expect(listener.states.length, 2);
      expect(listener.states[0], isA<AsyncLoading<List<Anime>>>());
      expect(listener.states[1], isA<AsyncError<List<Anime>>>());
      expect(listener.states[1].error, isA<ApiFailure>());
    });

    test('refresh should reload data', () async {
      // arrange
      final refreshedList = [
        const Anime(
          id: '2',
          canonicalTitle: 'Bleach',
          synopsis: 'Another synopsis',
          posterImageUrl: 'url2',
          averageRating: 9.0,
        ),
      ];
      var callCount = 0;

      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((_) async {
        callCount++;
        return Right(callCount == 1 ? tAnimeList : refreshedList);
      });

      final container = ProviderContainer.test(
        overrides: [animeRepositoryProvider.overrideWithValue(mockRepository)],
        retry: (_, __) => null,
      );

      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        popularAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );

      // act - initial load
      await container.read(popularAnimeListProvider.future);

      // act - refresh
      final notifier = container.read(popularAnimeListProvider.notifier);
      await notifier.refresh();

      // assert - verify all state transitions
      expect(listener.states.length, 4);
      // Initial: loading → data
      expect(listener.states[0], isA<AsyncLoading<List<Anime>>>());
      expect(listener.states[1].value, tAnimeList);
      // Refresh: loading → new data
      expect(listener.states[2], isA<AsyncLoading<List<Anime>>>());
      expect(listener.states[3].value, refreshedList);

      expect(callCount, 2);
    });

    test('should handle ApiFailure correctly', () async {
      // arrange
      final failure = ApiFailure(message: 'API failed');
      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((_) async => Left(failure));

      final container = ProviderContainer.test(
        overrides: [animeRepositoryProvider.overrideWithValue(mockRepository)],
        retry: (_, __) => null,
      );

      // act & assert
      await expectLater(
        container.read(popularAnimeListProvider.future),
        throwsA(isA<ApiFailure>()),
      );

      final state = container.read(popularAnimeListProvider);
      expect(state.hasError, true);
      expect(state.error, isA<ApiFailure>());
      expect((state.error as ApiFailure).message, 'API failed');
    });

    test('should handle NetworkFailure', () async {
      // arrange
      final failure = NetworkFailure(message: 'No internet');
      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((_) async => Left(failure));

      final container = ProviderContainer.test(
        overrides: [animeRepositoryProvider.overrideWithValue(mockRepository)],
        retry: (_, __) => null,
      );

      // act & assert
      await expectLater(
        container.read(popularAnimeListProvider.future),
        throwsA(isA<NetworkFailure>()),
      );

      final state = container.read(popularAnimeListProvider);
      expect((state.error as NetworkFailure).message, 'No internet');
    });

    test('should handle ServerFailure', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((_) async => Left(failure));

      final container = ProviderContainer.test(
        overrides: [animeRepositoryProvider.overrideWithValue(mockRepository)],
        retry: (_, __) => null,
      );

      // act & assert
      await expectLater(
        container.read(popularAnimeListProvider.future),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('should return empty list when repo returns empty', () async {
      // arrange
      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((_) async => const Right([]));

      final container = ProviderContainer.test(
        overrides: [animeRepositoryProvider.overrideWithValue(mockRepository)],
        retry: (_, __) => null,
      );

      // act
      final result = await container.read(popularAnimeListProvider.future);

      // assert
      expect(result, isEmpty);
    });

    test('should handle multiple anime correctly', () async {
      // arrange
      final multipleAnime = [
        const Anime(
          id: '1',
          canonicalTitle: 'Naruto',
          synopsis: 'Test',
          averageRating: 8.5,
        ),
        const Anime(
          id: '2',
          canonicalTitle: 'One Piece',
          synopsis: 'Test',
          averageRating: 9.0,
        ),
      ];
      when(
        () => mockRepository.getPopularAnime(offset: any(named: 'offset')),
      ).thenAnswer((_) async => Right(multipleAnime));

      final container = ProviderContainer.test(
        overrides: [animeRepositoryProvider.overrideWithValue(mockRepository)],
        retry: (_, __) => null,
      );

      // act
      final result = await container.read(popularAnimeListProvider.future);

      // assert
      expect(result.length, 2);
      expect(result[0].canonicalTitle, 'Naruto');
      expect(result[1].canonicalTitle, 'One Piece');
    });
  });

  group('searchAnime', () {
    final tQuery = 'Naruto';
    final tAnimeList = List.generate(kLimitPagination, (index) {
      final id = index.toString();
      final title = 'Title $id';
      return Anime(
        id: id,
        canonicalTitle: title,
        synopsis: 'Test synopsis',
        posterImageUrl: 'url',
        averageRating: 8.5,
      );
    });

    test('should return a list of Anime succefully', () async {
      when(
        () => mockRepository.searchAnime(
          any(),
          cancelToken: any(named: 'cancelToken'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => Right(tAnimeList));

      final container = _createSearchContainer(mockRepository);
      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        searchAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );

      container.read(searchQueryProvider.notifier).setQuery(tQuery);
      container.read(searchAnimeListProvider.notifier).search();

      await _waitForDebounce();

      expect(listener.states.length, 3);
      expect(listener.states[0].value, isEmpty);
      expect(listener.states[1], isA<AsyncLoading<List<Anime>>>());
      expect(listener.states[2].value, tAnimeList);

      verify(
        () => mockRepository.searchAnime(
          tQuery,
          cancelToken: any(named: 'cancelToken'),
          offset: any(named: 'offset'),
        ),
      ).called(1);
    });

    // test('should return a Failure when repo returns Left', () async {
    //   final failure = ApiFailure(message: 'search failed');
    //   when(
    //     () => mockRepository.searchAnime(
    //       any(),
    //       cancelToken: any(named: 'cancelToken'),
    //       offset: any(named: 'offset'),
    //     ),
    //   ).thenAnswer((_) async => Left(failure));

    //   final container = _createSearchContainer(mockRepository);
    //   final listener = Listener<AsyncValue<List<Anime>>>();
    //   container.listen(
    //     searchAnimeListProvider,
    //     listener.call,
    //     fireImmediately: true,
    //   );

    //   container.read(searchQueryProvider.notifier).setQuery(tQuery);
    //   container.read(searchAnimeListProvider.notifier).search();

    //   await _waitShort();
    //   await _waitShort();

    //   print("--------------------------");
    //   print(listener.states.toString());
    //   print("--------------------------");
    //   expect(listener.states.length, 2);

    //   await _waitForDebounce();
    //   await _waitForDebounce();

    //   print("--------------------------");
    //   print(listener.states.toString());
    //   print("--------------------------");

    //   expect(listener.states.length, 3);
    //   expect(listener.states[1], isA<AsyncLoading<List<Anime>>>());
    //   expect(listener.states[2], isA<AsyncError<List<Anime>>>());
    //   expect(listener.states[2].error, isA<ApiFailure>());
    // });

    test('should do debouncing when seach method is call', () async {
      when(
        () => mockRepository.searchAnime(
          any(),
          cancelToken: any(named: 'cancelToken'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => Right(tAnimeList));

      final container = _createSearchContainer(mockRepository);
      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        searchAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );

      container.read(searchQueryProvider.notifier).setQuery(tQuery);
      container.read(searchAnimeListProvider.notifier).search();

      await _waitShort();
      expect(listener.states.length, 2);
      verifyNever(
        () => mockRepository.searchAnime(
          any(),
          cancelToken: any(named: 'cancelToken'),
          offset: any(named: 'offset'),
        ),
      );

      await _waitForDebounce();

      expect(listener.states.length, 3);
      expect(listener.states[1], isA<AsyncLoading<List<Anime>>>());
      expect(listener.states[2].value, tAnimeList);

      verify(
        () => mockRepository.searchAnime(
          tQuery,
          cancelToken: any(named: 'cancelToken'),
          offset: any(named: 'offset'),
        ),
      ).called(1);
    });

    test(
      'should trigger cancelToken.cancel when user searches again',
      () async {
        final firstCallCompleter = Completer<Either<Failure, List<Anime>>>();
        when(
          () => mockRepository.searchAnime(
            any(),
            cancelToken: any(named: 'cancelToken'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((invocation) {
          if (!firstCallCompleter.isCompleted) {
            return firstCallCompleter.future;
          }
          return Future.value(Right(tAnimeList));
        });

        final container = _createSearchContainer(mockRepository);
        final listener = Listener<AsyncValue<List<Anime>>>();
        container.listen(
          searchAnimeListProvider,
          listener.call,
          fireImmediately: true,
        );
        final notifier = container.read(searchAnimeListProvider.notifier);
        final queryNotifier = container.read(searchQueryProvider.notifier);

        queryNotifier.setQuery('Naruto');
        notifier.search();
        await _waitForDebounce();

        final firstToken = notifier.cancelToken;
        expect(firstToken, isNotNull);
        expect(firstToken!.isCancelled, isFalse);

        queryNotifier.setQuery('Bleach');
        notifier.search();

        expect(firstToken.isCancelled, isTrue);

        firstCallCompleter.complete(Right(tAnimeList));

        await _waitForDebounce();

        expect(
          listener.states.whereType<AsyncLoading<List<Anime>>>().length,
          1,
        );
        expect(listener.states.last.value, tAnimeList);

        verify(
          () => mockRepository.searchAnime(
            any(),
            cancelToken: any(named: 'cancelToken'),
            offset: any(named: 'offset'),
          ),
        ).called(2);
      },
    );

    test(
      'shouldnt call repo when the raw query contains only spaces',
      () async {
        final container = _createSearchContainer(mockRepository);
        final listener = Listener<AsyncValue<List<Anime>>>();
        container.listen(
          searchAnimeListProvider,
          listener.call,
          fireImmediately: true,
        );

        container.read(searchQueryProvider.notifier).setQuery('   ');
        container.read(searchAnimeListProvider.notifier).search();

        await _waitForDebounce();

        verifyNever(
          () => mockRepository.searchAnime(
            any(),
            cancelToken: any(named: 'cancelToken'),
            offset: any(named: 'offset'),
          ),
        );
        expect(
          listener.states.whereType<AsyncLoading<List<Anime>>>().length,
          0,
        );
        expect(listener.states.last.value, isEmpty);
      },
    );

    test(
      'shouldnt call repo when the raw query now is the raw query + spaces',
      () async {
        var callCount = 0;
        when(
          () => mockRepository.searchAnime(
            any(),
            cancelToken: any(named: 'cancelToken'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async {
          callCount++;
          return Right(tAnimeList);
        });

        final container = _createSearchContainer(mockRepository);
        final listener = Listener<AsyncValue<List<Anime>>>();
        container.listen(
          searchAnimeListProvider,
          listener.call,
          fireImmediately: true,
        );
        final queryNotifier = container.read(searchQueryProvider.notifier);
        final notifier = container.read(searchAnimeListProvider.notifier);

        queryNotifier.setQuery('Naruto');
        notifier.search();
        await _waitForDebounce();

        queryNotifier.setQuery('Naruto   ');
        notifier.search();
        await _waitForDebounce();

        expect(callCount, 1);
        expect(listener.states.length, 3);
        expect(listener.states.last.value, tAnimeList);
      },
    );

    test('should call repo only once when raw query is same', () async {
      var callCount = 0;
      when(
        () => mockRepository.searchAnime(
          any(),
          cancelToken: any(named: 'cancelToken'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        return Right(tAnimeList);
      });

      final container = _createSearchContainer(mockRepository);
      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        searchAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );
      final notifier = container.read(searchAnimeListProvider.notifier);

      container.read(searchQueryProvider.notifier).setQuery(tQuery);
      notifier.search();
      await _waitForDebounce();

      notifier.search();
      await _waitForDebounce();

      expect(callCount, 1);
      expect(listener.states.length, 3);
      expect(listener.states.last.value, tAnimeList);
    });

    test('should call repo only when user finish to type', () async {
      when(
        () => mockRepository.searchAnime(
          any(),
          cancelToken: any(named: 'cancelToken'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => Right(tAnimeList));

      final container = _createSearchContainer(mockRepository);
      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        searchAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );
      final notifier = container.read(searchAnimeListProvider.notifier);

      container.read(searchQueryProvider.notifier).setQuery(tQuery);
      notifier.search();

      await _waitShort();
      expect(listener.states.length, 2);

      await _waitForDebounce();

      expect(listener.states.length, 3);
      expect(listener.states[1], isA<AsyncLoading<List<Anime>>>());
      expect(listener.states[2].value, tAnimeList);
    });

    test(
      'should call repo only once with multiple fast user typings',
      () async {
        when(
          () => mockRepository.searchAnime(
            any(),
            cancelToken: any(named: 'cancelToken'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => Right(tAnimeList));

        final container = _createSearchContainer(mockRepository);
        final listener = Listener<AsyncValue<List<Anime>>>();
        container.listen(
          searchAnimeListProvider,
          listener.call,
          fireImmediately: true,
        );
        final notifier = container.read(searchAnimeListProvider.notifier);
        final queryNotifier = container.read(searchQueryProvider.notifier);

        queryNotifier.setQuery('N');
        notifier.search();
        await _waitShort();

        queryNotifier.setQuery('Na');
        notifier.search();
        await _waitShort();

        queryNotifier.setQuery('Naruto');
        notifier.search();
        await _waitForDebounce();

        verify(
          () => mockRepository.searchAnime(
            'Naruto',
            cancelToken: any(named: 'cancelToken'),
            offset: any(named: 'offset'),
          ),
        ).called(1);
        expect(listener.states.length, 3);
        expect(listener.states[2].value, tAnimeList);
      },
    );

    test('should return empty list when repo returns empty', () async {
      when(
        () => mockRepository.searchAnime(
          any(),
          cancelToken: any(named: 'cancelToken'),
          offset: any(named: 'offset'),
        ),
      ).thenAnswer((_) async => const Right(<Anime>[]));

      final container = _createSearchContainer(mockRepository);
      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        searchAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );

      container.read(searchQueryProvider.notifier).setQuery('Unknown');
      container.read(searchAnimeListProvider.notifier).search();

      await _waitForDebounce();

      expect(listener.states.length, 3);
      expect(listener.states.last.value, isEmpty);
    });

    test(
      'should show the correct state order when search method is call',
      () async {
        when(
          () => mockRepository.searchAnime(
            any(),
            cancelToken: any(named: 'cancelToken'),
            offset: any(named: 'offset'),
          ),
        ).thenAnswer((_) async => Right(tAnimeList));

        final container = _createSearchContainer(mockRepository);
        final listener = Listener<AsyncValue<List<Anime>>>();
        container.listen(
          searchAnimeListProvider,
          listener.call,
          fireImmediately: true,
        );

        container.read(searchQueryProvider.notifier).setQuery(tQuery);
        container.read(searchAnimeListProvider.notifier).search();

        await _waitForDebounce();

        expect(listener.states.length, 3);
        expect(listener.states[0].value, isEmpty);
        expect(listener.states[1], isA<AsyncLoading<List<Anime>>>());
        expect(listener.states[2].value, tAnimeList);
      },
    );
  });

  group('category filter', () {
    final tAnimeList = List.generate(kLimitPagination, (index) {
      final id = index.toString();
      final title = 'Title $id';
      return Anime(
        id: id,
        canonicalTitle: title,
        synopsis: 'Test synopsis',
        posterImageUrl: 'url',
        averageRating: 8.5,
      );
    });
    test('list rebuilds when category changes', () async {
      // Mock returns any anime
      final actionAnime = [
        const Anime(id: '1', canonicalTitle: 'Some Action Anime', synopsis: ''),
      ];
      when(
        () => mockRepository.getPopularAnime(
          offset: any(named: 'offset'),
          categoryFilter: any(named: 'categoryFilter'),
        ),
      ).thenAnswer((invocation) async {
        final category = invocation.namedArguments[#categoryFilter];

        if (category == null) {
          return Right(tAnimeList);
        } else {
          return Right(actionAnime);
        }
      });

      final container = _createContainer(mockRepository);
      final listener = Listener<AsyncValue<List<Anime>>>();
      container.listen(
        popularAnimeListProvider,
        listener.call,
        fireImmediately: true,
      );

      await container.read(popularAnimeListProvider.future);

      expect(listener.states.length, 2);
      // Change filter
      container
          .read(popularAnimeListProvider.notifier)
          .filterByCategory(CategoryFilters.action);

      // Verify the API was called with correct category
      verify(
        () => mockRepository.getPopularAnime(
          offset: any(named: 'offset'),
          categoryFilter: CategoryFilters.action,
        ),
      ).called(1);

      // Trust that the server filtered correctly
      // No need to verify the anime actually has that category
    });
  });
}
