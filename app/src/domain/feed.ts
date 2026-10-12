/** Feed colours. Category colour = feed colour = pie-slice colour (docs/features/ledger.md). */
export const FEED_COLORS = {
  orange: { hex: '#FF9A3C', label: '橘色' },
  blue: { hex: '#4AA8FF', label: '藍色' },
  pink: { hex: '#FF7EB6', label: '粉紅色' },
  purple: { hex: '#A77BFF', label: '紫色' },
  green: { hex: '#4FD38A', label: '綠色' },
  cyan: { hex: '#35D6D0', label: '青色' },
  white: { hex: '#EEF2F4', label: '白色' },
  gold: { hex: '#FFD23F', label: '金色' },
} as const;

export type FeedColor = keyof typeof FEED_COLORS;

const HOUR = 60 * 60 * 1000;

/** Feed levels (docs/02-gameplay-economy.md). `tutorial` is the one-off starter feed. */
export const FEED_LEVELS = {
  a: { digestMs: 1 * HOUR, coins: 10, label: 'A' },
  b: { digestMs: 2 * HOUR, coins: 30, label: 'B' },
  c: { digestMs: 4 * HOUR, coins: 80, label: 'C' },
  d: { digestMs: 8 * HOUR, coins: 200, label: 'D' },
  tutorial: { digestMs: 0, coins: 5, label: '新手' },
} as const;

export type FeedLevel = keyof typeof FEED_LEVELS;
