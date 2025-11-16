import 'package:anime_discovery_app/core/failures/failure.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:dartz/dartz.dart';

abstract class IAnimeRepository {

  Future<Either<Failure, List<Anime>>> getPopularAnime();


}


