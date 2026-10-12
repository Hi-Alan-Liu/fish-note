import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:fish_note/data/db/app_database.dart';
import 'package:fish_note/domain/categories.dart';
import 'package:fish_note/domain/feed.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = memoryDb());
  tearDown(() => db.close());

  test('first launch seeds categories, settings, wallet, tank and the starter fish', () async {
    final cats = await db.allCategories();
    expect(cats, hasLength(8));

    final settings = await db.select(db.settings).getSingle();
    expect(settings.currency, 'TWD');
    expect(settings.cycleStartDay, 1);
    expect(settings.reminderEnabled, isTrue);
    expect(settings.reminderMinutes, 21 * 60);

    final wallet = await db.select(db.wallet).getSingle();
    expect(wallet.coins, 0);

    final tank = await db.select(db.tanks).getSingle();
    expect(tank.fishSlots, 1);
    expect(tank.decoSlots, 1);
    expect(tank.floorId, 'floor_sand');

    final fishes = await db.select(db.fishes).get();
    expect(fishes, hasLength(1));
    expect(fishes.single.speciesId, starterSpeciesId);
    expect(fishes.single.inTank, isTrue);
    expect(fishes.single.everPlaced, isTrue);
    expect(fishes.single.satiety, 50);

    final tutorial = await db.select(db.tutorialProgress).getSingle();
    expect(tutorial.step, 0);
    expect(tutorial.starterFeedGranted, isFalse);
  });

  test('seeding again does not duplicate anything', () async {
    await db.allCategories(); // opens the db, runs the first seed
    await db.seedIfNeeded();
    await db.seedIfNeeded();

    expect(await db.categories.count().getSingle(), 8);
    expect(await db.fishes.count().getSingle(), 1);
    expect(await db.settings.count().getSingle(), 1);
    expect(await db.wallet.count().getSingle(), 1);
    expect(await db.tanks.count().getSingle(), 1);
    expect(await db.tutorialProgress.count().getSingle(), 1);
  });

  test('stored category colours match the feed colours in the docs', () async {
    final cats = {for (final c in await db.allCategories()) c.id: c};
    const expected = {
      'food': FeedColor.orange,
      'transport': FeedColor.blue,
      'shopping': FeedColor.pink,
      'fun': FeedColor.purple,
      'home': FeedColor.green,
      'health': FeedColor.cyan,
      'other': FeedColor.white,
      'income': FeedColor.gold,
    };
    for (final e in expected.entries) {
      expect(cats[e.key]!.feedColor, e.value, reason: e.key);
    }
    expect(cats['income']!.type, TxType.income);
    expect(cats.values.where((c) => c.type == TxType.expense), hasLength(7));
  });

  test('feed levels follow the economy table', () {
    expect(FeedLevel.a.digest, const Duration(hours: 1));
    expect(FeedLevel.a.coins, 10);
    expect(FeedLevel.b.digest, const Duration(hours: 2));
    expect(FeedLevel.b.coins, 30);
    expect(FeedLevel.tutorial.digest, Duration.zero);
    expect(FeedLevel.tutorial.coins, 5);
  });
}
