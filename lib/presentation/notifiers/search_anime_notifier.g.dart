// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_anime_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchAnimeList)
const searchAnimeListProvider = SearchAnimeListProvider._();

final class SearchAnimeListProvider
    extends $AsyncNotifierProvider<SearchAnimeList, List<Anime>> {
  const SearchAnimeListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchAnimeListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchAnimeListHash();

  @$internal
  @override
  SearchAnimeList create() => SearchAnimeList();
}

String _$searchAnimeListHash() => r'5beb51a32c436544d46b06337c9ba6e6bd23451c';

abstract class _$SearchAnimeList extends $AsyncNotifier<List<Anime>> {
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
