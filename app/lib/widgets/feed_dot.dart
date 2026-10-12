import 'package:flutter/material.dart';

import '../domain/feed.dart';

/// A round feed pellet, matching the prototype's candy look.
class FeedDot extends StatelessWidget {
  const FeedDot({super.key, required this.color, this.size = 14, this.glow = false});

  final FeedColor color;
  final double size;

  /// Highlight ring for upgraded feed.
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.color,
        border: Border.all(
          color: glow ? const Color(0xFFFFE27A) : const Color(0x22000000),
          width: glow ? 2.5 : 1,
        ),
        gradient: RadialGradient(
          center: const Alignment(-0.35, -0.35),
          colors: [Color.lerp(color.color, Colors.white, 0.55)!, color.color],
          stops: const [0, 0.7],
        ),
      ),
    );
  }
}
