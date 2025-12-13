// App Inputs - Reusable Input Field Components
//
// Provides a comprehensive suite of themed input widgets to standardize
// the 28+ TextField patterns and eliminate 4 duplicate _buildTextField methods.
// Integrates with form_validators.dart for consistent validation.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
// app_spacing.dart available for future use
import '../../core/theme/app_radius.dart';

// ═══════════════════════════════════════════════════════════════
// INPUT VARIANTS & SIZES
// ═══════════════════════════════════════════════════════════════

/// Input field style variants
enum AppInputVariant {
  /// Filled background (default)
  filled,
  
  /// Outlined border only
  outlined,
  
  /// Underline only (minimal)
  underline,
}

/// Input field size presets
enum AppInputSize {
  /// Small input - compact
  small,
  
  /// Medium input - standard (default)
  medium,
  
  /// Large input - prominent
  large,
}

// ═══════════════════════════════════════════════════════════════
// BASE APP TEXT FIELD
// ═══════════════════════════════════════════════════════════════

/// Themed text field with consistent styling
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final AppInputVariant variant;
  final AppInputSize size;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool showCounter;
  final bool isDense;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.variant = AppInputVariant.filled,
    this.size = AppInputSize.medium,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.showCounter = false,
    this.isDense = false,
  });

  EdgeInsetsGeometry get _defaultPadding {
    switch (size) {
      case AppInputSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
      case AppInputSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 14);
      case AppInputSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 18);
    }
  }

  double get _fontSize {
    switch (size) {
      case AppInputSize.small:
        return 14;
      case AppInputSize.medium:
        return 16;
      case AppInputSize.large:
        return 18;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppInputSize.small:
        return 18;
      case AppInputSize.medium:
        return 20;
      case AppInputSize.large:
        return 24;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Theme colors
    final effectiveFillColor = fillColor ?? 
        (isDark ? AppColors.editingBay : AppColors.lightSurface);
    final effectiveBorderColor = borderColor ?? 
        (isDark ? AppColors.backstage : AppColors.lightBorder);
    final effectiveFocusedBorderColor = focusedBorderColor ?? AppColors.oscarGold;
    final textColor = isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary;
    final hintColor = isDark 
        ? AppColors.stageDirection.withValues(alpha: 0.6)
        : AppColors.lightTextTertiary;
    final labelColor = isDark ? AppColors.dialogueSecondary : AppColors.lightTextSecondary;
    final iconColor = isDark ? AppColors.stageDirection : AppColors.lightTextTertiary;

    // Build input decoration based on variant
    InputDecoration decoration;
    
    switch (variant) {
      case AppInputVariant.filled:
        decoration = InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          errorText: errorText,
          filled: true,
          fillColor: enabled ? effectiveFillColor : effectiveFillColor.withValues(alpha: 0.5),
          labelStyle: TextStyle(color: labelColor, fontSize: _fontSize),
          hintStyle: TextStyle(color: hintColor, fontSize: _fontSize),
          helperStyle: TextStyle(color: hintColor, fontSize: 12),
          errorStyle: const TextStyle(color: AppColors.cutRed, fontSize: 12),
          prefixIcon: prefixIcon != null 
              ? Icon(prefixIcon, color: iconColor, size: _iconSize) 
              : prefix,
          suffixIcon: suffixIcon ?? suffix,
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: effectiveFocusedBorderColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: const BorderSide(color: AppColors.cutRed),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: const BorderSide(color: AppColors.cutRed, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: effectiveBorderColor.withValues(alpha: 0.5)),
          ),
          contentPadding: contentPadding ?? _defaultPadding,
          counterText: showCounter ? null : '',
          isDense: isDense,
        );
        break;
        
      case AppInputVariant.outlined:
        decoration = InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          errorText: errorText,
          filled: false,
          labelStyle: TextStyle(color: labelColor, fontSize: _fontSize),
          hintStyle: TextStyle(color: hintColor, fontSize: _fontSize),
          helperStyle: TextStyle(color: hintColor, fontSize: 12),
          errorStyle: const TextStyle(color: AppColors.cutRed, fontSize: 12),
          prefixIcon: prefixIcon != null 
              ? Icon(prefixIcon, color: iconColor, size: _iconSize) 
              : prefix,
          suffixIcon: suffixIcon ?? suffix,
          border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: effectiveFocusedBorderColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: const BorderSide(color: AppColors.cutRed),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(AppRadius.md),
            borderSide: const BorderSide(color: AppColors.cutRed, width: 2),
          ),
          contentPadding: contentPadding ?? _defaultPadding,
          counterText: showCounter ? null : '',
          isDense: isDense,
        );
        break;
        
      case AppInputVariant.underline:
        decoration = InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          errorText: errorText,
          filled: false,
          labelStyle: TextStyle(color: labelColor, fontSize: _fontSize),
          hintStyle: TextStyle(color: hintColor, fontSize: _fontSize),
          helperStyle: TextStyle(color: hintColor, fontSize: 12),
          errorStyle: const TextStyle(color: AppColors.cutRed, fontSize: 12),
          prefixIcon: prefixIcon != null 
              ? Icon(prefixIcon, color: iconColor, size: _iconSize) 
              : prefix,
          suffixIcon: suffixIcon ?? suffix,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: effectiveBorderColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: effectiveFocusedBorderColor, width: 2),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.cutRed),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.cutRed, width: 2),
          ),
          contentPadding: contentPadding ?? _defaultPadding,
          counterText: showCounter ? null : '',
          isDense: isDense,
        );
        break;
    }

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      focusNode: focusNode,
      style: TextStyle(color: textColor, fontSize: _fontSize),
      decoration: decoration,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// LABELED TEXT FIELD (matches _buildTextField pattern)
// ═══════════════════════════════════════════════════════════════

/// Text field with external label (matches existing _buildTextField pattern)
class AppLabeledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final Color? borderColor;
  final double labelSpacing;
  final TextStyle? labelStyle;

  const AppLabeledTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.backgroundColor,
    this.borderColor,
    this.labelSpacing = 8,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBgColor = backgroundColor ?? 
        (isDark ? AppColors.editingBay : AppColors.lightSurface);
    final effectiveBorderColor = borderColor ?? 
        (isDark ? AppColors.backstage : AppColors.lightBorder);
    final textColor = isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary;
    final hintColor = isDark 
        ? AppColors.stageDirection.withValues(alpha: 0.6)
        : AppColors.lightTextTertiary;
    final iconColor = isDark ? AppColors.stageDirection : AppColors.lightTextTertiary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? TextStyle(
            color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: labelSpacing),
        Container(
          decoration: BoxDecoration(
            color: effectiveBgColor,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: effectiveBorderColor),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            enabled: enabled,
            maxLines: maxLines,
            maxLength: maxLength,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            focusNode: focusNode,
            style: TextStyle(color: textColor, fontSize: 16),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: hintColor),
              prefixIcon: prefixIcon != null 
                  ? Icon(prefixIcon, color: iconColor, size: 20)
                  : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// PASSWORD FIELD
// ═══════════════════════════════════════════════════════════════

/// Password field with visibility toggle
class AppPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final AppInputVariant variant;
  final AppInputSize size;
  final TextInputAction? textInputAction;
  final bool showStrengthIndicator;
  final bool useExternalLabel;

  const AppPasswordField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.variant = AppInputVariant.filled,
    this.size = AppInputSize.medium,
    this.textInputAction,
    this.showStrengthIndicator = false,
    this.useExternalLabel = false,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.stageDirection : AppColors.lightTextTertiary;

    final toggleButton = IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: iconColor,
        size: 20,
      ),
      onPressed: _toggleVisibility,
    );

    if (widget.useExternalLabel && widget.label != null) {
      return AppLabeledTextField(
        controller: widget.controller,
        label: widget.label!,
        hint: widget.hint ?? 'Enter password',
        prefixIcon: Icons.lock_outline,
        suffixIcon: toggleButton,
        obscureText: _obscureText,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        focusNode: widget.focusNode,
      );
    }

    return AppTextField(
      controller: widget.controller,
      label: widget.label ?? 'Password',
      hint: widget.hint ?? 'Enter password',
      prefixIcon: Icons.lock_outline,
      suffixIcon: toggleButton,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      variant: widget.variant,
      size: widget.size,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// SEARCH FIELD
// ═══════════════════════════════════════════════════════════════

/// Search input with clear button
class AppSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onClear;
  final FocusNode? focusNode;
  final bool autofocus;
  final AppInputVariant variant;
  final AppInputSize size;
  final bool showClearButton;
  final Widget? leading;
  final Widget? trailing;

  const AppSearchField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.focusNode,
    this.autofocus = false,
    this.variant = AppInputVariant.filled,
    this.size = AppInputSize.medium,
    this.showClearButton = true,
    this.leading,
    this.trailing,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _onClear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.stageDirection : AppColors.lightTextTertiary;

    Widget? suffixWidget;
    if (widget.showClearButton && _hasText) {
      suffixWidget = IconButton(
        icon: Icon(Icons.close, color: iconColor, size: 20),
        onPressed: _onClear,
      );
    } else if (widget.trailing != null) {
      suffixWidget = widget.trailing;
    }

    return AppTextField(
      controller: _controller,
      hint: widget.hint ?? 'Search...',
      prefix: widget.leading,
      prefixIcon: widget.leading == null ? Icons.search : null,
      suffixIcon: suffixWidget,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      variant: widget.variant,
      size: widget.size,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// TEXT AREA (Multi-line)
// ═══════════════════════════════════════════════════════════════

/// Multi-line text input
class AppTextArea extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool enabled;
  final bool showCounter;
  final AppInputVariant variant;
  final bool useExternalLabel;

  const AppTextArea({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.minLines = 3,
    this.maxLines = 6,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.enabled = true,
    this.showCounter = true,
    this.variant = AppInputVariant.filled,
    this.useExternalLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (useExternalLabel && label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: TextStyle(
              color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.editingBay : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: isDark ? AppColors.backstage : AppColors.lightBorder,
              ),
            ),
            child: TextField(
              controller: controller,
              minLines: minLines,
              maxLines: maxLines,
              maxLength: maxLength,
              enabled: enabled,
              focusNode: focusNode,
              onChanged: onChanged,
              style: TextStyle(
                color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: isDark 
                      ? AppColors.stageDirection.withValues(alpha: 0.6)
                      : AppColors.lightTextTertiary,
                ),
                helperText: helperText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                counterStyle: TextStyle(
                  color: isDark ? AppColors.stageDirection : AppColors.lightTextTertiary,
                ),
                counterText: showCounter ? null : '',
              ),
            ),
          ),
        ],
      );
    }

    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      helperText: helperText,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      enabled: enabled,
      showCounter: showCounter,
      variant: variant,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// EMAIL FIELD
// ═══════════════════════════════════════════════════════════════

/// Email input with validation
class AppEmailField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final AppInputVariant variant;
  final AppInputSize size;
  final TextInputAction? textInputAction;
  final bool useExternalLabel;

  const AppEmailField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.variant = AppInputVariant.filled,
    this.size = AppInputSize.medium,
    this.textInputAction,
    this.useExternalLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useExternalLabel) {
      return AppLabeledTextField(
        controller: controller,
        label: label ?? 'Email',
        hint: hint ?? 'Enter your email',
        prefixIcon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
        textInputAction: textInputAction ?? TextInputAction.next,
        validator: validator,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
      );
    }

    return AppTextField(
      controller: controller,
      label: label ?? 'Email',
      hint: hint ?? 'Enter your email',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      variant: variant,
      size: size,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// DROPDOWN FIELD
// ═══════════════════════════════════════════════════════════════

/// Themed dropdown selector
class AppDropdownField<T> extends StatelessWidget {
  final T? value;
  final String? label;
  final String? hint;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final IconData? prefixIcon;
  final bool enabled;
  final AppInputVariant variant;
  final bool useExternalLabel;

  const AppDropdownField({
    super.key,
    this.value,
    this.label,
    this.hint,
    required this.items,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.enabled = true,
    this.variant = AppInputVariant.filled,
    this.useExternalLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.editingBay : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.backstage : AppColors.lightBorder;
    final textColor = isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary;
    final hintColor = isDark 
        ? AppColors.stageDirection.withValues(alpha: 0.6)
        : AppColors.lightTextTertiary;
    final iconColor = isDark ? AppColors.stageDirection : AppColors.lightTextTertiary;

    final dropdown = Container(
      decoration: BoxDecoration(
        color: variant == AppInputVariant.filled ? bgColor : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: enabled ? onChanged : null,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: hintColor),
          prefixIcon: prefixIcon != null 
              ? Icon(prefixIcon, color: iconColor, size: 20)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        dropdownColor: isDark ? AppColors.screeningRoom : AppColors.lightSurface,
        style: TextStyle(color: textColor, fontSize: 16),
        icon: Icon(Icons.keyboard_arrow_down, color: iconColor),
      ),
    );

    if (useExternalLabel && label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: TextStyle(
              color: isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          dropdown,
        ],
      );
    }

    return dropdown;
  }
}

// ═══════════════════════════════════════════════════════════════
// PHONE FIELD
// ═══════════════════════════════════════════════════════════════

/// Phone number input with formatting
class AppPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final AppInputVariant variant;
  final AppInputSize size;
  final TextInputAction? textInputAction;
  final bool useExternalLabel;

  const AppPhoneField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.variant = AppInputVariant.filled,
    this.size = AppInputSize.medium,
    this.textInputAction,
    this.useExternalLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    if (useExternalLabel) {
      return AppLabeledTextField(
        controller: controller,
        label: label ?? 'Phone',
        hint: hint ?? 'Enter phone number',
        prefixIcon: Icons.phone_outlined,
        keyboardType: TextInputType.phone,
        textInputAction: textInputAction ?? TextInputAction.next,
        validator: validator,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
      );
    }

    return AppTextField(
      controller: controller,
      label: label ?? 'Phone',
      hint: hint ?? 'Enter phone number',
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      variant: variant,
      size: size,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-\+\(\)]')),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// NUMBER FIELD
// ═══════════════════════════════════════════════════════════════

/// Numeric input with optional formatting
class AppNumberField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final AppInputVariant variant;
  final AppInputSize size;
  final bool allowDecimal;
  final bool allowNegative;
  final String? prefix;
  final String? suffix;

  const AppNumberField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.variant = AppInputVariant.filled,
    this.size = AppInputSize.medium,
    this.allowDecimal = false,
    this.allowNegative = false,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.stageDirection : AppColors.lightTextTertiary;

    String pattern = allowNegative ? r'-?' : '';
    pattern += r'\d*';
    if (allowDecimal) {
      pattern += r'\.?\d*';
    }

    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      variant: variant,
      size: size,
      keyboardType: TextInputType.numberWithOptions(
        decimal: allowDecimal,
        signed: allowNegative,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(pattern)),
      ],
      prefix: prefix != null 
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(prefix!, style: TextStyle(color: textColor)),
            )
          : null,
      suffix: suffix != null
          ? Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(suffix!, style: TextStyle(color: textColor)),
            )
          : null,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// OTP / PIN FIELD
// ═══════════════════════════════════════════════════════════════

/// OTP/PIN input with individual boxes
class AppOtpField extends StatefulWidget {
  final int length;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final bool obscureText;
  final double boxSize;
  final double spacing;

  const AppOtpField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.obscureText = false,
    this.boxSize = 50,
    this.spacing = 8,
  });

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _currentValue {
    return _controllers.map((c) => c.text).join();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    
    widget.onChanged?.call(_currentValue);
    
    if (_currentValue.length == widget.length) {
      widget.onCompleted?.call(_currentValue);
    }
  }

  // Backspace handling for future keyboard listener integration
  // void _onBackspace(int index) {
  //   if (_controllers[index].text.isEmpty && index > 0) {
  //     _focusNodes[index - 1].requestFocus();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.editingBay : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.backstage : AppColors.lightBorder;
    final textColor = isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          width: widget.boxSize,
          height: widget.boxSize,
          margin: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: _focusNodes[index].hasFocus 
                  ? AppColors.oscarGold 
                  : borderColor,
              width: _focusNodes[index].hasFocus ? 2 : 1,
            ),
          ),
          child: Center(
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              obscureText: widget.obscureText,
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _onChanged(index, value),
              onTap: () {
                _controllers[index].selection = TextSelection.fromPosition(
                  TextPosition(offset: _controllers[index].text.length),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// CONTEXT EXTENSIONS
// ═══════════════════════════════════════════════════════════════

/// Extension methods for easy input field creation
extension AppInputContext on BuildContext {
  /// Get input background color based on theme
  Color get inputBackground {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark ? AppColors.editingBay : AppColors.lightSurface;
  }
  
  /// Get input border color based on theme
  Color get inputBorder {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark ? AppColors.backstage : AppColors.lightBorder;
  }
  
  /// Get input text color based on theme
  Color get inputText {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark ? AppColors.scriptPrimary : AppColors.lightTextPrimary;
  }
  
  /// Get input hint color based on theme
  Color get inputHint {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    return isDark 
        ? AppColors.stageDirection.withValues(alpha: 0.6)
        : AppColors.lightTextTertiary;
  }
}
