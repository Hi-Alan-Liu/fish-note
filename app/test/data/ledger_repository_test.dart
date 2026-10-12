import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:fish_note/data/db/app_database.dart';
import 'package:fish_note/data/ledger_repository.dart';
import 'package:fish_note/domain/categories.dart';
import 'package:fish_note/domain/feed.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  late AppDatabase db;
  late DateTime now;
  late LedgerRepository repo;

  setUp(() {
    db = memoryDb();
    now = DateTime(2026, 10, 12, 12);
    repo = LedgerRepository(db, clock: () => now);
  });
  tearDown(() => db.close());

  Future<SaveResult> expense(int amount, {String cat = 'food', DateTime? date}) =>
      repo.add(type: TxType.expense, amount: amount, categoryId: cat, date: date ?? now);

  Future<int> stock(FeedColor c, FeedLevel l) async {
    final row = await (db.select(db.feedInventory)
          ..where((f) => f.color.equalsValue(c) & f.level.equalsValue(l)))
        .getSingleOrNull();
    return row?.quantity ?? 0;
  }

  test('a record grants one level-A feed in its category colour', () async {
    final r = await expense(180, cat: 'transport');
    expect(r.reward?.color, FeedColor.blue);
    expect(r.reward?.level, FeedLevel.a);
    expect(await stock(FeedColor.blue, FeedLevel.a), 1);

    final tx = await db.select(db.transactions).getSingle();
    expect(tx.feedGranted, isTrue);
    expect(tx.amount, 180);
  });

  test('income grants gold feed', () async {
    final r = await repo.add(type: TxType.income, amount: 42000, categoryId: 'income', date: now);
    expect(r.reward?.color, FeedColor.gold);
  });

  test('a zero amount is saved but grants no feed', () async {
    final r = await expense(0);
    expect(r.reward, isNull);
    expect(r.noFeedReason, NoFeedReason.zeroAmount);
    expect(await db.transactions.count().getSingle(), 1);
    expect(await stock(FeedColor.orange, FeedLevel.a), 0);
  });

  test('at most 10 feeds per day; the 11th record grants none', () async {
    for (var i = 0; i < 10; i++) {
      expect((await expense(100)).reward, isNotNull, reason: 'record ${i + 1}');
    }
    final eleventh = await expense(100);
    expect(eleventh.reward, isNull);
    expect(eleventh.noFeedReason, NoFeedReason.dailyLimit);
    expect(await stock(FeedColor.orange, FeedLevel.a), 10);
  });

  test('deleting and re-entering does not refund the daily allowance', () async {
    final ids = <int>[];
    for (var i = 0; i < 10; i++) {
      ids.add((await expense(100)).txId);
    }
    await repo.delete(ids.last);
    final again = await expense(100);
    expect(again.noFeedReason, NoFeedReason.dailyLimit);
  });

  test('the allowance resets the next day', () async {
    for (var i = 0; i < 10; i++) {
      await expense(100);
    }
    now = now.add(const Duration(days: 1));
    expect((await expense(100)).reward, isNotNull);
  });

  test('back-dated records still count toward today', () async {
    for (var i = 0; i < 10; i++) {
      await expense(100, date: now.subtract(const Duration(days: 5)));
    }
    expect((await expense(100)).noFeedReason, NoFeedReason.dailyLimit);
  });

  test('3 days in a row upgrades the first feed of the day to B', () async {
    final day1 = await expense(50);
    expect(day1.reward?.level, FeedLevel.a);

    now = now.add(const Duration(days: 1));
    expect((await expense(50)).reward?.level, FeedLevel.a);

    now = now.add(const Duration(days: 1));
    final first = await expense(50);
    expect(first.reward?.level, FeedLevel.b);
    expect(first.reward?.streakBonus, isTrue);

    final second = await expense(50);
    expect(second.reward?.level, FeedLevel.a);
    expect(await stock(FeedColor.orange, FeedLevel.b), 1);
  });

  test('a gap day breaks the streak', () async {
    await expense(50);
    now = now.add(const Duration(days: 2)); // skipped a day
    await expense(50);
    now = now.add(const Duration(days: 1));
    expect((await expense(50)).reward?.level, FeedLevel.a);
  });

  test('editing changes the record but not the feed already granted', () async {
    final r = await expense(180);
    await repo.update(r.txId, type: TxType.expense, amount: 999, categoryId: 'shopping', date: now, note: ' 新鞋 ');

    final tx = await db.select(db.transactions).getSingle();
    expect(tx.amount, 999);
    expect(tx.categoryId, 'shopping');
    expect(tx.note, '新鞋');
    expect(await stock(FeedColor.orange, FeedLevel.a), 1);
    expect(await stock(FeedColor.pink, FeedLevel.a), 0);
  });
}
