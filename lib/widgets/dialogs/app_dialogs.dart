// App Dialogs - Reusable Dialog Components
//
// Provides consistent, themed dialogs and modals throughout the app.
// Uses the Tinseltown IQ cinematic design language.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

/// Dialog type determines the color scheme and icon
enum AppDialogType {
  info,
  success,
  warning,
  error,
  confirmation,
}

/// Standard app dialog with consistent styling
class AppDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? content;
  final AppDialogType type;
  final IconData? icon;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool showCloseButton;
  final bool barrierDismissible;

  const AppDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.type = AppDialogType.info,
    this.icon,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.showCloseButton = false,
    this.barrierDismissible = true,
  });

  /// Show an info dialog
  static Future<T?> showInfo<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return showAppDialog<T>(
      context: context,
      dialog: AppDialog(
        title: title,
        message: message,
        content: content,
        type: AppDialogType.info,
        icon: Icons.info_outline,
        primaryButtonText: buttonText ?? 'OK',
        onPrimaryPressed: onPressed ?? () => Navigator.pop(context),
      ),
    );
  }

  /// Show a success dialog
  static Future<T?> showSuccess<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return showAppDialog<T>(
      context: context,
      dialog: AppDialog(
        title: title,
        message: message,
        content: content,
        type: AppDialogType.success,
        icon: Icons.check_circle_outline,
        primaryButtonText: buttonText ?? 'Great!',
        onPrimaryPressed: onPressed ?? () => Navigator.pop(context),
      ),
    );
  }

  /// Show a warning dialog
  static Future<T?> showWarning<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
  }) {
    return showAppDialog<T>(
      context: context,
      dialog: AppDialog(
        title: title,
        message: message,
        content: content,
        type: AppDialogType.warning,
        icon: Icons.warning_amber_outlined,
        primaryButtonText: primaryButtonText ?? 'OK',
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed ?? () => Navigator.pop(context),
        onSecondaryPressed: onSecondaryPressed,
      ),
    );
  }

  /// Show an error dialog
  static Future<T?> showError<T>({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return showAppDialog<T>(
      context: context,
      dialog: AppDialog(
        title: title,
        message: message,
        content: content,
        type: AppDialogType.error,
        icon: Icons.error_outline,
        primaryButtonText: buttonText ?? 'OK',
        onPrimaryPressed: onPressed ?? () => Navigator.pop(context),
      ),
    );
  }

  /// Show a confirmation dialog
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    String? message,
    Widget? content,
    String? confirmText,
    String? cancelText,
    bool isDestructive = false,
  }) {
    return showAppDialog<bool>(
      context: context,
      dialog: AppDialog(
        title: title,
        message: message,
        content: content,
        type: isDestructive ? AppDialogType.error : AppDialogType.confirmation,
        icon: isDestructive ? Icons.delete_outline : Icons.help_outline,
        primaryButtonText: confirmText ?? 'Confirm',
        secondaryButtonText: cancelText ?? 'Cancel',
        onPrimaryPressed: () => Navigator.pop(context, true),
        onSecondaryPressed: () => Navigator.pop(context, false),
      ),
    );
  }

  Color get _typeColor {
    switch (type) {
      case AppDialogType.info:
        return AppColors.rewriteBlue;
      case AppDialogType.success:
        return AppColors.greenlightNeon;
      case AppDialogType.warning:
        return AppColors.champagneGold;
      case AppDialogType.error:
        return AppColors.cutRed;
      case AppDialogType.confirmation:
        return AppColors.oscarGold;
    }
  }

  IconData get _typeIcon {
    if (icon != null) return icon!;
    switch (type) {
      case AppDialogType.info:
        return Icons.info_outline;
      case AppDialogType.success:
        return Icons.check_circle_outline;
      case AppDialogType.warning:
        return Icons.warning_amber_outlined;
      case AppDialogType.error:
        return Icons.error_outline;
      case AppDialogType.confirmation:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.soundstageDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            if (showCloseButton)
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.dialogueSecondary,
                    size: 24,
                  ),
                ),
              ),
            
            // Icon
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: _typeColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(_typeIcon, color: _typeColor, size: 32),
            ),
            
            const SizedBox(height: AppSpacing.xl),
            
            // Title
            Text(
              title,
              style: const TextStyle(
                color: AppColors.scriptPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            
            // Message
            if (message != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.dialogueSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
            
            // Custom content
            if (content != null) ...[
              const SizedBox(height: AppSpacing.lg),
              content!,
            ],
            
            const SizedBox(height: AppSpacing.xxl),
            
            // Buttons
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (secondaryButtonText != null) {
      return Row(
        children: [
          Expanded(
            child: _DialogButton(
              text: secondaryButtonText!,
              onPressed: onSecondaryPressed ?? () => Navigator.pop(context),
              isSecondary: true,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _DialogButton(
              text: primaryButtonText ?? 'OK',
              onPressed: onPrimaryPressed ?? () => Navigator.pop(context),
              color: _typeColor,
            ),
          ),
        ],
      );
    }
    
    return SizedBox(
      width: double.infinity,
      child: _DialogButton(
        text: primaryButtonText ?? 'OK',
        onPressed: onPrimaryPressed ?? () => Navigator.pop(context),
        color: _typeColor,
      ),
    );
  }
}

/// Internal button widget for dialogs
class _DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final bool isSecondary;

  const _DialogButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSecondary ? AppColors.editingBay : (color ?? AppColors.oscarGold),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSecondary ? AppColors.scriptPrimary : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/// Show app dialog with standard configuration
Future<T?> showAppDialog<T>({
  required BuildContext context,
  required AppDialog dialog,
  bool barrierDismissible = true,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black54,
    builder: (context) => dialog,
  );
}

/// Input dialog for getting user input
class AppInputDialog extends StatefulWidget {
  final String title;
  final String? message;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final String confirmText;
  final String cancelText;
  final int? maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AppInputDialog({
    super.key,
    required this.title,
    this.message,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.confirmText = 'Submit',
    this.cancelText = 'Cancel',
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  /// Show input dialog and return the entered value
  static Future<String?> show({
    required BuildContext context,
    required String title,
    String? message,
    String? initialValue,
    String? hintText,
    String? labelText,
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
    int? maxLines = 1,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => AppInputDialog(
        title: title,
        message: message,
        initialValue: initialValue,
        hintText: hintText,
        labelText: labelText,
        confirmText: confirmText,
        cancelText: cancelText,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  @override
  State<AppInputDialog> createState() => _AppInputDialogState();
}

class _AppInputDialogState extends State<AppInputDialog> {
  late TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.validator != null) {
      final error = widget.validator!(_controller.text);
      if (error != null) {
        setState(() => _error = error);
        return;
      }
    }
    Navigator.pop(context, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.soundstageDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: AppColors.scriptPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                widget.message!,
                style: const TextStyle(
                  color: AppColors.dialogueSecondary,
                  fontSize: 14,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _controller,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              style: const TextStyle(color: AppColors.scriptPrimary),
              decoration: InputDecoration(
                hintText: widget.hintText,
                labelText: widget.labelText,
                errorText: _error,
                hintStyle: TextStyle(color: AppColors.stageDirection),
                labelStyle: const TextStyle(color: AppColors.dialogueSecondary),
                filled: true,
                fillColor: AppColors.editingBay,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: const BorderSide(color: AppColors.oscarGold, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  borderSide: const BorderSide(color: AppColors.cutRed, width: 2),
                ),
              ),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    text: widget.cancelText,
                    onPressed: () => Navigator.pop(context),
                    isSecondary: true,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _DialogButton(
                    text: widget.confirmText,
                    onPressed: _submit,
                    color: AppColors.oscarGold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Selection dialog for choosing from a list of options
class AppSelectionDialog<T> extends StatelessWidget {
  final String title;
  final String? message;
  final List<SelectionOption<T>> options;
  final T? selectedValue;

  const AppSelectionDialog({
    super.key,
    required this.title,
    this.message,
    required this.options,
    this.selectedValue,
  });

  /// Show selection dialog and return the selected value
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? message,
    required List<SelectionOption<T>> options,
    T? selectedValue,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => AppSelectionDialog<T>(
        title: title,
        message: message,
        options: options,
        selectedValue: selectedValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.soundstageDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.scriptPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: const TextStyle(
                  color: AppColors.dialogueSecondary,
                  fontSize: 14,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            ...options.map((option) => _SelectionTile<T>(
              option: option,
              isSelected: option.value == selectedValue,
              onTap: () => Navigator.pop(context, option.value),
            )),
          ],
        ),
      ),
    );
  }
}

/// Option for selection dialog
class SelectionOption<T> {
  final T value;
  final String title;
  final String? subtitle;
  final IconData? icon;

  const SelectionOption({
    required this.value,
    required this.title,
    this.subtitle,
    this.icon,
  });
}

class _SelectionTile<T> extends StatelessWidget {
  final SelectionOption<T> option;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.oscarGold.withValues(alpha: 0.15) : AppColors.editingBay,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: isSelected 
              ? Border.all(color: AppColors.oscarGold, width: 2)
              : null,
        ),
        child: Row(
          children: [
            if (option.icon != null) ...[
              Icon(
                option.icon,
                color: isSelected ? AppColors.oscarGold : AppColors.dialogueSecondary,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: TextStyle(
                      color: isSelected ? AppColors.oscarGold : AppColors.scriptPrimary,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  if (option.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      option.subtitle!,
                      style: const TextStyle(
                        color: AppColors.dialogueSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.oscarGold,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
