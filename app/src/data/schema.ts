import { DEFAULT_CATEGORIES } from '@/domain/categories';

import type { Db } from './db';

/** Single-row tables (settings, wallet, tank, tutorial) use this id. */
export const SINGLETON_ID = 1;
export const STARTER_SPECIES_ID = 'clownfish';

/**
 * Schema from docs/04-tech-architecture.md. Times are epoch milliseconds,
 * booleans are 0/1. Append new migrations; never edit a shipped one.
 */
const MIGRATIONS: string[] = [
  `
  CREATE TABLE categories (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    feed_color TEXT NOT NULL,
    sort_order INTEGER NOT NULL
  );
  CREATE TABLE transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    amount INTEGER NOT NULL,
    currency TEXT NOT NULL DEFAULT 'TWD',
    type TEXT NOT NULL,
    category_id TEXT NOT NULL REFERENCES categories(id),
    date INTEGER NOT NULL,
    note TEXT NOT NULL DEFAULT '',
    feed_granted INTEGER NOT NULL DEFAULT 0,
    is_tutorial INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL
  );
  CREATE INDEX transactions_date ON transactions(date);
  -- One row per feed handed out. Kept when a transaction is deleted, so the daily
  -- limit cannot be bypassed by deleting and re-entering records.
  CREATE TABLE feed_grants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tx_id INTEGER,
    color TEXT NOT NULL,
    level TEXT NOT NULL,
    granted_at INTEGER NOT NULL
  );
  CREATE INDEX feed_grants_granted_at ON feed_grants(granted_at);
  CREATE TABLE feed_inventory (
    color TEXT NOT NULL,
    level TEXT NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (color, level)
  );
  CREATE TABLE fishes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    species_id TEXT NOT NULL,
    in_tank INTEGER NOT NULL DEFAULT 0,
    satiety REAL NOT NULL DEFAULT 50,
    satiety_at INTEGER NOT NULL,
    ever_placed INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL
  );
  CREATE TABLE feedings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fish_id INTEGER NOT NULL REFERENCES fishes(id),
    feed_color TEXT NOT NULL,
    feed_level TEXT NOT NULL,
    fed_at INTEGER NOT NULL,
    ready_at INTEGER NOT NULL,
    remaining_ms INTEGER,
    completed INTEGER NOT NULL DEFAULT 0
  );
  CREATE TABLE dropped_coins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    amount INTEGER NOT NULL,
    x REAL NOT NULL,
    dropped_at INTEGER NOT NULL
  );
  CREATE TABLE wallet (
    id INTEGER PRIMARY KEY,
    coins INTEGER NOT NULL DEFAULT 0
  );
  CREATE TABLE tanks (
    id INTEGER PRIMARY KEY,
    background_id TEXT NOT NULL DEFAULT 'bg_default',
    floor_id TEXT NOT NULL DEFAULT 'floor_sand',
    fish_slots INTEGER NOT NULL DEFAULT 1,
    deco_slots INTEGER NOT NULL DEFAULT 1
  );
  CREATE TABLE inventory_items (
    item_id TEXT PRIMARY KEY,
    quantity INTEGER NOT NULL DEFAULT 0
  );
  CREATE TABLE placements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    item_id TEXT NOT NULL,
    x REAL NOT NULL,
    y REAL NOT NULL,
    layer INTEGER NOT NULL DEFAULT 0,
    flipped INTEGER NOT NULL DEFAULT 0
  );
  CREATE TABLE settings (
    id INTEGER PRIMARY KEY,
    currency TEXT NOT NULL DEFAULT 'TWD',
    cycle_start_day INTEGER NOT NULL DEFAULT 1,
    reminder_enabled INTEGER NOT NULL DEFAULT 1,
    reminder_minutes INTEGER NOT NULL DEFAULT 1260,
    coin_notify_enabled INTEGER NOT NULL DEFAULT 1,
    sound_enabled INTEGER NOT NULL DEFAULT 1,
    last_backup_at INTEGER
  );
  CREATE TABLE tutorial_progress (
    id INTEGER PRIMARY KEY,
    step INTEGER NOT NULL DEFAULT 0,
    completed INTEGER NOT NULL DEFAULT 0,
    skipped INTEGER NOT NULL DEFAULT 0,
    starter_feed_granted INTEGER NOT NULL DEFAULT 0
  );
  `,
];

export function migrate(db: Db): void {
  db.exec('PRAGMA foreign_keys = ON;');
  const current = db.get<{ user_version: number }>('PRAGMA user_version')?.user_version ?? 0;
  for (let v = current; v < MIGRATIONS.length; v++) {
    db.tx(() => {
      db.exec(MIGRATIONS[v]);
      db.exec(`PRAGMA user_version = ${v + 1}`);
    });
  }
}

/** Writes the first-launch data. Safe to call repeatedly. */
export function seedIfNeeded(db: Db, now: number): void {
  db.tx(() => {
    DEFAULT_CATEGORIES.forEach((c, i) => {
      db.run(
        'INSERT OR IGNORE INTO categories (id, name, type, feed_color, sort_order) VALUES (?, ?, ?, ?, ?)',
        [c.id, c.name, c.type, c.feedColor, i],
      );
    });
    for (const table of ['settings', 'wallet', 'tanks', 'tutorial_progress']) {
      db.run(`INSERT OR IGNORE INTO ${table} (id) VALUES (?)`, [SINGLETON_ID]);
    }
    const fishCount = db.get<{ n: number }>('SELECT COUNT(*) AS n FROM fishes')?.n ?? 0;
    if (fishCount === 0) {
      db.run(
        'INSERT INTO fishes (species_id, in_tank, satiety, satiety_at, ever_placed, created_at) VALUES (?, 1, 50, ?, 1, ?)',
        [STARTER_SPECIES_ID, now, now],
      );
    }
  });
}

export function setupDb(db: Db, now: number): Db {
  migrate(db);
  seedIfNeeded(db, now);
  return db;
}
