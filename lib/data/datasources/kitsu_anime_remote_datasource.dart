import 'package:anime_discovery_app/core/constants/const.dart';
import 'package:anime_discovery_app/core/enums/category_filter.dart';
import 'package:anime_discovery_app/data/models/anime_dto.dart';
import 'package:dio/dio.dart';

abstract class IKitsuAPIRemoteDataSource {
  Future<List<AnimeDto>> getPopularAnime({
    int? offset,
    CategoryFilters? categoryFilter,
  });
  Future<List<AnimeDto>> searchAnime(
    String query, {
    CancelToken? cancelToken,
    int? offset,
  });
}

class KitsuAPIRemoteDataSourceImpl implements IKitsuAPIRemoteDataSource {
  final Dio dio;

  KitsuAPIRemoteDataSourceImpl(this.dio);

  var paginationParameters = <String, String>{};

  void addPaginationParams(int? offset, Map<String, String> queryParameters) {
    if (offset == null) return;
    paginationParameters = {
      'page[limit]': '$kLimitPagination',
      'page[offset]': offset.toString(),
    };
    queryParameters.addAll(paginationParameters);
  }

  void addFiltersParams(
    CategoryFilters? categoryFilter,
    Map<String, String> queryParameters,
  ) {
    if (categoryFilter == null) return;
    if (categoryFilter == CategoryFilters.all) return;
    queryParameters.addAll({'filter[categories]': categoryFilter.name});
  }

  @override
  Future<List<AnimeDto>> getPopularAnime({
    int? offset,
    CategoryFilters? categoryFilter,
  }) async {
    final queryParameters = {'sort': '-user_count'};
    addPaginationParams(offset, queryParameters);
    addFiltersParams(categoryFilter, queryParameters);

    try {
      final response = await dio.get(
        kPopularAnimeEndpoint,
        queryParameters: queryParameters,
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

  @override
  Future<List<AnimeDto>> searchAnime(
    String query, {
    CancelToken? cancelToken,
    int? offset,
  }) async {
    final queryParameters = {'filter[text]': query, 'sort': '-user_count'};
    addPaginationParams(offset, queryParameters);

    try {
      final response = await dio.get(
        kPopularAnimeEndpoint,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
      );

      final List<dynamic> data = response.data['data'];

      return data.map((json) => AnimeDto.fromJson(json)).toList();
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to searching popular anime: $e');
    }
  }
}
