import 'package:anime_discovery_app/core/constants/const.dart';
import 'package:anime_discovery_app/core/enums/category_filter.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/presentation/providers/anime_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'popular_anime_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class PopularAnimeList extends _$PopularAnimeList {
  var _hasMore = true;
  bool _isLoadingMore = false;
  int _offset = 0;

  void _checkIfHasMore(List<Anime> newList) {
    if (newList.length < kLimitPagination) _hasMore = false;
  }

  Future<List<Anime>> _fetchPage({CategoryFilters? categoryFilter}) async {
    final repo = ref.watch(animeRepositoryProvider);
    final nextPage = await repo.getPopularAnime(offset: _offset,categoryFilter: categoryFilter);

    return nextPage.fold((failure) => throw failure, (animeList) => animeList);
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore) return;

    _isLoadingMore = true;

    _offset += kOffsetPaginationIncreasingRatio;

    final newAnimeList = await _fetchPage();

    _checkIfHasMore(newAnimeList);

    state.whenData((prev) => state = AsyncData([...prev, ...newAnimeList]));

    _isLoadingMore = false;
  }

  @override
  Future<List<Anime>> build() async {
    _offset = 0;
    _hasMore = true;
    return await _fetchPage();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    _offset = 0;

    _isLoadingMore = true;

    final newAnimeList = await _fetchPage();

    _checkIfHasMore(newAnimeList);

    state = AsyncData(newAnimeList);

    _isLoadingMore = false;
  }

  Future<void> filterByCategory(CategoryFilters category) async {
    state = const AsyncLoading();

    _offset = 0;

    _isLoadingMore = true;

    final newAnimeList = await _fetchPage(categoryFilter: category);

     _checkIfHasMore(newAnimeList);

    state = AsyncData(newAnimeList);

    _isLoadingMore = false;
  }

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;
}
