import 'dart:async';

import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/presentation/providers/anime_providers.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_anime_notifier.g.dart';

@riverpod
class SearchAnimeList extends _$SearchAnimeList {
  CancelToken? cancelToken;
  Timer? debounceTimer;

  @override
  FutureOr<List<Anime>> build() => <Anime>[];

  void search(String query) {
    cancelToken?.cancel("New search");
    debounceTimer?.cancel();

    if (query.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _performSearch(query, cancelToken);
    });
  }

  Future<void> _performSearch(String query, CancelToken? cancelToken) async {
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
