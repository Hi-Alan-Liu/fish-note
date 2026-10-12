import { createContext, useCallback, useContext, useEffect, useRef, useState, type ReactNode } from 'react';
import { Animated, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { colors } from '@/theme/tokens';

interface ToastMessage {
  id: number;
  text: string;
  leading?: ReactNode;
}

const ToastContext = createContext<(text: string, leading?: ReactNode) => void>(() => {});

export const useToast = () => useContext(ToastContext);

/** Bottom toast that sits above the tab bar. */
export function ToastProvider({ children, bottomOffset = 110 }: { children: ReactNode; bottomOffset?: number }) {
  const [msg, setMsg] = useState<ToastMessage | null>(null);
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const [appear] = useState(() => new Animated.Value(0));
  const insets = useSafeAreaInsets();

  const show = useCallback(
    (text: string, leading?: ReactNode) => {
      if (timer.current) clearTimeout(timer.current);
      setMsg({ id: Date.now(), text, leading });
      appear.setValue(0);
      Animated.timing(appear, { toValue: 1, duration: 180, useNativeDriver: true }).start();
      timer.current = setTimeout(() => setMsg(null), 2800);
    },
    [appear],
  );

  useEffect(() => () => {
    if (timer.current) clearTimeout(timer.current);
  }, []);

  return (
    <ToastContext.Provider value={show}>
      {children}
      {msg && (
        <Animated.View
          key={msg.id}
          pointerEvents="none"
          style={{
            position: 'absolute',
            left: 16,
            right: 16,
            bottom: bottomOffset + insets.bottom,
            opacity: appear,
            transform: [{ translateY: appear.interpolate({ inputRange: [0, 1], outputRange: [16, 0] }) }],
          }}>
          <View
            accessibilityRole="alert"
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              gap: 10,
              backgroundColor: colors.toast,
              borderRadius: 12,
              paddingHorizontal: 16,
              paddingVertical: 14,
            }}>
            {msg.leading}
            <Text style={{ color: '#fff', fontSize: 15, flex: 1 }}>{msg.text}</Text>
          </View>
        </Animated.View>
      )}
    </ToastContext.Provider>
  );
}
