// App SnackBar - Consistent Notification System
//
// Provides themed, accessible snackbars and toasts throughout the app.
// Uses the Tinseltown IQ cinematic design language.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

/// Snackbar type determines the color scheme and icon
enum SnackBarType {
  info,
  success,
  warning,
  error,
}

/// App-wide snackbar utility class
class AppSnackBar {
  AppSnackBar._();

  /// Show a generic snackbar
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    bool floating = true,
    IconData? icon,
  }) {
    final snackBar = SnackBar(
      content: _SnackBarContent(
        message: message,
        type: type,
        icon: icon,
      ),
      backgroundColor: _getBackgroundColor(type),
      behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      margin: floating 
          ? const EdgeInsets.all(AppSpacing.lg) 
          : null,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      duration: duration,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: _getActionColor(type),
              onPressed: onAction ?? () {},
            )
          : null,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Show an info snackbar
  static void info(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.info,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  /// Show a success snackbar
  static void success(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.success,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  /// Show a warning snackbar
  static void warning(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.warning,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  /// Show an error snackbar
  static void error(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 5),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.error,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
    );
  }

  /// Show a snackbar with undo action
  static void withUndo(
    BuildContext context, {
    required String message,
    required VoidCallback onUndo,
    Duration duration = const Duration(seconds: 5),
    SnackBarType type = SnackBarType.info,
  }) {
    show(
      context,
      message: message,
      type: type,
      actionLabel: 'Undo',
      onAction: onUndo,
      duration: duration,
    );
  }

  /// Show a loading snackbar (persists until dismissed)
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> loading(
    BuildContext context, {
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.oscarGold),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.scriptPrimary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.soundstageDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      margin: const EdgeInsets.all(AppSpacing.lg),
      duration: const Duration(days: 1), // Effectively infinite
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Hide current snackbar
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Clear all snackbars
  static void clearAll(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.info:
        return AppColors.soundstageDark;
      case SnackBarType.success:
        return AppColors.greenlightNeon.withValues(alpha: 0.15);
      case SnackBarType.warning:
        return AppColors.champagneGold.withValues(alpha: 0.15);
      case SnackBarType.error:
        return AppColors.cutRed.withValues(alpha: 0.15);
    }
  }

  static Color _getActionColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.info:
        return AppColors.oscarGold;
      case SnackBarType.success:
        return AppColors.greenlightNeon;
      case SnackBarType.warning:
        return AppColors.champagneGold;
      case SnackBarType.error:
        return AppColors.cutRed;
    }
  }
}

class _SnackBarContent extends StatelessWidget {
  final String message;
  final SnackBarType type;
  final IconData? icon;

  const _SnackBarContent({
    required this.message,
    required this.type,
    this.icon,
  });

  IconData get _typeIcon {
    if (icon != null) return icon!;
    switch (type) {
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
      case SnackBarType.error:
        return Icons.error_outline;
    }
  }

  Color get _iconColor {
    switch (type) {
      case SnackBarType.info:
        return AppColors.rewriteBlue;
      case SnackBarType.success:
        return AppColors.greenlightNeon;
      case SnackBarType.warning:
        return AppColors.champagneGold;
      case SnackBarType.error:
        return AppColors.cutRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          _typeIcon,
          color: _iconColor,
          size: 24,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: AppColors.scriptPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// Toast-style notification (appears at top of screen)
class AppToast {
  AppToast._();

  static OverlayEntry? _currentToast;

  /// Show a toast notification
  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    // Dismiss any existing toast
    _currentToast?.remove();
    _currentToast = null;

    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        icon: icon,
        onDismiss: () {
          _currentToast?.remove();
          _currentToast = null;
        },
      ),
    );

    _currentToast = entry;
    overlay.insert(entry);

    // Auto-dismiss after duration
    Future.delayed(duration, () {
      if (_currentToast == entry) {
        entry.remove();
        _currentToast = null;
      }
    });
  }

  /// Show success toast
  static void success(BuildContext context, String message) {
    show(context, message: message, type: SnackBarType.success);
  }

  /// Show error toast
  static void error(BuildContext context, String message) {
    show(context, message: message, type: SnackBarType.error);
  }

  /// Show info toast
  static void info(BuildContext context, String message) {
    show(context, message: message, type: SnackBarType.info);
  }

  /// Show warning toast
  static void warning(BuildContext context, String message) {
    show(context, message: message, type: SnackBarType.warning);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final SnackBarType type;
  final IconData? icon;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.message,
    required this.type,
    this.icon,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    switch (widget.type) {
      case SnackBarType.info:
        return AppColors.soundstageDark;
      case SnackBarType.success:
        return AppColors.greenlightNeon.withValues(alpha: 0.95);
      case SnackBarType.warning:
        return AppColors.champagneGold.withValues(alpha: 0.95);
      case SnackBarType.error:
        return AppColors.cutRed.withValues(alpha: 0.95);
    }
  }

  Color get _textColor {
    switch (widget.type) {
      case SnackBarType.info:
        return AppColors.scriptPrimary;
      case SnackBarType.success:
      case SnackBarType.warning:
      case SnackBarType.error:
        return Colors.white;
    }
  }

  IconData get _typeIcon {
    if (widget.icon != null) return widget.icon!;
    switch (widget.type) {
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.warning:
        return Icons.warning_amber;
      case SnackBarType.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + AppSpacing.lg,
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: widget.onDismiss,
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null && 
                    details.primaryVelocity! < 0) {
                  widget.onDismiss();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      _typeIcon,
                      color: _textColor,
                      size: 24,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          color: _textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(
                      Icons.close,
                      color: _textColor.withValues(alpha: 0.7),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Extension on BuildContext for easy snackbar access
extension SnackBarExtension on BuildContext {
  /// Show info snackbar
  void showInfoSnackBar(String message) => AppSnackBar.info(this, message: message);
  
  /// Show success snackbar
  void showSuccessSnackBar(String message) => AppSnackBar.success(this, message: message);
  
  /// Show warning snackbar
  void showWarningSnackBar(String message) => AppSnackBar.warning(this, message: message);
  
  /// Show error snackbar
  void showErrorSnackBar(String message) => AppSnackBar.error(this, message: message);
  
  /// Show snackbar with undo
  void showUndoSnackBar(String message, VoidCallback onUndo) {
    AppSnackBar.withUndo(this, message: message, onUndo: onUndo);
  }
  
  /// Hide current snackbar
  void hideSnackBar() => AppSnackBar.hide(this);
}
