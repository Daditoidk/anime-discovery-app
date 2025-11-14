import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/presentation/notifiers/popular_anime_list_notifier.dart';
import 'package:anime_discovery_app/presentation/providers/anime_providers.dart';
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
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final currentAnime = data[index];
                return AnimeTile(anime: currentAnime);
              },
            );
          },
          error: (e, stackTrace) {
            return Center(child: Text('$e'));
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
