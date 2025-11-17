// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_anime_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PopularAnimeList)
const popularAnimeListProvider = PopularAnimeListProvider._();

final class PopularAnimeListProvider
    extends $AsyncNotifierProvider<PopularAnimeList, List<Anime>> {
  const PopularAnimeListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularAnimeListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularAnimeListHash();

  @$internal
  @override
  PopularAnimeList create() => PopularAnimeList();
}

String _$popularAnimeListHash() => r'32cafaa9497bb04199965bf93abd8ea2aae8e6de';

abstract class _$PopularAnimeList extends $AsyncNotifier<List<Anime>> {
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
