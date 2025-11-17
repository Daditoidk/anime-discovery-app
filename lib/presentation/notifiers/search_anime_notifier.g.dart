// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_anime_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchQuery)
const searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  const SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'c5ddbabeae677a223937a3b7f415845162742b80';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

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

String _$searchAnimeListHash() => r'cde022b81654ec7fcdea1a23692d647eee90f235';

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
