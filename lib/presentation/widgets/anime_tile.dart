import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeTile extends StatelessWidget {
  final Anime anime;
  const AnimeTile({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAliasWithSaveLayer,

      child: SizedBox(
        height: size.height / 2.3,

        child: Stack(
          children: [
            Positioned.fill(
              bottom: 0,
              right: 0,
              left: 0,
              top: 0,
              child: CachedNetworkImage(
                imageUrl: anime.posterImageUrl ?? '',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: size.width,
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.darken,
                  gradient: LinearGradient(
                    colors: [Colors.black26, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${anime.id} - ${anime.canonicalTitle}}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
