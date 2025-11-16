import 'package:anime_discovery_app/core/failures/failure.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/presentation/notifiers/popular_anime_list_notifier.dart';
import 'package:anime_discovery_app/presentation/widgets/anime_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularAnimeListPage extends ConsumerWidget {
  const PopularAnimeListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(popularAnimeListProvider);
    return Scaffold(
      body: SafeArea(
        child: listAsync.when(
          data: (List<Anime> data) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(popularAnimeListProvider);
                await ref.read(popularAnimeListProvider.notifier).refresh();
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    expandedHeight: 120,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    flexibleSpace: FlexibleSpaceBar(
                      expandedTitleScale: 1.8,
                      title: const Text('Popular Anime'),
                      titlePadding: EdgeInsets.symmetric(vertical: 16),
                      centerTitle: true,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final currentAnime = data[index];
                      return AnimeTile(
                        key: ValueKey('anime_tile_${currentAnime.id}'),
                        anime: currentAnime,
                      );
                    }, childCount: data.length),
                  ),
                ],
              ),
            );
          },
          error: (failure, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text((failure as Failure).message ?? ''),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(popularAnimeListProvider.notifier).refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
