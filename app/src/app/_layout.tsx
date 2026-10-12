import { useFonts } from 'expo-font';
import { Stack } from 'expo-router';
import * as SplashScreen from 'expo-splash-screen';
import { StatusBar } from 'expo-status-bar';
import { useEffect } from 'react';
import { GestureHandlerRootView } from 'react-native-gesture-handler';

import { DataProvider } from '@/data/data-context';
import type { Db } from '@/data/db';
import { openExpoDb } from '@/data/expo-db';
import { setupDb } from '@/data/schema';
import { colors } from '@/theme/tokens';
import { ToastProvider } from '@/ui/toast';

SplashScreen.preventAutoHideAsync();

let appDb: Db | null = null;
const getDb = () => (appDb ??= setupDb(openExpoDb(), Date.now()));

export default function RootLayout() {
  const [fontsLoaded, fontError] = useFonts({
    Huninn: require('@/assets/fonts/Huninn-Regular.ttf'),
    Baloo2: require('@/assets/fonts/Baloo2-SemiBold.ttf'),
  });
  const ready = fontsLoaded || !!fontError;

  useEffect(() => {
    if (ready) SplashScreen.hideAsync();
  }, [ready]);

  if (!ready) return null;

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <DataProvider db={getDb()}>
        <ToastProvider>
          <StatusBar style="dark" />
          <Stack screenOptions={{ headerShown: false, contentStyle: { backgroundColor: colors.paper } }}>
            <Stack.Screen name="(tabs)" />
            <Stack.Screen
              name="transaction"
              options={{
                presentation: 'formSheet',
                sheetAllowedDetents: 'fitToContents',
                sheetGrabberVisible: true,
                sheetCornerRadius: 24,
                contentStyle: { backgroundColor: colors.surface },
              }}
            />
          </Stack>
        </ToastProvider>
      </DataProvider>
    </GestureHandlerRootView>
  );
}
