// App Buttons - Reusable Button Components
//
// Provides a comprehensive suite of themed button widgets to standardize
// the 50+ button patterns and eliminate 5+ duplicate button builder methods.
// Integrates with loading_widgets.dart for consistent loading states.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
// app_spacing.dart available for future use
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';

// ═══════════════════════════════════════════════════════════════
// BUTTON VARIANTS & SIZES
// ═══════════════════════════════════════════════════════════════

/// Button style variants
enum AppButtonVariant {
  /// Primary filled button with gradient (gold)
  primary,
  
  /// Secondary outlined button
  secondary,
  
  /// Tertiary text button
  tertiary,
  
  /// Filled button with solid color
  filled,
  
  /// Outlined button
  outlined,
  
  /// Text only button
  text,
  
  /// Danger/destructive button (red)
  danger,
  
  /// Success button (green)
  success,
}

/// Button size presets
enum AppButtonSize {
  /// Small button - compact
  small,
  
  /// Medium button - standard
  medium,
  
  /// Large button - prominent
  large,
}

// ═══════════════════════════════════════════════════════════════
// BASE APP BUTTON
// ═══════════════════════════════════════════════════════════════

/// Themed button with consistent styling
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final IconData? trailingIcon;
  final Color? color;
  final Color? textColor;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool expanded;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.trailingIcon,
    this.color,
    this.textColor,
    this.width,
    this.borderRadius,
    this.padding,
    this.expanded = false,
  });

  /// Primary gold gradient button
  factory AppButton.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    double? width,
    bool expanded = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.primary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      width: width,
      expanded: expanded,
    );
  }

  /// Secondary outlined button
  factory AppButton.secondary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    double? width,
    bool expanded = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.secondary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      width: width,
      expanded: expanded,
    );
  }

  /// Text button (tertiary)
  factory AppButton.text({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    Color? color,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.text,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      color: color,
    );
  }

  /// Danger/destructive button
  factory AppButton.danger({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    double? width,
    bool expanded = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.danger,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      width: width,
      expanded: expanded,
    );
  }

  /// Success button
  factory AppButton.success({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    IconData? icon,
    double? width,
    bool expanded = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: AppButtonVariant.success,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      icon: icon,
      width: width,
      expanded: expanded,
    );
  }

  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return 40;
      case AppButtonSize.medium:
        return 52;
      case AppButtonSize.large:
        return 60;
    }
  }

  double get _fontSize {
    switch (size) {
      case AppButtonSize.small:
        return 14;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 18;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.small:
        return 18;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  EdgeInsetsGeometry get _defaultPadding {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEnabled = onPressed != null && !isLoading && !isDisabled;

    // Determine colors based on variant
    Color bgColor;
    Color fgColor;
    Color? borderColor;
    Gradient? gradient;
    List<BoxShadow>? shadow;

    switch (variant) {
      case AppButtonVariant.primary:
        gradient = isEnabled
            ? LinearGradient(
                colors: [
                  color ?? AppColors.oscarGold,
                  color ?? AppColors.antiqueGold,
                ],
              )
            : null;
        bgColor = isEnabled 
            ? (color ?? AppColors.oscarGold) 
            : (isDark ? AppColors.backstage : AppColors.lightBorder);
        fgColor = textColor ?? AppColors.midnightPremiere;
        shadow = isEnabled ? [
          BoxShadow(
            color: (color ?? AppColors.oscarGold).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ] : null;
        break;

      case AppButtonVariant.secondary:
      case AppButtonVariant.outlined:
        bgColor = Colors.transparent;
        borderColor = isEnabled 
            ? (color ?? AppColors.stageDirection) 
            : (isDark ? AppColors.backstage : AppColors.lightBorder);
        fgColor = textColor ?? (isEnabled 
            ? (color ?? AppColors.stageDirection) 
            : (isDark ? AppColors.fadeOut : AppColors.lightTextDisabled));
        break;

      case AppButtonVariant.tertiary:
      case AppButtonVariant.text:
        bgColor = Colors.transparent;
        fgColor = textColor ?? (isEnabled 
            ? (color ?? AppColors.oscarGold) 
            : (isDark ? AppColors.fadeOut : AppColors.lightTextDisabled));
        break;

      case AppButtonVariant.filled:
        bgColor = isEnabled 
            ? (color ?? (isDark ? AppColors.editingBay : AppColors.lightCard))
            : (isDark ? AppColors.backstage : AppColors.lightBorder);
        fgColor = textColor ?? (isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary);
        borderColor = isDark ? AppColors.backstage : AppColors.lightBorder;
        break;

      case AppButtonVariant.danger:
        bgColor = isEnabled ? AppColors.cutRed : (isDark ? AppColors.backstage : AppColors.lightBorder);
        fgColor = textColor ?? Colors.white;
        shadow = isEnabled ? [
          BoxShadow(
            color: AppColors.cutRed.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ] : null;
        break;

      case AppButtonVariant.success:
        bgColor = isEnabled ? AppColors.greenlightNeon : (isDark ? AppColors.backstage : AppColors.lightBorder);
        fgColor = textColor ?? AppColors.midnightPremiere;
        shadow = isEnabled ? [
          BoxShadow(
            color: AppColors.greenlightNeon.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ] : null;
        break;
    }

    Widget buttonContent = Row(
      mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation(fgColor),
            ),
          ),
          const SizedBox(width: 12),
        ] else if (icon != null) ...[
          Icon(icon, color: fgColor, size: _iconSize),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: fgColor,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (trailingIcon != null && !isLoading) ...[
          const SizedBox(width: 8),
          Icon(trailingIcon, color: fgColor, size: _iconSize),
        ],
      ],
    );

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: expanded ? double.infinity : width,
        height: _height,
        padding: padding ?? _defaultPadding,
        decoration: BoxDecoration(
          color: gradient == null ? bgColor : null,
          gradient: gradient,
          borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.lg),
          border: borderColor != null 
              ? Border.all(color: borderColor, width: 1.5)
              : null,
          boxShadow: shadow,
        ),
        child: Center(child: buttonContent),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// ICON BUTTON
// ═══════════════════════════════════════════════════════════════

/// Themed icon button
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;
  final bool isLoading;
  final int? badgeCount;
  final bool showBadge;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.variant = AppButtonVariant.tertiary,
    this.size = AppButtonSize.medium,
    this.color,
    this.backgroundColor,
    this.tooltip,
    this.isLoading = false,
    this.badgeCount,
    this.showBadge = false,
  });

  double get _size {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.small:
        return 18;
      case AppButtonSize.medium:
        return 22;
      case AppButtonSize.large:
        return 26;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEnabled = onPressed != null && !isLoading;

    Color effectiveColor;
    Color? effectiveBgColor;
    Color? borderColor;

    switch (variant) {
      case AppButtonVariant.primary:
        effectiveBgColor = color ?? AppColors.oscarGold;
        effectiveColor = AppColors.midnightPremiere;
        break;
      case AppButtonVariant.secondary:
      case AppButtonVariant.outlined:
        effectiveBgColor = Colors.transparent;
        borderColor = color ?? (isDark ? AppColors.backstage : AppColors.lightBorder);
        effectiveColor = color ?? (isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary);
        break;
      case AppButtonVariant.filled:
        effectiveBgColor = backgroundColor ?? (isDark ? AppColors.editingBay : AppColors.lightCard);
        effectiveColor = color ?? (isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary);
        break;
      default:
        effectiveBgColor = backgroundColor;
        effectiveColor = color ?? (isDark ? AppColors.stageDirection : AppColors.lightTextTertiary);
    }

    if (!isEnabled) {
      effectiveColor = isDark ? AppColors.fadeOut : AppColors.lightTextDisabled;
    }

    Widget button = Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Center(
        child: isLoading
            ? SizedBox(
                width: _iconSize,
                height: _iconSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(effectiveColor),
                ),
              )
            : Icon(icon, color: effectiveColor, size: _iconSize),
      ),
    );

    // Add badge if needed
    if (showBadge || badgeCount != null) {
      button = Stack(
        clipBehavior: Clip.none,
        children: [
          button,
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: badgeCount != null 
                  ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
                  : const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.cutRed,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: badgeCount != null
                  ? Text(
                      badgeCount! > 99 ? '99+' : badgeCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : null,
            ),
          ),
        ],
      );
    }

    Widget result = GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: button,
    );

    if (tooltip != null) {
      result = Tooltip(message: tooltip!, child: result);
    }

    return result;
  }
}

// ═══════════════════════════════════════════════════════════════
// SOCIAL/OAUTH BUTTON
// ═══════════════════════════════════════════════════════════════

/// Social login button (Google, Apple, etc.)
class AppSocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;
  final AppButtonSize size;

  const AppSocialButton({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.iconColor,
    this.backgroundColor,
    this.textColor,
    this.size = AppButtonSize.medium,
  });

  /// Google sign-in button
  factory AppSocialButton.google({
    Key? key,
    VoidCallback? onPressed,
    bool isLoading = false,
    AppButtonSize size = AppButtonSize.medium,
  }) {
    return AppSocialButton(
      key: key,
      icon: Icons.g_mobiledata,
      text: 'Continue with Google',
      onPressed: onPressed,
      isLoading: isLoading,
      size: size,
    );
  }

  /// Apple sign-in button
  factory AppSocialButton.apple({
    Key? key,
    VoidCallback? onPressed,
    bool isLoading = false,
    AppButtonSize size = AppButtonSize.medium,
  }) {
    return AppSocialButton(
      key: key,
      icon: Icons.apple,
      text: 'Continue with Apple',
      onPressed: onPressed,
      isLoading: isLoading,
      size: size,
    );
  }

  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return 44;
      case AppButtonSize.medium:
        return 56;
      case AppButtonSize.large:
        return 64;
    }
  }

  double get _fontSize {
    switch (size) {
      case AppButtonSize.small:
        return 14;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 18;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEnabled = onPressed != null && !isLoading;

    final effectiveBgColor = backgroundColor ?? 
        (isDark ? AppColors.editingBay : AppColors.lightSurface);
    final effectiveTextColor = textColor ?? 
        (isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary);
    final effectiveIconColor = iconColor ?? effectiveTextColor;
    final borderColor = isDark ? AppColors.backstage : AppColors.lightBorder;

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: _height,
        decoration: BoxDecoration(
          color: isLoading 
              ? effectiveBgColor.withValues(alpha: 0.7) 
              : effectiveBgColor,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: isLoading 
                ? AppColors.oscarGold.withValues(alpha: 0.5) 
                : borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(AppColors.oscarGold),
                ),
              )
            else
              Icon(icon, color: effectiveIconColor, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: isLoading ? AppColors.oscarGold : effectiveTextColor,
                fontSize: _fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// FLOATING ACTION BUTTON
// ═══════════════════════════════════════════════════════════════

/// Themed floating action button
class AppFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;
  final bool isExtended;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isLoading;
  final String? tooltip;
  final AppButtonSize size;

  const AppFloatingButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
    this.isExtended = false,
    this.backgroundColor,
    this.foregroundColor,
    this.isLoading = false,
    this.tooltip,
    this.size = AppButtonSize.medium,
  });

  factory AppFloatingButton.extended({
    Key? key,
    required IconData icon,
    required String label,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool isLoading = false,
    String? tooltip,
  }) {
    return AppFloatingButton(
      key: key,
      icon: icon,
      label: label,
      onPressed: onPressed,
      isExtended: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      isLoading: isLoading,
      tooltip: tooltip,
    );
  }

  double get _size {
    switch (size) {
      case AppButtonSize.small:
        return 48;
      case AppButtonSize.medium:
        return 56;
      case AppButtonSize.large:
        return 64;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBgColor = backgroundColor ?? AppColors.oscarGold;
    final effectiveFgColor = foregroundColor ?? AppColors.midnightPremiere;
    final isEnabled = onPressed != null && !isLoading;

    Widget button;

    if (isExtended && label != null) {
      button = Container(
        height: _size,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isEnabled ? effectiveBgColor : effectiveBgColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(_size / 2),
          boxShadow: isEnabled ? AppShadows.buttonPrimary : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(effectiveFgColor),
                ),
              )
            else
              Icon(icon, color: effectiveFgColor, size: 24),
            const SizedBox(width: 12),
            Text(
              label!,
              style: TextStyle(
                color: effectiveFgColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      button = Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: isEnabled ? effectiveBgColor : effectiveBgColor.withValues(alpha: 0.5),
          shape: BoxShape.circle,
          boxShadow: isEnabled ? AppShadows.buttonPrimary : null,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation(effectiveFgColor),
                  ),
                )
              : Icon(icon, color: effectiveFgColor, size: 28),
        ),
      );
    }

    Widget result = GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: button,
    );

    if (tooltip != null) {
      result = Tooltip(message: tooltip!, child: result);
    }

    return result;
  }
}

// ═══════════════════════════════════════════════════════════════
// TOGGLE BUTTON GROUP
// ═══════════════════════════════════════════════════════════════

/// Toggle button group for selection
class AppToggleButtonGroup<T> extends StatelessWidget {
  final List<T> items;
  final T? selected;
  final void Function(T)? onSelected;
  final String Function(T) labelBuilder;
  final IconData Function(T)? iconBuilder;
  final bool allowDeselect;
  final Axis direction;
  final double spacing;

  const AppToggleButtonGroup({
    super.key,
    required this.items,
    this.selected,
    this.onSelected,
    required this.labelBuilder,
    this.iconBuilder,
    this.allowDeselect = false,
    this.direction = Axis.horizontal,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List<Widget> buttons = items.map((item) {
      final isSelected = item == selected;
      final bgColor = isSelected 
          ? AppColors.oscarGold.withValues(alpha: 0.2)
          : (isDark ? AppColors.editingBay : AppColors.lightSurface);
      final borderColor = isSelected 
          ? AppColors.oscarGold
          : (isDark ? AppColors.backstage : AppColors.lightBorder);
      final textColor = isSelected 
          ? AppColors.oscarGold
          : (isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary);

      return GestureDetector(
        onTap: () {
          if (allowDeselect && isSelected) {
            // Deselect not handled here - parent should manage null state
          } else {
            onSelected?.call(item);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconBuilder != null) ...[
                Icon(iconBuilder!(item), color: textColor, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                labelBuilder(item),
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    if (direction == Axis.horizontal) {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: buttons,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons
            .expand((btn) => [btn, SizedBox(height: spacing)])
            .take(buttons.length * 2 - 1)
            .toList(),
      );
    }
  }
}

// ═══════════════════════════════════════════════════════════════
// CHIP BUTTON
// ═══════════════════════════════════════════════════════════════

/// Chip-style button for tags and filters
class AppChipButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final VoidCallback? onDelete;
  final IconData? icon;
  final bool isSelected;
  final bool isDisabled;
  final Color? selectedColor;

  const AppChipButton({
    super.key,
    required this.label,
    this.onPressed,
    this.onDelete,
    this.icon,
    this.isSelected = false,
    this.isDisabled = false,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = selectedColor ?? AppColors.oscarGold;
    
    final bgColor = isSelected 
        ? color.withValues(alpha: 0.2)
        : (isDark ? AppColors.editingBay : AppColors.lightSurface);
    final borderColor = isSelected 
        ? color
        : (isDark ? AppColors.backstage : AppColors.lightBorder);
    final textColor = isSelected 
        ? color
        : (isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary);

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDisabled ? bgColor.withValues(alpha: 0.5) : bgColor,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 16),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close,
                  color: textColor.withValues(alpha: 0.7),
                  size: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// CONTEXT EXTENSIONS
// ═══════════════════════════════════════════════════════════════

/// Extension methods for easy button creation
extension AppButtonContext on BuildContext {
  /// Show a primary button style snackbar action
  SnackBarAction primaryAction(String label, VoidCallback onPressed) {
    return SnackBarAction(
      label: label,
      textColor: AppColors.oscarGold,
      onPressed: onPressed,
    );
  }
}
