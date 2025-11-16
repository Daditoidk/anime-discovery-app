import 'package:anime_discovery_app/core/constants/const.dart';
import 'package:anime_discovery_app/data/models/anime_dto.dart';
import 'package:dio/dio.dart';

abstract class IKitsuAPIRemoteDataSource {
  Future<List<AnimeDto>> getPopularAnime();
}

class KitsuAPIRemoteDataSourceImpl implements IKitsuAPIRemoteDataSource {
  final Dio dio;

  KitsuAPIRemoteDataSourceImpl(this.dio);

  @override
  Future<List<AnimeDto>> getPopularAnime() async {
    try {
      final response = await dio.get(
        kPopularAnimeEndpoint,
        queryParameters: {'sort': '-user_count'},
      );

      final List<dynamic> data = response.data['data'];

      return data
          .where((json) => json['type'] == kAnimeType)
          .map((json) => AnimeDto.fromJson(json))
          .toList();
          
    } on DioException {
      // let repository handle DioException → Failure mapping
      rethrow;
    } catch (e) {
      throw Exception('Failed to fetch popular anime: $e');
    }
  }
}
