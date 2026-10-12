import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../art/clownfish_painter.dart';
import '../../data/db/app_database.dart';
import '../../data/providers.dart';
import '../../theme/tokens.dart';
import '../../widgets/feed_dot.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coins = ref.watch(walletProvider).value?.coins ?? 0;
    final fishes = ref.watch(fishesProvider).value ?? const [];
    final slots = ref.watch(tankProvider).value?.fishSlots ?? 1;
    final inTank = fishes.where((f) => f.inTank).length;
    final stocks = ref.watch(feedStocksProvider).value ?? const <FeedStock>[];
    final feedTotal = stocks.fold<int>(0, (s, f) => s + f.quantity);

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 8, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('本月支出', style: Theme.of(context).textTheme.labelSmall),
                      const Text(
                        'NT\$ 0',
                        style: TextStyle(
                          fontFamily: AppFonts.number,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 16,
                        children: [
                          _Stat(icon: Icons.monetization_on_rounded, color: AppColors.coin, text: '$coins'),
                          _Stat(
                            key: const Key('feed-total'),
                            icon: Icons.grain_rounded,
                            color: AppColors.primaryDeep,
                            text: '$feedTotal',
                            onTap: () => _showFeedStocks(context, stocks),
                          ),
                          _Stat(icon: Icons.set_meal_rounded, color: AppColors.primary, text: '$inTank/$slots'),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: '設定',
                  onPressed: () {},
                  icon: const Icon(Icons.settings_rounded, color: AppColors.muted),
                ),
              ],
            ),
          ),
          const Expanded(child: _TankPlaceholder()),
        ],
      ),
    );
  }
}

void _showFeedStocks(BuildContext context, List<FeedStock> stocks) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('飼料庫存', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 12),
            if (stocks.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('記一筆帳就能拿到飼料', style: TextStyle(color: AppColors.muted)),
              ),
            for (final s in stocks)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(children: [
                  FeedDot(color: s.color, size: 18),
                  const SizedBox(width: 10),
                  Text('${s.color.label}飼料 ${s.level.label}'),
                  const Spacer(),
                  Text('×${s.quantity}',
                      style: const TextStyle(fontFamily: AppFonts.number, fontWeight: FontWeight.w600, fontSize: 16)),
                ]),
              ),
          ],
        ),
      ),
    ),
  );
}

class _Stat extends StatelessWidget {
  const _Stat({super.key, required this.icon, required this.color, required this.text, this.onTap});
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontFamily: AppFonts.number,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.ink,
          ),
        ),
      ],
    );
    if (onTap == null) return row;
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(8), child: row);
  }
}

/// Static tank until S04 brings in the Flame scene.
class _TankPlaceholder extends StatelessWidget {
  const _TankPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.seaTop, AppColors.seaMid, AppColors.seaBottom],
          stops: [0, 0.45, 1],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 56,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.sand,
                border: Border(top: BorderSide(color: AppColors.sandEdge, width: 3)),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0, -0.1),
            child: SizedBox(
              width: 150,
              height: 150 * 124 / 164,
              child: CustomPaint(painter: ClownfishPainter()),
            ),
          ),
        ],
      ),
    );
  }
}
