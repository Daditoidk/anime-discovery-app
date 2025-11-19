import 'package:anime_discovery_app/core/enums/category_filter.dart';
import 'package:anime_discovery_app/core/failures/failure.dart';
import 'package:anime_discovery_app/domain/entities/anime.dart';
import 'package:anime_discovery_app/presentation/notifiers/popular_anime_list_notifier.dart';
import 'package:anime_discovery_app/presentation/notifiers/search_anime_notifier.dart';
import 'package:anime_discovery_app/presentation/widgets/anime_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularAnimeListPage extends ConsumerStatefulWidget {
  const PopularAnimeListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PopularAnimeListPageState();
}

class _PopularAnimeListPageState extends ConsumerState<PopularAnimeListPage> {
  late final TextEditingController searchController;
  late final ScrollController scrollController;

  @override
  void initState() {
    searchController = TextEditingController(text: '');
    scrollController = ScrollController(
      debugLabel: 'AnimeListScrollController',
    );
    scrollController.addListener(() {
      if (_nearBottom) callLoadMore();
    });
    super.initState();
  }

  bool get _nearBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScrollOffset = scrollController.offset;
    return currentScrollOffset >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void callLoadMore() async {
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) {
      //popular anime list
      await ref.read(popularAnimeListProvider.notifier).loadMore();
    } else {
      //search anime list
      await ref.read(searchAnimeListProvider.notifier).loadMore();
    }
  }

  Future<void> onRefresh() async {
    final query = ref.watch(searchQueryProvider);
    if (query.isEmpty) {
      //popular anime list
      ref.invalidate(popularAnimeListProvider);
      await ref.read(popularAnimeListProvider.notifier).refresh();
    } else {
      //search anime list
      ref.read(searchAnimeListProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);

    final state = query.isEmpty
        ? ref.watch(popularAnimeListProvider)
        : ref.watch(searchAnimeListProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                expandedHeight: 140,
                collapsedHeight: 140,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  collapseMode: CollapseMode.pin,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text('Popular Anime', textAlign: TextAlign.center),
                        SizedBox(height: 16),
                        TextFormField(
                          key: const Key('popular-anime-search-input'),
                          controller: searchController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(width: 2),
                              gapPadding: 16,
                            ),
                            contentPadding: EdgeInsets.only(bottom: 8),
                            hintText: 'Search anime ...',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffix: IconButton(
                              onPressed: () {
                                searchController.text = '';
                                ref.read(searchQueryProvider.notifier).clear();
                              },
                              icon: Icon(Icons.close),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ref
                                    .read(searchQueryProvider.notifier)
                                    .setQuery(searchController.text);
                                ref
                                    .read(searchAnimeListProvider.notifier)
                                    .search();
                              },
                              icon: Icon(Icons.search),
                            ),
                          ),
                          onChanged: (query) {
                            ref
                                .read(searchQueryProvider.notifier)
                                .setQuery(query);
                            ref.read(searchAnimeListProvider.notifier).search();
                          },
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.symmetric(vertical: 16),
                  centerTitle: true,
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      CategoryFilters.values.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          label: Text(CategoryFilters.values[index].name),
                          onSelected: (selected) {
                            ref
                                .read(popularAnimeListProvider.notifier)
                                .filterByCategory(
                                  CategoryFilters.values[index],
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              switch (state) {
                AsyncLoading() => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                ),
                AsyncError(:final error) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text((error as Failure).message ?? ''),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => onRefresh(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
                AsyncData<List<Anime>>(:List<Anime> value) => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final currentAnime = value[index];
                    return AnimeTile(
                      key: ValueKey('anime_tile_${currentAnime.id}'),
                      anime: currentAnime,
                    );
                  }, childCount: value.length),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
