import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'onboarding_screen.dart';
import 'sign_in_screen.dart';

/// Hollywood-themed welcome screen with animated background
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _starController;
  late AnimationController _searchlightController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Fade and slide animation for content
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    // Twinkling stars animation
    _starController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    // Searchlight rotation animation
    _searchlightController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _starController.dispose();
    _searchlightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.midnightPremiere,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0A0A12),
                  Color(0xFF151525),
                  Color(0xFF0D0D18),
                ],
              ),
            ),
          ),

          // Animated star field
          AnimatedBuilder(
            animation: _starController,
            builder: (context, child) {
              return CustomPaint(
                size: screenSize,
                painter: StarFieldPainter(
                  animationValue: _starController.value,
                ),
              );
            },
          ),

          // Hills silhouette
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(screenSize.width, 200),
              painter: HillsPainter(),
            ),
          ),

          // Searchlight beams
          AnimatedBuilder(
            animation: _searchlightController,
            builder: (context, child) {
              return CustomPaint(
                size: screenSize,
                painter: SearchlightPainter(
                  animationValue: _searchlightController.value,
                ),
              );
            },
          ),

          // Main content
          SafeArea(
            child: AnimatedBuilder(
              animation: _fadeController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 2),

                          // Logo with glow effect
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.oscarGold.withValues(alpha: 0.6),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.oscarGold.withValues(alpha: 0.3),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'IQ',
                                style: TextStyle(
                                  color: AppColors.oscarGold,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Title
                          Column(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: const Text(
                                  'TINSELTOWN',
                                  style: TextStyle(
                                    color: AppColors.scriptPrimary,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w200,
                                    letterSpacing: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 60,
                                    child: Divider(color: AppColors.oscarGold, thickness: 1),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      'IQ',
                                      style: TextStyle(
                                        color: AppColors.oscarGold,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 8,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 60,
                                    child: Divider(color: AppColors.oscarGold, thickness: 1),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Tagline
                          const Text(
                            '"Every great film starts\nwith a greenlit concept"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.stageDirection,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              height: 1.6,
                            ),
                          ),

                          const Spacer(flex: 2),

                          // Enter button
                          GestureDetector(
                            onTap: () => _navigateToOnboarding(context),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                color: AppColors.oscarGold,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.oscarGold.withValues(alpha: 0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'ENTER THE LOT',
                                  style: TextStyle(
                                    color: AppColors.midnightPremiere,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Sign in link
                          TextButton(
                            onPressed: () => _navigateToSignIn(context),
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  color: AppColors.stageDirection,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(text: 'Already have an account? '),
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                      color: AppColors.oscarGold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToOnboarding(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  void _navigateToSignIn(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }
}

/// Custom painter for animated star field
class StarFieldPainter extends CustomPainter {
  final double animationValue;
  final List<_Star> _stars = [];
  static bool _starsInitialized = false;

  StarFieldPainter({required this.animationValue}) {
    if (!_starsInitialized) {
      final random = math.Random(42);
      for (int i = 0; i < 100; i++) {
        _stars.add(_Star(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 2 + 0.5,
          twinkleSpeed: random.nextDouble() * 2 + 1,
          twinklePhase: random.nextDouble() * math.pi * 2,
        ));
      }
      _starsInitialized = true;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in _stars) {
      final twinkle = (math.sin(animationValue * math.pi * 2 * star.twinkleSpeed + star.twinklePhase) + 1) / 2;
      final alpha = 0.3 + twinkle * 0.7;
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: alpha)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size * (0.8 + twinkle * 0.4),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class _Star {
  final double x, y, size, twinkleSpeed, twinklePhase;
  _Star({required this.x, required this.y, required this.size, required this.twinkleSpeed, required this.twinklePhase});
}

/// Custom painter for Hollywood hills silhouette
class HillsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0A0A10)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.3, size.width * 0.3, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.45, size.height * 0.7, size.width * 0.55, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.1, size.width * 0.85, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.5, size.width, size.height * 0.45);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for animated searchlight beams
class SearchlightPainter extends CustomPainter {
  final double animationValue;

  SearchlightPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw multiple searchlight beams
    for (int i = 0; i < 3; i++) {
      final baseAngle = (animationValue * math.pi * 2 + i * math.pi / 1.5) % (math.pi * 2);
      final centerX = size.width * (0.2 + i * 0.3);
      final centerY = size.height * 0.9;

      final path = Path();
      final angle1 = baseAngle - 0.1;
      final angle2 = baseAngle + 0.1;
      final length = size.height * 1.2;

      path.moveTo(centerX, centerY);
      path.lineTo(
        centerX + math.cos(angle1 - math.pi / 2) * length,
        centerY - math.sin(angle1 + math.pi / 2) * length,
      );
      path.lineTo(
        centerX + math.cos(angle2 - math.pi / 2) * length,
        centerY - math.sin(angle2 + math.pi / 2) * length,
      );
      path.close();

      paint.shader = RadialGradient(
        center: Alignment.bottomCenter,
        radius: 1.0,
        colors: [
          AppColors.oscarGold.withValues(alpha: 0.08),
          AppColors.oscarGold.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: length));

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SearchlightPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
