import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/presentation/providers/anime_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'popular_anime_list_notifier.g.dart';

@riverpod
class PopularAnimeListNotifier extends _$PopularAnimeListNotifier {
  @override
  Future<List<Anime>> build() async {
    return _loadPopularAnime();
  }

  Future<List<Anime>> _loadPopularAnime() async {
    final repo = ref.watch(animeRepositoryProvider);
    final result = await repo.getPopularAnime();

    return result.fold((failure) => throw failure, (animeList) => animeList);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadPopularAnime());
  }
}
