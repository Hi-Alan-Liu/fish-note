import 'package:drift/drift.dart';

import '../../domain/categories.dart';
import '../../domain/feed.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Single-row tables (settings, wallet, tank, tutorial) use this id.
const singletonId = 1;

const starterSpeciesId = 'clownfish';

@DriftDatabase(tables: [
  Categories,
  Transactions,
  FeedInventory,
  Fishes,
  FeedGrants,
  Feedings,
  DroppedCoins,
  Wallet,
  Tanks,
  InventoryItems,
  Placements,
  Settings,
  TutorialProgress,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await seedIfNeeded();
        },
      );

  /// Writes the first-launch data. Safe to call repeatedly.
  Future<void> seedIfNeeded({DateTime? now}) => transaction(() async {
        final at = now ?? DateTime.now();

        for (final (i, c) in defaultCategories.indexed) {
          await into(categories).insert(
            CategoriesCompanion.insert(
              id: c.id,
              name: c.name,
              type: c.type,
              feedColor: c.feedColor,
              sortOrder: i,
            ),
            mode: InsertMode.insertOrIgnore,
          );
        }

        await into(settings).insert(
          const SettingsCompanion(id: Value(singletonId)),
          mode: InsertMode.insertOrIgnore,
        );
        await into(wallet).insert(
          const WalletCompanion(id: Value(singletonId)),
          mode: InsertMode.insertOrIgnore,
        );
        await into(tanks).insert(
          const TanksCompanion(id: Value(singletonId)),
          mode: InsertMode.insertOrIgnore,
        );
        await into(tutorialProgress).insert(
          const TutorialProgressCompanion(id: Value(singletonId)),
          mode: InsertMode.insertOrIgnore,
        );

        final fishCount = await fishes.count().getSingle();
        if (fishCount == 0) {
          await into(fishes).insert(FishesCompanion.insert(
            speciesId: starterSpeciesId,
            inTank: const Value(true),
            satiety: const Value(50),
            satietyAt: at,
            everPlaced: const Value(true),
            createdAt: at,
          ));
        }
      });

  // ---------- queries ----------

  Stream<Tank> watchTank() =>
      (select(tanks)..where((t) => t.id.equals(singletonId))).watchSingle();

  Stream<List<Fish>> watchFishes() =>
      (select(fishes)..orderBy([(f) => OrderingTerm.asc(f.id)])).watch();

  Stream<WalletRow> watchWallet() =>
      (select(wallet)..where((w) => w.id.equals(singletonId))).watchSingle();

  Future<List<Category>> allCategories() =>
      (select(categories)..orderBy([(c) => OrderingTerm.asc(c.sortOrder)])).get();

  Stream<List<FeedStock>> watchFeedStocks() => (select(feedInventory)
        ..where((f) => f.quantity.isBiggerThanValue(0))
        ..orderBy([(f) => OrderingTerm.asc(f.color), (f) => OrderingTerm.asc(f.level)]))
      .watch();

  /// Newest first; each record paired with its category.
  Stream<List<TxWithCategory>> watchTransactions() {
    final q = select(transactions).join([
      innerJoin(categories, categories.id.equalsExp(transactions.categoryId)),
    ])
      ..orderBy([OrderingTerm.desc(transactions.date), OrderingTerm.desc(transactions.id)]);
    return q.watch().map((rows) => [
          for (final r in rows) TxWithCategory(r.readTable(transactions), r.readTable(categories)),
        ]);
  }
}

class TxWithCategory {
  const TxWithCategory(this.tx, this.category);
  final TxRecord tx;
  final Category category;
}
