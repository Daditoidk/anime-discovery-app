import 'dart:async';

import 'package:anime_discovery_app/core/constants/const.dart';
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
  String _lastquery = '';
  CancelToken? _cancelToken;
  Timer? _debounceTimer;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  int _offset = 0;

  @override
  FutureOr<List<Anime>> build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
      _cancelToken?.cancel("disposed");
    });
    return const <Anime>[];
  }

  void search() {

    final String normalizedQuery = ref.read(searchQueryProvider);

    // Cancel previous operations
    _cancelToken?.cancel("New search");
    _debounceTimer?.cancel();

    // Handle empty query
    if (normalizedQuery.isEmpty) {
      _resetState();
      state = const AsyncData([]);
      return;
    }

    // Skip if same query
    if (normalizedQuery == _lastquery) return;

    // New search - reset everything
    _lastquery = normalizedQuery;
    _offset = 0; // ✅ Reset offset
    _hasMore = true; // ✅ Reset hasMore
    _isLoadingMore = false;

    state = const AsyncLoading();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _performSearch(
        normalizedQuery,
        isNewSearch: true,
      ); // ✅ Flag as new search
    });
  }

  void refresh() {
    _resetState();

    final String normalizedQuery = ref.read(searchQueryProvider);
    if (normalizedQuery.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading();
    _performSearch(normalizedQuery, isNewSearch: true);
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore) return;

    final String normalizedQuery = ref.read(searchQueryProvider);
    if (normalizedQuery.isEmpty) {
      _resetState();
      state = const AsyncData([]);
      return;
    }

    _isLoadingMore = true;
    _offset += kOffsetPaginationIncreasingRatio;

    await _performSearch(
      normalizedQuery,
      isNewSearch: false,
    ); // ✅ Not a new search

    _isLoadingMore = false;
  }

  Future<void> _performSearch(String query, {required bool isNewSearch}) async {
    
    if (!_hasMore && !isNewSearch) {
      return; // Only check hasMore if not new search
    }

    _cancelToken = CancelToken();

    final response = await ref
        .read(animeRepositoryProvider)
        .searchAnime(query, cancelToken: _cancelToken, offset: _offset);

    if (!ref.mounted) {
      state = const AsyncData([]);
      return;
    }

    final List<Anime> newAnimeList = response.fold(
      (failure) => throw failure,
      (searchedAnimeList) => searchedAnimeList,
    );

    _checkIfHasMore(newAnimeList);

    // ✅ CRITICAL: Replace on new search, append on loadMore
    if (isNewSearch) {
      state = AsyncData(newAnimeList); // Replace
    } else {
      state = AsyncData([...state.value ?? [], ...newAnimeList]); // Append
    }
  }

  void _checkIfHasMore(List<Anime> animeList) {
    if (animeList.length < kLimitPagination) {
      _hasMore = false;
    }
  }

  void _resetState() {
    _lastquery = '';
    _offset = 0;
    _hasMore = true;
    _isLoadingMore = false;
    _cancelToken?.cancel("reset");
  }

  // Getters for UI (optional, but helpful for debugging)
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;
  CancelToken? get cancelToken => _cancelToken;
}
