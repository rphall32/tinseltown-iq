import 'package:flutter/material.dart';

/// Tinseltown IQ Form Validation System
/// 
/// Centralized validation logic for consistent form handling across the app.

/// Validation result with error message
class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult.valid() : isValid = true, errorMessage = null;
  const ValidationResult.invalid(this.errorMessage) : isValid = false;

  /// Convert to standard Flutter validator return type
  String? get asValidatorResult => isValid ? null : errorMessage;
}

/// Standard form validators
class FormValidators {
  FormValidators._();

  // ═══════════════════════════════════════════════════════════════
  // Required Field Validators
  // ═══════════════════════════════════════════════════════════════
  
  /// Validate that a field is not empty
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null 
          ? '$fieldName is required' 
          : 'This field is required';
    }
    return null;
  }

  /// Validate that a field has a minimum length
  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value == null || value.length < min) {
      return fieldName != null
          ? '$fieldName must be at least $min characters'
          : 'Must be at least $min characters';
    }
    return null;
  }

  /// Validate that a field has a maximum length
  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value != null && value.length > max) {
      return fieldName != null
          ? '$fieldName must be at most $max characters'
          : 'Must be at most $max characters';
    }
    return null;
  }

  /// Validate length range
  static String? lengthRange(String? value, int min, int max, {String? fieldName}) {
    final minError = minLength(value, min, fieldName: fieldName);
    if (minError != null) return minError;
    return maxLength(value, max, fieldName: fieldName);
  }

  // ═══════════════════════════════════════════════════════════════
  // Email Validators
  // ═══════════════════════════════════════════════════════════════
  
  /// Email regex pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$',
  );

  /// Validate email format
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════
  // Password Validators
  // ═══════════════════════════════════════════════════════════════
  
  /// Validate password strength
  static String? password(String? value, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = false,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    final errors = <String>[];

    if (value.length < minLength) {
      errors.add('at least $minLength characters');
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      errors.add('one uppercase letter');
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      errors.add('one lowercase letter');
    }

    if (requireDigit && !value.contains(RegExp(r'[0-9]'))) {
      errors.add('one number');
    }

    if (requireSpecialChar && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      errors.add('one special character');
    }

    if (errors.isNotEmpty) {
      return 'Password must contain ${errors.join(', ')}';
    }

    return null;
  }

  /// Validate password confirmation matches
  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════
  // Name Validators
  // ═══════════════════════════════════════════════════════════════
  
  /// Validate name (letters, spaces, hyphens, apostrophes)
  static String? name(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(value)) {
      return '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════
  // Project-Specific Validators (Tinseltown IQ)
  // ═══════════════════════════════════════════════════════════════
  
  /// Validate project title
  static String? projectTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Project title is required';
    }
    if (value.length < 2) {
      return 'Title must be at least 2 characters';
    }
    if (value.length > 100) {
      return 'Title must be at most 100 characters';
    }
    return null;
  }

  /// Validate logline
  static String? logline(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Logline is required';
    }
    if (value.length < 20) {
      return 'Logline should be at least 20 characters';
    }
    if (value.length > 200) {
      return 'Logline must be at most 200 characters';
    }
    return null;
  }

  /// Validate synopsis
  static String? synopsis(String? value, {bool required = false}) {
    if (required && (value == null || value.trim().isEmpty)) {
      return 'Synopsis is required';
    }
    if (value != null && value.isNotEmpty && value.length > 2000) {
      return 'Synopsis must be at most 2000 characters';
    }
    return null;
  }

  /// Validate genre selection
  static String? genre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a genre';
    }
    return null;
  }

  /// Validate format selection
  static String? format(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a format';
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════
  // Numeric Validators
  // ═══════════════════════════════════════════════════════════════
  
  /// Validate numeric input
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return fieldName != null 
          ? '$fieldName is required' 
          : 'This field is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  /// Validate integer input
  static String? integer(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return fieldName != null 
          ? '$fieldName is required' 
          : 'This field is required';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a whole number';
    }
    return null;
  }

  /// Validate number range
  static String? numberRange(String? value, double min, double max, {String? fieldName}) {
    final numericError = numeric(value, fieldName: fieldName);
    if (numericError != null) return numericError;

    final number = double.parse(value!);
    if (number < min || number > max) {
      return '${fieldName ?? 'Value'} must be between $min and $max';
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════
  // URL Validators
  // ═══════════════════════════════════════════════════════════════
  
  /// Validate URL format
  static String? url(String? value, {bool required = false}) {
    if (value == null || value.isEmpty) {
      return required ? 'URL is required' : null;
    }
    
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════
  // Phone Validators
  // ═══════════════════════════════════════════════════════════════
  
  /// Validate phone number (basic)
  static String? phone(String? value, {bool required = false}) {
    if (value == null || value.isEmpty) {
      return required ? 'Phone number is required' : null;
    }
    
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // ═══════════════════════════════════════════════════════════════
  // Composite Validators
  // ═══════════════════════════════════════════════════════════════
  
  /// Combine multiple validators
  static String? compose(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }
}

/// Form field builder with built-in validation
class ValidatedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefix;
  final Widget? suffix;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const ValidatedTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefix,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.focusNode,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      maxLength: maxLength,
      autofocus: autofocus,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}

/// Form state manager mixin
mixin FormStateMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  String? _formError;

  bool get isSubmitting => _isSubmitting;
  String? get formError => _formError;

  /// Validate and submit the form
  Future<bool> validateAndSubmit(Future<void> Function() onSubmit) async {
    // Clear previous error
    setState(() {
      _formError = null;
    });

    // Validate form
    if (!formKey.currentState!.validate()) {
      return false;
    }

    // Save form
    formKey.currentState!.save();

    // Submit
    setState(() {
      _isSubmitting = true;
    });

    try {
      await onSubmit();
      return true;
    } catch (e) {
      setState(() {
        _formError = e.toString();
      });
      return false;
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  /// Set a form-level error
  void setFormError(String error) {
    setState(() {
      _formError = error;
    });
  }

  /// Clear form error
  void clearFormError() {
    setState(() {
      _formError = null;
    });
  }
}
