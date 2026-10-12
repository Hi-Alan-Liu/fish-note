import { Ionicons } from '@expo/vector-icons';
import { Text, View } from 'react-native';

import { colors } from '@/theme/tokens';

export function EmptyState({ icon, message }: { icon: keyof typeof Ionicons.glyphMap; message: string }) {
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center', paddingHorizontal: 32, gap: 16 }}>
      <View
        style={{
          width: 88,
          height: 88,
          borderRadius: 44,
          backgroundColor: colors.chip,
          alignItems: 'center',
          justifyContent: 'center',
        }}>
        <Ionicons name={icon} size={40} color={colors.muted} />
      </View>
      <Text style={{ fontSize: 16, color: colors.muted, textAlign: 'center', lineHeight: 24 }}>{message}</Text>
    </View>
  );
}
