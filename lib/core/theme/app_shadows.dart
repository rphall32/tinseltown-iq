import 'package:flutter/material.dart';

/// Tinseltown IQ Shadow System
/// 
/// Centralized shadow definitions for consistent elevation effects.
class AppShadows {
  AppShadows._();

  // ═══════════════════════════════════════════════════════════════
  // Shadow Colors
  // ═══════════════════════════════════════════════════════════════
  
  /// Default shadow color (dark mode optimized)
  static Color shadowDark = Colors.black.withValues(alpha: 0.3);
  
  /// Light shadow color
  static Color shadowLight = Colors.black.withValues(alpha: 0.1);
  
  /// Accent shadow color (gold glow)
  static const Color shadowGold = Color(0x40D4A84B);
  
  /// Success shadow color (green glow)
  static const Color shadowGreen = Color(0x4000E676);
  
  /// Error shadow color (red glow)
  static const Color shadowRed = Color(0x40FF5252);

  // ═══════════════════════════════════════════════════════════════
  // Elevation Shadows (Material-style)
  // ═══════════════════════════════════════════════════════════════
  
  /// No shadow
  static const List<BoxShadow> none = [];
  
  /// Subtle shadow - elevation 1
  static List<BoxShadow> get sm => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];
  
  /// Small shadow - elevation 2
  static List<BoxShadow> get md => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
  
  /// Medium shadow - elevation 4
  static List<BoxShadow> get lg => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  
  /// Large shadow - elevation 8
  static List<BoxShadow> get xl => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
  
  /// Extra large shadow - elevation 16
  static List<BoxShadow> get xxl => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 32,
      offset: const Offset(0, 16),
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // Card Shadows
  // ═══════════════════════════════════════════════════════════════
  
  /// Card shadow (default)
  static List<BoxShadow> get card => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
  
  /// Card shadow hover/pressed
  static List<BoxShadow> get cardHover => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
  
  /// Card shadow with gold accent
  static const List<BoxShadow> cardGold = [
    BoxShadow(
      color: shadowGold,
      blurRadius: 16,
      spreadRadius: 2,
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // Button Shadows
  // ═══════════════════════════════════════════════════════════════
  
  /// Primary button shadow
  static const List<BoxShadow> buttonPrimary = [
    BoxShadow(
      color: shadowGold,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];
  
  /// Button hover shadow
  static const List<BoxShadow> buttonHover = [
    BoxShadow(
      color: shadowGold,
      blurRadius: 20,
      offset: Offset(0, 6),
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // Glow Effects
  // ═══════════════════════════════════════════════════════════════
  
  /// Gold glow effect
  static const List<BoxShadow> glowGold = [
    BoxShadow(
      color: shadowGold,
      blurRadius: 20,
      spreadRadius: 4,
    ),
  ];
  
  /// Green glow effect (success/high score)
  static const List<BoxShadow> glowGreen = [
    BoxShadow(
      color: shadowGreen,
      blurRadius: 20,
      spreadRadius: 4,
    ),
  ];
  
  /// Red glow effect (error/low score)
  static const List<BoxShadow> glowRed = [
    BoxShadow(
      color: shadowRed,
      blurRadius: 20,
      spreadRadius: 4,
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // Modal/Overlay Shadows
  // ═══════════════════════════════════════════════════════════════
  
  /// Bottom sheet shadow
  static List<BoxShadow> get bottomSheet => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 24,
      offset: const Offset(0, -8),
    ),
  ];
  
  /// Dialog shadow
  static List<BoxShadow> get dialog => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 32,
      offset: const Offset(0, 12),
    ),
  ];
  
  /// Dropdown shadow
  static List<BoxShadow> get dropdown => [
    BoxShadow(
      color: shadowDark,
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  // ═══════════════════════════════════════════════════════════════
  // Inner Shadows (using gradient)
  // ═══════════════════════════════════════════════════════════════
  
  /// Inner shadow decoration (top)
  static BoxDecoration innerShadowTop({Color? color}) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          (color ?? Colors.black).withValues(alpha: 0.1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3],
      ),
    );
  }
  
  /// Inner shadow decoration (bottom)
  static BoxDecoration innerShadowBottom({Color? color}) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          (color ?? Colors.black).withValues(alpha: 0.1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Helper Methods
  // ═══════════════════════════════════════════════════════════════
  
  /// Create a custom shadow
  static List<BoxShadow> custom({
    Color? color,
    double blurRadius = 10,
    double spreadRadius = 0,
    Offset offset = const Offset(0, 4),
  }) {
    return [
      BoxShadow(
        color: color ?? shadowDark,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        offset: offset,
      ),
    ];
  }
  
  /// Create score-based glow
  static List<BoxShadow> scoreGlow(int score) {
    if (score >= 80) return glowGreen;
    if (score >= 60) return glowGold;
    return glowRed;
  }
}
