import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../art/clownfish_painter.dart';
import '../../data/providers.dart';
import '../../theme/tokens.dart';

class BackpackPage extends ConsumerWidget {
  const BackpackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fishes = ref.watch(fishesProvider).value ?? const [];
    final slots = ref.watch(tankProvider).value?.fishSlots ?? 1;
    final inTank = fishes.where((f) => f.inTank).length;

    return Scaffold(
      appBar: AppBar(title: const Text('背包')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        children: [
          Text('魚 $inTank/$slots', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final f in fishes)
                SizedBox(
                  width: 150,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 110,
                            height: 110 * 124 / 164,
                            child: CustomPaint(painter: ClownfishPainter()),
                          ),
                          const SizedBox(height: 8),
                          const Text('橘橘', style: TextStyle(fontWeight: FontWeight.w700)),
                          Text(
                            f.inTank ? '在魚缸中' : '休息中',
                            style: TextStyle(
                              fontSize: 12,
                              color: f.inTank ? AppColors.primaryDeep : AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
