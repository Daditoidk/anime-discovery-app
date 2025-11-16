import 'package:anime_discovery_app/core/extensions/mappers.dart';
import 'package:anime_discovery_app/core/failures/failure.dart';
import 'package:anime_discovery_app/data/datasources/kitsu_anime_remote_datasource.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/domain/repositories/i_anime_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AnimeRepositoryImpl implements IAnimeRepository {
  final IKitsuAPIRemoteDataSource api;

  AnimeRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<Anime>>> getPopularAnime() async {
    try {
      final popularAnimeDtos = await api.getPopularAnime();

      final popularAnimeEntities = popularAnimeDtos
          .map((dto) => dto.toEntity())
          .toList();

      return Right(popularAnimeEntities);
    } on DioException catch (e){
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
