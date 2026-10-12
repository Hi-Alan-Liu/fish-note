import { TabList, Tabs, TabSlot, TabTrigger } from 'expo-router/ui';
import { Text } from 'react-native';

import { FishTabBar } from '@/features/shell/fish-tab-bar';

export default function TabsLayout() {
  return (
    <Tabs>
      <TabSlot />
      <FishTabBar />
      {/* Hidden list that defines the tab routes; FishTabBar renders the visible bar. */}
      <TabList style={{ display: 'none' }}>
        <TabTrigger name="index" href="/">
          <Text>魚缸</Text>
        </TabTrigger>
        <TabTrigger name="ledger" href="/ledger">
          <Text>明細</Text>
        </TabTrigger>
        <TabTrigger name="shop" href="/shop">
          <Text>商城</Text>
        </TabTrigger>
        <TabTrigger name="backpack" href="/backpack">
          <Text>背包</Text>
        </TabTrigger>
      </TabList>
    </Tabs>
  );
}
