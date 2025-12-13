import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Global error handling utilities for Tinseltown IQ
/// 
/// Provides comprehensive error handling, crash recovery, and user-friendly error displays.

/// Error severity levels for categorizing errors
enum ErrorSeverity {
  /// Minor issues that don't affect functionality
  warning,
  /// Errors that may affect some features
  error,
  /// Critical errors that prevent app usage
  critical,
}

/// Structured error information for logging and display
class AppError {
  final String message;
  final String? details;
  final ErrorSeverity severity;
  final DateTime timestamp;
  final String? stackTrace;
  final String? source;

  AppError({
    required this.message,
    this.details,
    this.severity = ErrorSeverity.error,
    DateTime? timestamp,
    this.stackTrace,
    this.source,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'message': message,
    'details': details,
    'severity': severity.name,
    'timestamp': timestamp.toIso8601String(),
    'stackTrace': stackTrace,
    'source': source,
  };

  @override
  String toString() => 'AppError($severity): $message${details != null ? ' - $details' : ''}';
}

/// Global error handler singleton
class ErrorHandler {
  static final ErrorHandler _instance = ErrorHandler._internal();
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();

  final List<AppError> _errorLog = [];
  final int _maxLogSize = 100;
  
  /// Callbacks for external error reporting (e.g., Firebase Crashlytics)
  void Function(AppError error)? onError;
  void Function(FlutterErrorDetails details)? onFlutterError;

  /// Initialize error handling for the app
  static void initialize() {
    // Set up Flutter error handling
    FlutterError.onError = (FlutterErrorDetails details) {
      ErrorHandler()._handleFlutterError(details);
    };

    // Set up custom error widget for release mode
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return ErrorHandler.buildErrorWidget(
        context: null,
        error: details.exception.toString(),
        onRetry: null,
      );
    };
  }

  /// Run the app within a guarded zone for async error handling
  static Future<void> runGuarded(Future<void> Function() appRunner) async {
    await runZonedGuarded(
      () async {
        await appRunner();
      },
      (error, stackTrace) {
        ErrorHandler()._handleZoneError(error, stackTrace);
      },
    );
  }

  void _handleFlutterError(FlutterErrorDetails details) {
    final error = AppError(
      message: 'Flutter Framework Error',
      details: details.exceptionAsString(),
      severity: ErrorSeverity.critical,
      stackTrace: details.stack?.toString(),
      source: 'FlutterError',
    );
    
    _logError(error);
    
    // Call external handler if configured
    onFlutterError?.call(details);
    
    // In debug mode, also print to console
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    }
  }

  void _handleZoneError(Object error, StackTrace stackTrace) {
    final appError = AppError(
      message: 'Unhandled Async Error',
      details: error.toString(),
      severity: ErrorSeverity.critical,
      stackTrace: stackTrace.toString(),
      source: 'Zone',
    );
    
    _logError(appError);
    
    // Call external handler if configured
    onError?.call(appError);
    
    // In debug mode, print to console
    if (kDebugMode) {
      debugPrint('Zone Error: $error');
      debugPrint('Stack Trace: $stackTrace');
    }
  }

  /// Log an error to the internal log
  void _logError(AppError error) {
    _errorLog.add(error);
    
    // Trim log if it exceeds max size
    while (_errorLog.length > _maxLogSize) {
      _errorLog.removeAt(0);
    }
  }

  /// Report an error manually
  void reportError(
    String message, {
    String? details,
    ErrorSeverity severity = ErrorSeverity.error,
    String? stackTrace,
    String? source,
  }) {
    final error = AppError(
      message: message,
      details: details,
      severity: severity,
      stackTrace: stackTrace,
      source: source,
    );
    
    _logError(error);
    onError?.call(error);
  }

  /// Get recent errors for debugging
  List<AppError> getRecentErrors({int count = 10}) {
    final start = _errorLog.length > count ? _errorLog.length - count : 0;
    return _errorLog.sublist(start);
  }

  /// Clear error log
  void clearErrorLog() {
    _errorLog.clear();
  }

  /// Build a user-friendly error widget
  static Widget buildErrorWidget({
    BuildContext? context,
    required String error,
    VoidCallback? onRetry,
    String? title,
    IconData? icon,
  }) {
    return Material(
      color: const Color(0xFF14141F),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.error_outline,
                  size: 64,
                  color: const Color(0xFFFF5252),
                ),
                const SizedBox(height: 24),
                Text(
                  title ?? 'Oops! Something went wrong',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  kDebugMode ? error : 'An unexpected error occurred. Please try again.',
                  style: const TextStyle(
                    color: Color(0xFF9090A0),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4A84B),
                      foregroundColor: const Color(0xFF0D0D12),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that catches errors in its child tree and displays a fallback UI
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(FlutterErrorDetails details)? errorBuilder;
  final void Function(FlutterErrorDetails details)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  FlutterErrorDetails? _errorDetails;

  @override
  void initState() {
    super.initState();
    FlutterError.onError = _handleError;
  }

  void _handleError(FlutterErrorDetails details) {
    widget.onError?.call(details);
    
    if (mounted) {
      setState(() {
        _errorDetails = details;
      });
    }
  }

  void _resetError() {
    setState(() {
      _errorDetails = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_errorDetails != null) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(_errorDetails!);
      }
      
      return ErrorHandler.buildErrorWidget(
        context: context,
        error: _errorDetails!.exceptionAsString(),
        onRetry: _resetError,
        title: 'Something went wrong',
      );
    }
    
    return widget.child;
  }
}

/// Mixin for State classes to handle async errors gracefully
mixin AsyncErrorHandler<T extends StatefulWidget> on State<T> {
  bool _hasError = false;
  String? _errorMessage;

  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;

  /// Execute an async operation with error handling
  Future<R?> safeAsync<R>(
    Future<R> Function() operation, {
    String? errorMessage,
    VoidCallback? onError,
    bool showSnackBar = true,
  }) async {
    try {
      clearError();
      return await operation();
    } catch (e, stackTrace) {
      _hasError = true;
      _errorMessage = errorMessage ?? e.toString();
      
      // Log the error
      ErrorHandler().reportError(
        _errorMessage!,
        details: e.toString(),
        stackTrace: stackTrace.toString(),
        source: T.toString(),
      );
      
      // Show snackbar if enabled
      if (showSnackBar && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _errorMessage!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFF5252),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
      
      onError?.call();
      
      if (mounted) {
        setState(() {});
      }
      
      return null;
    }
  }

  /// Clear the error state
  void clearError() {
    _hasError = false;
    _errorMessage = null;
  }
}

/// Extension for showing error dialogs
extension ErrorDialogExtension on BuildContext {
  /// Show an error dialog
  Future<void> showErrorDialog({
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) async {
    return showDialog<void>(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.error_outline, color: Color(0xFFFF5252)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Color(0xFF9090A0),
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed?.call();
              },
              child: Text(
                buttonText ?? 'OK',
                style: const TextStyle(
                  color: Color(0xFFD4A84B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Show a retry dialog
  Future<bool> showRetryDialog({
    required String title,
    required String message,
  }) async {
    final result = await showDialog<bool>(
      context: this,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFFFAB00)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Color(0xFF9090A0),
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF9090A0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A84B),
                foregroundColor: const Color(0xFF0D0D12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
    
    return result ?? false;
  }
}

/// Network error types for better error messages
enum NetworkErrorType {
  noConnection,
  timeout,
  serverError,
  unauthorized,
  notFound,
  unknown,
}

/// Helper to categorize network errors
class NetworkErrorHelper {
  static NetworkErrorType categorize(dynamic error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('socketexception') || 
        errorString.contains('no internet') ||
        errorString.contains('network is unreachable')) {
      return NetworkErrorType.noConnection;
    }
    
    if (errorString.contains('timeout')) {
      return NetworkErrorType.timeout;
    }
    
    if (errorString.contains('401') || errorString.contains('unauthorized')) {
      return NetworkErrorType.unauthorized;
    }
    
    if (errorString.contains('404') || errorString.contains('not found')) {
      return NetworkErrorType.notFound;
    }
    
    if (errorString.contains('500') || errorString.contains('server error')) {
      return NetworkErrorType.serverError;
    }
    
    return NetworkErrorType.unknown;
  }

  static String getMessage(NetworkErrorType type) {
    switch (type) {
      case NetworkErrorType.noConnection:
        return 'No internet connection. Please check your network settings.';
      case NetworkErrorType.timeout:
        return 'Request timed out. Please try again.';
      case NetworkErrorType.serverError:
        return 'Server error. Our team has been notified.';
      case NetworkErrorType.unauthorized:
        return 'Authentication required. Please sign in again.';
      case NetworkErrorType.notFound:
        return 'The requested resource was not found.';
      case NetworkErrorType.unknown:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
