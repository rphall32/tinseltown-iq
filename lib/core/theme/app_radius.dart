import 'package:flutter/material.dart';

/// Tinseltown IQ Border Radius System
/// 
/// Centralized border radius definitions for consistent component styling.
class AppRadius {
  AppRadius._();

  // ═══════════════════════════════════════════════════════════════
  // Base Radius Values
  // ═══════════════════════════════════════════════════════════════
  
  /// 0px - No radius (sharp corners)
  static const double none = 0.0;
  
  /// 4px - Extra small radius
  static const double xs = 4.0;
  
  /// 8px - Small radius
  static const double sm = 8.0;
  
  /// 10px - Small-medium radius
  static const double md = 10.0;
  
  /// 12px - Medium radius
  static const double lg = 12.0;
  
  /// 16px - Large radius
  static const double xl = 16.0;
  
  /// 20px - Extra large radius
  static const double xxl = 20.0;
  
  /// 24px - Card radius
  static const double card = 24.0;
  
  /// 32px - Modal/sheet radius
  static const double modal = 32.0;
  
  /// 9999px - Full/pill radius
  static const double full = 9999.0;

  // ═══════════════════════════════════════════════════════════════
  // BorderRadius - All Corners
  // ═══════════════════════════════════════════════════════════════
  
  /// No radius
  static const BorderRadius roundedNone = BorderRadius.zero;
  
  /// All corners: 4px
  static const BorderRadius roundedXs = BorderRadius.all(Radius.circular(xs));
  
  /// All corners: 8px
  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(sm));
  
  /// All corners: 10px
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(md));
  
  /// All corners: 12px
  static const BorderRadius roundedLg = BorderRadius.all(Radius.circular(lg));
  
  /// All corners: 16px
  static const BorderRadius roundedXl = BorderRadius.all(Radius.circular(xl));
  
  /// All corners: 20px
  static const BorderRadius roundedXxl = BorderRadius.all(Radius.circular(xxl));
  
  /// All corners: 24px (card)
  static const BorderRadius roundedCard = BorderRadius.all(Radius.circular(card));
  
  /// All corners: 32px (modal)
  static const BorderRadius roundedModal = BorderRadius.all(Radius.circular(modal));
  
  /// Full/pill radius
  static const BorderRadius roundedFull = BorderRadius.all(Radius.circular(full));

  // ═══════════════════════════════════════════════════════════════
  // BorderRadius - Top Only (for bottom sheets, modals)
  // ═══════════════════════════════════════════════════════════════
  
  /// Top corners only: 16px
  static const BorderRadius topXl = BorderRadius.vertical(top: Radius.circular(xl));
  
  /// Top corners only: 20px
  static const BorderRadius topXxl = BorderRadius.vertical(top: Radius.circular(xxl));
  
  /// Top corners only: 24px
  static const BorderRadius topCard = BorderRadius.vertical(top: Radius.circular(card));
  
  /// Top corners only: 32px (modal)
  static const BorderRadius topModal = BorderRadius.vertical(top: Radius.circular(modal));

  // ═══════════════════════════════════════════════════════════════
  // BorderRadius - Bottom Only
  // ═══════════════════════════════════════════════════════════════
  
  /// Bottom corners only: 16px
  static const BorderRadius bottomXl = BorderRadius.vertical(bottom: Radius.circular(xl));
  
  /// Bottom corners only: 24px
  static const BorderRadius bottomCard = BorderRadius.vertical(bottom: Radius.circular(card));

  // ═══════════════════════════════════════════════════════════════
  // BorderRadius - Left/Right Only
  // ═══════════════════════════════════════════════════════════════
  
  /// Left corners only: 12px
  static const BorderRadius leftLg = BorderRadius.horizontal(left: Radius.circular(lg));
  
  /// Right corners only: 12px
  static const BorderRadius rightLg = BorderRadius.horizontal(right: Radius.circular(lg));

  // ═══════════════════════════════════════════════════════════════
  // Component-Specific Radii
  // ═══════════════════════════════════════════════════════════════
  
  /// Button radius
  static const BorderRadius button = roundedLg;
  
  /// Input field radius
  static const BorderRadius input = roundedLg;
  
  /// Chip/badge radius
  static const BorderRadius chip = roundedFull;
  
  /// Avatar radius (circular)
  static const BorderRadius avatar = roundedFull;
  
  /// Snackbar radius
  static const BorderRadius snackbar = roundedMd;
  
  /// Tooltip radius
  static const BorderRadius tooltip = roundedSm;
  
  /// Dialog radius
  static const BorderRadius dialog = roundedXxl;
  
  /// Bottom sheet radius
  static const BorderRadius bottomSheet = topCard;
  
  /// Card radius
  static const BorderRadius cardDefault = roundedXl;
  
  /// Image radius
  static const BorderRadius image = roundedLg;
  
  /// Progress bar radius
  static const BorderRadius progressBar = roundedFull;

  // ═══════════════════════════════════════════════════════════════
  // Shape Helpers
  // ═══════════════════════════════════════════════════════════════
  
  /// Create a RoundedRectangleBorder with custom radius
  static RoundedRectangleBorder shape(BorderRadius radius) {
    return RoundedRectangleBorder(borderRadius: radius);
  }
  
  /// Create a RoundedRectangleBorder with border
  static RoundedRectangleBorder shapeWithBorder(
    BorderRadius radius, {
    Color borderColor = Colors.transparent,
    double borderWidth = 1.0,
  }) {
    return RoundedRectangleBorder(
      borderRadius: radius,
      side: BorderSide(color: borderColor, width: borderWidth),
    );
  }

  /// Stadium border (fully rounded sides)
  static const StadiumBorder stadium = StadiumBorder();
  
  /// Circle shape
  static const CircleBorder circle = CircleBorder();
}
