import type { ReactNode } from 'react';

import { DAILY_FEED_LIMIT, STREAK_DAYS_FOR_B } from '@/data/ledger';
import { FEED_COLORS, FEED_LEVELS } from '@/domain/feed';
import { FeedDot } from '@/ui/feed-dot';

import type { FormResult } from './transaction-form';

/** Toast copy after the form closes (docs/stages/S02-ledger-entry.md). */
export function feedbackFor(result: FormResult): { text: string; leading?: ReactNode } | null {
  if (result.kind === 'cancelled') return null;
  if (result.kind === 'deleted') return { text: '已刪除這筆紀錄' };
  const save = result.save;
  if (!save) return { text: '已儲存' };

  const r = save.reward;
  if (r) {
    const feed = `${FEED_COLORS[r.color].label}飼料 ${FEED_LEVELS[r.level].label} ×1`;
    return {
      text: r.streakBonus ? `連續記帳 ${STREAK_DAYS_FOR_B} 天！獲得 ${feed}` : `獲得 ${feed}`,
      leading: <FeedDot color={r.color} size={18} glow={r.streakBonus} />,
    };
  }
  if (save.noFeedReason === 'zeroAmount') return { text: '金額為 0，這筆不會獲得飼料' };
  if (save.noFeedReason === 'dailyLimit') return { text: `今天的 ${DAILY_FEED_LIMIT} 份飼料已經領完囉` };
  return { text: '已記下這筆帳' };
}
