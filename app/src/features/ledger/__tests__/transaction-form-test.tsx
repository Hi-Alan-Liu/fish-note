import { fireEvent, screen } from '@testing-library/react-native';
import { useState } from 'react';
import { Pressable, Text } from 'react-native';

import { createTestDb } from '../../../../test-utils/sqljs-db';
import { renderWithData } from '../../../../test-utils/render';
import type { Db } from '@/data/db';
import { useQuery } from '@/data/data-context';
import { getTransaction } from '@/data/queries';
import { HomeScreen } from '@/features/home/home-screen';
import { feedbackFor } from '../feedback';
import { LedgerScreen } from '../ledger-screen';
import { TransactionForm, type FormResult } from '../transaction-form';

jest.mock('expo-router', () => ({ router: { push: jest.fn(), back: jest.fn() } }));

let db: Db;
const now = new Date(2026, 9, 12, 12).getTime();

beforeEach(async () => {
  db = await createTestDb(now);
});

/** Home + ledger + an in-place form, mimicking the routes without a navigator. */
function Harness() {
  const [editing, setEditing] = useState<number | 'new' | null>(null);
  const [toast, setToast] = useState('');
  const existing = useQuery((d) => (typeof editing === 'number' ? getTransaction(d, editing) : null), [editing]);

  function done(r: FormResult) {
    setToast(feedbackFor(r)?.text ?? '');
    setEditing(null);
  }

  return (
    <>
      <Pressable testID="open-add" onPress={() => setEditing('new')} />
      <Pressable testID="open-edit-1" onPress={() => setEditing(1)} />
      <Text testID="toast">{toast}</Text>
      {editing !== null ? <TransactionForm existing={existing} onDone={done} /> : null}
      <HomeScreen />
      <LedgerScreen />
    </>
  );
}

const typeDigits = (digits: string) => digits.split('').forEach((k) => fireEvent.press(screen.getByTestId(`key-${k}`)));

test('entering an expense saves it, grants feed and lists it in 明細', () => {
  renderWithData(<Harness />, db, () => now);

  fireEvent.press(screen.getByTestId('open-add'));
  expect(screen.getByTestId('key-submit')).toBeDisabled();

  typeDigits('180');
  expect(screen.getByTestId('amount-display')).toHaveTextContent('180');

  fireEvent.press(screen.getByTestId('cat-food'));
  fireEvent.press(screen.getByTestId('key-submit'));

  expect(screen.getByTestId('toast')).toHaveTextContent('獲得 橘色飼料 A ×1');
  expect(screen.getByTestId('feed-total')).toHaveTextContent('1');
  expect(screen.getAllByText('-180').length).toBeGreaterThan(0);
  expect(screen.getByText('餐飲')).toBeTruthy();
});

test('a record can be edited and deleted', () => {
  renderWithData(<Harness />, db, () => now);
  fireEvent.press(screen.getByTestId('open-add'));
  typeDigits('50');
  fireEvent.press(screen.getByTestId('key-submit'));

  fireEvent.press(screen.getByTestId('open-edit-1'));
  expect(screen.getByText('編輯紀錄')).toBeTruthy();
  typeDigits('0');
  fireEvent.press(screen.getByTestId('key-submit'));
  expect(screen.getByTestId('toast')).toHaveTextContent('已儲存');
  expect(screen.getAllByText('-500').length).toBeGreaterThan(0);

  fireEvent.press(screen.getByTestId('open-edit-1'));
  fireEvent.press(screen.getByText('刪除這筆'));
  fireEvent.press(screen.getByTestId('confirm-delete'));

  expect(screen.getByTestId('toast')).toHaveTextContent('已刪除這筆紀錄');
  expect(screen.getByText('還沒有任何紀錄，按下方 ＋ 記第一筆帳')).toBeTruthy();
});

test('switching to 收入 selects the income category', () => {
  renderWithData(<Harness />, db, () => now);
  fireEvent.press(screen.getByTestId('open-add'));
  fireEvent.press(screen.getByTestId('type-income'));

  expect(screen.getByTestId('cat-income')).toBeSelected();
  expect(screen.queryByTestId('cat-food')).toBeNull();
});
