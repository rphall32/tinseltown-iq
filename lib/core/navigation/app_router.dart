// App Router - Centralized Navigation Management
//
// Provides type-safe, named routes with consistent transitions
// and deep linking support for the Tinseltown IQ app.

import 'package:flutter/material.dart';

/// Route names for the application
abstract class AppRoutes {
  // Authentication flow
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String planSelection = '/plan-selection';
  static const String onboarding = '/onboarding';
  
  // Main app
  static const String home = '/home';
  static const String analysis = '/analysis';
  static const String results = '/results';
  static const String reAnalyze = '/re-analyze';
  static const String projectComparison = '/project-comparison';
  
  // Settings
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String subscription = '/subscription';
  static const String notifications = '/notifications';
  
  // Deep link patterns
  static const String projectDetails = '/project/:id';
  static const String sharedResult = '/shared/:shareId';
}

/// Route arguments for passing data between screens
class RouteArguments {
  final Map<String, dynamic> data;
  
  const RouteArguments([this.data = const {}]);
  
  T? get<T>(String key) => data[key] as T?;
  
  String? get projectId => get<String>('projectId');
  String? get shareId => get<String>('shareId');
  Map<String, dynamic>? get analysisData => get<Map<String, dynamic>>('analysisData');
  bool get showResults => get<bool>('showResults') ?? false;
}

/// Centralized route generation with consistent transitions
class AppRouter {
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  AppRouter._internal();
  
  /// Navigation key for accessing navigator without context
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  /// Get current navigator state
  NavigatorState? get navigator => navigatorKey.currentState;
  
  /// Generate route based on settings
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments as RouteArguments? ?? const RouteArguments();
    
    // Handle deep link patterns
    final uri = Uri.parse(settings.name ?? '/');
    
    // Project details deep link: /project/:id
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'project') {
      final projectId = uri.pathSegments[1];
      return _createRoute(
        _buildProjectDetailsScreen(projectId),
        settings,
      );
    }
    
    // Shared result deep link: /shared/:shareId
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'shared') {
      final shareId = uri.pathSegments[1];
      return _createRoute(
        _buildSharedResultScreen(shareId),
        settings,
      );
    }
    
    // Standard routes
    switch (settings.name) {
      case AppRoutes.splash:
        return _createRoute(_buildSplashScreen(), settings);
      case AppRoutes.welcome:
        return _createRoute(_buildWelcomeScreen(), settings);
      case AppRoutes.signIn:
        return _createRoute(_buildSignInScreen(), settings);
      case AppRoutes.signUp:
        return _createRoute(_buildSignUpScreen(), settings);
      case AppRoutes.planSelection:
        return _createRoute(_buildPlanSelectionScreen(), settings);
      case AppRoutes.onboarding:
        return _createRoute(_buildOnboardingScreen(), settings);
      case AppRoutes.home:
        return _createRoute(_buildHomeScreen(), settings);
      case AppRoutes.analysis:
        return _createRoute(_buildAnalysisScreen(args), settings);
      case AppRoutes.results:
        return _createRoute(_buildResultsScreen(args), settings);
      case AppRoutes.reAnalyze:
        return _createRoute(_buildReAnalyzeScreen(args), settings);
      case AppRoutes.projectComparison:
        return _createRoute(_buildProjectComparisonScreen(args), settings);
      default:
        return _createRoute(_build404Screen(), settings);
    }
  }
  
  /// Create route with consistent page transition
  Route<T> _createRoute<T>(Widget page, RouteSettings settings, {
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      fullscreenDialog: fullscreenDialog,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Cinematic fade-scale transition
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            ),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 250),
    );
  }
  
  // Screen builders - These reference screens from main.dart
  // In the future, these will be extracted to separate files
  
  Widget _buildSplashScreen() {
    return const _PlaceholderScreen(name: 'SplashScreen');
  }
  
  Widget _buildWelcomeScreen() {
    return const _PlaceholderScreen(name: 'WelcomeScreen');
  }
  
  Widget _buildSignInScreen() {
    return const _PlaceholderScreen(name: 'SignInScreen');
  }
  
  Widget _buildSignUpScreen() {
    return const _PlaceholderScreen(name: 'SignUpScreen');
  }
  
  Widget _buildPlanSelectionScreen() {
    return const _PlaceholderScreen(name: 'PlanSelectionScreen');
  }
  
  Widget _buildOnboardingScreen() {
    return const _PlaceholderScreen(name: 'OnboardingScreen');
  }
  
  Widget _buildHomeScreen() {
    return const _PlaceholderScreen(name: 'HomeScreen');
  }
  
  Widget _buildAnalysisScreen(RouteArguments args) {
    return const _PlaceholderScreen(name: 'AnalysisScreen');
  }
  
  Widget _buildResultsScreen(RouteArguments args) {
    return const _PlaceholderScreen(name: 'ResultsScreen');
  }
  
  Widget _buildReAnalyzeScreen(RouteArguments args) {
    return const _PlaceholderScreen(name: 'ReAnalyzeScreen');
  }
  
  Widget _buildProjectComparisonScreen(RouteArguments args) {
    return const _PlaceholderScreen(name: 'ProjectComparisonScreen');
  }
  
  Widget _buildProjectDetailsScreen(String projectId) {
    return _PlaceholderScreen(name: 'ProjectDetails: $projectId');
  }
  
  Widget _buildSharedResultScreen(String shareId) {
    return _PlaceholderScreen(name: 'SharedResult: $shareId');
  }
  
  Widget _build404Screen() {
    return const _NotFoundScreen();
  }
  
  // ============================================================
  // NAVIGATION HELPERS
  // Type-safe, consistent navigation methods
  // ============================================================
  
  /// Navigate to a named route
  Future<T?> navigateTo<T>(String routeName, {RouteArguments? arguments}) {
    return navigator!.pushNamed<T>(routeName, arguments: arguments);
  }
  
  /// Navigate and replace current route
  Future<T?> navigateReplace<T>(String routeName, {RouteArguments? arguments}) {
    return navigator!.pushReplacementNamed<T, dynamic>(
      routeName, 
      arguments: arguments,
    );
  }
  
  /// Navigate and clear all previous routes
  Future<T?> navigateClearStack<T>(String routeName, {RouteArguments? arguments}) {
    return navigator!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
  
  /// Pop current route
  void pop<T>([T? result]) {
    navigator!.pop<T>(result);
  }
  
  /// Pop until a specific route
  void popUntil(String routeName) {
    navigator!.popUntil(ModalRoute.withName(routeName));
  }
  
  /// Check if can pop
  bool canPop() => navigator!.canPop();
  
  // ============================================================
  // CONVENIENCE METHODS
  // Common navigation patterns
  // ============================================================
  
  /// Navigate to home screen and clear stack (after login)
  Future<void> toHomeAndClear() {
    return navigateClearStack(AppRoutes.home);
  }
  
  /// Navigate to sign in and clear stack (logout)
  Future<void> toSignInAndClear() {
    return navigateClearStack(AppRoutes.signIn);
  }
  
  /// Navigate to welcome and clear stack (full logout)
  Future<void> toWelcomeAndClear() {
    return navigateClearStack(AppRoutes.welcome);
  }
  
  /// Navigate to analysis screen
  Future<void> toAnalysis({Map<String, dynamic>? data}) {
    return navigateTo(AppRoutes.analysis, arguments: RouteArguments({'analysisData': data}));
  }
  
  /// Navigate to results screen
  Future<void> toResults({required Map<String, dynamic> analysisData}) {
    return navigateTo(AppRoutes.results, arguments: RouteArguments({'analysisData': analysisData}));
  }
  
  /// Navigate to project details
  Future<void> toProjectDetails(String projectId) {
    return navigateTo('/project/$projectId');
  }
  
  /// Navigate to shared result
  Future<void> toSharedResult(String shareId) {
    return navigateTo('/shared/$shareId');
  }
}

/// Extension on BuildContext for easy navigation access
extension NavigationExtension on BuildContext {
  /// Get AppRouter instance
  AppRouter get router => AppRouter();
  
  /// Navigate to named route
  Future<T?> navigateTo<T>(String routeName, {RouteArguments? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }
  
  /// Navigate and replace
  Future<T?> navigateReplace<T>(String routeName, {RouteArguments? arguments}) {
    return Navigator.of(this).pushReplacementNamed<T, dynamic>(
      routeName,
      arguments: arguments,
    );
  }
  
  /// Navigate and clear stack
  Future<T?> navigateClearStack<T>(String routeName, {RouteArguments? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
  
  /// Pop current screen
  void pop<T>([T? result]) => Navigator.of(this).pop<T>(result);
  
  /// Check if can pop
  bool canPop() => Navigator.of(this).canPop();
  
  /// Pop until route
  void popUntil(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }
}

/// Placeholder screen for routes not yet extracted
class _PlaceholderScreen extends StatelessWidget {
  final String name;
  
  const _PlaceholderScreen({required this.name});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Screen: $name\n(Route not connected - use direct import)',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

/// 404 Not Found screen
class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.movie_filter_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              '404',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Scene Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.navigateClearStack(AppRoutes.home),
              icon: const Icon(Icons.home),
              label: const Text('Back to Studio'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Route observer for analytics and logging
class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final void Function(String? routeName)? onRouteChanged;
  
  AppRouteObserver({this.onRouteChanged});
  
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      onRouteChanged?.call(route.settings.name);
    }
  }
  
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      onRouteChanged?.call(newRoute.settings.name);
    }
  }
  
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute) {
      onRouteChanged?.call(previousRoute.settings.name);
    }
  }
}
