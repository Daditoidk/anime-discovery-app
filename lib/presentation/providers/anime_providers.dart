import 'package:anime_discovery_app/core/constants/const.dart';
import 'package:anime_discovery_app/data/datasources/kitsu_anime_remote_datasource.dart';
import 'package:anime_discovery_app/data/repositories/anime_repo_impl.dart';
import 'package:anime_discovery_app/domain/repositories/i_anime_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'anime_providers.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: kKitsuAPI,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }
  return dio;
}

@Riverpod(keepAlive: true)
IKitsuAPIRemoteDataSource kitsuAPIRemoteDatasource(Ref ref) {
  return KitsuAPIRemoteDataSourceImpl(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
IAnimeRepository animeRepository(Ref ref) {
  return AnimeRepositoryImpl(ref.watch(kitsuAPIRemoteDatasourceProvider));
}
