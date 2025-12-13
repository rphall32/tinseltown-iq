// App Sheets - Reusable Bottom Sheet Components
//
// Provides consistent, themed bottom sheets throughout the app.
// Uses the Tinseltown IQ cinematic design language.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_radius.dart';

/// Base bottom sheet wrapper with consistent styling
class AppSheet extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget child;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showDragHandle;
  final bool showCloseButton;
  final EdgeInsets? padding;
  final double? maxHeight;

  const AppSheet({
    super.key,
    this.title,
    this.subtitle,
    required this.child,
    this.leading,
    this.actions,
    this.showDragHandle = true,
    this.showCloseButton = false,
    this.padding,
    this.maxHeight,
  });

  /// Show a standard bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? subtitle,
    Widget? leading,
    List<Widget>? actions,
    bool showDragHandle = true,
    bool showCloseButton = false,
    EdgeInsets? padding,
    double? maxHeight,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => AppSheet(
        title: title,
        subtitle: subtitle,
        leading: leading,
        actions: actions,
        showDragHandle: showDragHandle,
        showCloseButton: showCloseButton,
        padding: padding,
        maxHeight: maxHeight,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      constraints: maxHeight != null 
          ? BoxConstraints(maxHeight: maxHeight!)
          : null,
      decoration: const BoxDecoration(
        color: AppColors.soundstageDark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.modal),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDragHandle) _buildDragHandle(),
          if (title != null || showCloseButton) _buildHeader(context),
          Flexible(
            child: Padding(
              padding: padding ?? const EdgeInsets.all(AppSpacing.xxl),
              child: child,
            ),
          ),
        ],
      ),
    );

    // Handle keyboard padding for input sheets
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: content,
    );
  }

  Widget _buildDragHandle() {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.md),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.stageDirection,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xxl, 
        AppSpacing.lg, 
        AppSpacing.xxl, 
        0,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: const TextStyle(
                      color: AppColors.scriptPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: AppColors.dialogueSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (actions != null) ...actions!,
          if (showCloseButton)
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.editingBay,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(
                  Icons.close,
                  color: AppColors.dialogueSecondary,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Action sheet with a list of actions
class AppActionSheet extends StatelessWidget {
  final String? title;
  final String? message;
  final List<SheetAction> actions;
  final String? cancelText;

  const AppActionSheet({
    super.key,
    this.title,
    this.message,
    required this.actions,
    this.cancelText = 'Cancel',
  });

  /// Show an action sheet
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    String? message,
    required List<SheetAction<T>> actions,
    String? cancelText = 'Cancel',
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AppActionSheet(
        title: title,
        message: message,
        actions: actions.map((a) => SheetAction(
          title: a.title,
          subtitle: a.subtitle,
          icon: a.icon,
          isDestructive: a.isDestructive,
          onTap: () {
            Navigator.pop(context, a.value);
          },
        )).toList(),
        cancelText: cancelText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.soundstageDark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.modal),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: AppSpacing.md),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.stageDirection,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Title and message
            if (title != null || message != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xxl,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                  AppSpacing.md,
                ),
                child: Column(
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: const TextStyle(
                          color: AppColors.scriptPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    if (message != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        message!,
                        style: const TextStyle(
                          color: AppColors.dialogueSecondary,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            
            // Divider
            const Divider(color: AppColors.editingBay, height: 1),
            
            // Actions
            ...actions.map((action) => _ActionTile(action: action)),
            
            // Cancel button
            if (cancelText != null) ...[
              const Divider(color: AppColors.editingBay, height: 1),
              _ActionTile(
                action: SheetAction(
                  title: cancelText!,
                  onTap: () => Navigator.pop(context),
                ),
                isCancel: true,
              ),
            ],
            
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

/// Single action for action sheet
class SheetAction<T> {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final bool isDestructive;
  final VoidCallback? onTap;
  final T? value;

  const SheetAction({
    required this.title,
    this.subtitle,
    this.icon,
    this.isDestructive = false,
    this.onTap,
    this.value,
  });
}

class _ActionTile extends StatelessWidget {
  final SheetAction action;
  final bool isCancel;

  const _ActionTile({
    required this.action,
    this.isCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = action.isDestructive 
        ? AppColors.cutRed 
        : (isCancel ? AppColors.dialogueSecondary : AppColors.scriptPrimary);

    return InkWell(
      onTap: action.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xxl,
          vertical: AppSpacing.lg,
        ),
        child: Row(
          children: [
            if (action.icon != null) ...[
              Icon(
                action.icon,
                color: textColor,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.lg),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    action.title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: isCancel ? FontWeight.w500 : FontWeight.w600,
                    ),
                  ),
                  if (action.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      action.subtitle!,
                      style: const TextStyle(
                        color: AppColors.dialogueSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Form sheet for input-heavy bottom sheets
class AppFormSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget form;
  final String submitText;
  final String? cancelText;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final bool isSubmitting;

  const AppFormSheet({
    super.key,
    required this.title,
    this.subtitle,
    required this.form,
    this.submitText = 'Submit',
    this.cancelText,
    this.onSubmit,
    this.onCancel,
    this.isSubmitting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.soundstageDark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.modal),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: AppSpacing.md),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.stageDirection,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.scriptPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.dialogueSecondary,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: AppColors.dialogueSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Form content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: form,
              ),
            ),
            
            // Action buttons
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Row(
                children: [
                  if (cancelText != null) ...[
                    Expanded(
                      child: _SheetButton(
                        text: cancelText!,
                        onPressed: onCancel ?? () => Navigator.pop(context),
                        isSecondary: true,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  Expanded(
                    flex: cancelText != null ? 1 : 2,
                    child: _SheetButton(
                      text: submitText,
                      onPressed: isSubmitting ? null : onSubmit,
                      isLoading: isSubmitting,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final bool isLoading;

  const _SheetButton({
    required this.text,
    this.onPressed,
    this.isSecondary = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSecondary ? AppColors.editingBay : AppColors.oscarGold,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: isSecondary ? AppColors.scriptPrimary : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

/// Media picker sheet for selecting images/videos
class AppMediaPickerSheet extends StatelessWidget {
  final String? title;
  final bool showCamera;
  final bool showGallery;
  final bool showFiles;
  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;
  final VoidCallback? onFilesTap;

  const AppMediaPickerSheet({
    super.key,
    this.title = 'Select Media',
    this.showCamera = true,
    this.showGallery = true,
    this.showFiles = false,
    this.onCameraTap,
    this.onGalleryTap,
    this.onFilesTap,
  });

  /// Show media picker and return selection type
  static Future<MediaPickerResult?> show({
    required BuildContext context,
    String? title = 'Select Media',
    bool showCamera = true,
    bool showGallery = true,
    bool showFiles = false,
  }) {
    return showModalBottomSheet<MediaPickerResult>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AppMediaPickerSheet(
        title: title,
        showCamera: showCamera,
        showGallery: showGallery,
        showFiles: showFiles,
        onCameraTap: () => Navigator.pop(context, MediaPickerResult.camera),
        onGalleryTap: () => Navigator.pop(context, MediaPickerResult.gallery),
        onFilesTap: () => Navigator.pop(context, MediaPickerResult.files),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.soundstageDark,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.modal),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: AppSpacing.md),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.stageDirection,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Title
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: AppColors.scriptPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            
            // Options
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (showCamera)
                    _MediaOption(
                      icon: Icons.camera_alt,
                      label: 'Camera',
                      onTap: onCameraTap,
                    ),
                  if (showGallery)
                    _MediaOption(
                      icon: Icons.photo_library,
                      label: 'Gallery',
                      onTap: onGalleryTap,
                    ),
                  if (showFiles)
                    _MediaOption(
                      icon: Icons.folder,
                      label: 'Files',
                      onTap: onFilesTap,
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

/// Media picker result type
enum MediaPickerResult { camera, gallery, files }

class _MediaOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _MediaOption({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: AppColors.editingBay,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Icon(
              icon,
              color: AppColors.oscarGold,
              size: 32,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.scriptPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
