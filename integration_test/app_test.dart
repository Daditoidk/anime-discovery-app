import 'package:anime_discovery_app/presentation/widgets/anime_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:anime_discovery_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Popular anime list loads and displays', (tester) async {
    app.main();
    //First build
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //API call delay to wait for data to load
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(SliverList), findsOneWidget);

    expect(find.byType(AnimeTile), findsAtLeastNWidgets(1));
  });

  testWidgets('Search popular anime and display it', (tester) async {
    app.main();

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //API call delay to wait for data to load
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(SliverAppBar), findsOneWidget);

    expect(find.byKey(const Key('popular-anime-search-input')), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('popular-anime-search-input')),
      'Kimetsu no Yaiba',
    );

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(SliverList), findsOneWidget);

    expect(find.byType(AnimeTile), findsAtLeastNWidgets(1));
  });

  testWidgets('Search no popular anime and it shoudlnt display it', (
    tester,
  ) async {
    app.main();

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    //API call delay to wait for data to load
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(SliverAppBar), findsOneWidget);

    expect(find.byKey(const Key('popular-anime-search-input')), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('popular-anime-search-input')),
      'Ranma 1/2',
    );

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(SliverList), findsOneWidget);

    expect(find.byType(AnimeTile), findsNothing);

  });
}
