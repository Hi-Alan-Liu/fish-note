import 'package:flutter/material.dart';

/// Design tokens from docs/03-art-style.md (baseline: clownfish "橘橘").
abstract final class AppColors {
  static const primary = Color(0xFFFF7A2E);
  static const primaryDeep = Color(0xFFE2622A);
  static const ink = Color(0xFF1D3640);
  static const muted = Color(0xFF5B7680);
  static const paper = Color(0xFFF3F8F9);
  static const surface = Color(0xFFFFFFFF);
  static const line = Color(0xFFD5E4E8);
  static const chip = Color(0xFFE8F2F4);
  static const outline = Color(0xFF2B1D1A);

  static const seaTop = Color(0xFF5FD3E8);
  static const seaMid = Color(0xFF2FB2D4);
  static const seaBottom = Color(0xFF1A8FBD);
  static const sand = Color(0xFFF6DFA8);
  static const sandEdge = Color(0xFFE8C67C);

  static const coin = Color(0xFFFFC83D);
  static const danger = Color(0xFFD43C4E);
}

abstract final class AppFonts {
  static const display = 'Huninn';
  static const number = 'Baloo2';
}

abstract final class AppRadius {
  static const card = 18.0;
  static const button = 14.0;
}
