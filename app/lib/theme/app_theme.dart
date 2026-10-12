import 'package:flutter/material.dart';

import 'tokens.dart';

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.ink,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.paper,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontFamily: AppFonts.display, fontSize: 26, color: AppColors.ink),
      titleLarge: TextStyle(fontFamily: AppFonts.display, fontSize: 22, color: AppColors.ink),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.ink),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.ink, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.ink, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.muted),
      labelSmall: TextStyle(fontSize: 12, color: AppColors.muted, letterSpacing: 0.6),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.paper,
      foregroundColor: AppColors.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(fontFamily: AppFonts.display, fontSize: 22, color: AppColors.ink),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: const BorderSide(color: AppColors.line),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(48, 48),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button)),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
  );
}
