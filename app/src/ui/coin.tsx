import { Text, View } from 'react-native';

/** Gold coin badge, the "fish droppings" currency (docs/02-gameplay-economy.md). */
export function Coin({ size = 16 }: { size?: number }) {
  return (
    <View
      style={{
        width: size,
        height: size,
        borderRadius: size / 2,
        backgroundColor: '#FFC83D',
        borderWidth: Math.max(1, size / 10),
        borderColor: '#E0A21A',
        alignItems: 'center',
        justifyContent: 'center',
      }}>
      <Text style={{ fontSize: size * 0.55, lineHeight: size * 0.7, color: '#B87A0C', fontWeight: '800' }}>$</Text>
    </View>
  );
}
