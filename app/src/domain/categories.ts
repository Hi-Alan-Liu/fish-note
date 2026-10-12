import type { FeedColor } from './feed';

export type TxType = 'expense' | 'income';

export interface CategoryDef {
  id: string;
  name: string;
  type: TxType;
  feedColor: FeedColor;
}

/** The 8 default categories (docs/02-gameplay-economy.md). */
export const DEFAULT_CATEGORIES: readonly CategoryDef[] = [
  { id: 'food', name: '餐飲', type: 'expense', feedColor: 'orange' },
  { id: 'transport', name: '交通', type: 'expense', feedColor: 'blue' },
  { id: 'shopping', name: '購物', type: 'expense', feedColor: 'pink' },
  { id: 'fun', name: '娛樂', type: 'expense', feedColor: 'purple' },
  { id: 'home', name: '居家 / 帳單', type: 'expense', feedColor: 'green' },
  { id: 'health', name: '醫療 / 學習', type: 'expense', feedColor: 'cyan' },
  { id: 'other', name: '其他支出', type: 'expense', feedColor: 'white' },
  { id: 'income', name: '收入', type: 'income', feedColor: 'gold' },
];
