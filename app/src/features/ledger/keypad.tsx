import { Ionicons } from '@expo/vector-icons';
import { Pressable, Text, View } from 'react-native';

import { colors, fonts, radius } from '@/theme/tokens';

const ROWS = [
  ['7', '8', '9'],
  ['4', '5', '6'],
  ['1', '2', '3'],
  ['00', '0', '.'],
];
const KEY_H = 54;
const GAP = 8;

export function Keypad({
  onKey,
  onSubmit,
  canSubmit,
  submitLabel,
}: {
  onKey: (key: string) => void;
  onSubmit: () => void;
  canSubmit: boolean;
  submitLabel: string;
}) {
  return (
    <View style={{ flexDirection: 'row', gap: GAP, paddingHorizontal: 12, paddingTop: 8 }}>
      <View style={{ flex: 3, gap: GAP }}>
        {ROWS.map((row) => (
          <View key={row.join()} style={{ flexDirection: 'row', gap: GAP }}>
            {row.map((k) => (
              // NT$ has no decimals in phase 1, so "." stays disabled.
              <Key key={k} testID={`key-${k}`} label={k} onPress={k === '.' ? undefined : () => onKey(k)} />
            ))}
          </View>
        ))}
      </View>
      <View style={{ flex: 1, gap: GAP }}>
        <Key testID="key-back" icon="backspace-outline" onPress={() => onKey('back')} />
        <Key testID="key-clear" label="C" onPress={() => onKey('clear')} />
        <Pressable
          testID="key-submit"
          accessibilityRole="button"
          accessibilityState={{ disabled: !canSubmit }}
          disabled={!canSubmit}
          onPress={onSubmit}
          style={({ pressed }) => ({
            height: KEY_H * 2 + GAP,
            borderRadius: radius.button,
            alignItems: 'center',
            justifyContent: 'center',
            backgroundColor: !canSubmit ? colors.line : pressed ? colors.primaryDeep : colors.primary,
          })}>
          <Text style={{ color: canSubmit ? '#fff' : colors.muted, fontSize: 17, fontWeight: '700' }}>{submitLabel}</Text>
        </Pressable>
      </View>
    </View>
  );
}

function Key({
  label,
  icon,
  onPress,
  testID,
}: {
  label?: string;
  icon?: keyof typeof Ionicons.glyphMap;
  onPress?: () => void;
  testID: string;
}) {
  const enabled = !!onPress;
  return (
    <Pressable
      testID={testID}
      accessibilityRole="button"
      accessibilityLabel={label ?? '刪除一位'}
      disabled={!enabled}
      onPress={onPress}
      style={({ pressed }) => ({
        flex: 1,
        height: KEY_H,
        borderRadius: radius.button,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: pressed ? colors.line : colors.chip,
      })}>
      {icon ? (
        <Ionicons name={icon} size={24} color={colors.ink} />
      ) : (
        <Text style={{ fontFamily: fonts.number, fontSize: 24, color: enabled ? colors.ink : colors.line }}>{label}</Text>
      )}
    </Pressable>
  );
}
