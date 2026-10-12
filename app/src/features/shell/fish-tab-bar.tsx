import { Ionicons } from '@expo/vector-icons';
import { router } from 'expo-router';
import { TabTrigger, type TabTriggerSlotProps } from 'expo-router/ui';
import type { Ref } from 'react';
import { Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { colors } from '@/theme/tokens';

const BAR_HEIGHT = 68;
const ADD_SIZE = 60;
const ADD_RISE = 18;

type IconName = keyof typeof Ionicons.glyphMap;

interface TabButtonProps extends TabTriggerSlotProps {
  icon: IconName;
  label: string;
  ref?: Ref<View>;
}

function TabButton({ icon, label, isFocused, ref, ...rest }: TabButtonProps) {
  const color = isFocused ? colors.primary : colors.muted;
  return (
    <Pressable
      ref={ref}
      {...rest}
      accessibilityRole="tab"
      accessibilityState={{ selected: !!isFocused }}
      style={{ flex: 1, alignItems: 'center', justifyContent: 'center', gap: 2 }}>
      <Ionicons name={icon} size={26} color={color} />
      <Text style={{ fontSize: 12, color, fontWeight: isFocused ? '700' : '500' }}>{label}</Text>
    </Pressable>
  );
}

/** Bottom navigation with a raised centre "＋" (docs/stages/S01-skeleton.md). */
export function FishTabBar() {
  const insets = useSafeAreaInsets();
  return (
    <View style={{ height: BAR_HEIGHT + insets.bottom + ADD_RISE }}>
      <View
        style={{
          position: 'absolute',
          left: 0,
          right: 0,
          bottom: 0,
          height: BAR_HEIGHT + insets.bottom,
          paddingBottom: insets.bottom,
          backgroundColor: colors.surface,
          borderTopWidth: 1,
          borderTopColor: colors.line,
          flexDirection: 'row',
        }}>
        <TabTrigger name="index" asChild>
          <TabButton icon="water" label="魚缸" />
        </TabTrigger>
        <TabTrigger name="ledger" asChild>
          <TabButton icon="pie-chart" label="明細" />
        </TabTrigger>
        <View style={{ width: ADD_SIZE + 16 }} />
        <TabTrigger name="shop" asChild>
          <TabButton icon="storefront" label="商城" />
        </TabTrigger>
        <TabTrigger name="backpack" asChild>
          <TabButton icon="bag-handle" label="背包" />
        </TabTrigger>
      </View>
      <View style={{ position: 'absolute', top: 0, left: 0, right: 0, alignItems: 'center' }}>
        <Pressable
          testID="nav-add"
          accessibilityRole="button"
          accessibilityLabel="記一筆帳"
          onPress={() => router.push('/transaction')}
          style={({ pressed }) => ({
            width: ADD_SIZE,
            height: ADD_SIZE,
            borderRadius: ADD_SIZE / 2,
            backgroundColor: pressed ? colors.primaryDeep : colors.primary,
            borderWidth: 4,
            borderColor: colors.surface,
            alignItems: 'center',
            justifyContent: 'center',
            boxShadow: '0 4px 10px rgba(226, 98, 42, 0.25)',
          })}>
          <Ionicons name="add" size={34} color="#fff" />
        </Pressable>
      </View>
    </View>
  );
}
