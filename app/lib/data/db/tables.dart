import 'package:drift/drift.dart';

import '../../domain/categories.dart';
import '../../domain/feed.dart';

/// Schema from docs/04-tech-architecture.md.

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => textEnum<TxType>()();
  TextColumn get feedColor => textEnum<FeedColor>()();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TxRecord')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Whole currency units (NT$ has no decimals).
  IntColumn get amount => integer()();
  TextColumn get currency => text().withDefault(const Constant('TWD'))();
  TextColumn get type => textEnum<TxType>()();
  TextColumn get categoryId => text().references(Categories, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().withDefault(const Constant(''))();
  BoolColumn get feedGranted => boolean().withDefault(const Constant(false))();
  BoolColumn get isTutorial => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('FeedStock')
class FeedInventory extends Table {
  TextColumn get color => textEnum<FeedColor>()();
  TextColumn get level => textEnum<FeedLevel>()();
  IntColumn get quantity => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {color, level};
}

@DataClassName('Fish')
class Fishes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get speciesId => text()();
  BoolColumn get inTank => boolean().withDefault(const Constant(false))();

  /// 0–100. Frozen while the fish is in the backpack (D-15).
  RealColumn get satiety => real().withDefault(const Constant(50))();
  DateTimeColumn get satietyAt => dateTime()();

  /// Whether the fish has ever been placed in the tank; the 50% start applies only once.
  BoolColumn get everPlaced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

/// One row per feed handed out. Kept when a transaction is deleted, so the
/// daily limit cannot be bypassed by deleting and re-entering records.
class FeedGrants extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get txId => integer().nullable()();
  TextColumn get color => textEnum<FeedColor>()();
  TextColumn get level => textEnum<FeedLevel>()();
  DateTimeColumn get grantedAt => dateTime()();
}

class Feedings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fishId => integer().references(Fishes, #id)();
  TextColumn get feedColor => textEnum<FeedColor>()();
  TextColumn get feedLevel => textEnum<FeedLevel>()();
  DateTimeColumn get fedAt => dateTime()();
  DateTimeColumn get readyAt => dateTime()();

  /// Remaining digestion time saved while the fish sits in the backpack.
  IntColumn get remainingMs => integer().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}

class DroppedCoins extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()();

  /// Horizontal position, 0–1 of the tank width.
  RealColumn get x => real()();
  DateTimeColumn get droppedAt => dateTime()();
}

@DataClassName('WalletRow')
class Wallet extends Table {
  IntColumn get id => integer()();
  IntColumn get coins => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Tanks extends Table {
  IntColumn get id => integer()();
  TextColumn get backgroundId => text().withDefault(const Constant('bg_default'))();
  TextColumn get floorId => text().withDefault(const Constant('floor_sand'))();
  IntColumn get fishSlots => integer().withDefault(const Constant(1))();
  IntColumn get decoSlots => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

class InventoryItems extends Table {
  TextColumn get itemId => text()();
  IntColumn get quantity => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {itemId};
}

class Placements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemId => text()();

  /// 0–1 proportional coordinates so layouts survive screen changes.
  RealColumn get x => real()();
  RealColumn get y => real()();
  IntColumn get layer => integer().withDefault(const Constant(0))();
  BoolColumn get flipped => boolean().withDefault(const Constant(false))();
}

@DataClassName('AppSettings')
class Settings extends Table {
  IntColumn get id => integer()();
  TextColumn get currency => text().withDefault(const Constant('TWD'))();
  IntColumn get cycleStartDay => integer().withDefault(const Constant(1))();
  BoolColumn get reminderEnabled => boolean().withDefault(const Constant(true))();

  /// Minutes after midnight; 21:00 by default.
  IntColumn get reminderMinutes => integer().withDefault(const Constant(21 * 60))();
  BoolColumn get coinNotifyEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastBackupAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TutorialState')
class TutorialProgress extends Table {
  IntColumn get id => integer()();
  IntColumn get step => integer().withDefault(const Constant(0))();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  BoolColumn get skipped => boolean().withDefault(const Constant(false))();
  BoolColumn get starterFeedGranted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
