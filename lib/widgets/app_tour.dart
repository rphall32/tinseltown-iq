import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App Tour / Onboarding Widgets
/// 
/// Interactive feature introduction and guided tour system.

/// Tour step configuration
class TourStep {
  final String id;
  final String title;
  final String description;
  final GlobalKey? targetKey;
  final IconData? icon;
  final Color? iconColor;
  final String? imagePath;
  final TooltipPosition position;
  final bool canSkip;

  const TourStep({
    required this.id,
    required this.title,
    required this.description,
    this.targetKey,
    this.icon,
    this.iconColor,
    this.imagePath,
    this.position = TooltipPosition.bottom,
    this.canSkip = true,
  });
}

/// Tooltip position relative to target
enum TooltipPosition {
  top,
  bottom,
  left,
  right,
  center,
}

/// App Tour Controller
class AppTourController extends ChangeNotifier {
  static final AppTourController _instance = AppTourController._internal();
  factory AppTourController() => _instance;
  AppTourController._internal();

  static const String _hasSeenTourKey = 'has_seen_app_tour';
  static const String _tourVersionKey = 'tour_version';
  static const int _currentTourVersion = 1;

  List<TourStep> _steps = [];
  int _currentStepIndex = 0;
  bool _isActive = false;
  bool _hasSeenTour = false;
  
  // Callbacks
  VoidCallback? onTourComplete;
  VoidCallback? onTourSkipped;
  void Function(int)? onStepChanged;

  List<TourStep> get steps => _steps;
  int get currentStepIndex => _currentStepIndex;
  bool get isActive => _isActive;
  bool get hasSeenTour => _hasSeenTour;
  TourStep? get currentStep => 
      _currentStepIndex < _steps.length ? _steps[_currentStepIndex] : null;
  bool get isFirstStep => _currentStepIndex == 0;
  bool get isLastStep => _currentStepIndex == _steps.length - 1;
  double get progress => _steps.isEmpty ? 0 : (_currentStepIndex + 1) / _steps.length;

  /// Initialize the tour controller
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _hasSeenTour = prefs.getBool(_hasSeenTourKey) ?? false;
    final savedVersion = prefs.getInt(_tourVersionKey) ?? 0;
    
    // Reset tour if version has been updated
    if (savedVersion < _currentTourVersion) {
      _hasSeenTour = false;
    }
    
    notifyListeners();
  }

  /// Configure tour steps
  void setSteps(List<TourStep> steps) {
    _steps = steps;
    _currentStepIndex = 0;
    notifyListeners();
  }

  /// Start the tour
  void startTour() {
    if (_steps.isEmpty) return;
    _isActive = true;
    _currentStepIndex = 0;
    notifyListeners();
  }

  /// Go to next step
  void nextStep() {
    if (_currentStepIndex < _steps.length - 1) {
      _currentStepIndex++;
      onStepChanged?.call(_currentStepIndex);
      notifyListeners();
    } else {
      completeTour();
    }
  }

  /// Go to previous step
  void previousStep() {
    if (_currentStepIndex > 0) {
      _currentStepIndex--;
      onStepChanged?.call(_currentStepIndex);
      notifyListeners();
    }
  }

  /// Go to specific step
  void goToStep(int index) {
    if (index >= 0 && index < _steps.length) {
      _currentStepIndex = index;
      onStepChanged?.call(_currentStepIndex);
      notifyListeners();
    }
  }

  /// Complete the tour
  Future<void> completeTour() async {
    _isActive = false;
    _hasSeenTour = true;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenTourKey, true);
    await prefs.setInt(_tourVersionKey, _currentTourVersion);
    
    onTourComplete?.call();
    notifyListeners();
  }

  /// Skip the tour
  Future<void> skipTour() async {
    _isActive = false;
    _hasSeenTour = true;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenTourKey, true);
    await prefs.setInt(_tourVersionKey, _currentTourVersion);
    
    onTourSkipped?.call();
    notifyListeners();
  }

  /// Reset tour (for testing or allowing replay)
  Future<void> resetTour() async {
    _hasSeenTour = false;
    _currentStepIndex = 0;
    _isActive = false;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_hasSeenTourKey);
    await prefs.remove(_tourVersionKey);
    
    notifyListeners();
  }
}

/// Tour overlay widget that displays the current step
class TourOverlay extends StatelessWidget {
  final TourStep step;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSkip;
  final bool isFirstStep;
  final bool isLastStep;
  final double progress;

  const TourOverlay({
    super.key,
    required this.step,
    required this.onNext,
    required this.onPrevious,
    required this.onSkip,
    required this.isFirstStep,
    required this.isLastStep,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.7),
      child: SafeArea(
        child: Stack(
          children: [
            // Tap anywhere to proceed
            GestureDetector(
              onTap: onNext,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
            
            // Content card
            Center(
              child: Container(
                margin: const EdgeInsets.all(32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C2A),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon
                    if (step.icon != null)
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: (step.iconColor ?? const Color(0xFFD4A84B))
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Icon(
                          step.icon,
                          size: 32,
                          color: step.iconColor ?? const Color(0xFFD4A84B),
                        ),
                      ),
                    
                    const SizedBox(height: 20),
                    
                    // Title
                    Text(
                      step.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Description
                    Text(
                      step.description,
                      style: const TextStyle(
                        color: Color(0xFF9090A0),
                        fontSize: 15,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Progress indicator
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFF2F2F42),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4A84B)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Navigation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        if (!isFirstStep)
                          TextButton(
                            onPressed: onPrevious,
                            child: const Text(
                              'Back',
                              style: TextStyle(
                                color: Color(0xFF9090A0),
                              ),
                            ),
                          )
                        else if (step.canSkip)
                          TextButton(
                            onPressed: onSkip,
                            child: const Text(
                              'Skip Tour',
                              style: TextStyle(
                                color: Color(0xFF9090A0),
                              ),
                            ),
                          )
                        else
                          const SizedBox(width: 80),
                        
                        // Next button
                        ElevatedButton(
                          onPressed: onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4A84B),
                            foregroundColor: const Color(0xFF0D0D12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isLastStep ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Feature spotlight widget - highlights a specific UI element
class FeatureSpotlight extends StatelessWidget {
  final GlobalKey targetKey;
  final String title;
  final String description;
  final VoidCallback onDismiss;
  final TooltipPosition position;

  const FeatureSpotlight({
    super.key,
    required this.targetKey,
    required this.title,
    required this.description,
    required this.onDismiss,
    this.position = TooltipPosition.bottom,
  });

  @override
  Widget build(BuildContext context) {
    // Get the target widget's position
    final RenderBox? renderBox = targetKey.currentContext?.findRenderObject() as RenderBox?;
    final Offset? targetPosition = renderBox?.localToGlobal(Offset.zero);
    final Size? targetSize = renderBox?.size;

    if (targetPosition == null || targetSize == null) {
      return const SizedBox.shrink();
    }

    // Calculate spotlight position
    final spotlightRect = Rect.fromLTWH(
      targetPosition.dx - 8,
      targetPosition.dy - 8,
      targetSize.width + 16,
      targetSize.height + 16,
    );

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Semi-transparent background with cutout
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: SpotlightPainter(spotlightRect: spotlightRect),
          ),
          
          // Tooltip
          Positioned(
            left: _getTooltipLeft(context, spotlightRect),
            top: _getTooltipTop(context, spotlightRect),
            child: Container(
              width: 280,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C2A),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF9090A0),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: onDismiss,
                      child: const Text(
                        'Got it',
                        style: TextStyle(
                          color: Color(0xFFD4A84B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getTooltipLeft(BuildContext context, Rect spotlightRect) {
    final screenWidth = MediaQuery.of(context).size.width;
    switch (position) {
      case TooltipPosition.left:
        return spotlightRect.left - 296;
      case TooltipPosition.right:
        return spotlightRect.right + 16;
      default:
        return (spotlightRect.center.dx - 140).clamp(16, screenWidth - 296);
    }
  }

  double _getTooltipTop(BuildContext context, Rect spotlightRect) {
    final screenHeight = MediaQuery.of(context).size.height;
    switch (position) {
      case TooltipPosition.top:
        return spotlightRect.top - 150;
      case TooltipPosition.bottom:
        return spotlightRect.bottom + 16;
      case TooltipPosition.left:
      case TooltipPosition.right:
        return (spotlightRect.center.dy - 50).clamp(16, screenHeight - 150);
      case TooltipPosition.center:
        return (screenHeight - 150) / 2;
    }
  }
}

/// Custom painter for spotlight effect with cutout
class SpotlightPainter extends CustomPainter {
  final Rect spotlightRect;

  SpotlightPainter({required this.spotlightRect});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.7);

    // Draw full screen overlay
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    
    // Create a path with the spotlight cutout
    final path = Path()
      ..addRect(fullRect)
      ..addRRect(RRect.fromRectAndRadius(spotlightRect, const Radius.circular(12)));
    
    path.fillType = PathFillType.evenOdd;
    
    canvas.drawPath(path, paint);
    
    // Draw spotlight border glow
    final glowPaint = Paint()
      ..color = const Color(0xFFD4A84B)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(spotlightRect, const Radius.circular(12)),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Onboarding page widget for fullscreen onboarding
class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;
  final Color? iconColor;
  final String? imagePath;
  final Widget? customContent;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.iconColor,
    this.imagePath,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon or Image
          if (icon != null)
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: (iconColor ?? const Color(0xFFD4A84B)).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                icon,
                size: 60,
                color: iconColor ?? const Color(0xFFD4A84B),
              ),
            )
          else if (imagePath != null)
            Image.asset(
              imagePath!,
              height: 200,
              fit: BoxFit.contain,
            )
          else if (customContent != null)
            customContent!,
          
          const SizedBox(height: 48),
          
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF9090A0),
              fontSize: 16,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Full onboarding screen with multiple pages
class OnboardingScreen extends StatefulWidget {
  final List<OnboardingPage> pages;
  final VoidCallback onComplete;
  final VoidCallback? onSkip;
  final bool showSkip;

  const OnboardingScreen({
    super.key,
    required this.pages,
    required this.onComplete,
    this.onSkip,
    this.showSkip = true,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete();
    }
  }

  void _skip() {
    if (widget.onSkip != null) {
      widget.onSkip!();
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14141F),
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            if (widget.showSkip && _currentPage < widget.pages.length - 1)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: _skip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF9090A0),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 56),
            
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: widget.pages,
              ),
            ),
            
            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? const Color(0xFFD4A84B)
                        : const Color(0xFF2F2F42),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Next/Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4A84B),
                    foregroundColor: const Color(0xFF0D0D12),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage == widget.pages.length - 1 
                        ? 'Get Started' 
                        : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// Default Tinseltown IQ onboarding pages
class TinseltownIQOnboarding {
  static List<OnboardingPage> get pages => const [
    OnboardingPage(
      icon: Icons.movie_filter,
      iconColor: Color(0xFFD4A84B),
      title: 'Welcome to Tinseltown IQ',
      description: 'Your AI-powered partner for evaluating movie and TV concepts. Get instant feedback on your creative ideas.',
    ),
    OnboardingPage(
      icon: Icons.analytics,
      iconColor: Color(0xFF00E676),
      title: 'Smart Analysis',
      description: 'Our AI analyzes your logline, synopsis, and format to generate a comprehensive GreenlightIQ Score based on market trends.',
    ),
    OnboardingPage(
      icon: Icons.groups,
      iconColor: Color(0xFF448AFF),
      title: 'Find Your Buyers',
      description: 'Discover which studios, networks, and producers are most likely to be interested in your concept.',
    ),
    OnboardingPage(
      icon: Icons.trending_up,
      iconColor: Color(0xFFFFAB00),
      title: 'Track Progress',
      description: 'Save and compare your projects over time. Watch your scores improve as you refine your concepts.',
    ),
  ];
}
