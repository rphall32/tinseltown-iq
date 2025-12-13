import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Tinseltown IQ Theme Configuration
/// 
/// Provides consistent theming across the app with a cinematic dark aesthetic.
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Dark theme for Tinseltown IQ
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.soundstageDark,
      primaryColor: AppColors.oscarGold,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.oscarGold,
        secondary: AppColors.greenlightNeon,
        surface: AppColors.editingBay,
        error: AppColors.cutRed,
      ),
      
      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.soundstageDark,
        foregroundColor: AppColors.scriptPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.editingBay,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.oscarGold,
          foregroundColor: AppColors.midnightPremiere,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.oscarGold,
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backstage,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.backstage),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.oscarGold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cutRed),
        ),
        hintStyle: const TextStyle(color: AppColors.stageDirection),
        labelStyle: const TextStyle(color: AppColors.dialogueSecondary),
      ),
      
      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.editingBay,
        contentTextStyle: const TextStyle(color: AppColors.scriptPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      
      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.soundstageDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      
      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.editingBay,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.backstage,
        thickness: 1,
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.dialogueSecondary,
      ),
      
      // Text theme
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: AppColors.scriptPrimary),
          displayMedium: TextStyle(color: AppColors.scriptPrimary),
          displaySmall: TextStyle(color: AppColors.scriptPrimary),
          headlineLarge: TextStyle(color: AppColors.scriptPrimary),
          headlineMedium: TextStyle(color: AppColors.scriptPrimary),
          headlineSmall: TextStyle(color: AppColors.scriptPrimary),
          titleLarge: TextStyle(color: AppColors.scriptPrimary),
          titleMedium: TextStyle(color: AppColors.scriptPrimary),
          titleSmall: TextStyle(color: AppColors.dialogueSecondary),
          bodyLarge: TextStyle(color: AppColors.dialogueSecondary),
          bodyMedium: TextStyle(color: AppColors.dialogueSecondary),
          bodySmall: TextStyle(color: AppColors.stageDirection),
          labelLarge: TextStyle(color: AppColors.scriptPrimary),
          labelMedium: TextStyle(color: AppColors.dialogueSecondary),
          labelSmall: TextStyle(color: AppColors.stageDirection),
        ),
      ),
    );
  }

  /// Light theme for Tinseltown IQ
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.lightGold,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightGold,
        secondary: AppColors.lightGoldAccent,
        surface: AppColors.lightSurface,
        error: AppColors.lightError,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
        onError: Colors.white,
      ),
      
      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.lightDivider,
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGold,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.lightGold,
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightGold, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightError),
        ),
        hintStyle: const TextStyle(color: AppColors.lightTextTertiary),
        labelStyle: const TextStyle(color: AppColors.lightTextSecondary),
      ),
      
      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightTextPrimary,
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      
      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      
      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      
      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.lightTextSecondary,
      ),
      
      // Text theme
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: AppColors.lightTextPrimary),
          displayMedium: TextStyle(color: AppColors.lightTextPrimary),
          displaySmall: TextStyle(color: AppColors.lightTextPrimary),
          headlineLarge: TextStyle(color: AppColors.lightTextPrimary),
          headlineMedium: TextStyle(color: AppColors.lightTextPrimary),
          headlineSmall: TextStyle(color: AppColors.lightTextPrimary),
          titleLarge: TextStyle(color: AppColors.lightTextPrimary),
          titleMedium: TextStyle(color: AppColors.lightTextPrimary),
          titleSmall: TextStyle(color: AppColors.lightTextSecondary),
          bodyLarge: TextStyle(color: AppColors.lightTextSecondary),
          bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
          bodySmall: TextStyle(color: AppColors.lightTextTertiary),
          labelLarge: TextStyle(color: AppColors.lightTextPrimary),
          labelMedium: TextStyle(color: AppColors.lightTextSecondary),
          labelSmall: TextStyle(color: AppColors.lightTextTertiary),
        ),
      ),
    );
  }

  /// Get ThemeMode from string preference
  static ThemeMode getThemeMode(String themePreference) {
    switch (themePreference) {
      case 'Light':
        return ThemeMode.light;
      case 'Dark':
        return ThemeMode.dark;
      case 'System':
      default:
        return ThemeMode.system;
    }
  }

  /// Get ThemeData based on preference string
  static ThemeData getTheme(String themePreference, Brightness platformBrightness) {
    switch (themePreference) {
      case 'Light':
        return lightTheme;
      case 'Dark':
        return darkTheme;
      case 'System':
      default:
        return platformBrightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }
}
