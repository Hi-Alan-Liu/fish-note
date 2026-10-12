import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'db/app_database.dart';
import 'ledger_repository.dart';

/// Overridden in main() (and in tests) with a real database.
final databaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('databaseProvider must be overridden'),
);

/// Overridable in tests to control "now".
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final ledgerRepositoryProvider = Provider<LedgerRepository>(
  (ref) => LedgerRepository(ref.watch(databaseProvider), clock: ref.watch(clockProvider)),
);

final tankProvider = StreamProvider<Tank>((ref) => ref.watch(databaseProvider).watchTank());

final fishesProvider = StreamProvider<List<Fish>>((ref) => ref.watch(databaseProvider).watchFishes());

final walletProvider = StreamProvider<WalletRow>((ref) => ref.watch(databaseProvider).watchWallet());

final categoriesProvider = FutureProvider<List<Category>>((ref) => ref.watch(databaseProvider).allCategories());

final transactionsProvider =
    StreamProvider<List<TxWithCategory>>((ref) => ref.watch(databaseProvider).watchTransactions());

final feedStocksProvider = StreamProvider<List<FeedStock>>((ref) => ref.watch(databaseProvider).watchFeedStocks());
