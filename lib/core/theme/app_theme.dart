import 'package:flutter/material.dart';

/// App-wide visual constants and the ThemeData factory.
/// Kept in `core` because theming is a cross-cutting concern used by
/// every feature's presentation layer, not owned by any single feature.
class AppColors {
  AppColors._();
  static const Color primary = Color(0xFFB5654A); // warm terracotta
  static const Color background = Color(0xFFFBF6F2);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
}
