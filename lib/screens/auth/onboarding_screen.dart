import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../main.dart' show OnboardingService, HomeScreen;

/// Onboarding screen with feature introduction
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  final _onboardingService = OnboardingService();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: Icons.auto_awesome,
      title: 'Welcome to GreenlightIQ™',
      description:
          'The industry\'s most powerful concept validation tool. Get AI-powered analysis that helps you pitch with confidence.',
      highlights: [
        'Score your concept 0-100',
        'Compare to 500K+ titles',
        'Match with active buyers',
      ],
      accentColor: AppColors.oscarGold,
    ),
    _OnboardingPage(
      icon: Icons.analytics_outlined,
      title: 'Smart Scoring System',
      description:
          'Our algorithm analyzes your logline, synopsis, genre trends, and market conditions to generate your GreenlightIQ™ score.',
      highlights: [
        '85+ = Strong greenlight potential',
        '70-84 = Development ready',
        '50-69 = Needs refinement',
        'Below 50 = Major revision needed',
      ],
      accentColor: AppColors.greenlightNeon,
    ),
    _OnboardingPage(
      icon: Icons.people_alt_outlined,
      title: 'Buyer & Producer Matching',
      description:
          'Discover which studios, streamers, and producers are actively looking for projects like yours.',
      highlights: [
        'Real-time market data',
        'Genre-specific recommendations',
        'Recent acquisition history',
      ],
      accentColor: AppColors.rewriteBlue,
    ),
    _OnboardingPage(
      icon: Icons.shield_outlined,
      title: 'Your Ideas Are Protected',
      description:
          'We never train AI on your concepts. Your submissions remain your intellectual property with industry-standard encryption.',
      highlights: [
        '256-bit encryption',
        'No AI training on your data',
        'Delete anytime',
      ],
      accentColor: AppColors.cautionAmber,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _navigateToHome() async {
    await _onboardingService.markOnboardingSeen();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.soundstageDark,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _navigateToHome(),
                  child: const Text(
                    'Skip →',
                    style: TextStyle(
                      color: AppColors.stageDirection,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              // Page indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    for (int i = 0; i < _pages.length; i++)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: i <= _currentPage
                                ? _pages[_currentPage].accentColor
                                : AppColors.backstage,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: i == _currentPage
                                ? [
                                    BoxShadow(
                                      color: _pages[_currentPage]
                                          .accentColor
                                          .withValues(alpha: 0.5),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : [],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon with animated glow
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.8, end: 1.0),
                            duration: const Duration(milliseconds: 500),
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.editingBay,
                                    border: Border.all(
                                      color: page.accentColor.withValues(alpha: 0.5),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: page.accentColor.withValues(alpha: 0.3),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    page.icon,
                                    size: 56,
                                    color: page.accentColor,
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 40),

                          // Title
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.scriptPrimary,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Description
                          Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.dialogueSecondary,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Feature highlights
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: page.accentColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: page.accentColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Column(
                              children: page.highlights.map((highlight) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: page.accentColor.withValues(alpha: 0.2),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          size: 14,
                                          color: page.accentColor,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          highlight,
                                          style: const TextStyle(
                                            color: AppColors.dialogueSecondary,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: _buildSecondaryButton('BACK', onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }),
                      ),
                    if (_currentPage > 0) const SizedBox(width: 16),
                    Expanded(
                      child: _buildPrimaryButton(
                        _currentPage == _pages.length - 1
                            ? 'START ANALYZING'
                            : 'NEXT',
                        onTap: () {
                          if (_currentPage < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _navigateToHome();
                          }
                        },
                        accentColor: _pages[_currentPage].accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text,
      {required VoidCallback onTap, Color? accentColor}) {
    final color = accentColor ?? AppColors.oscarGold;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.midnightPremiere,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.stageDirection, width: 1.5),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.stageDirection,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

/// Onboarding page data model
class _OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final List<String> highlights;
  final Color accentColor;

  _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.highlights,
    required this.accentColor,
  });
}
