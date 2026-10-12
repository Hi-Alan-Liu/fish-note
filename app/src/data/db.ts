export type SqlValue = string | number | null;

/**
 * The small synchronous SQL surface the app needs. Implemented by expo-sqlite in the
 * app (expo-db.ts) and by sql.js in tests (test-utils/sqljs-db.ts), so the same SQL and
 * repositories run in both.
 */
export interface Db {
  run(sql: string, params?: SqlValue[]): { lastInsertRowId: number; changes: number };
  all<T>(sql: string, params?: SqlValue[]): T[];
  get<T>(sql: string, params?: SqlValue[]): T | null;
  exec(sql: string): void;
  /** Runs fn atomically. Nested calls join the outer transaction. */
  tx<T>(fn: () => T): T;
}
