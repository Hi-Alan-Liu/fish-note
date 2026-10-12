import { router } from 'expo-router';
import { FlatList, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { useQuery } from '@/data/data-context';
import { getTransactions, type TxRecord, type TxWithCategory } from '@/data/queries';
import { colors, fonts, radius, type } from '@/theme/tokens';
import { EmptyState } from '@/ui/empty-state';
import { FeedDot } from '@/ui/feed-dot';
import { formatDayHeader, formatSigned, isSameDay } from '@/ui/format';

const signed = (tx: TxRecord) => (tx.type === 'income' ? tx.amount : -tx.amount);

export function LedgerScreen() {
  const insets = useSafeAreaInsets();
  const items = useQuery(getTransactions);

  // items are newest first; group consecutive records of the same day.
  const groups: TxWithCategory[][] = [];
  for (const it of items) {
    const last = groups.at(-1);
    if (last && isSameDay(last[0].tx.date, it.tx.date)) last.push(it);
    else groups.push([it]);
  }

  return (
    <View style={{ flex: 1, backgroundColor: colors.paper, paddingTop: insets.top }}>
      <Text style={[type.title, { paddingHorizontal: 20, paddingVertical: 12 }]}>明細</Text>
      {items.length === 0 ? (
        <EmptyState icon="receipt-outline" message="還沒有任何紀錄，按下方 ＋ 記第一筆帳" />
      ) : (
        <FlatList
          data={groups}
          keyExtractor={(g) => `${g[0].tx.id}`}
          contentContainerStyle={{ paddingHorizontal: 16, paddingBottom: 24, gap: 12 }}
          renderItem={({ item: g }) => (
            <View
              style={{
                backgroundColor: colors.surface,
                borderRadius: radius.card,
                borderWidth: 1,
                borderColor: colors.line,
                paddingBottom: 4,
              }}>
              <View style={{ flexDirection: 'row', paddingHorizontal: 16, paddingTop: 12, paddingBottom: 4 }}>
                <Text style={[type.label, { flex: 1 }]}>{formatDayHeader(g[0].tx.date)}</Text>
                <Text style={{ fontFamily: fonts.number, fontSize: 13, color: colors.muted }}>
                  {formatSigned(g.reduce((s, it) => s + signed(it.tx), 0))}
                </Text>
              </View>
              {g.map((it) => (
                <TxRow key={it.tx.id} item={it} />
              ))}
            </View>
          )}
        />
      )}
    </View>
  );
}

function TxRow({ item }: { item: TxWithCategory }) {
  const { tx, category } = item;
  return (
    <Pressable
      testID={`tx-${tx.id}`}
      onPress={() => router.push({ pathname: '/transaction', params: { id: String(tx.id) } })}
      style={({ pressed }) => ({
        flexDirection: 'row',
        alignItems: 'center',
        gap: 12,
        paddingHorizontal: 16,
        paddingVertical: 10,
        backgroundColor: pressed ? colors.chip : 'transparent',
      })}>
      <FeedDot color={category.feedColor} size={16} />
      <View style={{ flex: 1 }}>
        <Text numberOfLines={1} style={{ fontSize: 15, fontWeight: '500', color: colors.ink }}>
          {tx.note || category.name}
        </Text>
        {!!tx.note && <Text style={type.small}>{category.name}</Text>}
      </View>
      <Text
        style={{
          fontFamily: fonts.number,
          fontSize: 17,
          color: tx.type === 'income' ? colors.primaryDeep : colors.ink,
        }}>
        {formatSigned(signed(tx))}
      </Text>
    </Pressable>
  );
}
