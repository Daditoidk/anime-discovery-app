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

    expect(find.byType(ListView), findsOneWidget);

    expect(find.byType(AnimeTile), findsAtLeastNWidgets(1));

  });
}
