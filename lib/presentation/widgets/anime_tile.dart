import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:flutter/material.dart';

class AnimeTile extends StatelessWidget {
  final Anime anime;
  const AnimeTile({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      elevation: 8,
      shape: RoundedRectangleBorder(),
      child: Stack(
        children: [
          Image.network(
            anime.coverImageUrl ?? '',
            errorBuilder: (context, error, stackTrace) =>
                Center(child: Icon(Icons.error_outline_outlined)),
          ),
          Container(
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.darken,
              gradient: LinearGradient(
                colors: [Colors.black12, Colors.black54],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Text(anime.canonicalTitle),
          ),
        ],
      ),
    );
  }
}
