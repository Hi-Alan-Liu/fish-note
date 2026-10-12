/** @jest-environment node */
import { createTestDb } from '../../../test-utils/sqljs-db';
import type { Db } from '../db';
import { LedgerRepository, type SaveResult } from '../ledger';
import { getTransactions } from '../queries';
import type { FeedColor, FeedLevel } from '@/domain/feed';

let db: Db;
let now: number;
let repo: LedgerRepository;
const DAY = 24 * 60 * 60 * 1000;

beforeEach(async () => {
  now = new Date(2026, 9, 12, 12).getTime();
  db = await createTestDb(now);
  repo = new LedgerRepository(db, () => now);
});

const expense = (amount: number, cat = 'food', date = now): SaveResult =>
  repo.add({ type: 'expense', amount, categoryId: cat, date });

const stock = (color: FeedColor, level: FeedLevel) =>
  db.get<{ quantity: number }>('SELECT quantity FROM feed_inventory WHERE color = ? AND level = ?', [color, level])
    ?.quantity ?? 0;

test('a record grants one level-A feed in its category colour', () => {
  const r = expense(180, 'transport');
  expect(r.reward).toMatchObject({ color: 'blue', level: 'a' });
  expect(stock('blue', 'a')).toBe(1);
  expect(getTransactions(db)[0].tx).toMatchObject({ amount: 180, feedGranted: true });
});

test('income grants gold feed', () => {
  const r = repo.add({ type: 'income', amount: 42000, categoryId: 'income', date: now });
  expect(r.reward?.color).toBe('gold');
});

test('a zero amount is saved but grants no feed', () => {
  const r = expense(0);
  expect(r.reward).toBeUndefined();
  expect(r.noFeedReason).toBe('zeroAmount');
  expect(getTransactions(db)).toHaveLength(1);
  expect(stock('orange', 'a')).toBe(0);
});

test('at most 10 feeds per day; the 11th record grants none', () => {
  for (let i = 0; i < 10; i++) expect(expense(100).reward).toBeDefined();
  const eleventh = expense(100);
  expect(eleventh.reward).toBeUndefined();
  expect(eleventh.noFeedReason).toBe('dailyLimit');
  expect(stock('orange', 'a')).toBe(10);
});

test('deleting and re-entering does not refund the daily allowance', () => {
  const ids = Array.from({ length: 10 }, () => expense(100).txId);
  repo.delete(ids.at(-1)!);
  expect(expense(100).noFeedReason).toBe('dailyLimit');
});

test('the allowance resets the next day', () => {
  for (let i = 0; i < 10; i++) expense(100);
  now += DAY;
  expect(expense(100).reward).toBeDefined();
});

test('back-dated records still count toward today', () => {
  for (let i = 0; i < 10; i++) expense(100, 'food', now - 5 * DAY);
  expect(expense(100).noFeedReason).toBe('dailyLimit');
});

test('3 days in a row upgrades the first feed of the day to B', () => {
  expect(expense(50).reward?.level).toBe('a');
  now += DAY;
  expect(expense(50).reward?.level).toBe('a');
  now += DAY;
  const first = expense(50);
  expect(first.reward).toMatchObject({ level: 'b', streakBonus: true });
  expect(expense(50).reward?.level).toBe('a');
  expect(stock('orange', 'b')).toBe(1);
});

test('a gap day breaks the streak', () => {
  expense(50);
  now += 2 * DAY; // skipped a day
  expense(50);
  now += DAY;
  expect(expense(50).reward?.level).toBe('a');
});

test('editing changes the record but not the feed already granted', () => {
  const r = expense(180);
  repo.update(r.txId, { type: 'expense', amount: 999, categoryId: 'shopping', date: now, note: ' 新鞋 ' });

  expect(getTransactions(db)[0].tx).toMatchObject({ amount: 999, categoryId: 'shopping', note: '新鞋' });
  expect(stock('orange', 'a')).toBe(1);
  expect(stock('pink', 'a')).toBe(0);
});
