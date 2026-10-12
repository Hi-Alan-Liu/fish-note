import 'package:fish_note/data/db/app_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  late AppDatabase db;
  final now = DateTime(2026, 10, 12, 12);

  setUp(() async => db = await openedMemoryDb());

  Future<void> enterAmount(WidgetTester tester, String digits) async {
    for (final k in digits.split('')) {
      await tester.tap(find.byKey(Key('key-$k')));
    }
    await tester.pump();
  }

  testWidgets('entering an expense saves it, grants feed and lists it in 明細', (tester) async {
    await pumpFishNote(tester, db, clock: () => now);

    await tester.tap(find.byKey(const Key('nav-add')));
    await tester.pumpAndSettle();

    final submit = find.byKey(const Key('key-submit'));
    expect(tester.widget<FilledButton>(submit).onPressed, isNull, reason: 'disabled at 0');

    await enterAmount(tester, '180');
    expect(tester.widget<Text>(find.byKey(const Key('amount-display'))).data, '180');

    await tester.tap(find.byKey(const Key('cat-food')));
    await tester.tap(submit);
    await settle(tester);

    expect(find.text('獲得 橘色飼料 A ×1'), findsOneWidget);
    expect(find.descendant(of: find.byKey(const Key('feed-total')), matching: find.text('1')), findsOneWidget);

    await tester.tap(find.text('明細').last);
    await tester.pumpAndSettle();
    expect(find.text('-180'), findsWidgets);
    expect(find.text('餐飲'), findsOneWidget);

    await disposeFishNote(tester, db);
  });

  testWidgets('a record can be edited and deleted from 明細', (tester) async {
    await pumpFishNote(tester, db, clock: () => now);
    await tester.tap(find.byKey(const Key('nav-add')));
    await tester.pumpAndSettle();
    await enterAmount(tester, '50');
    await tester.tap(find.byKey(const Key('key-submit')));
    await settle(tester);

    await tester.tap(find.text('明細').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('餐飲'));
    await tester.pumpAndSettle();
    expect(find.text('編輯紀錄'), findsOneWidget);

    await enterAmount(tester, '0');
    await tester.tap(find.byKey(const Key('key-submit')));
    await settle(tester);
    expect(find.text('-500'), findsWidgets);

    await tester.tap(find.text('餐飲'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('刪除這筆'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('刪除'));
    await settle(tester);

    expect(find.text('還沒有任何紀錄，按下方 ＋ 記第一筆帳'), findsOneWidget);
    await disposeFishNote(tester, db);
  });
}
