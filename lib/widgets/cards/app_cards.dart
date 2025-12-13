// App Cards - Reusable Card Components
//
// Provides a comprehensive suite of themed card widgets to standardize
// the 725+ Container/BoxDecoration patterns throughout the app.
// Follows the Tinseltown IQ cinematic design system.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';

// ═══════════════════════════════════════════════════════════════
// CARD VARIANTS ENUM
// ═══════════════════════════════════════════════════════════════

/// Card style variants
enum AppCardVariant {
  /// Standard surface card with subtle elevation
  surface,
  
  /// Elevated card with prominent shadow
  elevated,
  
  /// Outlined card with border
  outlined,
  
  /// Filled card with solid background
  filled,
  
  /// Premium gold-accented card
  premium,
  
  /// Transparent card with blur effect (glass morphism)
  glass,
}

/// Card size presets
enum AppCardSize {
  /// Small card - compact padding
  small,
  
  /// Medium card - standard padding
  medium,
  
  /// Large card - generous padding
  large,
}

// ═══════════════════════════════════════════════════════════════
// BASE APP CARD
// ═══════════════════════════════════════════════════════════════

/// Base card widget with consistent theming
class AppCard extends StatelessWidget {
  final Widget child;
  final AppCardVariant variant;
  final AppCardSize size;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Clip clipBehavior;
  final Gradient? gradient;

  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.surface,
    this.size = AppCardSize.medium,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
    this.boxShadow,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.constraints,
    this.clipBehavior = Clip.antiAlias,
    this.gradient,
  });

  /// Factory constructor for surface card
  factory AppCard.surface({
    Key? key,
    required Widget child,
    AppCardSize size = AppCardSize.medium,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) {
    return AppCard(
      key: key,
      variant: AppCardVariant.surface,
      size: size,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      child: child,
    );
  }

  /// Factory constructor for elevated card
  factory AppCard.elevated({
    Key? key,
    required Widget child,
    AppCardSize size = AppCardSize.medium,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) {
    return AppCard(
      key: key,
      variant: AppCardVariant.elevated,
      size: size,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      child: child,
    );
  }

  /// Factory constructor for outlined card
  factory AppCard.outlined({
    Key? key,
    required Widget child,
    Color? borderColor,
    AppCardSize size = AppCardSize.medium,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) {
    return AppCard(
      key: key,
      variant: AppCardVariant.outlined,
      borderColor: borderColor,
      size: size,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      child: child,
    );
  }

  /// Factory constructor for premium gold card
  factory AppCard.premium({
    Key? key,
    required Widget child,
    AppCardSize size = AppCardSize.medium,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    VoidCallback? onTap,
    double? width,
    double? height,
  }) {
    return AppCard(
      key: key,
      variant: AppCardVariant.premium,
      size: size,
      padding: padding,
      margin: margin,
      onTap: onTap,
      width: width,
      height: height,
      child: child,
    );
  }

  EdgeInsetsGeometry get _defaultPadding {
    switch (size) {
      case AppCardSize.small:
        return const EdgeInsets.all(AppSpacing.sm);
      case AppCardSize.medium:
        return const EdgeInsets.all(AppSpacing.md);
      case AppCardSize.large:
        return const EdgeInsets.all(AppSpacing.lg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Determine colors based on variant and theme
    Color effectiveBackground;
    Color? effectiveBorder;
    List<BoxShadow>? effectiveShadow;
    
    switch (variant) {
      case AppCardVariant.surface:
        effectiveBackground = backgroundColor ?? 
            (isDark ? AppColors.editingBay : AppColors.lightSurface);
        effectiveShadow = boxShadow ?? AppShadows.card;
        break;
        
      case AppCardVariant.elevated:
        effectiveBackground = backgroundColor ?? 
            (isDark ? AppColors.editingBay : AppColors.lightSurface);
        effectiveShadow = boxShadow ?? AppShadows.lg;
        break;
        
      case AppCardVariant.outlined:
        effectiveBackground = backgroundColor ?? 
            (isDark ? AppColors.soundstageDark : AppColors.lightSurface);
        effectiveBorder = borderColor ?? 
            (isDark ? AppColors.backstage : AppColors.lightBorder);
        break;
        
      case AppCardVariant.filled:
        effectiveBackground = backgroundColor ?? 
            (isDark ? AppColors.screeningRoom : AppColors.lightCard);
        break;
        
      case AppCardVariant.premium:
        effectiveBackground = backgroundColor ?? 
            (isDark ? AppColors.soundstageDark : AppColors.lightSurface);
        effectiveBorder = AppColors.oscarGold.withValues(alpha: 0.5);
        effectiveShadow = boxShadow ?? [
          BoxShadow(
            color: AppColors.oscarGold.withValues(alpha: 0.15),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ];
        break;
        
      case AppCardVariant.glass:
        effectiveBackground = (isDark ? AppColors.editingBay : AppColors.lightSurface)
            .withValues(alpha: 0.7);
        effectiveBorder = (isDark ? AppColors.backstage : AppColors.lightBorder)
            .withValues(alpha: 0.3);
        break;
    }

    Widget cardContent = Container(
      width: width,
      height: height,
      constraints: constraints,
      padding: padding ?? _defaultPadding,
      margin: margin,
      decoration: BoxDecoration(
        color: gradient == null ? effectiveBackground : null,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.card),
        border: effectiveBorder != null
            ? Border.all(
                color: effectiveBorder,
                width: borderWidth ?? 1,
              )
            : null,
        boxShadow: effectiveShadow,
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.card),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}

// ═══════════════════════════════════════════════════════════════
// INTERACTIVE CARD WITH PRESS ANIMATION
// ═══════════════════════════════════════════════════════════════

/// Card with press animation effect
class AppPressCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final Color? pressedColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double scaleFactor;
  final Duration animationDuration;

  const AppPressCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.pressedColor,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.scaleFactor = 0.98,
    this.animationDuration = const Duration(milliseconds: 100),
  });

  @override
  State<AppPressCard> createState() => _AppPressCardState();
}

class _AppPressCardState extends State<AppPressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleFactor).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null || widget.onLongPress != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = widget.backgroundColor ?? 
        (isDark ? AppColors.editingBay : AppColors.lightSurface);
    final pressedColor = widget.pressedColor ?? baseColor.withValues(alpha: 0.8);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onLongPress: widget.onLongPress,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: widget.animationDuration,
              padding: widget.padding ?? const EdgeInsets.all(AppSpacing.md),
              margin: widget.margin,
              decoration: BoxDecoration(
                color: _isPressed ? pressedColor : baseColor,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(AppRadius.lg),
                border: widget.border ?? Border.all(
                  color: _isPressed 
                      ? AppColors.oscarGold.withValues(alpha: 0.5) 
                      : (isDark ? AppColors.backstage : AppColors.lightBorder),
                ),
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// STAT CARD
// ═══════════════════════════════════════════════════════════════

/// Card for displaying statistics with icon and value
class AppStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;
  final Widget? iconWidget;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? valueColor;
  final VoidCallback? onTap;
  final String? subtitle;
  final Widget? trailing;
  final AppCardVariant variant;

  const AppStatCard({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.iconWidget,
    this.iconColor,
    this.backgroundColor,
    this.valueColor,
    this.onTap,
    this.subtitle,
    this.trailing,
    this.variant = AppCardVariant.surface,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveIconColor = iconColor ?? AppColors.oscarGold;

    return AppCard(
      variant: variant,
      backgroundColor: backgroundColor,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null || iconWidget != null)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: effectiveIconColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: iconWidget ?? Icon(
                    icon,
                    color: effectiveIconColor,
                    size: 20,
                  ),
                ),
              if (icon != null || iconWidget != null)
                const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDark ? AppColors.stageDirection : AppColors.lightTextTertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? (isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              subtitle!,
              style: TextStyle(
                color: isDark ? AppColors.fadeOut : AppColors.lightTextTertiary,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// LIST TILE CARD
// ═══════════════════════════════════════════════════════════════

/// Card styled list tile for settings, menus, etc.
class AppListTileCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final IconData? leadingIcon;
  final Color? leadingIconColor;
  final VoidCallback? onTap;
  final bool showDivider;
  final bool isFirst;
  final bool isLast;
  final AppCardVariant variant;

  const AppListTileCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.leadingIcon,
    this.leadingIconColor,
    this.onTap,
    this.showDivider = false,
    this.isFirst = true,
    this.isLast = true,
    this.variant = AppCardVariant.surface,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    BorderRadius? borderRadius;
    if (isFirst && isLast) {
      borderRadius = BorderRadius.circular(AppRadius.card);
    } else if (isFirst) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(AppRadius.card),
        topRight: Radius.circular(AppRadius.card),
      );
    } else if (isLast) {
      borderRadius = const BorderRadius.only(
        bottomLeft: Radius.circular(AppRadius.card),
        bottomRight: Radius.circular(AppRadius.card),
      );
    }

    return AppCard(
      variant: variant,
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                if (leading != null || leadingIcon != null) ...[
                  leading ?? Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: (leadingIconColor ?? AppColors.oscarGold).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(
                      leadingIcon,
                      color: leadingIconColor ?? AppColors.oscarGold,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            color: isDark ? AppColors.stageDirection : AppColors.lightTextTertiary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                trailing ?? Icon(
                  Icons.chevron_right,
                  color: isDark ? AppColors.fadeOut : AppColors.lightTextDisabled,
                ),
              ],
            ),
          ),
          if (showDivider && !isLast)
            Divider(
              height: 1,
              indent: leading != null || leadingIcon != null ? 56 : AppSpacing.md,
              color: isDark ? AppColors.backstage : AppColors.lightDivider,
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// FEATURE CARD
// ═══════════════════════════════════════════════════════════════

/// Card for showcasing features with icon and description
class AppFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final Widget? badge;
  final bool isPremium;

  const AppFeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.badge,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveIconColor = iconColor ?? AppColors.oscarGold;

    return AppCard(
      variant: isPremium ? AppCardVariant.premium : AppCardVariant.surface,
      backgroundColor: backgroundColor,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: effectiveIconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  icon,
                  color: effectiveIconColor,
                  size: 28,
                ),
              ),
              const Spacer(),
              if (badge != null) badge!,
              if (isPremium && badge == null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.oscarGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                  child: Text(
                    'PRO',
                    style: TextStyle(
                      color: AppColors.oscarGold,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: TextStyle(
              color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            description,
            style: TextStyle(
              color: isDark ? AppColors.stageDirection : AppColors.lightTextSecondary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// INFO CARD
// ═══════════════════════════════════════════════════════════════

/// Card type for info cards
enum AppInfoCardType {
  info,
  success,
  warning,
  error,
}

/// Card for displaying info, warnings, or alerts
class AppInfoCard extends StatelessWidget {
  final String message;
  final String? title;
  final AppInfoCardType type;
  final VoidCallback? onDismiss;
  final VoidCallback? onAction;
  final String? actionLabel;
  final IconData? customIcon;

  const AppInfoCard({
    super.key,
    required this.message,
    this.title,
    this.type = AppInfoCardType.info,
    this.onDismiss,
    this.onAction,
    this.actionLabel,
    this.customIcon,
  });

  factory AppInfoCard.success({
    Key? key,
    required String message,
    String? title,
    VoidCallback? onDismiss,
  }) {
    return AppInfoCard(
      key: key,
      message: message,
      title: title,
      type: AppInfoCardType.success,
      onDismiss: onDismiss,
    );
  }

  factory AppInfoCard.warning({
    Key? key,
    required String message,
    String? title,
    VoidCallback? onDismiss,
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    return AppInfoCard(
      key: key,
      message: message,
      title: title,
      type: AppInfoCardType.warning,
      onDismiss: onDismiss,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }

  factory AppInfoCard.error({
    Key? key,
    required String message,
    String? title,
    VoidCallback? onDismiss,
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    return AppInfoCard(
      key: key,
      message: message,
      title: title,
      type: AppInfoCardType.error,
      onDismiss: onDismiss,
      onAction: onAction,
      actionLabel: actionLabel,
    );
  }

  Color get _typeColor {
    switch (type) {
      case AppInfoCardType.info:
        return AppColors.rewriteBlue;
      case AppInfoCardType.success:
        return AppColors.greenlightNeon;
      case AppInfoCardType.warning:
        return AppColors.cautionAmber;
      case AppInfoCardType.error:
        return AppColors.cutRed;
    }
  }

  IconData get _typeIcon {
    switch (type) {
      case AppInfoCardType.info:
        return Icons.info_outline;
      case AppInfoCardType.success:
        return Icons.check_circle_outline;
      case AppInfoCardType.warning:
        return Icons.warning_amber_outlined;
      case AppInfoCardType.error:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: _typeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: _typeColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            customIcon ?? _typeIcon,
            color: _typeColor,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: TextStyle(
                      color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                ],
                Text(
                  message,
                  style: TextStyle(
                    color: isDark ? AppColors.dialogueSecondary : AppColors.lightTextSecondary,
                    fontSize: 14,
                  ),
                ),
                if (onAction != null && actionLabel != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  GestureDetector(
                    onTap: onAction,
                    child: Text(
                      actionLabel!,
                      style: TextStyle(
                        color: _typeColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(
                Icons.close,
                color: isDark ? AppColors.fadeOut : AppColors.lightTextTertiary,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SCORE CARD
// ═══════════════════════════════════════════════════════════════

/// Card for displaying scores (Greenlight IQ specific)
class AppScoreCard extends StatelessWidget {
  final int score;
  final String title;
  final String? subtitle;
  final double size;
  final VoidCallback? onTap;
  final bool showGlow;

  const AppScoreCard({
    super.key,
    required this.score,
    this.title = 'GreenlightIQ Score',
    this.subtitle,
    this.size = 120,
    this.onTap,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scoreColor = AppColors.getScoreColor(score);

    return AppCard(
      variant: AppCardVariant.elevated,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  scoreColor.withValues(alpha: 0.3),
                  scoreColor.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
              boxShadow: showGlow ? [
                BoxShadow(
                  color: scoreColor.withValues(alpha: 0.4),
                  blurRadius: 24,
                  spreadRadius: 0,
                ),
              ] : null,
            ),
            child: Center(
              child: Container(
                width: size * 0.8,
                height: size * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? AppColors.soundstageDark : AppColors.lightSurface,
                  border: Border.all(
                    color: scoreColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    score.toString(),
                    style: TextStyle(
                      color: scoreColor,
                      fontSize: size * 0.35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: TextStyle(
              color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              subtitle!,
              style: TextStyle(
                color: isDark ? AppColors.stageDirection : AppColors.lightTextTertiary,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SECTION HEADER CARD
// ═══════════════════════════════════════════════════════════════

/// Header card for sections
class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTrailingTap;
  final String? trailingText;
  final EdgeInsetsGeometry? padding;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTrailingTap,
    this.trailingText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: isDark ? AppColors.stageDirection : AppColors.lightTextTertiary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null)
            trailing!
          else if (trailingText != null || onTrailingTap != null)
            GestureDetector(
              onTap: onTrailingTap,
              child: Text(
                trailingText ?? 'See All',
                style: TextStyle(
                  color: AppColors.oscarGold,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// CONTEXT EXTENSIONS
// ═══════════════════════════════════════════════════════════════

/// Extension for easy card creation from context
extension AppCardContext on BuildContext {
  /// Get current brightness
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  
  /// Get surface card color
  Color get cardSurface => isDarkMode ? AppColors.editingBay : AppColors.lightSurface;
  
  /// Get elevated card color
  Color get cardElevated => isDarkMode ? AppColors.soundstageDark : AppColors.lightSurface;
  
  /// Get card border color
  Color get cardBorder => isDarkMode ? AppColors.backstage : AppColors.lightBorder;
}
