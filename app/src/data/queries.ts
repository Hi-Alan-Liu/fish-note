import type { TxType } from '@/domain/categories';
import type { FeedColor, FeedLevel } from '@/domain/feed';

import type { Db } from './db';
import { SINGLETON_ID } from './schema';

export interface Category {
  id: string;
  name: string;
  type: TxType;
  feedColor: FeedColor;
}

export interface TxRecord {
  id: number;
  amount: number;
  type: TxType;
  categoryId: string;
  date: number;
  note: string;
  feedGranted: boolean;
  isTutorial: boolean;
}

export interface TxWithCategory {
  tx: TxRecord;
  category: Category;
}

export interface FeedStock {
  color: FeedColor;
  level: FeedLevel;
  quantity: number;
}

export interface Fish {
  id: number;
  speciesId: string;
  inTank: boolean;
  satiety: number;
  satietyAt: number;
  everPlaced: boolean;
}

export interface Tank {
  backgroundId: string;
  floorId: string;
  fishSlots: number;
  decoSlots: number;
}

export interface Settings {
  currency: string;
  cycleStartDay: number;
  reminderEnabled: boolean;
  reminderMinutes: number;
  coinNotifyEnabled: boolean;
  soundEnabled: boolean;
}

type Row = Record<string, string | number | null>;

const toCategory = (r: Row, p = ''): Category => ({
  id: r[`${p}id`] as string,
  name: r[`${p}name`] as string,
  type: r[`${p}type`] as TxType,
  feedColor: r[`${p}feed_color`] as FeedColor,
});

const toTx = (r: Row): TxRecord => ({
  id: r.id as number,
  amount: r.amount as number,
  type: r.type as TxType,
  categoryId: r.category_id as string,
  date: r.date as number,
  note: r.note as string,
  feedGranted: r.feed_granted === 1,
  isTutorial: r.is_tutorial === 1,
});

export function getCategories(db: Db): Category[] {
  return db.all<Row>('SELECT * FROM categories ORDER BY sort_order').map((r) => toCategory(r));
}

export function getTransaction(db: Db, id: number): TxRecord | null {
  const r = db.get<Row>('SELECT * FROM transactions WHERE id = ?', [id]);
  return r ? toTx(r) : null;
}

/** Newest first; each record paired with its category. */
export function getTransactions(db: Db): TxWithCategory[] {
  return db
    .all<Row>(
      `SELECT t.*, c.id AS c_id, c.name AS c_name, c.type AS c_type, c.feed_color AS c_feed_color
       FROM transactions t JOIN categories c ON c.id = t.category_id
       ORDER BY t.date DESC, t.id DESC`,
    )
    .map((r) => ({ tx: toTx(r), category: toCategory(r, 'c_') }));
}

export function getFeedStocks(db: Db): FeedStock[] {
  return db
    .all<Row>('SELECT * FROM feed_inventory WHERE quantity > 0 ORDER BY color, level')
    .map((r) => ({ color: r.color as FeedColor, level: r.level as FeedLevel, quantity: r.quantity as number }));
}

export function getFishes(db: Db): Fish[] {
  return db.all<Row>('SELECT * FROM fishes ORDER BY id').map((r) => ({
    id: r.id as number,
    speciesId: r.species_id as string,
    inTank: r.in_tank === 1,
    satiety: r.satiety as number,
    satietyAt: r.satiety_at as number,
    everPlaced: r.ever_placed === 1,
  }));
}

export function getTank(db: Db): Tank {
  const r = db.get<Row>('SELECT * FROM tanks WHERE id = ?', [SINGLETON_ID])!;
  return {
    backgroundId: r.background_id as string,
    floorId: r.floor_id as string,
    fishSlots: r.fish_slots as number,
    decoSlots: r.deco_slots as number,
  };
}

export function getWalletCoins(db: Db): number {
  return db.get<{ coins: number }>('SELECT coins FROM wallet WHERE id = ?', [SINGLETON_ID])?.coins ?? 0;
}

export function getSettings(db: Db): Settings {
  const r = db.get<Row>('SELECT * FROM settings WHERE id = ?', [SINGLETON_ID])!;
  return {
    currency: r.currency as string,
    cycleStartDay: r.cycle_start_day as number,
    reminderEnabled: r.reminder_enabled === 1,
    reminderMinutes: r.reminder_minutes as number,
    coinNotifyEnabled: r.coin_notify_enabled === 1,
    soundEnabled: r.sound_enabled === 1,
  };
}

export function getTutorial(db: Db) {
  const r = db.get<Row>('SELECT * FROM tutorial_progress WHERE id = ?', [SINGLETON_ID])!;
  return {
    step: r.step as number,
    completed: r.completed === 1,
    skipped: r.skipped === 1,
    starterFeedGranted: r.starter_feed_granted === 1,
  };
}
