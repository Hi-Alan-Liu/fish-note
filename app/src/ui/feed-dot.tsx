import { View } from 'react-native';

import { FEED_COLORS, type FeedColor } from '@/domain/feed';

/** A round feed pellet, matching the prototype's candy look. */
export function FeedDot({ color, size = 14, glow = false }: { color: FeedColor; size?: number; glow?: boolean }) {
  return (
    <View
      style={{
        width: size,
        height: size,
        borderRadius: size / 2,
        backgroundColor: FEED_COLORS[color].hex,
        borderWidth: glow ? 2.5 : 1,
        borderColor: glow ? '#FFE27A' : 'rgba(0,0,0,0.13)',
        overflow: 'hidden',
      }}>
      <View
        style={{
          position: 'absolute',
          left: size * 0.18,
          top: size * 0.14,
          width: size * 0.34,
          height: size * 0.34,
          borderRadius: size,
          backgroundColor: 'rgba(255,255,255,0.55)',
        }}
      />
    </View>
  );
}
