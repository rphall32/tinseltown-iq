import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_spacing.dart';
import 'app_radius.dart';
import 'app_shadows.dart';

/// Theme-Aware Color Extensions
/// 
/// Provides context-based access to colors that automatically
/// adapt to the current theme (light/dark mode).

extension ThemeColorsExtension on BuildContext {
  // ═══════════════════════════════════════════════════════════════
  // Theme Detection
  // ═══════════════════════════════════════════════════════════════
  
  /// Check if current theme is dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  
  /// Check if current theme is light mode
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  // ═══════════════════════════════════════════════════════════════
  // Background Colors
  // ═══════════════════════════════════════════════════════════════
  
  /// Primary scaffold background
  Color get scaffoldBackground => isDarkMode 
      ? AppColors.soundstageDark 
      : AppColors.lightBackground;
  
  /// Card/surface background
  Color get surfaceColor => isDarkMode 
      ? AppColors.editingBay 
      : AppColors.lightSurface;
  
  /// Secondary surface (slightly elevated)
  Color get surfaceVariant => isDarkMode 
      ? AppColors.screeningRoom 
      : AppColors.lightCard;
  
  /// Tertiary surface (more elevated)
  Color get surfaceTertiary => isDarkMode 
      ? AppColors.backstage 
      : AppColors.lightDivider;
  
  /// Container background (for cards, dialogs)
  Color get containerColor => isDarkMode 
      ? AppColors.editingBay 
      : AppColors.lightCard;
  
  /// Input field background
  Color get inputBackground => isDarkMode 
      ? AppColors.backstage 
      : AppColors.lightSurface;

  // ═══════════════════════════════════════════════════════════════
  // Text Colors
  // ═══════════════════════════════════════════════════════════════
  
  /// Primary text color
  Color get textPrimary => isDarkMode 
      ? AppColors.scriptPrimary 
      : AppColors.lightTextPrimary;
  
  /// Secondary text color
  Color get textSecondary => isDarkMode 
      ? AppColors.dialogueSecondary 
      : AppColors.lightTextSecondary;
  
  /// Tertiary/hint text color
  Color get textTertiary => isDarkMode 
      ? AppColors.stageDirection 
      : AppColors.lightTextTertiary;
  
  /// Disabled text color
  Color get textDisabled => isDarkMode 
      ? AppColors.fadeOut 
      : AppColors.lightTextDisabled;

  // ═══════════════════════════════════════════════════════════════
  // Accent/Brand Colors
  // ═══════════════════════════════════════════════════════════════
  
  /// Primary accent color (gold)
  Color get accentPrimary => isDarkMode 
      ? AppColors.oscarGold 
      : AppColors.lightGold;
  
  /// Secondary accent color
  Color get accentSecondary => isDarkMode 
      ? AppColors.champagneGold 
      : AppColors.lightGoldAccent;

  // ═══════════════════════════════════════════════════════════════
  // Semantic Colors (Status)
  // ═══════════════════════════════════════════════════════════════
  
  /// Success color
  Color get successColor => isDarkMode 
      ? AppColors.greenlightNeon 
      : AppColors.lightSuccess;
  
  /// Warning color
  Color get warningColor => isDarkMode 
      ? AppColors.cautionAmber 
      : AppColors.lightWarning;
  
  /// Error color
  Color get errorColor => isDarkMode 
      ? AppColors.cutRed 
      : AppColors.lightError;
  
  /// Info color
  Color get infoColor => isDarkMode 
      ? AppColors.rewriteBlue 
      : AppColors.lightInfo;

  // ═══════════════════════════════════════════════════════════════
  // Border Colors
  // ═══════════════════════════════════════════════════════════════
  
  /// Default border color
  Color get borderColor => isDarkMode 
      ? AppColors.backstage 
      : AppColors.lightBorder;
  
  /// Subtle border color
  Color get borderSubtle => isDarkMode 
      ? AppColors.editingBay 
      : AppColors.lightDivider;
  
  /// Focused border color
  Color get borderFocused => accentPrimary;

  // ═══════════════════════════════════════════════════════════════
  // Divider Colors
  // ═══════════════════════════════════════════════════════════════
  
  /// Divider color
  Color get dividerColor => isDarkMode 
      ? AppColors.backstage 
      : AppColors.lightDivider;

  // ═══════════════════════════════════════════════════════════════
  // Icon Colors
  // ═══════════════════════════════════════════════════════════════
  
  /// Primary icon color
  Color get iconPrimary => isDarkMode 
      ? AppColors.dialogueSecondary 
      : AppColors.lightTextSecondary;
  
  /// Secondary icon color
  Color get iconSecondary => isDarkMode 
      ? AppColors.stageDirection 
      : AppColors.lightTextTertiary;
  
  /// Active icon color
  Color get iconActive => accentPrimary;

  // ═══════════════════════════════════════════════════════════════
  // Score Colors (Theme-Aware)
  // ═══════════════════════════════════════════════════════════════
  
  /// Get score color based on value
  Color scoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    return errorColor;
  }
  
  /// Get score background color
  Color scoreBackgroundColor(int score) {
    return scoreColor(score).withValues(alpha: isDarkMode ? 0.15 : 0.1);
  }

  // ═══════════════════════════════════════════════════════════════
  // Overlay Colors
  // ═══════════════════════════════════════════════════════════════
  
  /// Modal barrier color
  Color get barrierColor => isDarkMode 
      ? Colors.black.withValues(alpha: 0.7) 
      : Colors.black.withValues(alpha: 0.5);
  
  /// Hover overlay color
  Color get hoverOverlay => isDarkMode 
      ? Colors.white.withValues(alpha: 0.05) 
      : Colors.black.withValues(alpha: 0.05);
  
  /// Press overlay color
  Color get pressOverlay => isDarkMode 
      ? Colors.white.withValues(alpha: 0.1) 
      : Colors.black.withValues(alpha: 0.1);
}

/// Typography Extensions
extension ThemeTypographyExtension on BuildContext {
  // ═══════════════════════════════════════════════════════════════
  // Pre-colored Text Styles
  // ═══════════════════════════════════════════════════════════════
  
  /// Display large with theme color
  TextStyle get displayLarge => AppTypography.displayLarge.copyWith(color: textPrimary);
  
  /// Display medium with theme color
  TextStyle get displayMedium => AppTypography.displayMedium.copyWith(color: textPrimary);
  
  /// Display small with theme color
  TextStyle get displaySmall => AppTypography.displaySmall.copyWith(color: textPrimary);
  
  /// Headline large with theme color
  TextStyle get headlineLarge => AppTypography.headlineLarge.copyWith(color: textPrimary);
  
  /// Headline medium with theme color
  TextStyle get headlineMedium => AppTypography.headlineMedium.copyWith(color: textPrimary);
  
  /// Headline small with theme color
  TextStyle get headlineSmall => AppTypography.headlineSmall.copyWith(color: textPrimary);
  
  /// Title large with theme color
  TextStyle get titleLarge => AppTypography.titleLarge.copyWith(color: textPrimary);
  
  /// Title medium with theme color
  TextStyle get titleMedium => AppTypography.titleMedium.copyWith(color: textPrimary);
  
  /// Title small with theme color
  TextStyle get titleSmall => AppTypography.titleSmall.copyWith(color: textSecondary);
  
  /// Body large with theme color
  TextStyle get bodyLarge => AppTypography.bodyLarge.copyWith(color: textSecondary);
  
  /// Body medium with theme color
  TextStyle get bodyMedium => AppTypography.bodyMedium.copyWith(color: textSecondary);
  
  /// Body small with theme color
  TextStyle get bodySmall => AppTypography.bodySmall.copyWith(color: textTertiary);
  
  /// Label large with theme color
  TextStyle get labelLarge => AppTypography.labelLarge.copyWith(color: textPrimary);
  
  /// Label medium with theme color
  TextStyle get labelMedium => AppTypography.labelMedium.copyWith(color: textSecondary);
  
  /// Label small with theme color
  TextStyle get labelSmall => AppTypography.labelSmall.copyWith(color: textTertiary);
  
  /// Caption with theme color
  TextStyle get caption => AppTypography.caption.copyWith(color: textTertiary);
  
  /// Button text with theme color
  TextStyle get buttonText => AppTypography.button.copyWith(color: textPrimary);
}

/// Spacing Quick Access Extension
extension ThemeSpacingExtension on BuildContext {
  /// Quick access to common gaps
  Widget get gapXs => AppSpacing.gapXs;
  Widget get gapSm => AppSpacing.gapSm;
  Widget get gapMd => AppSpacing.gapMd;
  Widget get gapLg => AppSpacing.gapLg;
  Widget get gapXl => AppSpacing.gapXl;
  Widget get gapXxl => AppSpacing.gapXxl;
  
  /// Quick access to spacing values
  double get spacingXs => AppSpacing.xs;
  double get spacingSm => AppSpacing.sm;
  double get spacingMd => AppSpacing.md;
  double get spacingLg => AppSpacing.lg;
  double get spacingXl => AppSpacing.xl;
  double get spacingXxl => AppSpacing.xxl;
}

/// Radius Quick Access Extension
extension ThemeRadiusExtension on BuildContext {
  /// Quick access to radius values
  double get radiusXs => AppRadius.xs;
  double get radiusSm => AppRadius.sm;
  double get radiusMd => AppRadius.md;
  double get radiusLg => AppRadius.lg;
  double get radiusXl => AppRadius.xl;
  double get radiusCard => AppRadius.card;
  double get radiusModal => AppRadius.modal;
  double get radiusFull => AppRadius.full;
}

/// Shadows Quick Access Extension
extension ThemeShadowsExtension on BuildContext {
  /// Get theme-appropriate card shadow
  List<BoxShadow> get cardShadow => isDarkMode 
      ? AppShadows.card 
      : AppShadows.sm;
  
  /// Get theme-appropriate elevation shadow
  List<BoxShadow> get elevatedShadow => isDarkMode 
      ? AppShadows.lg 
      : AppShadows.md;
}

/// Decoration Builder Extension
extension ThemeDecorationExtension on BuildContext {
  /// Build a theme-aware card decoration
  BoxDecoration cardDecoration({
    Color? color,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? containerColor,
      borderRadius: borderRadius ?? AppRadius.cardDefault,
      border: border ?? Border.all(color: borderSubtle),
      boxShadow: boxShadow ?? cardShadow,
    );
  }
  
  /// Build a theme-aware surface decoration
  BoxDecoration surfaceDecoration({
    Color? color,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: color ?? surfaceColor,
      borderRadius: borderRadius ?? AppRadius.roundedLg,
    );
  }
  
  /// Build a theme-aware input decoration
  BoxDecoration inputDecoration({
    bool focused = false,
    bool error = false,
  }) {
    return BoxDecoration(
      color: inputBackground,
      borderRadius: AppRadius.input,
      border: Border.all(
        color: error 
            ? errorColor 
            : focused 
                ? borderFocused 
                : borderColor,
        width: focused || error ? 2 : 1,
      ),
    );
  }
}
