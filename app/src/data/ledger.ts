import type { TxType } from '@/domain/categories';
import type { FeedColor, FeedLevel } from '@/domain/feed';

import type { Db } from './db';

export interface FeedReward {
  color: FeedColor;
  level: FeedLevel;
  /** True when the level was upgraded by the 3-day streak. */
  streakBonus: boolean;
}

export type NoFeedReason = 'zeroAmount' | 'dailyLimit';

export interface SaveResult {
  txId: number;
  reward?: FeedReward;
  noFeedReason?: NoFeedReason;
}

export interface TxInput {
  type: TxType;
  amount: number;
  categoryId: string;
  date: number;
  note?: string;
}

export const DAILY_FEED_LIMIT = 10;
/** Days in a row (including today) needed for the first feed of the day to become B. */
export const STREAK_DAYS_FOR_B = 3;

const DAY_MS = 24 * 60 * 60 * 1000;

function startOfDay(ms: number): number {
  const d = new Date(ms);
  return new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime();
}

function addDays(dayStart: number, days: number): number {
  const d = new Date(dayStart);
  return new Date(d.getFullYear(), d.getMonth(), d.getDate() + days).getTime();
}

/** Ledger writes and the feed hand-out rules (docs/stages/S02-ledger-entry.md). */
export class LedgerRepository {
  constructor(
    private readonly db: Db,
    private readonly clock: () => number = Date.now,
  ) {}

  add(input: TxInput): SaveResult {
    return this.db.tx(() => {
      const now = this.clock();
      const category = this.db.get<{ feed_color: FeedColor }>('SELECT feed_color FROM categories WHERE id = ?', [
        input.categoryId,
      ]);
      if (!category) throw new Error(`Unknown category ${input.categoryId}`);

      const { lastInsertRowId: txId } = this.db.run(
        `INSERT INTO transactions (amount, type, category_id, date, note, created_at)
         VALUES (?, ?, ?, ?, ?, ?)`,
        [input.amount, input.type, input.categoryId, input.date, (input.note ?? '').trim(), now],
      );

      if (input.amount <= 0) return { txId, noFeedReason: 'zeroAmount' };

      // The limit follows the moment of entry, not the date written on the record.
      const today = startOfDay(now);
      const grantedToday = this.grantsOn(today);
      if (grantedToday >= DAILY_FEED_LIMIT) return { txId, noFeedReason: 'dailyLimit' };

      let streak = false;
      if (grantedToday === 0) {
        streak = true;
        for (let d = 1; d < STREAK_DAYS_FOR_B; d++) {
          if (this.grantsOn(addDays(today, -d)) === 0) {
            streak = false;
            break;
          }
        }
      }
      const level: FeedLevel = streak ? 'b' : 'a';
      const color = category.feed_color;

      this.db.run('INSERT INTO feed_grants (tx_id, color, level, granted_at) VALUES (?, ?, ?, ?)', [
        txId,
        color,
        level,
        now,
      ]);
      this.addFeed(color, level, 1);
      this.db.run('UPDATE transactions SET feed_granted = 1 WHERE id = ?', [txId]);

      return { txId, reward: { color, level, streakBonus: streak } };
    });
  }

  /** Edits never change feed that was already handed out. */
  update(id: number, input: TxInput): void {
    this.db.run('UPDATE transactions SET type = ?, amount = ?, category_id = ?, date = ?, note = ? WHERE id = ?', [
      input.type,
      input.amount,
      input.categoryId,
      input.date,
      (input.note ?? '').trim(),
      id,
    ]);
  }

  /** Feed grants stay, so today's used allowance is not refunded. */
  delete(id: number): void {
    this.db.run('DELETE FROM transactions WHERE id = ?', [id]);
  }

  private grantsOn(dayStart: number): number {
    const next = addDays(dayStart, 1);
    return (
      this.db.get<{ n: number }>('SELECT COUNT(*) AS n FROM feed_grants WHERE granted_at >= ? AND granted_at < ?', [
        dayStart,
        next,
      ])?.n ?? 0
    );
  }

  private addFeed(color: FeedColor, level: FeedLevel, n: number): void {
    this.db.run(
      `INSERT INTO feed_inventory (color, level, quantity) VALUES (?, ?, ?)
       ON CONFLICT(color, level) DO UPDATE SET quantity = quantity + excluded.quantity`,
      [color, level, n],
    );
  }
}

export { DAY_MS };
