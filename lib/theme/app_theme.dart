import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.mediterraneanBlue,
        primary: AppColors.mediterraneanBlue,
        secondary: AppColors.terracotta,
        surface: AppColors.card,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.offWhite,
      useMaterial3: true,
    );

    final bodyTheme = GoogleFonts.plusJakartaSansTextTheme(base.textTheme);
    final headingFamily = GoogleFonts.soraTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: bodyTheme.copyWith(
        displayLarge: headingFamily.displayLarge?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
          height: 1.02,
        ),
        displayMedium: headingFamily.displayMedium?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
          height: 1.04,
        ),
        displaySmall: headingFamily.displaySmall?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
          height: 1.06,
        ),
        headlineLarge: headingFamily.headlineLarge?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
        ),
        headlineMedium: headingFamily.headlineMedium?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w800,
        ),
        titleLarge: headingFamily.titleLarge?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: headingFamily.titleMedium?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: bodyTheme.bodyLarge?.copyWith(
          color: AppColors.inkSoft,
          height: 1.52,
        ),
        bodyMedium: bodyTheme.bodyMedium?.copyWith(
          color: AppColors.inkSoft,
          height: 1.45,
        ),
        bodySmall: bodyTheme.bodySmall?.copyWith(color: AppColors.muted),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.card,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.ink,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        labelStyle: const TextStyle(
          color: AppColors.muted,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.sandDark.withValues(alpha: 0.9),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppColors.mediterraneanBlue,
            width: 1.5,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mediterraneanBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
          textStyle: headingFamily.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          side: BorderSide(color: AppColors.sandDark.withValues(alpha: 0.9)),
          foregroundColor: AppColors.deepBlue,
          textStyle: headingFamily.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: Colors.white.withValues(alpha: 0.75),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: Colors.white,
        selectedColor: AppColors.mediterraneanBlue.withValues(alpha: 0.12),
        checkmarkColor: AppColors.mediterraneanBlue,
        side: BorderSide(color: AppColors.sandDark.withValues(alpha: 0.9)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        labelStyle: bodyTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white.withValues(alpha: 0.96),
        indicatorColor: AppColors.mediterraneanBlue.withValues(alpha: 0.14),
        labelTextStyle: WidgetStatePropertyAll(
          bodyTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.deepBlue,
          ),
        ),
      ),
      dividerColor: AppColors.sand,
      canvasColor: AppColors.offWhite,
    );
  }
}
