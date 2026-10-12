import { openDatabaseSync } from 'expo-sqlite';

import type { Db, SqlValue } from './db';

export function openExpoDb(name = 'fish_note.db'): Db {
  const sqlite = openDatabaseSync(name);
  let depth = 0;

  return {
    run(sql, params: SqlValue[] = []) {
      const r = sqlite.runSync(sql, params);
      return { lastInsertRowId: r.lastInsertRowId, changes: r.changes };
    },
    all<T>(sql: string, params: SqlValue[] = []) {
      return sqlite.getAllSync<T>(sql, params);
    },
    get<T>(sql: string, params: SqlValue[] = []) {
      return sqlite.getFirstSync<T>(sql, params) ?? null;
    },
    exec(sql) {
      sqlite.execSync(sql);
    },
    tx<T>(fn: () => T): T {
      if (depth > 0) return fn();
      let result!: T;
      depth++;
      try {
        sqlite.withTransactionSync(() => {
          result = fn();
        });
      } finally {
        depth--;
      }
      return result;
    },
  };
}
