import { router, useLocalSearchParams } from 'expo-router';
import { ScrollView } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

import { useQuery } from '@/data/data-context';
import { getTransaction } from '@/data/queries';
import { feedbackFor } from '@/features/ledger/feedback';
import { TransactionForm, type FormResult } from '@/features/ledger/transaction-form';
import { useToast } from '@/ui/toast';

export default function TransactionRoute() {
  const { id } = useLocalSearchParams<{ id?: string }>();
  const existing = useQuery((db) => (id ? getTransaction(db, Number(id)) : null), [id]);
  const toast = useToast();
  const insets = useSafeAreaInsets();

  function done(result: FormResult) {
    const fb = feedbackFor(result);
    if (fb) toast(fb.text, fb.leading);
    router.back();
  }

  return (
    <ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={{ paddingBottom: insets.bottom }}>
      <TransactionForm existing={existing} onDone={done} />
    </ScrollView>
  );
}
