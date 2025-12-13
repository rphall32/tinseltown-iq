import 'package:flutter/material.dart';

/// Accessibility utilities for Tinseltown IQ
/// 
/// Provides consistent accessibility labels and semantic wrappers.
class A11y {
  A11y._();

  // ═══════════════════════════════════════════════════════════════
  // Score Semantics
  // ═══════════════════════════════════════════════════════════════

  /// Generate semantic label for GreenlightIQ score
  static String scoreLabel(int score, String verdict) {
    final quality = _getScoreQuality(score);
    return 'GreenlightIQ Score: $score out of 100. $quality. Verdict: $verdict';
  }

  static String _getScoreQuality(int score) {
    if (score >= 80) return 'Excellent score';
    if (score >= 60) return 'Good score';
    if (score >= 40) return 'Fair score';
    return 'Low score';
  }

  /// Generate semantic label for score change
  static String scoreChangeLabel(int? change) {
    if (change == null) return 'No previous score to compare';
    if (change > 0) return 'Score improved by $change points';
    if (change < 0) return 'Score decreased by ${change.abs()} points';
    return 'Score unchanged';
  }

  // ═══════════════════════════════════════════════════════════════
  // Navigation Semantics
  // ═══════════════════════════════════════════════════════════════

  /// Tab bar item label
  static String tabLabel(String name, bool isSelected, int index, int total) {
    return '$name tab, ${isSelected ? 'selected' : 'not selected'}, ${index + 1} of $total';
  }

  /// Navigation item label
  static String navItemLabel(String name, bool isSelected) {
    return '$name, ${isSelected ? 'currently selected' : 'tap to navigate'}';
  }

  // ═══════════════════════════════════════════════════════════════
  // Button Semantics
  // ═══════════════════════════════════════════════════════════════

  /// Primary action button label
  static String buttonLabel(String action, {String? hint}) {
    return hint != null ? '$action. $hint' : action;
  }

  /// Toggle button label
  static String toggleLabel(String name, bool isEnabled) {
    return '$name, ${isEnabled ? 'enabled' : 'disabled'}. Double tap to toggle';
  }

  // ═══════════════════════════════════════════════════════════════
  // List Item Semantics
  // ═══════════════════════════════════════════════════════════════

  /// Project list item label
  static String projectItemLabel({
    required String title,
    required int score,
    required String verdict,
    required String genre,
    required String timeAgo,
    required bool isFavorite,
  }) {
    final favoriteStatus = isFavorite ? ', marked as favorite' : '';
    return 'Project: $title. Score: $score. $verdict. Genre: $genre. Analyzed $timeAgo$favoriteStatus. Double tap to view details. Swipe to delete.';
  }

  /// Buyer match item label
  static String buyerItemLabel({
    required String name,
    required String type,
    required int matchPercent,
    required String lookingFor,
  }) {
    return '$name, $type. $matchPercent percent match. Looking for: $lookingFor';
  }

  /// Producer match item label
  static String producerItemLabel({
    required String name,
    required String company,
    required int matchPercent,
    required String specialty,
  }) {
    return '$name at $company. $matchPercent percent match. Specialty: $specialty';
  }

  // ═══════════════════════════════════════════════════════════════
  // Form Field Semantics
  // ═══════════════════════════════════════════════════════════════

  /// Text field label with validation status
  static String textFieldLabel(String name, {String? error, bool isRequired = false}) {
    final requiredText = isRequired ? 'required field' : '';
    final errorText = error != null ? '. Error: $error' : '';
    return '$name$requiredText$errorText';
  }

  /// Dropdown label
  static String dropdownLabel(String name, String? selectedValue) {
    final selected = selectedValue ?? 'not selected';
    return '$name dropdown, current value: $selected. Double tap to open options';
  }

  // ═══════════════════════════════════════════════════════════════
  // Status Semantics
  // ═══════════════════════════════════════════════════════════════

  /// Loading status
  static const String loading = 'Loading, please wait';
  
  /// Success status
  static String success(String action) => '$action completed successfully';
  
  /// Error status
  static String error(String message) => 'Error: $message';

  /// Network status
  static String networkStatus(bool isOnline) {
    return isOnline ? 'Connected to network' : 'No network connection. Working offline';
  }

  // ═══════════════════════════════════════════════════════════════
  // Subscription Semantics
  // ═══════════════════════════════════════════════════════════════

  /// Plan card label
  static String planCardLabel({
    required String planName,
    required String price,
    required bool isCurrentPlan,
    required List<String> features,
  }) {
    final status = isCurrentPlan ? 'This is your current plan' : 'Available plan';
    final featureList = features.join(', ');
    return '$planName plan, $price. $status. Features: $featureList';
  }

  /// Scan usage label
  static String scanUsageLabel(int used, int total, {bool isUnlimited = false}) {
    if (isUnlimited) return 'Unlimited scans available';
    final remaining = total - used;
    return '$used of $total scans used this month. $remaining remaining';
  }
}

/// Semantic wrapper widget for accessibility
class SemanticWrapper extends StatelessWidget {
  final Widget child;
  final String label;
  final String? hint;
  final bool isButton;
  final bool isHeader;
  final bool isImage;
  final bool excludeSemantics;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const SemanticWrapper({
    super.key,
    required this.child,
    required this.label,
    this.hint,
    this.isButton = false,
    this.isHeader = false,
    this.isImage = false,
    this.excludeSemantics = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint,
      button: isButton,
      header: isHeader,
      image: isImage,
      excludeSemantics: excludeSemantics,
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }
}

/// Accessible score display widget
class AccessibleScoreDisplay extends StatelessWidget {
  final int score;
  final String verdict;
  final Widget child;

  const AccessibleScoreDisplay({
    super.key,
    required this.score,
    required this.verdict,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: A11y.scoreLabel(score, verdict),
      excludeSemantics: true,
      child: child,
    );
  }
}

/// Accessible button with proper semantics
class AccessibleButton extends StatelessWidget {
  final Widget child;
  final String label;
  final String? hint;
  final VoidCallback? onPressed;
  final bool enabled;

  const AccessibleButton({
    super.key,
    required this.child,
    required this.label,
    this.hint,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint ?? (enabled ? 'Double tap to activate' : 'Button disabled'),
      button: true,
      enabled: enabled,
      child: child,
    );
  }
}
