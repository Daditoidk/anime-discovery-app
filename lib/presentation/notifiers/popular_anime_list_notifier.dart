import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/presentation/providers/anime_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'popular_anime_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class PopularAnimeList extends _$PopularAnimeList {
  @override
  Future<List<Anime>> build() async {
    final repo = ref.watch(animeRepositoryProvider);
    final result = await repo.getPopularAnime();

    // Either throw the error or return the data
    return result.fold(
      (failure) => throw failure, // Let Riverpod wrap it in AsyncError
      (animeList) => animeList,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    final repo = ref.read(animeRepositoryProvider);
    final result = await repo.getPopularAnime();

    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      (animeList) => AsyncData(animeList),
    );
  }
}
