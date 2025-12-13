import 'package:flutter/material.dart';

/// Offline Indicator Widgets
/// 
/// Visual indicators for offline state that can be used throughout the app.

/// A banner that appears at the top of the screen when offline
class OfflineBanner extends StatelessWidget {
  final bool isOffline;
  final VoidCallback? onRetry;
  final String? message;

  const OfflineBanner({
    super.key,
    required this.isOffline,
    this.onRetry,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isOffline ? 48 : 0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFF9500).withValues(alpha: 0.9),
            const Color(0xFFFF5722).withValues(alpha: 0.9),
          ],
        ),
        boxShadow: isOffline ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isOffline ? 1.0 : 0.0,
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.wifi_off,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message ?? 'No internet connection',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (onRetry != null)
                  TextButton(
                    onPressed: onRetry,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh, size: 16),
                        SizedBox(width: 4),
                        Text('Retry'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A small dot indicator for connectivity status
class ConnectivityDot extends StatelessWidget {
  final bool isOnline;
  final double size;
  final bool showLabel;

  const ConnectivityDot({
    super.key,
    required this.isOnline,
    this.size = 8,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isOnline 
                ? const Color(0xFF00E676)  // Green
                : const Color(0xFFFF5252), // Red
            boxShadow: [
              BoxShadow(
                color: (isOnline 
                    ? const Color(0xFF00E676)
                    : const Color(0xFFFF5252)).withValues(alpha: 0.4),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        if (showLabel) ...[
          const SizedBox(width: 6),
          Text(
            isOnline ? 'Online' : 'Offline',
            style: TextStyle(
              color: isOnline 
                  ? const Color(0xFF00E676)
                  : const Color(0xFFFF5252),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

/// A card overlay that shows when content is unavailable offline
class OfflineOverlay extends StatelessWidget {
  final bool isOffline;
  final Widget child;
  final String? message;
  final VoidCallback? onRetry;

  const OfflineOverlay({
    super.key,
    required this.isOffline,
    required this.child,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isOffline)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF14141F).withValues(alpha: 0.9),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_off,
                      size: 48,
                      color: const Color(0xFF9090A0).withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message ?? 'Content unavailable offline',
                      style: const TextStyle(
                        color: Color(0xFF9090A0),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (onRetry != null) ...[
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Try Again'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFD4A84B),
                          side: const BorderSide(color: Color(0xFFD4A84B)),
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

/// A snackbar-style notification for connectivity changes
class ConnectivitySnackbar {
  static void show(BuildContext context, {required bool isOnline}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isOnline ? Icons.wifi : Icons.wifi_off,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              isOnline ? 'Back online' : 'You are offline',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: isOnline 
            ? const Color(0xFF00E676)
            : const Color(0xFFFF9500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(seconds: isOnline ? 2 : 4),
        action: isOnline ? null : SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

/// A wrapper widget that listens to connectivity changes and shows indicators
class ConnectivityAwareScaffold extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool showOfflineBanner;
  final VoidCallback? onRetry;

  const ConnectivityAwareScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.showOfflineBanner = true,
    this.onRetry,
  });

  @override
  State<ConnectivityAwareScaffold> createState() => _ConnectivityAwareScaffoldState();
}

class _ConnectivityAwareScaffoldState extends State<ConnectivityAwareScaffold> {
  // Tracks offline state - connected to ConnectivityService in production
  // ignore: prefer_final_fields
  final bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    // TODO: Connect to ConnectivityService for real connectivity monitoring
    // ConnectivityService().addListener(_handleConnectivityChange);
  }

  @override
  void dispose() {
    // TODO: Disconnect from ConnectivityService
    // ConnectivityService().removeListener(_handleConnectivityChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Column(
        children: [
          if (widget.showOfflineBanner)
            OfflineBanner(
              isOffline: _isOffline,
              onRetry: widget.onRetry,
            ),
          Expanded(child: widget.body),
        ],
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}

/// Mixin for adding offline awareness to StatefulWidgets
mixin OfflineAwareMixin<T extends StatefulWidget> on State<T> {
  // ignore: prefer_final_fields
  bool _isOfflineState = false;

  bool get isOffline => _isOfflineState;
  bool get isOnline => !_isOfflineState;

  @override
  void initState() {
    super.initState();
    // TODO: Connect to ConnectivityService for real connectivity monitoring
    // ConnectivityService().addListener(_onConnectivityStateChanged);
    // _isOfflineState = ConnectivityService().isOffline;
  }

  @override
  void dispose() {
    // TODO: Disconnect from ConnectivityService
    // ConnectivityService().removeListener(_onConnectivityStateChanged);
    super.dispose();
  }

  /// Override this method to handle connectivity changes
  void onConnectivityChanged(bool isOnline) {
    // Default implementation shows snackbar
    if (mounted) {
      ConnectivitySnackbar.show(context, isOnline: isOnline);
    }
  }
}

/// Empty state widget for offline scenarios
class OfflineEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  const OfflineEmptyState({
    super.key,
    this.title = 'You are offline',
    this.message = 'This content requires an internet connection. Please check your connection and try again.',
    this.icon = Icons.cloud_off,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF2F2F42),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                icon,
                size: 40,
                color: const Color(0xFF9090A0),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                color: Color(0xFF9090A0),
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
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
    );
  }
}
