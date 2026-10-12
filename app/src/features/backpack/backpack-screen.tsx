import { ScrollView, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { useQuery } from '@/data/data-context';
import { getFishes, getTank } from '@/data/queries';
import { colors, radius, type } from '@/theme/tokens';
import { Clownfish } from '@/ui/clownfish';

export function BackpackScreen() {
  const insets = useSafeAreaInsets();
  const fishes = useQuery(getFishes);
  const tank = useQuery(getTank);
  const inTank = fishes.filter((f) => f.inTank).length;

  return (
    <View style={{ flex: 1, backgroundColor: colors.paper, paddingTop: insets.top }}>
      <Text style={[type.title, { paddingHorizontal: 20, paddingVertical: 12 }]}>背包</Text>
      <ScrollView contentContainerStyle={{ paddingHorizontal: 16, paddingBottom: 24, gap: 12 }}>
        <Text style={{ fontSize: 16, fontWeight: '700', color: colors.ink }}>
          魚 {inTank}/{tank.fishSlots}
        </Text>
        <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 12 }}>
          {fishes.map((f) => (
            <View
              key={f.id}
              style={{
                width: 150,
                alignItems: 'center',
                padding: 12,
                backgroundColor: colors.surface,
                borderRadius: radius.card,
                borderWidth: 1,
                borderColor: colors.line,
                gap: 4,
              }}>
              <Clownfish width={110} />
              <Text style={{ fontWeight: '700', color: colors.ink, marginTop: 4 }}>橘橘</Text>
              <Text style={{ fontSize: 12, color: f.inTank ? colors.primaryDeep : colors.muted }}>
                {f.inTank ? '在魚缸中' : '休息中'}
              </Text>
            </View>
          ))}
        </View>
      </ScrollView>
    </View>
  );
}
