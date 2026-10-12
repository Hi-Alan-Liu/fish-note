import { Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { colors, type } from '@/theme/tokens';
import { EmptyState } from '@/ui/empty-state';

export function ShopScreen() {
  const insets = useSafeAreaInsets();
  return (
    <View style={{ flex: 1, backgroundColor: colors.paper, paddingTop: insets.top }}>
      <Text style={[type.title, { paddingHorizontal: 20, paddingVertical: 12 }]}>商城</Text>
      <EmptyState icon="storefront-outline" message="商城準備中，橘橘正在進貨" />
    </View>
  );
}
