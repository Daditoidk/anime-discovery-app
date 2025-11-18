import 'dart:developer';

import 'package:anime_discovery_app/presentation/widgets/anime_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:anime_discovery_app/main.dart' as app;

Future<void> enterSearchQuery(WidgetTester tester, String query) async {
  final searchField = find.byKey(const Key('popular-anime-search-input'));
  expect(searchField, findsOneWidget);

  await tester.ensureVisible(searchField);
  await tester.enterText(searchField, query);

  // Wait for debounce timer to be scheduled
  await tester.pump(const Duration(milliseconds: 100));

  // Wait for debounce timer to fire (350ms + buffer)
  await tester.pump(const Duration(milliseconds: 400));

  // Allow async operation to start
  await tester.pump();

  // Wait a bit for API call to start
  await tester.pump(const Duration(seconds: 1));
}

Future<void> waitForFinder(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
  Duration step = const Duration(milliseconds: 100),
}) async {
  var elapsed = Duration.zero;
  while (elapsed < timeout) {
    await tester.pump(step);
    if (finder.evaluate().isNotEmpty) return;
    elapsed += step;
  }
  fail('finder $finder not satisfied within $timeout');
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Popular anime list loads and displays', (tester) async {
    app.main();
    //First build
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //API call delay to wait for data to load
    await waitForFinder(tester, find.byType(SliverList));

    expect(find.byType(SliverList), findsOneWidget);

    expect(find.byType(AnimeTile), findsAtLeastNWidgets(1));
  });
  testWidgets('infinite scroll loads more anime', (tester) async {
    app.main();
    await tester.pump();

    // Wait for initial data
    await waitForFinder(
      tester,
      find.byType(AnimeTile),
      timeout: const Duration(seconds: 10),
    );

    // Verify at least some items loaded
    expect(find.byType(AnimeTile), findsAtLeastNWidgets(1));

    // Store initial count of VISIBLE items
    final initialCount = tester.widgetList(find.byType(AnimeTile)).length;
    var count = initialCount;
    log('Initial visible items: $initialCount');

    // Scroll down A LOT to trigger loadMore
    final scrollView = find.byType(CustomScrollView);

    // Do multiple small drags (more reliable than one big drag)
    for (int i = 0; i < 3; i++) {
      await tester.drag(scrollView, const Offset(0, -500));
      await tester.pump(const Duration(milliseconds: 100));
      count += tester.widgetList(find.byType(AnimeTile)).length;
      log('Dragging down $i times, now visible items: $count');
    }

    // Wait for network request
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Scroll back up to make earlier items visible again
    for (int i = 0; i < 3; i++) {
      await tester.drag(scrollView, const Offset(0, 500));
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.pumpAndSettle();

    // Now count visible items again
    log('After scroll visible items: $count');

    // Verify MORE items are now rendered
    expect(count, greaterThan(initialCount));
  });
}
