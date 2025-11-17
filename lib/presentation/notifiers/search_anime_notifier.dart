import 'dart:async';

import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/presentation/providers/anime_providers.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_anime_notifier.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String raw) {
    final String normalized = raw.trim();
    if (normalized == state) return;
    state = normalized;
  }

  void clear() {
    state = '';
  }
}

@riverpod
class SearchAnimeList extends _$SearchAnimeList {
  String lastquery = '';
  CancelToken? cancelToken;
  Timer? debounceTimer;

  @override
  FutureOr<List<Anime>> build() {
    ref.onDispose(() {
      debounceTimer?.cancel();
      cancelToken?.cancel("new search");
    });
    return <Anime>[];
  }

  void search() {
    final String normalizedQuery = ref.read(searchQueryProvider);

    cancelToken?.cancel("New search");
    debounceTimer?.cancel();

    if (normalizedQuery.isEmpty) {
      lastquery = '';
      state = const AsyncData([]);
      return;
    }

    if (normalizedQuery == lastquery) return;

    lastquery = normalizedQuery;

    debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _performSearch(normalizedQuery);
    });
  }

  Future<void> _performSearch(String query) async {
    state = AsyncLoading();

    cancelToken = CancelToken();

    final response = await ref
        .watch(animeRepositoryProvider)
        .searchAnime(query, cancelToken: cancelToken);

    if (!ref.mounted) return;

    state = response.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (searchedAnimeList) => AsyncData(searchedAnimeList),
    );
  }
}
