// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_anime_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PopularAnimeListNotifier)
const popularAnimeListProvider = PopularAnimeListNotifierProvider._();

final class PopularAnimeListNotifierProvider
    extends $AsyncNotifierProvider<PopularAnimeListNotifier, List<Anime>> {
  const PopularAnimeListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularAnimeListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularAnimeListNotifierHash();

  @$internal
  @override
  PopularAnimeListNotifier create() => PopularAnimeListNotifier();
}

String _$popularAnimeListNotifierHash() =>
    r'249648f23b411168c7ae298c5ecd6e5fcd2f2be4';

abstract class _$PopularAnimeListNotifier extends $AsyncNotifier<List<Anime>> {
  FutureOr<List<Anime>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Anime>>, List<Anime>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Anime>>, List<Anime>>,
              AsyncValue<List<Anime>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
