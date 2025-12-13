import 'package:flutter/material.dart';

/// Tinseltown IQ Color Palette
/// 
/// A cinematic, premium color scheme inspired by Hollywood aesthetics.
/// Supports both dark (default) and light themes.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ═══════════════════════════════════════════════════════════════
  // Signature Gold Spectrum - Premium, award-worthy accents
  // ═══════════════════════════════════════════════════════════════
  static const Color oscarGold = Color(0xFFD4A84B);
  static const Color champagneGold = Color(0xFFF7E7CE);
  static const Color antiqueGold = Color(0xFFC9A227);
  static const Color bronzeAccent = Color(0xFF8B7355);

  // ═══════════════════════════════════════════════════════════════
  // Cinematic Dark Spectrum - Theater-inspired backgrounds
  // ═══════════════════════════════════════════════════════════════
  static const Color midnightPremiere = Color(0xFF0D0D12);
  static const Color soundstageDark = Color(0xFF14141F);
  static const Color editingBay = Color(0xFF1C1C2A);
  static const Color screeningRoom = Color(0xFF252536);
  static const Color backstage = Color(0xFF2F2F42);

  // ═══════════════════════════════════════════════════════════════
  // Spotlight Accent Spectrum - Status and action colors
  // ═══════════════════════════════════════════════════════════════
  static const Color greenlightNeon = Color(0xFF00E676);
  static const Color cautionAmber = Color(0xFFFFAB00);
  static const Color cutRed = Color(0xFFFF5252);
  static const Color rewriteBlue = Color(0xFF448AFF);

  // ═══════════════════════════════════════════════════════════════
  // Typography Spectrum - Text hierarchy colors
  // ═══════════════════════════════════════════════════════════════
  static const Color scriptPrimary = Color(0xFFFFFFFF);
  static const Color dialogueSecondary = Color(0xFFE0E0E6);
  static const Color stageDirection = Color(0xFF9090A0);
  static const Color fadeOut = Color(0xFF606070);

  // ═══════════════════════════════════════════════════════════════
  // Semantic Colors - For specific use cases
  // ═══════════════════════════════════════════════════════════════
  static const Color success = greenlightNeon;
  static const Color warning = cautionAmber;
  static const Color error = cutRed;
  static const Color info = rewriteBlue;

  // ═══════════════════════════════════════════════════════════════
  // Score Colors - For GreenlightIQ score visualization
  // ═══════════════════════════════════════════════════════════════
  static Color getScoreColor(int score) {
    if (score >= 80) return greenlightNeon;
    if (score >= 60) return cautionAmber;
    return cutRed;
  }

  static Color getScoreBackgroundColor(int score) {
    if (score >= 80) return greenlightNeon.withValues(alpha: 0.15);
    if (score >= 60) return cautionAmber.withValues(alpha: 0.15);
    return cutRed.withValues(alpha: 0.15);
  }

  // ═══════════════════════════════════════════════════════════════
  // Light Theme Color Palette
  // ═══════════════════════════════════════════════════════════════
  
  /// Light Theme Backgrounds
  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE5E5EA);
  static const Color lightBorder = Color(0xFFD1D1D6);
  
  /// Light Theme Text Colors
  static const Color lightTextPrimary = Color(0xFF1C1C1E);
  static const Color lightTextSecondary = Color(0xFF3C3C43);
  static const Color lightTextTertiary = Color(0xFF8E8E93);
  static const Color lightTextDisabled = Color(0xFFAEAEB2);
  
  /// Light Theme Accent - Adjusted gold for light backgrounds
  static const Color lightGold = Color(0xFFB8860B);  // Darker gold for contrast
  static const Color lightGoldAccent = Color(0xFFDAA520);
  
  /// Light Theme Status Colors (adjusted for light backgrounds)
  static const Color lightSuccess = Color(0xFF34C759);
  static const Color lightWarning = Color(0xFFFF9500);
  static const Color lightError = Color(0xFFFF3B30);
  static const Color lightInfo = Color(0xFF007AFF);
}
