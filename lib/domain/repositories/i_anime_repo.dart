import 'package:anime_discovery_app/core/failures/failure.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class IAnimeRepository {

  Future<Either<Failure, List<Anime>>> getPopularAnime();
  Future<Either<Failure, List<Anime>>> searchAnime(String query, {CancelToken? cancelToken});


}


