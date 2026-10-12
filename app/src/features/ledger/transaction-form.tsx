import { Ionicons } from '@expo/vector-icons';
import DateTimePicker, { DateTimePickerAndroid } from '@react-native-community/datetimepicker';
import { useState } from 'react';
import { Platform, Pressable, Text, TextInput, View } from 'react-native';

import { useData, useLedger, useQuery } from '@/data/data-context';
import type { SaveResult } from '@/data/ledger';
import { getCategories, type Category, type TxRecord } from '@/data/queries';
import type { TxType } from '@/domain/categories';
import { FEED_COLORS } from '@/domain/feed';
import { colors, fonts, type } from '@/theme/tokens';
import { FeedDot } from '@/ui/feed-dot';
import { formatAmount, formatDayHeader, isSameDay } from '@/ui/format';

import { Keypad } from './keypad';

export type FormResult = { kind: 'saved'; save?: SaveResult } | { kind: 'deleted' } | { kind: 'cancelled' };

const MAX_DIGITS = 9;
let lastExpenseCategory = 'food';

/** Add / edit form (docs/stages/S02-ledger-entry.md). */
export function TransactionForm({ existing, onDone }: { existing?: TxRecord | null; onDone: (r: FormResult) => void }) {
  const { clock } = useData();
  const ledger = useLedger();
  const categories = useQuery(getCategories);
  // Read the id once at the top level. The React Compiler memoizes closures on the
  // property paths they read, so `existing!.id` inside a handler was evaluated during
  // render and crashed when adding a new record (existing === null).
  const existingId = existing != null ? existing.id : null;
  const isEdit = existingId !== null;

  const initial =
    existing != null
      ? { type: existing.type, categoryId: existing.categoryId, digits: String(existing.amount), date: existing.date, note: existing.note }
      : { type: 'expense' as TxType, categoryId: lastExpenseCategory, digits: '', date: clock(), note: '' };
  const [txType, setTxType] = useState<TxType>(initial.type);
  const [categoryId, setCategoryId] = useState(initial.categoryId);
  const [digits, setDigits] = useState(initial.digits);
  const [date, setDate] = useState(initial.date);
  const [note, setNote] = useState(initial.note);
  const [editingNote, setEditingNote] = useState(false);
  const [iosPicker, setIosPicker] = useState(false);
  const [confirmDelete, setConfirmDelete] = useState(false);

  const amount = Number(digits || '0');
  const visible = categories.filter((c) => c.type === txType);
  const selected = categories.find((c) => c.id === categoryId);

  function switchType(t: TxType) {
    setTxType(t);
    if (selected?.type !== t) {
      setCategoryId(t === 'income' ? categories.find((c) => c.type === 'income')!.id : lastExpenseCategory);
    }
  }

  function press(key: string) {
    setDigits((d) => {
      if (key === 'back') return d.slice(0, -1);
      if (key === 'clear') return '';
      const next = (d + key).replace(/^0+/, '');
      return next.length <= MAX_DIGITS ? next : d;
    });
  }

  function pickDate() {
    const keepTime = (picked: Date) => {
      const old = new Date(date);
      picked.setHours(old.getHours(), old.getMinutes(), 0, 0);
      setDate(picked.getTime());
    };
    if (Platform.OS === 'android') {
      DateTimePickerAndroid.open({
        value: new Date(date),
        mode: 'date',
        onChange: (e, d) => e.type === 'set' && d && keepTime(d),
      });
    } else {
      setIosPicker((v) => !v);
    }
  }

  function save() {
    if (amount <= 0) return;
    if (txType === 'expense') lastExpenseCategory = categoryId;
    const input = { type: txType, amount, categoryId, date, note };
    if (existingId !== null) {
      ledger.update(existingId, input);
      onDone({ kind: 'saved' });
    } else {
      onDone({ kind: 'saved', save: ledger.add(input) });
    }
  }

  function remove() {
    if (existingId === null) return;
    ledger.delete(existingId);
    onDone({ kind: 'deleted' });
  }

  return (
    <View style={{ backgroundColor: colors.surface, paddingBottom: 16 }}>
      <View style={{ flexDirection: 'row', alignItems: 'center', paddingHorizontal: 16, paddingTop: 12, gap: 12 }}>
        {isEdit && <Text style={type.title}>編輯紀錄</Text>}
        <Segmented value={txType} onChange={switchType} />
        <View style={{ flex: 1 }} />
        <Pressable accessibilityLabel="關閉" hitSlop={8} onPress={() => onDone({ kind: 'cancelled' })}>
          <Ionicons name="close" size={26} color={colors.ink} />
        </Pressable>
      </View>

      <View style={{ flexDirection: 'row', alignItems: 'flex-end', paddingHorizontal: 20, paddingTop: 12, gap: 6 }}>
        {selected && (
          <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6, paddingBottom: 8 }}>
            <FeedDot color={selected.feedColor} size={16} />
            <Text style={{ fontWeight: '700', color: colors.ink, fontSize: 15 }}>{selected.name}</Text>
          </View>
        )}
        <View style={{ flex: 1, flexDirection: 'row', justifyContent: 'flex-end', alignItems: 'baseline', gap: 4 }}>
          <Text style={type.small}>NT$</Text>
          <Text
            testID="amount-display"
            numberOfLines={1}
            adjustsFontSizeToFit
            style={{
              fontFamily: fonts.number,
              fontSize: 40,
              lineHeight: 48,
              color: txType === 'income' ? colors.primaryDeep : colors.ink,
            }}>
            {formatAmount(amount)}
          </Text>
        </View>
      </View>

      <View style={{ height: 1, backgroundColor: colors.line, marginVertical: 8 }} />

      <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 8, paddingHorizontal: 16 }}>
        {visible.map((c) => (
          <CategoryChip key={c.id} category={c} selected={c.id === categoryId} onPress={() => setCategoryId(c.id)} />
        ))}
      </View>

      <View style={{ flexDirection: 'row', alignItems: 'center', paddingHorizontal: 12, paddingTop: 8, gap: 8 }}>
        <Pressable onPress={pickDate} style={{ flexDirection: 'row', alignItems: 'center', gap: 6, padding: 8 }}>
          <Ionicons name="calendar" size={20} color={colors.primaryDeep} />
          <Text style={{ color: colors.primaryDeep, fontSize: 15 }}>
            {isSameDay(date, clock()) ? `今天 ${new Date(date).getMonth() + 1}/${new Date(date).getDate()}` : formatDayHeader(date)}
          </Text>
        </Pressable>
        {editingNote ? (
          <TextInput
            autoFocus
            value={note}
            onChangeText={setNote}
            maxLength={40}
            placeholder="備註（選填）"
            placeholderTextColor={colors.muted}
            returnKeyType="done"
            onSubmitEditing={() => setEditingNote(false)}
            onBlur={() => setEditingNote(false)}
            style={{ flex: 1, fontSize: 15, color: colors.ink, borderBottomWidth: 1, borderColor: colors.line, paddingVertical: 6 }}
          />
        ) : (
          <Pressable
            onPress={() => setEditingNote(true)}
            style={{ flex: 1, flexDirection: 'row', alignItems: 'center', gap: 6, padding: 8 }}>
            <Ionicons name="create-outline" size={20} color={colors.primaryDeep} />
            <Text numberOfLines={1} style={{ color: note ? colors.ink : colors.primaryDeep, fontSize: 15, flex: 1 }}>
              {note || '備註…'}
            </Text>
          </Pressable>
        )}
      </View>

      {iosPicker && (
        <DateTimePicker
          value={new Date(date)}
          mode="date"
          display="inline"
          onChange={(_, d) => {
            if (d) {
              const old = new Date(date);
              d.setHours(old.getHours(), old.getMinutes(), 0, 0);
              setDate(d.getTime());
            }
            setIosPicker(false);
          }}
        />
      )}

      {!editingNote && (
        <Keypad onKey={press} onSubmit={save} canSubmit={amount > 0} submitLabel={isEdit ? '儲存' : '記一筆'} />
      )}

      {isEdit && !editingNote && (
        <View style={{ alignItems: 'center', paddingTop: 12 }}>
          {confirmDelete ? (
            <View style={{ flexDirection: 'row', alignItems: 'center', gap: 16 }}>
              <Text style={{ color: colors.ink }}>確定刪除？已拿到的飼料不會收回</Text>
              <Pressable onPress={() => setConfirmDelete(false)} hitSlop={8}>
                <Text style={{ color: colors.muted, fontWeight: '700' }}>取消</Text>
              </Pressable>
              <Pressable testID="confirm-delete" onPress={remove} hitSlop={8}>
                <Text style={{ color: colors.danger, fontWeight: '700' }}>刪除</Text>
              </Pressable>
            </View>
          ) : (
            <Pressable onPress={() => setConfirmDelete(true)} hitSlop={8}>
              <Text style={{ color: colors.danger, fontWeight: '600' }}>刪除這筆</Text>
            </Pressable>
          )}
        </View>
      )}
    </View>
  );
}

function Segmented({ value, onChange }: { value: TxType; onChange: (t: TxType) => void }) {
  const items: { v: TxType; label: string }[] = [
    { v: 'expense', label: '支出' },
    { v: 'income', label: '收入' },
  ];
  return (
    <View style={{ flexDirection: 'row', borderWidth: 1, borderColor: colors.line, borderRadius: 20, overflow: 'hidden' }}>
      {items.map(({ v, label }) => {
        const on = v === value;
        return (
          <Pressable
            key={v}
            testID={`type-${v}`}
            accessibilityRole="button"
            accessibilityState={{ selected: on }}
            onPress={() => onChange(v)}
            style={{ paddingHorizontal: 18, paddingVertical: 7, backgroundColor: on ? colors.primary : 'transparent' }}>
            <Text style={{ color: on ? '#fff' : colors.ink, fontWeight: on ? '700' : '500', fontSize: 15 }}>{label}</Text>
          </Pressable>
        );
      })}
    </View>
  );
}

function CategoryChip({ category, selected, onPress }: { category: Category; selected: boolean; onPress: () => void }) {
  const hex = FEED_COLORS[category.feedColor].hex;
  // The white feed would vanish as a ring, so it uses the muted ink instead.
  const ring = category.feedColor === 'white' ? colors.muted : hex;
  return (
    <Pressable
      testID={`cat-${category.id}`}
      accessibilityRole="button"
      accessibilityState={{ selected }}
      onPress={onPress}
      style={{
        flexDirection: 'row',
        alignItems: 'center',
        gap: 6,
        paddingLeft: 8,
        paddingRight: 12,
        paddingVertical: 7,
        borderRadius: 999,
        borderWidth: selected ? 2 : 1,
        borderColor: selected ? ring : colors.line,
        backgroundColor: selected ? `${hex}2E` : colors.paper,
      }}>
      <FeedDot color={category.feedColor} size={14} />
      <Text style={{ fontSize: 14, color: colors.ink, fontWeight: selected ? '700' : '500' }}>{category.name}</Text>
    </Pressable>
  );
}
