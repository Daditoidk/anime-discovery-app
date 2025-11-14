import 'package:anime_discovery_app/core/failures/failure.dart';
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text('Popular Anime List'),
            ),
            Flexible(
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
                error: (failure, stackTrace) {
                  return Center(child: Text('${(failure as Failure).message}'));
          },
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
        ),
            ),
          ],
        )
      ),
    );
  }
}
