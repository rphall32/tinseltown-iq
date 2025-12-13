// App Animations - Reusable Animation Utilities
//
// Provides consistent animations, transitions, and motion throughout the app.
// Inspired by cinematic motion design for the Tinseltown IQ brand.

import 'package:flutter/material.dart';

/// Animation duration presets
abstract class AppDurations {
  AppDurations._();

  /// Instant (0ms) - For immediate changes
  static const Duration instant = Duration.zero;

  /// Extra fast (100ms) - Micro-interactions
  static const Duration extraFast = Duration(milliseconds: 100);

  /// Fast (200ms) - Quick feedback
  static const Duration fast = Duration(milliseconds: 200);

  /// Normal (300ms) - Standard transitions
  static const Duration normal = Duration(milliseconds: 300);

  /// Medium (400ms) - Emphasis transitions
  static const Duration medium = Duration(milliseconds: 400);

  /// Slow (500ms) - Deliberate animations
  static const Duration slow = Duration(milliseconds: 500);

  /// Extra slow (700ms) - Dramatic effect
  static const Duration extraSlow = Duration(milliseconds: 700);

  /// Page transition duration
  static const Duration pageTransition = Duration(milliseconds: 350);

  /// Modal/sheet animation duration
  static const Duration modal = Duration(milliseconds: 300);

  /// Splash/intro animation duration
  static const Duration splash = Duration(milliseconds: 2000);
}

/// Animation curve presets
abstract class AppCurves {
  AppCurves._();

  /// Standard ease - General purpose
  static const Curve standard = Curves.easeInOut;

  /// Ease out - Elements entering
  static const Curve enter = Curves.easeOutCubic;

  /// Ease in - Elements exiting
  static const Curve exit = Curves.easeInCubic;

  /// Emphasis - Draw attention
  static const Curve emphasis = Curves.easeOutBack;

  /// Bounce - Playful feedback
  static const Curve bounce = Curves.elasticOut;

  /// Sharp - Quick, precise
  static const Curve sharp = Curves.easeOutQuart;

  /// Smooth - Cinematic feel
  static const Curve cinematic = Curves.easeInOutCubic;

  /// Decelerate - Slowing down
  static const Curve decelerate = Curves.decelerate;

  /// Linear - Constant speed
  static const Curve linear = Curves.linear;
}

/// Pre-built page route transitions
class AppPageRoutes {
  AppPageRoutes._();

  /// Fade transition (cinematic style)
  static PageRouteBuilder<T> fade<T>({
    required Widget page,
    RouteSettings? settings,
    Duration? duration,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: AppCurves.cinematic,
          ),
          child: child,
        );
      },
      transitionDuration: duration ?? AppDurations.pageTransition,
    );
  }

  /// Slide from right (standard push)
  static PageRouteBuilder<T> slideRight<T>({
    required Widget page,
    RouteSettings? settings,
    Duration? duration,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: AppCurves.enter,
        ));

        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
      transitionDuration: duration ?? AppDurations.pageTransition,
    );
  }

  /// Slide from bottom (modal style)
  static PageRouteBuilder<T> slideUp<T>({
    required Widget page,
    RouteSettings? settings,
    Duration? duration,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: AppCurves.enter,
        ));

        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
      transitionDuration: duration ?? AppDurations.pageTransition,
    );
  }

  /// Scale with fade (cinematic zoom)
  static PageRouteBuilder<T> scaleUp<T>({
    required Widget page,
    RouteSettings? settings,
    Duration? duration,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = Tween<double>(
          begin: 0.9,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: AppCurves.enter,
        ));

        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: AppCurves.standard,
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: duration ?? AppDurations.pageTransition,
    );
  }

  /// Shared axis horizontal (Material motion)
  static PageRouteBuilder<T> sharedAxisHorizontal<T>({
    required Widget page,
    RouteSettings? settings,
    Duration? duration,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.3, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: AppCurves.enter,
        ));

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: duration ?? AppDurations.pageTransition,
    );
  }
}

/// Animated wrapper widgets
class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  const FadeInWidget({
    super.key,
    required this.child,
    this.duration = AppDurations.normal,
    this.delay = Duration.zero,
    this.curve = AppCurves.enter,
  });

  @override
  State<FadeInWidget> createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

/// Slide and fade in widget
class SlideInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final Offset begin;

  const SlideInWidget({
    super.key,
    required this.child,
    this.duration = AppDurations.normal,
    this.delay = Duration.zero,
    this.curve = AppCurves.enter,
    this.begin = const Offset(0, 0.3),
  });

  /// Slide in from left
  factory SlideInWidget.fromLeft({
    Key? key,
    required Widget child,
    Duration duration = AppDurations.normal,
    Duration delay = Duration.zero,
  }) {
    return SlideInWidget(
      key: key,
      duration: duration,
      delay: delay,
      begin: const Offset(-0.3, 0),
      child: child,
    );
  }

  /// Slide in from right
  factory SlideInWidget.fromRight({
    Key? key,
    required Widget child,
    Duration duration = AppDurations.normal,
    Duration delay = Duration.zero,
  }) {
    return SlideInWidget(
      key: key,
      duration: duration,
      delay: delay,
      begin: const Offset(0.3, 0),
      child: child,
    );
  }

  /// Slide in from bottom
  factory SlideInWidget.fromBottom({
    Key? key,
    required Widget child,
    Duration duration = AppDurations.normal,
    Duration delay = Duration.zero,
  }) {
    return SlideInWidget(
      key: key,
      duration: duration,
      delay: delay,
      begin: const Offset(0, 0.3),
      child: child,
    );
  }

  /// Slide in from top
  factory SlideInWidget.fromTop({
    Key? key,
    required Widget child,
    Duration duration = AppDurations.normal,
    Duration delay = Duration.zero,
  }) {
    return SlideInWidget(
      key: key,
      duration: duration,
      delay: delay,
      begin: const Offset(0, -0.3),
      child: child,
    );
  }

  @override
  State<SlideInWidget> createState() => _SlideInWidgetState();
}

class _SlideInWidgetState extends State<SlideInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Scale in widget with optional bounce
class ScaleInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double begin;

  const ScaleInWidget({
    super.key,
    required this.child,
    this.duration = AppDurations.normal,
    this.delay = Duration.zero,
    this.curve = AppCurves.enter,
    this.begin = 0.8,
  });

  /// Scale in with bounce effect
  factory ScaleInWidget.bounce({
    Key? key,
    required Widget child,
    Duration duration = AppDurations.medium,
    Duration delay = Duration.zero,
  }) {
    return ScaleInWidget(
      key: key,
      duration: duration,
      delay: delay,
      curve: AppCurves.bounce,
      begin: 0.5,
      child: child,
    );
  }

  @override
  State<ScaleInWidget> createState() => _ScaleInWidgetState();
}

class _ScaleInWidgetState extends State<ScaleInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.begin,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Staggered animation for lists
class StaggeredListAnimation extends StatelessWidget {
  final List<Widget> children;
  final Duration itemDuration;
  final Duration staggerDelay;
  final Curve curve;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const StaggeredListAnimation({
    super.key,
    required this.children,
    this.itemDuration = AppDurations.normal,
    this.staggerDelay = const Duration(milliseconds: 50),
    this.curve = AppCurves.enter,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        return SlideInWidget.fromBottom(
          duration: itemDuration,
          delay: staggerDelay * index,
          child: child,
        );
      }).toList(),
    );
  }
}

/// Animated counter for numbers
class AnimatedCounter extends StatelessWidget {
  final int value;
  final Duration duration;
  final TextStyle? style;
  final String? prefix;
  final String? suffix;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.duration = AppDurations.slow,
    this.style,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      curve: AppCurves.decelerate,
      builder: (context, animatedValue, child) {
        return Text(
          '${prefix ?? ''}$animatedValue${suffix ?? ''}',
          style: style,
        );
      },
    );
  }
}

/// Animated progress bar
class AnimatedProgressBar extends StatelessWidget {
  final double value;
  final Duration duration;
  final Color? backgroundColor;
  final Color? valueColor;
  final double height;
  final BorderRadius? borderRadius;

  const AnimatedProgressBar({
    super.key,
    required this.value,
    this.duration = AppDurations.medium,
    this.backgroundColor,
    this.valueColor,
    this.height = 8.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surfaceContainerHighest,
        borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: value.clamp(0.0, 1.0)),
        duration: duration,
        curve: AppCurves.decelerate,
        builder: (context, animatedValue, child) {
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: animatedValue,
            child: Container(
              decoration: BoxDecoration(
                color: valueColor ?? theme.colorScheme.primary,
                borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Shake animation for error feedback
class ShakeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double amplitude;
  final bool shake;
  final VoidCallback? onShakeComplete;

  const ShakeWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.amplitude = 10.0,
    this.shake = false,
    this.onShakeComplete,
  });

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticIn),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        widget.onShakeComplete?.call();
      }
    });

    if (widget.shake) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(ShakeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shake && !oldWidget.shake) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _shakeOffset(double progress) {
    const count = 4;
    return widget.amplitude *
        (1 - progress) *
        (progress < 0.5 ? 1 : -1) *
        (progress * count * 2 * 3.14159).abs();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeOffset(_animation.value), 0),
          child: widget.child,
        );
      },
    );
  }
}

/// Pulse animation for attention
class PulseWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;
  final bool enabled;

  const PulseWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.minScale = 0.95,
    this.maxScale = 1.05,
    this.enabled = true,
  });

  @override
  State<PulseWidget> createState() => _PulseWidgetState();
}

class _PulseWidgetState extends State<PulseWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.enabled) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PulseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}

/// Extension for easy animation access
extension AnimationExtension on Widget {
  /// Wrap widget with fade in animation
  Widget fadeIn({
    Duration duration = AppDurations.normal,
    Duration delay = Duration.zero,
  }) {
    return FadeInWidget(
      duration: duration,
      delay: delay,
      child: this,
    );
  }

  /// Wrap widget with slide in animation
  Widget slideIn({
    Duration duration = AppDurations.normal,
    Duration delay = Duration.zero,
    Offset begin = const Offset(0, 0.3),
  }) {
    return SlideInWidget(
      duration: duration,
      delay: delay,
      begin: begin,
      child: this,
    );
  }

  /// Wrap widget with scale in animation
  Widget scaleIn({
    Duration duration = AppDurations.normal,
    Duration delay = Duration.zero,
    double begin = 0.8,
  }) {
    return ScaleInWidget(
      duration: duration,
      delay: delay,
      begin: begin,
      child: this,
    );
  }

  /// Wrap widget with pulse animation
  Widget pulse({
    Duration duration = const Duration(milliseconds: 1500),
    bool enabled = true,
  }) {
    return PulseWidget(
      duration: duration,
      enabled: enabled,
      child: this,
    );
  }
}
