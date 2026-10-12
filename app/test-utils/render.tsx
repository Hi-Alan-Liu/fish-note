import { render } from '@testing-library/react-native';
import type { ReactElement } from 'react';
import { SafeAreaProvider } from 'react-native-safe-area-context';

import { DataProvider } from '@/data/data-context';
import type { Db } from '@/data/db';
import { ToastProvider } from '@/ui/toast';

const metrics = {
  frame: { x: 0, y: 0, width: 390, height: 844 },
  insets: { top: 47, left: 0, right: 0, bottom: 34 },
};

/** Renders UI with the app's providers around a test database. */
export function renderWithData(ui: ReactElement, db: Db, clock: () => number = Date.now) {
  return render(
    <SafeAreaProvider initialMetrics={metrics}>
      <DataProvider db={db} clock={clock}>
        <ToastProvider>{ui}</ToastProvider>
      </DataProvider>
    </SafeAreaProvider>,
  );
}
