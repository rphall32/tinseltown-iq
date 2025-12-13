import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Centralized notification system for consistent UI feedback
// Replaces scattered ScaffoldMessenger.showSnackBar calls throughout the app

/// Notification type enum for different visual styles
enum NotificationType {
  success,
  error,
  warning,
  info,
}

/// Extension to get properties for each notification type
extension NotificationTypeExtension on NotificationType {
  Color get backgroundColor {
    switch (this) {
      case NotificationType.success:
        return AppColors.editingBay;
      case NotificationType.error:
        return AppColors.cutRed.withValues(alpha: 0.9);
      case NotificationType.warning:
        return AppColors.cautionAmber.withValues(alpha: 0.9);
      case NotificationType.info:
        return AppColors.editingBay;
    }
  }

  Color get iconColor {
    switch (this) {
      case NotificationType.success:
        return AppColors.greenlightNeon;
      case NotificationType.error:
        return Colors.white;
      case NotificationType.warning:
        return AppColors.midnightPremiere;
      case NotificationType.info:
        return AppColors.rewriteBlue;
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.error:
        return Icons.error;
      case NotificationType.warning:
        return Icons.warning_amber;
      case NotificationType.info:
        return Icons.info_outline;
    }
  }

  Color get textColor {
    switch (this) {
      case NotificationType.success:
      case NotificationType.info:
        return AppColors.scriptPrimary;
      case NotificationType.error:
        return Colors.white;
      case NotificationType.warning:
        return AppColors.midnightPremiere;
    }
  }
}

/// Centralized notification utility class
/// 
/// Usage examples:
/// ```dart
/// AppNotifications.showSuccess(context, 'Saved successfully!');
/// AppNotifications.showError(context, 'Failed to save');
/// AppNotifications.showWarning(context, 'Low storage space');
/// AppNotifications.showInfo(context, 'New feature available');
/// ```
class AppNotifications {
  // Private constructor to prevent instantiation
  AppNotifications._();

  /// Default duration for notifications
  static const Duration defaultDuration = Duration(seconds: 3);
  static const Duration shortDuration = Duration(seconds: 2);
  static const Duration longDuration = Duration(seconds: 5);

  /// Show a success notification (green checkmark)
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    _show(
      context,
      message,
      NotificationType.success,
      duration: duration ?? shortDuration,
      action: action,
    );
  }

  /// Show an error notification (red background)
  static void showError(
    BuildContext context,
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    _show(
      context,
      message,
      NotificationType.error,
      duration: duration ?? defaultDuration,
      action: action,
    );
  }

  /// Show a warning notification (amber/yellow)
  static void showWarning(
    BuildContext context,
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    _show(
      context,
      message,
      NotificationType.warning,
      duration: duration ?? defaultDuration,
      action: action,
    );
  }

  /// Show an info notification (blue icon)
  static void showInfo(
    BuildContext context,
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    _show(
      context,
      message,
      NotificationType.info,
      duration: duration ?? defaultDuration,
      action: action,
    );
  }

  /// Show a custom notification with full control
  static void showCustom(
    BuildContext context, {
    required Widget content,
    Color? backgroundColor,
    Duration? duration,
    SnackBarAction? action,
    EdgeInsetsGeometry? margin,
  }) {
    _clearAndShow(
      context,
      SnackBar(
        content: content,
        backgroundColor: backgroundColor ?? AppColors.editingBay,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: duration ?? defaultDuration,
        action: action,
        margin: margin,
      ),
    );
  }

  /// Show notification with undo action
  static void showWithUndo(
    BuildContext context,
    String message, {
    required VoidCallback onUndo,
    NotificationType type = NotificationType.info,
    Duration? duration,
  }) {
    _show(
      context,
      message,
      type,
      duration: duration ?? longDuration,
      action: SnackBarAction(
        label: 'UNDO',
        textColor: type == NotificationType.error || type == NotificationType.warning
            ? type.textColor
            : AppColors.oscarGold,
        onPressed: onUndo,
      ),
    );
  }

  /// Show loading notification (doesn't auto-dismiss)
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showLoading(
    BuildContext context,
    String message,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: AppColors.scriptPrimary),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.editingBay,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(days: 1), // Effectively infinite
      ),
    );
  }

  /// Dismiss any currently showing notification
  static void dismiss(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  /// Internal method to show notifications
  static void _show(
    BuildContext context,
    String message,
    NotificationType type, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    _clearAndShow(
      context,
      SnackBar(
        content: Row(
          children: [
            Icon(type.icon, color: type.iconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: type.textColor),
              ),
            ),
          ],
        ),
        backgroundColor: type.backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: duration ?? defaultDuration,
        action: action,
      ),
    );
  }

  /// Clear existing snackbars and show new one
  static void _clearAndShow(BuildContext context, SnackBar snackBar) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(snackBar);
  }
}

/// Extension on BuildContext for convenient access
/// 
/// Usage:
/// ```dart
/// context.showSuccess('Saved!');
/// context.showError('Failed to save');
/// ```
extension NotificationContextExtension on BuildContext {
  void showSuccess(String message, {Duration? duration}) {
    AppNotifications.showSuccess(this, message, duration: duration);
  }

  void showError(String message, {Duration? duration}) {
    AppNotifications.showError(this, message, duration: duration);
  }

  void showWarning(String message, {Duration? duration}) {
    AppNotifications.showWarning(this, message, duration: duration);
  }

  void showInfo(String message, {Duration? duration}) {
    AppNotifications.showInfo(this, message, duration: duration);
  }

  void dismissNotification() {
    AppNotifications.dismiss(this);
  }
}
