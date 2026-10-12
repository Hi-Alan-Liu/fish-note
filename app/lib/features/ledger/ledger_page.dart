import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import '../../data/providers.dart';
import '../../domain/categories.dart';
import '../../theme/tokens.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/feed_dot.dart';
import '../../widgets/format.dart';
import 'transaction_sheet.dart';

class LedgerPage extends ConsumerWidget {
  const LedgerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(transactionsProvider).value ?? const <TxWithCategory>[];

    return Scaffold(
      appBar: AppBar(title: const Text('明細')),
      body: items.isEmpty
          ? const EmptyState(icon: Icons.receipt_long_rounded, message: '還沒有任何紀錄，按下方 ＋ 記第一筆帳')
          : _GroupedList(items: items),
    );
  }
}

class _GroupedList extends StatelessWidget {
  const _GroupedList({required this.items});
  final List<TxWithCategory> items;

  @override
  Widget build(BuildContext context) {
    // items are newest first; group consecutive records of the same day.
    final groups = <List<TxWithCategory>>[];
    for (final it in items) {
      if (groups.isEmpty || !isSameDay(groups.last.first.tx.date, it.tx.date)) {
        groups.add([it]);
      } else {
        groups.last.add(it);
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemCount: groups.length,
      itemBuilder: (context, i) {
        final g = groups[i];
        final net = g.fold<int>(0, (sum, it) => sum + _signed(it.tx));
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    children: [
                      Text(formatDayHeader(g.first.tx.date), style: Theme.of(context).textTheme.labelSmall),
                      const Spacer(),
                      Text(
                        _signedText(net),
                        style: const TextStyle(fontFamily: AppFonts.number, fontSize: 13, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                for (final it in g) _TxRow(item: it),
                const SizedBox(height: 4),
              ],
            ),
          ),
        );
      },
    );
  }
}

int _signed(TxRecord tx) => tx.type == TxType.income ? tx.amount : -tx.amount;

String _signedText(int v) => v > 0 ? '+${formatAmount(v)}' : v < 0 ? '-${formatAmount(-v)}' : '0';

class _TxRow extends StatelessWidget {
  const _TxRow({required this.item});
  final TxWithCategory item;

  @override
  Widget build(BuildContext context) {
    final tx = item.tx;
    final income = tx.type == TxType.income;
    return InkWell(
      onTap: () => openTransactionSheet(context, existing: tx),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            FeedDot(color: item.category.feedColor, size: 16),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.note.isEmpty ? item.category.name : tx.note,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (tx.note.isNotEmpty)
                    Text(item.category.name, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Text(
              _signedText(_signed(tx)),
              style: TextStyle(
                fontFamily: AppFonts.number,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: income ? AppColors.primaryDeep : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
