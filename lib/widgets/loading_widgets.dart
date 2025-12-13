import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_radius.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Tinseltown IQ Loading State System
/// 
/// Standardized loading indicators and states for consistent UX.

// ═══════════════════════════════════════════════════════════════
// Loading State Enum
// ═══════════════════════════════════════════════════════════════

enum LoadingState {
  idle,
  loading,
  success,
  error,
}

// ═══════════════════════════════════════════════════════════════
// Standard Loading Indicators
// ═══════════════════════════════════════════════════════════════

/// Standard circular loading indicator
class AppLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;

  const AppLoadingIndicator({
    super.key,
    this.size = 24,
    this.color,
    this.strokeWidth = 2.5,
  });

  /// Small variant
  const AppLoadingIndicator.small({super.key})
      : size = 16,
        color = null,
        strokeWidth = 2.0;

  /// Medium variant (default)
  const AppLoadingIndicator.medium({super.key})
      : size = 24,
        color = null,
        strokeWidth = 2.5;

  /// Large variant
  const AppLoadingIndicator.large({super.key})
      : size = 40,
        color = null,
        strokeWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.oscarGold,
        ),
      ),
    );
  }
}

/// Full-screen loading overlay
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? barrierColor;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.barrierColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: barrierColor ?? Colors.black.withValues(alpha: 0.5),
            child: Center(
              child: Container(
                padding: AppSpacing.allXxl,
                decoration: BoxDecoration(
                  color: AppColors.editingBay,
                  borderRadius: AppRadius.roundedXl,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AppLoadingIndicator.large(),
                    if (message != null) ...[
                      AppSpacing.gapLg,
                      Text(
                        message!,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.dialogueSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Inline loading button
class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String text;
  final String? loadingText;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final EdgeInsets? padding;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.loadingText,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.oscarGold,
          foregroundColor: foregroundColor ?? AppColors.midnightPremiere,
          padding: padding ?? AppSpacing.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.button,
          ),
          disabledBackgroundColor: (backgroundColor ?? AppColors.oscarGold)
              .withValues(alpha: 0.6),
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        foregroundColor ?? AppColors.midnightPremiere,
                      ),
                    ),
                  ),
                  if (loadingText != null) ...[
                    AppSpacing.hGapSm,
                    Text(loadingText!),
                  ],
                ],
              )
            : Text(text),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Skeleton Loading (Shimmer Effect)
// ═══════════════════════════════════════════════════════════════

/// Skeleton loading placeholder with shimmer effect
class SkeletonLoader extends StatefulWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  /// Text line skeleton
  const SkeletonLoader.text({
    super.key,
    this.width,
  }) : height = 14,
       borderRadius = const BorderRadius.all(Radius.circular(4));

  /// Title skeleton
  const SkeletonLoader.title({
    super.key,
    this.width,
  }) : height = 20,
       borderRadius = const BorderRadius.all(Radius.circular(4));

  /// Avatar skeleton (circular)
  factory SkeletonLoader.avatar({
    Key? key,
    double size = 40,
  }) {
    return SkeletonLoader(
      key: key,
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }

  /// Card skeleton
  const SkeletonLoader.card({
    super.key,
    this.width,
    this.height = 120,
  }) : borderRadius = AppRadius.cardDefault;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? AppRadius.roundedSm,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFF2F2F42),
                Color(0xFF3A3A50),
                Color(0xFF2F2F42),
              ],
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Skeleton card with common layout
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.card,
      decoration: BoxDecoration(
        color: AppColors.editingBay,
        borderRadius: AppRadius.cardDefault,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SkeletonLoader.avatar(size: 48),
              AppSpacing.hGapMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonLoader.title(width: 120),
                    AppSpacing.gapSm,
                    SkeletonLoader.text(width: 80),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.gapLg,
          const SkeletonLoader.text(),
          AppSpacing.gapSm,
          SkeletonLoader.text(width: MediaQuery.of(context).size.width * 0.7),
          AppSpacing.gapSm,
          SkeletonLoader.text(width: MediaQuery.of(context).size.width * 0.5),
        ],
      ),
    );
  }
}

/// Skeleton list
class SkeletonList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final EdgeInsets? padding;

  const SkeletonList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding ?? AppSpacing.screen,
      itemCount: itemCount,
      separatorBuilder: (_, __) => AppSpacing.gapMd,
      itemBuilder: (_, __) => const SkeletonCard(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Empty States
// ═══════════════════════════════════════════════════════════════

/// Empty state widget
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allXxxl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.backstage,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                icon,
                size: 40,
                color: AppColors.stageDirection,
              ),
            ),
            AppSpacing.gapXxl,
            Text(
              title,
              style: AppTypography.headlineSmall.copyWith(
                color: AppColors.scriptPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              AppSpacing.gapMd,
              Text(
                message!,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.stageDirection,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              AppSpacing.gapXxl,
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.oscarGold,
                  foregroundColor: AppColors.midnightPremiere,
                  padding: AppSpacing.buttonPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.button,
                  ),
                ),
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Error States
// ═══════════════════════════════════════════════════════════════

/// Error state widget
class ErrorState extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorState({
    super.key,
    this.title = 'Something went wrong',
    this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppSpacing.allXxxl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.cutRed.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                icon,
                size: 40,
                color: AppColors.cutRed,
              ),
            ),
            AppSpacing.gapXxl,
            Text(
              title,
              style: AppTypography.headlineSmall.copyWith(
                color: AppColors.scriptPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              AppSpacing.gapMd,
              Text(
                message!,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.stageDirection,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              AppSpacing.gapXxl,
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.oscarGold,
                  foregroundColor: AppColors.midnightPremiere,
                  padding: AppSpacing.buttonPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.button,
                  ),
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
// Async Content Builder
// ═══════════════════════════════════════════════════════════════

/// Widget that handles loading, error, and success states
class AsyncContentBuilder<T> extends StatelessWidget {
  final LoadingState state;
  final T? data;
  final String? errorMessage;
  final Widget Function(T data) builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final VoidCallback? onRetry;

  const AsyncContentBuilder({
    super.key,
    required this.state,
    required this.data,
    required this.builder,
    this.errorMessage,
    this.loadingWidget,
    this.errorWidget,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case LoadingState.idle:
      case LoadingState.loading:
        return loadingWidget ?? const Center(child: AppLoadingIndicator.large());
      
      case LoadingState.error:
        return errorWidget ?? ErrorState(
          message: errorMessage,
          onRetry: onRetry,
        );
      
      case LoadingState.success:
        if (data != null) {
          return builder(data as T);
        }
        return const EmptyState(
          icon: Icons.inbox_outlined,
          title: 'No data available',
        );
    }
  }
}

// ═══════════════════════════════════════════════════════════════
// Loading State Mixin
// ═══════════════════════════════════════════════════════════════

/// Mixin for managing loading states in StatefulWidgets
mixin LoadingStateMixin<T extends StatefulWidget> on State<T> {
  LoadingState _loadingState = LoadingState.idle;
  String? _errorMessage;

  LoadingState get loadingState => _loadingState;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _loadingState == LoadingState.loading;
  bool get hasError => _loadingState == LoadingState.error;
  bool get isSuccess => _loadingState == LoadingState.success;

  /// Set loading state
  void setLoading() {
    if (mounted) {
      setState(() {
        _loadingState = LoadingState.loading;
        _errorMessage = null;
      });
    }
  }

  /// Set success state
  void setSuccess() {
    if (mounted) {
      setState(() {
        _loadingState = LoadingState.success;
        _errorMessage = null;
      });
    }
  }

  /// Set error state
  void setError([String? message]) {
    if (mounted) {
      setState(() {
        _loadingState = LoadingState.error;
        _errorMessage = message;
      });
    }
  }

  /// Reset to idle state
  void setIdle() {
    if (mounted) {
      setState(() {
        _loadingState = LoadingState.idle;
        _errorMessage = null;
      });
    }
  }

  /// Execute an async operation with automatic state management
  Future<R?> runAsync<R>(Future<R> Function() operation) async {
    setLoading();
    try {
      final result = await operation();
      setSuccess();
      return result;
    } catch (e) {
      setError(e.toString());
      return null;
    }
  }
}
