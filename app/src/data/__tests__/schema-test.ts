/** @jest-environment node */
import { createTestDb } from '../../../test-utils/sqljs-db';
import { getCategories, getFishes, getSettings, getTank, getTutorial, getWalletCoins } from '../queries';
import { seedIfNeeded, STARTER_SPECIES_ID } from '../schema';
import { FEED_LEVELS } from '@/domain/feed';

const count = (db: Awaited<ReturnType<typeof createTestDb>>, table: string) =>
  db.get<{ n: number }>(`SELECT COUNT(*) AS n FROM ${table}`)!.n;

test('first launch seeds categories, settings, wallet, tank and the starter fish', async () => {
  const db = await createTestDb();

  expect(getCategories(db)).toHaveLength(8);

  const settings = getSettings(db);
  expect(settings.currency).toBe('TWD');
  expect(settings.cycleStartDay).toBe(1);
  expect(settings.reminderEnabled).toBe(true);
  expect(settings.reminderMinutes).toBe(21 * 60);

  expect(getWalletCoins(db)).toBe(0);

  const tank = getTank(db);
  expect(tank.fishSlots).toBe(1);
  expect(tank.decoSlots).toBe(1);
  expect(tank.floorId).toBe('floor_sand');

  const fishes = getFishes(db);
  expect(fishes).toHaveLength(1);
  expect(fishes[0]).toMatchObject({ speciesId: STARTER_SPECIES_ID, inTank: true, everPlaced: true, satiety: 50 });

  expect(getTutorial(db)).toMatchObject({ step: 0, starterFeedGranted: false });
});

test('seeding again does not duplicate anything', async () => {
  const db = await createTestDb();
  seedIfNeeded(db, Date.now());
  seedIfNeeded(db, Date.now());

  expect(count(db, 'categories')).toBe(8);
  for (const t of ['fishes', 'settings', 'wallet', 'tanks', 'tutorial_progress']) {
    expect(count(db, t)).toBe(1);
  }
});

test('stored category colours match the feed colours in the docs', async () => {
  const db = await createTestDb();
  const cats = Object.fromEntries(getCategories(db).map((c) => [c.id, c]));
  expect(Object.fromEntries(Object.entries(cats).map(([id, c]) => [id, c.feedColor]))).toEqual({
    food: 'orange',
    transport: 'blue',
    shopping: 'pink',
    fun: 'purple',
    home: 'green',
    health: 'cyan',
    other: 'white',
    income: 'gold',
  });
  expect(cats.income.type).toBe('income');
  expect(Object.values(cats).filter((c) => c.type === 'expense')).toHaveLength(7);
});

test('feed levels follow the economy table', () => {
  const HOUR = 3_600_000;
  expect(FEED_LEVELS.a).toMatchObject({ digestMs: HOUR, coins: 10 });
  expect(FEED_LEVELS.b).toMatchObject({ digestMs: 2 * HOUR, coins: 30 });
  expect(FEED_LEVELS.tutorial).toMatchObject({ digestMs: 0, coins: 5 });
});
