import 'package:fish_note/data/db/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  late AppDatabase db;

  setUp(() async => db = await openedMemoryDb());

  testWidgets('bottom nav switches between the four tabs', (tester) async {
    await pumpFishNote(tester, db);

    for (final label in ['魚缸', '明細', '商城', '背包']) {
      expect(find.text(label), findsWidgets);
    }

    await tester.tap(find.text('明細').last);
    await tester.pumpAndSettle();
    expect(find.text('還沒有任何紀錄，按下方 ＋ 記第一筆帳'), findsOneWidget);

    await tester.tap(find.text('商城').last);
    await tester.pumpAndSettle();
    expect(find.text('商城準備中，橘橘正在進貨'), findsOneWidget);

    await disposeFishNote(tester, db);
  });

  testWidgets('backpack reads the seeded starter fish from the database', (tester) async {
    await pumpFishNote(tester, db);
    await tester.tap(find.text('背包').last);
    await tester.pumpAndSettle();

    expect(find.text('魚 1/1'), findsOneWidget);
    expect(find.text('橘橘'), findsOneWidget);
    expect(find.text('在魚缸中'), findsOneWidget);

    await disposeFishNote(tester, db);
  });
}
