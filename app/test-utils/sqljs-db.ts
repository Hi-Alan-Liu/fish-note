import initSqlJs, { type Database } from 'sql.js';

import type { Db, SqlValue } from '@/data/db';
import { setupDb } from '@/data/schema';

let SQL: Awaited<ReturnType<typeof initSqlJs>> | null = null;

/** In-memory sql.js database behind the same Db interface the app uses. */
export async function createTestDb(now = Date.now()): Promise<Db> {
  SQL ??= await initSqlJs();
  const raw: Database = new SQL.Database();
  let depth = 0;

  const db: Db = {
    run(sql, params: SqlValue[] = []) {
      raw.run(sql, params);
      const changes = raw.getRowsModified();
      const id = raw.exec('SELECT last_insert_rowid()')[0]?.values[0][0];
      return { lastInsertRowId: Number(id ?? 0), changes };
    },
    all<T>(sql: string, params: SqlValue[] = []) {
      const stmt = raw.prepare(sql);
      try {
        stmt.bind(params);
        const rows: T[] = [];
        while (stmt.step()) rows.push(stmt.getAsObject() as T);
        return rows;
      } finally {
        stmt.free();
      }
    },
    get<T>(sql: string, params: SqlValue[] = []) {
      return db.all<T>(sql, params)[0] ?? null;
    },
    exec(sql) {
      raw.exec(sql);
    },
    tx<T>(fn: () => T): T {
      if (depth > 0) return fn();
      depth++;
      raw.exec('BEGIN');
      try {
        const r = fn();
        raw.exec('COMMIT');
        return r;
      } catch (e) {
        raw.exec('ROLLBACK');
        throw e;
      } finally {
        depth--;
      }
    },
  };

  return setupDb(db, now);
}
