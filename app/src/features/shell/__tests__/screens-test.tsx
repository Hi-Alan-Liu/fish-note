import { screen } from '@testing-library/react-native';

import { createTestDb } from '../../../../test-utils/sqljs-db';
import { renderWithData } from '../../../../test-utils/render';
import { BackpackScreen } from '@/features/backpack/backpack-screen';
import { HomeScreen } from '@/features/home/home-screen';
import { LedgerScreen } from '@/features/ledger/ledger-screen';
import { ShopScreen } from '@/features/shop/shop-screen';

jest.mock('expo-router', () => ({ router: { push: jest.fn() } }));

test('empty ledger and shop show their designed empty states', async () => {
  const db = await createTestDb();
  renderWithData(
    <>
      <LedgerScreen />
      <ShopScreen />
    </>,
    db,
  );
  expect(screen.getByText('還沒有任何紀錄，按下方 ＋ 記第一筆帳')).toBeTruthy();
  expect(screen.getByText('商城準備中，橘橘正在進貨')).toBeTruthy();
});

test('backpack reads the seeded starter fish from the database', async () => {
  const db = await createTestDb();
  renderWithData(<BackpackScreen />, db);
  expect(screen.getByText('魚 1/1')).toBeTruthy();
  expect(screen.getByText('橘橘')).toBeTruthy();
  expect(screen.getByText('在魚缸中')).toBeTruthy();
});

test('home shows coins, feed and fish slots from the database', async () => {
  const db = await createTestDb();
  renderWithData(<HomeScreen />, db);
  expect(screen.getByText('本月支出')).toBeTruthy();
  expect(screen.getByText('1/1')).toBeTruthy();
  expect(screen.getByTestId('feed-total')).toHaveTextContent('0');
});
