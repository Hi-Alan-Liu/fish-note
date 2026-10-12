import { Ionicons } from '@expo/vector-icons';
import { LinearGradient } from 'expo-linear-gradient';
import { useState, type ReactNode } from 'react';
import { Modal, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { useQuery } from '@/data/data-context';
import { getFeedStocks, getFishes, getTank, getWalletCoins, type FeedStock } from '@/data/queries';
import { FEED_COLORS, FEED_LEVELS } from '@/domain/feed';
import { colors, fonts, type } from '@/theme/tokens';
import { Clownfish } from '@/ui/clownfish';
import { Coin } from '@/ui/coin';
import { FeedDot } from '@/ui/feed-dot';

export function HomeScreen() {
  const insets = useSafeAreaInsets();
  const coins = useQuery(getWalletCoins);
  const stocks = useQuery(getFeedStocks);
  const fishes = useQuery(getFishes);
  const tank = useQuery(getTank);
  const [showStocks, setShowStocks] = useState(false);

  const feedTotal = stocks.reduce((s, f) => s + f.quantity, 0);
  const inTank = fishes.filter((f) => f.inTank).length;

  return (
    <View style={{ flex: 1, backgroundColor: colors.paper, paddingTop: insets.top }}>
      <View style={{ flexDirection: 'row', paddingHorizontal: 20, paddingTop: 12, paddingBottom: 12 }}>
        <View style={{ flex: 1 }}>
          <Text style={type.label}>本月支出</Text>
          <Text style={{ fontFamily: fonts.number, fontSize: 32, color: colors.ink, lineHeight: 40 }}>NT$ 0</Text>
          <View style={{ flexDirection: 'row', gap: 16, marginTop: 4 }}>
            <Stat icon={<Coin size={16} />} text={`${coins}`} />
            <Pressable testID="feed-total" onPress={() => setShowStocks(true)} hitSlop={8}>
              <Stat icon={<FeedDot color="orange" size={15} />} text={`${feedTotal}`} />
            </Pressable>
            <Stat icon={<Ionicons name="fish" size={17} color={colors.primary} />} text={`${inTank}/${tank.fishSlots}`} />
          </View>
        </View>
        <Pressable accessibilityLabel="設定" hitSlop={8} style={{ padding: 8 }}>
          <Ionicons name="settings-sharp" size={24} color={colors.muted} />
        </Pressable>
      </View>

      <LinearGradient
        colors={[colors.seaTop, colors.seaMid, colors.seaBottom]}
        locations={[0, 0.45, 1]}
        style={{ flex: 1, marginHorizontal: 12, marginBottom: 8, borderRadius: 22, overflow: 'hidden' }}>
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <Clownfish width={150} />
        </View>
        <View
          style={{ height: 56, backgroundColor: colors.sand, borderTopWidth: 3, borderTopColor: colors.sandEdge }}
        />
      </LinearGradient>

      <FeedStockSheet visible={showStocks} stocks={stocks} onClose={() => setShowStocks(false)} />
    </View>
  );
}

function Stat({ icon, text }: { icon: ReactNode; text: string }) {
  return (
    <View style={{ flexDirection: 'row', alignItems: 'center', gap: 5 }}>
      {icon}
      <Text style={{ fontFamily: fonts.number, fontSize: 16, color: colors.ink }}>{text}</Text>
    </View>
  );
}

function FeedStockSheet({ visible, stocks, onClose }: { visible: boolean; stocks: FeedStock[]; onClose: () => void }) {
  const insets = useSafeAreaInsets();
  return (
    <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
      <Pressable style={{ flex: 1, backgroundColor: 'rgba(0,0,0,0.35)' }} onPress={onClose} />
      <View
        style={{
          backgroundColor: colors.surface,
          borderTopLeftRadius: 24,
          borderTopRightRadius: 24,
          padding: 20,
          paddingBottom: 20 + insets.bottom,
          gap: 12,
        }}>
        <Text style={type.title}>飼料庫存</Text>
        {stocks.length === 0 && <Text style={{ color: colors.muted, paddingVertical: 12 }}>記一筆帳就能拿到飼料</Text>}
        {stocks.map((s) => (
          <View key={`${s.color}-${s.level}`} style={{ flexDirection: 'row', alignItems: 'center', gap: 10 }}>
            <FeedDot color={s.color} size={18} />
            <Text style={{ flex: 1, fontSize: 15, color: colors.ink }}>
              {FEED_COLORS[s.color].label}飼料 {FEED_LEVELS[s.level].label}
            </Text>
            <Text style={{ fontFamily: fonts.number, fontSize: 16, color: colors.ink }}>×{s.quantity}</Text>
          </View>
        ))}
      </View>
    </Modal>
  );
}
