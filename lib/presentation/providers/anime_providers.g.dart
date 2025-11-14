// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
const dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'f0c035218bb620547f41b69a2b286b319148a835';

@ProviderFor(kitsuAPIRemoteDatasource)
const kitsuAPIRemoteDatasourceProvider = KitsuAPIRemoteDatasourceProvider._();

final class KitsuAPIRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          IKitsuAPIRemoteDataSource,
          IKitsuAPIRemoteDataSource,
          IKitsuAPIRemoteDataSource
        >
    with $Provider<IKitsuAPIRemoteDataSource> {
  const KitsuAPIRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitsuAPIRemoteDatasourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitsuAPIRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<IKitsuAPIRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IKitsuAPIRemoteDataSource create(Ref ref) {
    return kitsuAPIRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IKitsuAPIRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IKitsuAPIRemoteDataSource>(value),
    );
  }
}

String _$kitsuAPIRemoteDatasourceHash() =>
    r'797500f006d2b54bde0186c82aaf289411be2956';

@ProviderFor(animeRepository)
const animeRepositoryProvider = AnimeRepositoryProvider._();

final class AnimeRepositoryProvider
    extends
        $FunctionalProvider<
          IAnimeRepository,
          IAnimeRepository,
          IAnimeRepository
        >
    with $Provider<IAnimeRepository> {
  const AnimeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'animeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$animeRepositoryHash();

  @$internal
  @override
  $ProviderElement<IAnimeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IAnimeRepository create(Ref ref) {
    return animeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IAnimeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IAnimeRepository>(value),
    );
  }
}

String _$animeRepositoryHash() => r'208dc6117b655d57b8389d64eea895599dddabb5';
