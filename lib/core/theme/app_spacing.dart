import 'package:flutter/material.dart';

/// Tinseltown IQ Spacing System
/// 
/// Centralized spacing definitions for consistent layout across the app.
/// Uses an 8-point grid system as the foundation.
class AppSpacing {
  AppSpacing._();

  // ═══════════════════════════════════════════════════════════════
  // Base Spacing Values (8-point grid)
  // ═══════════════════════════════════════════════════════════════
  
  /// 2px - Minimal spacing
  static const double xxs = 2.0;
  
  /// 4px - Extra small spacing
  static const double xs = 4.0;
  
  /// 8px - Small spacing
  static const double sm = 8.0;
  
  /// 12px - Small-medium spacing
  static const double md = 12.0;
  
  /// 16px - Medium spacing (default)
  static const double lg = 16.0;
  
  /// 20px - Medium-large spacing
  static const double xl = 20.0;
  
  /// 24px - Large spacing
  static const double xxl = 24.0;
  
  /// 32px - Extra large spacing
  static const double xxxl = 32.0;
  
  /// 40px - Section spacing
  static const double section = 40.0;
  
  /// 48px - Large section spacing
  static const double sectionLarge = 48.0;
  
  /// 64px - Page spacing
  static const double page = 64.0;

  // ═══════════════════════════════════════════════════════════════
  // Common EdgeInsets
  // ═══════════════════════════════════════════════════════════════
  
  /// No padding
  static const EdgeInsets zero = EdgeInsets.zero;
  
  /// All sides: 4px
  static const EdgeInsets allXs = EdgeInsets.all(xs);
  
  /// All sides: 8px
  static const EdgeInsets allSm = EdgeInsets.all(sm);
  
  /// All sides: 12px
  static const EdgeInsets allMd = EdgeInsets.all(md);
  
  /// All sides: 16px
  static const EdgeInsets allLg = EdgeInsets.all(lg);
  
  /// All sides: 20px
  static const EdgeInsets allXl = EdgeInsets.all(xl);
  
  /// All sides: 24px
  static const EdgeInsets allXxl = EdgeInsets.all(xxl);
  
  /// All sides: 32px
  static const EdgeInsets allXxxl = EdgeInsets.all(xxxl);

  // ═══════════════════════════════════════════════════════════════
  // Horizontal EdgeInsets
  // ═══════════════════════════════════════════════════════════════
  
  /// Horizontal: 8px
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  
  /// Horizontal: 12px
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  
  /// Horizontal: 16px
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  
  /// Horizontal: 20px
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);
  
  /// Horizontal: 24px
  static const EdgeInsets horizontalXxl = EdgeInsets.symmetric(horizontal: xxl);
  
  /// Horizontal: 32px
  static const EdgeInsets horizontalXxxl = EdgeInsets.symmetric(horizontal: xxxl);

  // ═══════════════════════════════════════════════════════════════
  // Vertical EdgeInsets
  // ═══════════════════════════════════════════════════════════════
  
  /// Vertical: 8px
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  
  /// Vertical: 12px
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  
  /// Vertical: 16px
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  
  /// Vertical: 20px
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);
  
  /// Vertical: 24px
  static const EdgeInsets verticalXxl = EdgeInsets.symmetric(vertical: xxl);

  // ═══════════════════════════════════════════════════════════════
  // Screen/Page EdgeInsets
  // ═══════════════════════════════════════════════════════════════
  
  /// Standard screen padding: horizontal 16px
  static const EdgeInsets screenHorizontal = EdgeInsets.symmetric(horizontal: lg);
  
  /// Standard screen padding: all 16px
  static const EdgeInsets screen = EdgeInsets.all(lg);
  
  /// Screen with extra top padding
  static const EdgeInsets screenWithTop = EdgeInsets.fromLTRB(lg, xxl, lg, lg);
  
  /// Screen with extra bottom padding (for FAB)
  static const EdgeInsets screenWithBottom = EdgeInsets.fromLTRB(lg, lg, lg, 80);

  // ═══════════════════════════════════════════════════════════════
  // Card/Container EdgeInsets
  // ═══════════════════════════════════════════════════════════════
  
  /// Card padding: 16px
  static const EdgeInsets card = EdgeInsets.all(lg);
  
  /// Card padding compact: 12px
  static const EdgeInsets cardCompact = EdgeInsets.all(md);
  
  /// Card padding large: 20px
  static const EdgeInsets cardLarge = EdgeInsets.all(xl);
  
  /// List item padding
  static const EdgeInsets listItem = EdgeInsets.symmetric(horizontal: lg, vertical: md);
  
  /// List item padding compact
  static const EdgeInsets listItemCompact = EdgeInsets.symmetric(horizontal: md, vertical: sm);

  // ═══════════════════════════════════════════════════════════════
  // Button EdgeInsets
  // ═══════════════════════════════════════════════════════════════
  
  /// Primary button padding
  static const EdgeInsets buttonPrimary = EdgeInsets.symmetric(horizontal: xxl, vertical: 14);
  
  /// Secondary button padding
  static const EdgeInsets buttonSecondary = EdgeInsets.symmetric(horizontal: lg, vertical: md);
  
  /// Small button padding
  static const EdgeInsets buttonSmall = EdgeInsets.symmetric(horizontal: md, vertical: sm);
  
  /// Icon button padding
  static const EdgeInsets buttonIcon = EdgeInsets.all(sm);

  // ═══════════════════════════════════════════════════════════════
  // Input Field EdgeInsets
  // ═══════════════════════════════════════════════════════════════
  
  /// Text field content padding
  static const EdgeInsets inputContent = EdgeInsets.symmetric(horizontal: lg, vertical: lg);
  
  /// Text field content padding compact
  static const EdgeInsets inputContentCompact = EdgeInsets.symmetric(horizontal: md, vertical: md);

  // ═══════════════════════════════════════════════════════════════
  // Gap Widgets (for use in Row/Column)
  // ═══════════════════════════════════════════════════════════════
  
  /// Vertical gap: 4px
  static const Widget gapXs = SizedBox(height: xs);
  
  /// Vertical gap: 8px
  static const Widget gapSm = SizedBox(height: sm);
  
  /// Vertical gap: 12px
  static const Widget gapMd = SizedBox(height: md);
  
  /// Vertical gap: 16px
  static const Widget gapLg = SizedBox(height: lg);
  
  /// Vertical gap: 20px
  static const Widget gapXl = SizedBox(height: xl);
  
  /// Vertical gap: 24px
  static const Widget gapXxl = SizedBox(height: xxl);
  
  /// Vertical gap: 32px
  static const Widget gapXxxl = SizedBox(height: xxxl);

  /// Horizontal gap: 4px
  static const Widget hGapXs = SizedBox(width: xs);
  
  /// Horizontal gap: 8px
  static const Widget hGapSm = SizedBox(width: sm);
  
  /// Horizontal gap: 12px
  static const Widget hGapMd = SizedBox(width: md);
  
  /// Horizontal gap: 16px
  static const Widget hGapLg = SizedBox(width: lg);
  
  /// Horizontal gap: 20px
  static const Widget hGapXl = SizedBox(width: xl);
  
  /// Horizontal gap: 24px
  static const Widget hGapXxl = SizedBox(width: xxl);
}
