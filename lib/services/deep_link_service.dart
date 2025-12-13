import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Deep Link Service
/// 
/// Handles URL-based navigation and deep linking for the app.
/// Supports both Android App Links and iOS Universal Links.

/// Route types supported by deep linking
enum DeepLinkRoute {
  home,
  project,
  newScan,
  results,
  profile,
  settings,
  subscription,
  unknown,
}

/// Parsed deep link data
class DeepLinkData {
  final DeepLinkRoute route;
  final Map<String, String> parameters;
  final String rawUri;

  const DeepLinkData({
    required this.route,
    this.parameters = const {},
    required this.rawUri,
  });

  /// Get a parameter value by key
  String? getParameter(String key) => parameters[key];

  /// Check if a parameter exists
  bool hasParameter(String key) => parameters.containsKey(key);

  @override
  String toString() => 'DeepLinkData(route: $route, parameters: $parameters, rawUri: $rawUri)';
}

/// Deep Link Service - Handles URL routing and navigation
class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  /// App scheme for custom URL handling (e.g., tinseltowniq://)
  static const String appScheme = 'tinseltowniq';
  
  /// Web host for universal links
  static const String webHost = 'tinseltowniq.app';

  /// Registered routes and their handlers
  final Map<DeepLinkRoute, void Function(BuildContext, DeepLinkData)> _handlers = {};

  /// Global navigation key for routing without context
  GlobalKey<NavigatorState>? navigatorKey;

  /// Initialize deep link handling
  void initialize(GlobalKey<NavigatorState> navKey) {
    navigatorKey = navKey;
    
    // Register default handlers
    _registerDefaultHandlers();
    
    if (kDebugMode) {
      debugPrint('DeepLinkService: Initialized with navigator key');
    }
  }

  void _registerDefaultHandlers() {
    // Default route handlers can be registered here
    // These are overridden by explicit handlers set via registerHandler
  }

  /// Register a handler for a specific route
  void registerHandler(DeepLinkRoute route, void Function(BuildContext, DeepLinkData) handler) {
    _handlers[route] = handler;
  }

  /// Unregister a handler
  void unregisterHandler(DeepLinkRoute route) {
    _handlers.remove(route);
  }

  /// Parse a URI string into DeepLinkData
  DeepLinkData parseUri(String uriString) {
    try {
      final uri = Uri.parse(uriString);
      return _parseUri(uri);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('DeepLinkService: Error parsing URI: $e');
      }
      return DeepLinkData(
        route: DeepLinkRoute.unknown,
        rawUri: uriString,
      );
    }
  }

  DeepLinkData _parseUri(Uri uri) {
    // Extract path segments
    final pathSegments = uri.pathSegments;
    
    // Parse parameters from query string
    final parameters = Map<String, String>.from(uri.queryParameters);
    
    // Determine route from path
    DeepLinkRoute route = DeepLinkRoute.unknown;
    
    if (pathSegments.isEmpty || (pathSegments.length == 1 && pathSegments[0].isEmpty)) {
      route = DeepLinkRoute.home;
    } else {
      final firstSegment = pathSegments[0].toLowerCase();
      
      switch (firstSegment) {
        case 'home':
          route = DeepLinkRoute.home;
          break;
        case 'project':
        case 'projects':
          route = DeepLinkRoute.project;
          // Extract project ID from path if present
          if (pathSegments.length > 1) {
            parameters['projectId'] = pathSegments[1];
          }
          break;
        case 'scan':
        case 'new-scan':
        case 'new_scan':
          route = DeepLinkRoute.newScan;
          break;
        case 'results':
        case 'result':
          route = DeepLinkRoute.results;
          // Extract result ID from path if present
          if (pathSegments.length > 1) {
            parameters['resultId'] = pathSegments[1];
          }
          break;
        case 'profile':
          route = DeepLinkRoute.profile;
          break;
        case 'settings':
          route = DeepLinkRoute.settings;
          break;
        case 'subscription':
        case 'upgrade':
        case 'pricing':
          route = DeepLinkRoute.subscription;
          break;
        default:
          route = DeepLinkRoute.unknown;
      }
    }

    return DeepLinkData(
      route: route,
      parameters: parameters,
      rawUri: uri.toString(),
    );
  }

  /// Handle an incoming deep link
  Future<bool> handleDeepLink(String uriString, {BuildContext? context}) async {
    final data = parseUri(uriString);
    
    if (kDebugMode) {
      debugPrint('DeepLinkService: Handling deep link - $data');
    }

    // Get context from navigator key if not provided
    final ctx = context ?? navigatorKey?.currentContext;
    
    if (ctx == null) {
      if (kDebugMode) {
        debugPrint('DeepLinkService: No context available for navigation');
      }
      return false;
    }

    // Check for registered handler
    final handler = _handlers[data.route];
    if (handler != null) {
      handler(ctx, data);
      return true;
    }

    // Default handling for routes without specific handlers
    return _defaultRouteHandler(ctx, data);
  }

  bool _defaultRouteHandler(BuildContext context, DeepLinkData data) {
    // This would navigate to the appropriate screen
    // Implementation depends on the navigation structure of the app
    
    if (kDebugMode) {
      debugPrint('DeepLinkService: Default handler for ${data.route}');
    }

    switch (data.route) {
      case DeepLinkRoute.home:
        // Navigate to home - typically the app is already there
        return true;
        
      case DeepLinkRoute.project:
        // Navigate to specific project
        final projectId = data.getParameter('projectId');
        if (projectId != null) {
          // Navigator.of(context).pushNamed('/project/$projectId');
          if (kDebugMode) {
            debugPrint('DeepLinkService: Would navigate to project $projectId');
          }
        }
        return true;
        
      case DeepLinkRoute.newScan:
        // Navigate to new scan screen
        // Navigator.of(context).pushNamed('/new-scan');
        if (kDebugMode) {
          debugPrint('DeepLinkService: Would navigate to new scan');
        }
        return true;
        
      case DeepLinkRoute.results:
        // Navigate to results screen
        final resultId = data.getParameter('resultId');
        if (kDebugMode) {
          debugPrint('DeepLinkService: Would navigate to results $resultId');
        }
        return true;
        
      case DeepLinkRoute.profile:
        // Navigator.of(context).pushNamed('/profile');
        return true;
        
      case DeepLinkRoute.settings:
        // Navigator.of(context).pushNamed('/settings');
        return true;
        
      case DeepLinkRoute.subscription:
        // Navigator.of(context).pushNamed('/subscription');
        return true;
        
      case DeepLinkRoute.unknown:
        if (kDebugMode) {
          debugPrint('DeepLinkService: Unknown route, ignoring');
        }
        return false;
    }
  }

  /// Generate a deep link URL for a specific route
  String generateLink(DeepLinkRoute route, {Map<String, String>? parameters}) {
    String path;
    
    switch (route) {
      case DeepLinkRoute.home:
        path = '/';
        break;
      case DeepLinkRoute.project:
        final projectId = parameters?['projectId'];
        path = projectId != null ? '/project/$projectId' : '/projects';
        break;
      case DeepLinkRoute.newScan:
        path = '/new-scan';
        break;
      case DeepLinkRoute.results:
        final resultId = parameters?['resultId'];
        path = resultId != null ? '/results/$resultId' : '/results';
        break;
      case DeepLinkRoute.profile:
        path = '/profile';
        break;
      case DeepLinkRoute.settings:
        path = '/settings';
        break;
      case DeepLinkRoute.subscription:
        path = '/subscription';
        break;
      case DeepLinkRoute.unknown:
        path = '/';
        break;
    }

    // Build URI with web host
    final uri = Uri.https(webHost, path, parameters);
    return uri.toString();
  }

  /// Generate a custom scheme link (for app-to-app linking)
  String generateAppLink(DeepLinkRoute route, {Map<String, String>? parameters}) {
    final webLink = generateLink(route, parameters: parameters);
    final uri = Uri.parse(webLink);
    
    // Convert to app scheme
    final appUri = Uri(
      scheme: appScheme,
      host: uri.host,
      path: uri.path,
      queryParameters: uri.queryParameters.isNotEmpty ? uri.queryParameters : null,
    );
    
    return appUri.toString();
  }
}

/// Extension for easy deep link access
extension DeepLinkContext on BuildContext {
  /// Handle a deep link from this context
  Future<bool> handleDeepLink(String uri) {
    return DeepLinkService().handleDeepLink(uri, context: this);
  }
}

/// Deep link route configuration for Android and iOS
/// 
/// Android (AndroidManifest.xml):
/// ```xml
/// <intent-filter android:autoVerify="true">
///   <action android:name="android.intent.action.VIEW" />
///   <category android:name="android.intent.category.DEFAULT" />
///   <category android:name="android.intent.category.BROWSABLE" />
///   <data android:scheme="https" android:host="tinseltowniq.app" />
/// </intent-filter>
/// <intent-filter>
///   <action android:name="android.intent.action.VIEW" />
///   <category android:name="android.intent.category.DEFAULT" />
///   <category android:name="android.intent.category.BROWSABLE" />
///   <data android:scheme="tinseltowniq" />
/// </intent-filter>
/// ```
/// 
/// iOS (Info.plist):
/// ```xml
/// <key>CFBundleURLTypes</key>
/// <array>
///   <dict>
///     <key>CFBundleURLSchemes</key>
///     <array>
///       <string>tinseltowniq</string>
///     </array>
///   </dict>
/// </array>
/// <key>com.apple.developer.associated-domains</key>
/// <array>
///   <string>applinks:tinseltowniq.app</string>
/// </array>
/// ```

/// Route observer for tracking navigation analytics
class DeepLinkRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final void Function(String routeName)? onRouteChanged;

  DeepLinkRouteObserver({this.onRouteChanged});

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      onRouteChanged?.call(route.settings.name ?? 'unknown');
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute) {
      onRouteChanged?.call(previousRoute.settings.name ?? 'unknown');
    }
  }
}
