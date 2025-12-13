import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Analytics Service
/// 
/// Provides user behavior tracking and event logging capabilities.
/// Designed to integrate with Firebase Analytics, Mixpanel, or custom backends.

/// Event categories for organizing analytics
enum AnalyticsCategory {
  navigation,
  user,
  content,
  engagement,
  conversion,
  error,
  performance,
}

/// Analytics event data structure
class AnalyticsEvent {
  final String name;
  final AnalyticsCategory category;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;
  final String? userId;
  final String? sessionId;

  AnalyticsEvent({
    required this.name,
    required this.category,
    Map<String, dynamic>? parameters,
    DateTime? timestamp,
    this.userId,
    this.sessionId,
  }) : 
    parameters = parameters ?? {},
    timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'name': name,
    'category': category.name,
    'parameters': parameters,
    'timestamp': timestamp.toIso8601String(),
    'userId': userId,
    'sessionId': sessionId,
  };

  @override
  String toString() => 'AnalyticsEvent($name, $category, $parameters)';
}

/// User properties for analytics
class UserProperties {
  final String? userId;
  final String? email;
  final String? displayName;
  final String? subscriptionPlan;
  final int? scansUsed;
  final DateTime? signUpDate;
  final Map<String, dynamic> customProperties;

  UserProperties({
    this.userId,
    this.email,
    this.displayName,
    this.subscriptionPlan,
    this.scansUsed,
    this.signUpDate,
    Map<String, dynamic>? customProperties,
  }) : customProperties = customProperties ?? {};

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'displayName': displayName,
    'subscriptionPlan': subscriptionPlan,
    'scansUsed': scansUsed,
    'signUpDate': signUpDate?.toIso8601String(),
    ...customProperties,
  };
}

/// Analytics Service - Centralized analytics management
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  /// Whether analytics is enabled
  bool _isEnabled = true;
  
  /// Current user properties
  UserProperties? _userProperties;
  
  /// Current session ID
  String? _sessionId;
  
  /// Event queue for batching
  final List<AnalyticsEvent> _eventQueue = [];
  
  /// Maximum queue size before auto-flush
  static const int _maxQueueSize = 50;
  
  /// External analytics handlers
  final List<void Function(AnalyticsEvent)> _handlers = [];

  // ═══════════════════════════════════════════════════════════════
  // Configuration
  // ═══════════════════════════════════════════════════════════════

  /// Enable or disable analytics
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    if (kDebugMode) {
      debugPrint('AnalyticsService: Analytics ${enabled ? "enabled" : "disabled"}');
    }
  }

  bool get isEnabled => _isEnabled;

  /// Start a new session
  void startSession() {
    _sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    logEvent('session_start', category: AnalyticsCategory.user);
  }

  /// End the current session
  void endSession() {
    logEvent('session_end', category: AnalyticsCategory.user);
    _sessionId = null;
    _flushQueue();
  }

  /// Set user properties
  void setUserProperties(UserProperties properties) {
    _userProperties = properties;
    
    // Log user property update
    logEvent('user_properties_set', 
      category: AnalyticsCategory.user,
      parameters: properties.toJson(),
    );
  }

  /// Clear user properties (on logout)
  void clearUserProperties() {
    _userProperties = null;
  }

  /// Add an external event handler (e.g., for Firebase Analytics)
  void addHandler(void Function(AnalyticsEvent) handler) {
    _handlers.add(handler);
  }

  /// Remove an event handler
  void removeHandler(void Function(AnalyticsEvent) handler) {
    _handlers.remove(handler);
  }

  // ═══════════════════════════════════════════════════════════════
  // Event Logging
  // ═══════════════════════════════════════════════════════════════

  /// Log a custom event
  void logEvent(
    String name, {
    AnalyticsCategory category = AnalyticsCategory.engagement,
    Map<String, dynamic>? parameters,
  }) {
    if (!_isEnabled) return;

    final event = AnalyticsEvent(
      name: name,
      category: category,
      parameters: parameters,
      userId: _userProperties?.userId,
      sessionId: _sessionId,
    );

    _queueEvent(event);
  }

  void _queueEvent(AnalyticsEvent event) {
    _eventQueue.add(event);
    
    // Notify handlers
    for (final handler in _handlers) {
      try {
        handler(event);
      } catch (e) {
        if (kDebugMode) {
          debugPrint('AnalyticsService: Handler error: $e');
        }
      }
    }

    if (kDebugMode) {
      debugPrint('AnalyticsService: Logged event - $event');
    }

    // Auto-flush if queue is full
    if (_eventQueue.length >= _maxQueueSize) {
      _flushQueue();
    }
  }

  /// Flush the event queue (send to backend)
  void _flushQueue() {
    if (_eventQueue.isEmpty) return;
    
    // In a real implementation, this would send events to the analytics backend
    // For now, we just clear the queue
    if (kDebugMode) {
      debugPrint('AnalyticsService: Flushing ${_eventQueue.length} events');
    }
    
    _eventQueue.clear();
  }

  // ═══════════════════════════════════════════════════════════════
  // Pre-defined Events - Navigation
  // ═══════════════════════════════════════════════════════════════

  /// Log screen view
  void logScreenView(String screenName, {String? screenClass}) {
    logEvent('screen_view',
      category: AnalyticsCategory.navigation,
      parameters: {
        'screen_name': screenName,
        if (screenClass != null) 'screen_class': screenClass,
      },
    );
  }

  /// Log navigation action
  void logNavigation(String from, String to) {
    logEvent('navigation',
      category: AnalyticsCategory.navigation,
      parameters: {
        'from': from,
        'to': to,
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Pre-defined Events - User Actions
  // ═══════════════════════════════════════════════════════════════

  /// Log user sign up
  void logSignUp(String method) {
    logEvent('sign_up',
      category: AnalyticsCategory.user,
      parameters: {'method': method},
    );
  }

  /// Log user login
  void logLogin(String method) {
    logEvent('login',
      category: AnalyticsCategory.user,
      parameters: {'method': method},
    );
  }

  /// Log user logout
  void logLogout() {
    logEvent('logout', category: AnalyticsCategory.user);
    clearUserProperties();
  }

  // ═══════════════════════════════════════════════════════════════
  // Pre-defined Events - Content
  // ═══════════════════════════════════════════════════════════════

  /// Log project analysis started
  void logAnalysisStarted({
    required String genre,
    required String format,
    int? loglineLength,
    int? synopsisLength,
  }) {
    logEvent('analysis_started',
      category: AnalyticsCategory.content,
      parameters: {
        'genre': genre,
        'format': format,
        if (loglineLength != null) 'logline_length': loglineLength,
        if (synopsisLength != null) 'synopsis_length': synopsisLength,
      },
    );
  }

  /// Log project analysis completed
  void logAnalysisCompleted({
    required int score,
    required String verdict,
    required Duration duration,
  }) {
    logEvent('analysis_completed',
      category: AnalyticsCategory.content,
      parameters: {
        'score': score,
        'verdict': verdict,
        'duration_ms': duration.inMilliseconds,
      },
    );
  }

  /// Log project saved
  void logProjectSaved({required String projectId, bool isUpdate = false}) {
    logEvent(isUpdate ? 'project_updated' : 'project_saved',
      category: AnalyticsCategory.content,
      parameters: {'project_id': projectId},
    );
  }

  /// Log project deleted
  void logProjectDeleted({required String projectId}) {
    logEvent('project_deleted',
      category: AnalyticsCategory.content,
      parameters: {'project_id': projectId},
    );
  }

  /// Log PDF export
  void logPdfExport({required String projectId}) {
    logEvent('pdf_export',
      category: AnalyticsCategory.content,
      parameters: {'project_id': projectId},
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Pre-defined Events - Engagement
  // ═══════════════════════════════════════════════════════════════

  /// Log feature usage
  void logFeatureUsed(String featureName, {Map<String, dynamic>? details}) {
    logEvent('feature_used',
      category: AnalyticsCategory.engagement,
      parameters: {
        'feature': featureName,
        ...?details,
      },
    );
  }

  /// Log button tap
  void logButtonTap(String buttonName, {String? screen}) {
    logEvent('button_tap',
      category: AnalyticsCategory.engagement,
      parameters: {
        'button': buttonName,
        if (screen != null) 'screen': screen,
      },
    );
  }

  /// Log search
  void logSearch(String query, {int? resultsCount}) {
    logEvent('search',
      category: AnalyticsCategory.engagement,
      parameters: {
        'query': query,
        if (resultsCount != null) 'results_count': resultsCount,
      },
    );
  }

  /// Log share action
  void logShare({required String contentType, String? method}) {
    logEvent('share',
      category: AnalyticsCategory.engagement,
      parameters: {
        'content_type': contentType,
        if (method != null) 'method': method,
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Pre-defined Events - Conversion
  // ═══════════════════════════════════════════════════════════════

  /// Log subscription view
  void logSubscriptionViewed({required String source}) {
    logEvent('subscription_viewed',
      category: AnalyticsCategory.conversion,
      parameters: {'source': source},
    );
  }

  /// Log subscription started
  void logSubscriptionStarted({
    required String plan,
    required double price,
    String? currency,
  }) {
    logEvent('subscription_started',
      category: AnalyticsCategory.conversion,
      parameters: {
        'plan': plan,
        'price': price,
        'currency': currency ?? 'USD',
      },
    );
  }

  /// Log subscription cancelled
  void logSubscriptionCancelled({required String plan, String? reason}) {
    logEvent('subscription_cancelled',
      category: AnalyticsCategory.conversion,
      parameters: {
        'plan': plan,
        if (reason != null) 'reason': reason,
      },
    );
  }

  /// Log promo code applied
  void logPromoCodeApplied({required String code, required double discount}) {
    logEvent('promo_code_applied',
      category: AnalyticsCategory.conversion,
      parameters: {
        'code': code,
        'discount': discount,
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Pre-defined Events - Errors
  // ═══════════════════════════════════════════════════════════════

  /// Log an error
  void logError({
    required String errorType,
    required String message,
    String? stackTrace,
    String? screen,
  }) {
    logEvent('error',
      category: AnalyticsCategory.error,
      parameters: {
        'error_type': errorType,
        'message': message,
        if (stackTrace != null) 'stack_trace': stackTrace,
        if (screen != null) 'screen': screen,
      },
    );
  }

  /// Log network error
  void logNetworkError({
    required String endpoint,
    required int statusCode,
    String? errorMessage,
  }) {
    logEvent('network_error',
      category: AnalyticsCategory.error,
      parameters: {
        'endpoint': endpoint,
        'status_code': statusCode,
        if (errorMessage != null) 'error_message': errorMessage,
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Pre-defined Events - Performance
  // ═══════════════════════════════════════════════════════════════

  /// Log app startup time
  void logAppStartupTime(Duration duration) {
    logEvent('app_startup',
      category: AnalyticsCategory.performance,
      parameters: {'duration_ms': duration.inMilliseconds},
    );
  }

  /// Log screen load time
  void logScreenLoadTime(String screenName, Duration duration) {
    logEvent('screen_load',
      category: AnalyticsCategory.performance,
      parameters: {
        'screen_name': screenName,
        'duration_ms': duration.inMilliseconds,
      },
    );
  }

  /// Log API response time
  void logApiResponseTime(String endpoint, Duration duration) {
    logEvent('api_response',
      category: AnalyticsCategory.performance,
      parameters: {
        'endpoint': endpoint,
        'duration_ms': duration.inMilliseconds,
      },
    );
  }
}

/// Mixin for easy analytics access in widgets
mixin AnalyticsMixin {
  AnalyticsService get analytics => AnalyticsService();
  
  /// Log when screen is viewed
  void logScreenView(String screenName) {
    analytics.logScreenView(screenName);
  }
}

/// Navigator observer for automatic screen tracking
class AnalyticsNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logScreenView(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      _logScreenView(previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _logScreenView(newRoute);
    }
  }

  void _logScreenView(Route<dynamic> route) {
    final screenName = route.settings.name;
    if (screenName != null && screenName.isNotEmpty) {
      AnalyticsService().logScreenView(screenName);
    }
  }
}
