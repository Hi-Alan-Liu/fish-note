import 'package:drift/drift.dart';

import '../domain/categories.dart';
import '../domain/feed.dart';
import 'db/app_database.dart';

class FeedReward {
  const FeedReward(this.color, this.level, {this.streakBonus = false});
  final FeedColor color;
  final FeedLevel level;

  /// True when the level was upgraded by the 3-day streak.
  final bool streakBonus;
}

enum NoFeedReason { zeroAmount, dailyLimit }

class SaveResult {
  const SaveResult(this.txId, {this.reward, this.noFeedReason});
  final int txId;
  final FeedReward? reward;
  final NoFeedReason? noFeedReason;
}

/// Ledger writes and the feed hand-out rules (docs/stages/S02-ledger-entry.md).
class LedgerRepository {
  LedgerRepository(this._db, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final DateTime Function() _clock;

  static const dailyFeedLimit = 10;

  /// Days in a row (including today) needed for the first feed of the day to become B.
  static const streakDaysForB = 3;

  Future<SaveResult> add({
    required TxType type,
    required int amount,
    required String categoryId,
    required DateTime date,
    String note = '',
  }) =>
      _db.transaction(() async {
        final now = _clock();
        final category = await (_db.select(_db.categories)..where((c) => c.id.equals(categoryId))).getSingle();

        final txId = await _db.into(_db.transactions).insert(TransactionsCompanion.insert(
              amount: amount,
              type: type,
              categoryId: categoryId,
              date: date,
              note: Value(note.trim()),
              createdAt: now,
            ));

        if (amount <= 0) return SaveResult(txId, noFeedReason: NoFeedReason.zeroAmount);

        // The limit follows the moment of entry, not the date written on the record.
        final today = DateTime(now.year, now.month, now.day);
        final grantedToday = await _grantsOn(today);
        if (grantedToday >= dailyFeedLimit) return SaveResult(txId, noFeedReason: NoFeedReason.dailyLimit);

        var streak = false;
        if (grantedToday == 0) {
          streak = true;
          for (var d = 1; d < streakDaysForB; d++) {
            if (await _grantsOn(today.subtract(Duration(days: d))) == 0) {
              streak = false;
              break;
            }
          }
        }
        final level = streak ? FeedLevel.b : FeedLevel.a;
        final color = category.feedColor;

        await _db.into(_db.feedGrants).insert(FeedGrantsCompanion.insert(
              txId: Value(txId),
              color: color,
              level: level,
              grantedAt: now,
            ));
        await _addFeed(color, level, 1);
        await (_db.update(_db.transactions)..where((t) => t.id.equals(txId)))
            .write(const TransactionsCompanion(feedGranted: Value(true)));

        return SaveResult(txId, reward: FeedReward(color, level, streakBonus: streak));
      });

  /// Edits never change feed that was already handed out.
  Future<void> update(
    int id, {
    required TxType type,
    required int amount,
    required String categoryId,
    required DateTime date,
    String note = '',
  }) =>
      (_db.update(_db.transactions)..where((t) => t.id.equals(id))).write(TransactionsCompanion(
        type: Value(type),
        amount: Value(amount),
        categoryId: Value(categoryId),
        date: Value(date),
        note: Value(note.trim()),
      ));

  /// Feed grants stay, so today's used allowance is not refunded.
  Future<void> delete(int id) => (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();

  Future<int> _grantsOn(DateTime day) {
    final next = day.add(const Duration(days: 1));
    final count = _db.feedGrants.id.count();
    final q = _db.selectOnly(_db.feedGrants)
      ..addColumns([count])
      ..where(_db.feedGrants.grantedAt.isBiggerOrEqualValue(day) & _db.feedGrants.grantedAt.isSmallerThanValue(next));
    return q.map((r) => r.read(count)!).getSingle();
  }

  Future<void> _addFeed(FeedColor color, FeedLevel level, int n) => _db.into(_db.feedInventory).insert(
        FeedInventoryCompanion.insert(color: color, level: level, quantity: Value(n)),
        onConflict: DoUpdate((old) => FeedInventoryCompanion.custom(quantity: old.quantity + Constant(n))),
      );
}
