import 'package:flutter/painting.dart';

/// Feed colours. Category colour = feed colour = pie-slice colour (docs/features/ledger.md).
enum FeedColor {
  orange(Color(0xFFFF9A3C), '橘色'),
  blue(Color(0xFF4AA8FF), '藍色'),
  pink(Color(0xFFFF7EB6), '粉紅色'),
  purple(Color(0xFFA77BFF), '紫色'),
  green(Color(0xFF4FD38A), '綠色'),
  cyan(Color(0xFF35D6D0), '青色'),
  white(Color(0xFFEEF2F4), '白色'),
  gold(Color(0xFFFFD23F), '金色');

  const FeedColor(this.color, this.label);
  final Color color;
  final String label;
}

/// Feed levels (docs/02-gameplay-economy.md). `tutorial` is the one-off starter feed.
enum FeedLevel {
  a(digest: Duration(hours: 1), coins: 10),
  b(digest: Duration(hours: 2), coins: 30),
  c(digest: Duration(hours: 4), coins: 80),
  d(digest: Duration(hours: 8), coins: 200),
  tutorial(digest: Duration.zero, coins: 5);

  const FeedLevel({required this.digest, required this.coins});
  final Duration digest;
  final int coins;

  String get label => this == tutorial ? '新手' : name.toUpperCase();
}
