// Performance utilities for Tinseltown IQ
//
// Provides utilities for optimizing app performance.

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// Debouncer utility to prevent excessive function calls
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  /// Run the action after the debounce delay
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Cancel any pending action
  void cancel() {
    _timer?.cancel();
  }

  /// Dispose of the debouncer
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}

/// Throttler utility to limit function call frequency
class Throttler {
  final int milliseconds;
  DateTime? _lastRun;

  Throttler({required this.milliseconds});

  /// Run the action if enough time has passed
  void run(VoidCallback action) {
    final now = DateTime.now();
    if (_lastRun == null ||
        now.difference(_lastRun!).inMilliseconds >= milliseconds) {
      _lastRun = now;
      action();
    }
  }

  /// Reset the throttler
  void reset() {
    _lastRun = null;
  }
}

/// Cache manager for expensive computations
class ComputeCache<K, V> {
  final int maxSize;
  final Map<K, _CacheEntry<V>> _cache = {};

  ComputeCache({this.maxSize = 100});

  /// Get or compute a value
  V getOrCompute(K key, V Function() compute) {
    if (_cache.containsKey(key)) {
      final entry = _cache[key]!;
      entry.accessCount++;
      return entry.value;
    }

    // Evict least accessed entry if at capacity
    if (_cache.length >= maxSize) {
      _evictLeastAccessed();
    }

    final value = compute();
    _cache[key] = _CacheEntry(value);
    return value;
  }

  void _evictLeastAccessed() {
    if (_cache.isEmpty) return;

    K? leastAccessedKey;
    int minAccess = double.maxFinite.toInt();

    for (final entry in _cache.entries) {
      if (entry.value.accessCount < minAccess) {
        minAccess = entry.value.accessCount;
        leastAccessedKey = entry.key;
      }
    }

    if (leastAccessedKey != null) {
      _cache.remove(leastAccessedKey);
    }
  }

  /// Clear the cache
  void clear() {
    _cache.clear();
  }

  /// Get cache size
  int get size => _cache.length;

  /// Check if key exists
  bool containsKey(K key) => _cache.containsKey(key);
}

class _CacheEntry<V> {
  final V value;
  int accessCount = 1;

  _CacheEntry(this.value);
}

/// Memory-efficient image cache wrapper
class ImageCacheConfig {
  static void configure({int maxImages = 100, int maxSizeBytes = 50 * 1024 * 1024}) {
    // Configure PaintingBinding image cache
    PaintingBinding.instance.imageCache.maximumSize = maxImages;
    PaintingBinding.instance.imageCache.maximumSizeBytes = maxSizeBytes;
  }

  static void clear() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  static int get currentSize => PaintingBinding.instance.imageCache.currentSize;
  static int get currentSizeBytes => PaintingBinding.instance.imageCache.currentSizeBytes;
}

/// Performance monitoring utilities
class PerformanceMonitor {
  static final Map<String, Stopwatch> _timers = {};

  /// Start timing an operation
  static void startTimer(String name) {
    _timers[name] = Stopwatch()..start();
  }

  /// Stop timing and return duration in milliseconds
  static int? stopTimer(String name) {
    final timer = _timers.remove(name);
    if (timer != null) {
      timer.stop();
      return timer.elapsedMilliseconds;
    }
    return null;
  }

  /// Log timer result in debug mode
  static void logTimerResult(String name) {
    final duration = stopTimer(name);
    if (duration != null && kDebugMode) {
      debugPrint('⏱️ $name: ${duration}ms');
    }
  }

  /// Measure and log a synchronous operation
  static T measure<T>(String name, T Function() operation) {
    startTimer(name);
    final result = operation();
    logTimerResult(name);
    return result;
  }

  /// Measure and log an async operation
  static Future<T> measureAsync<T>(String name, Future<T> Function() operation) async {
    startTimer(name);
    final result = await operation();
    logTimerResult(name);
    return result;
  }
}

/// Lazy initialization wrapper
class Lazy<T> {
  T? _value;
  final T Function() _factory;

  Lazy(this._factory);

  T get value {
    _value ??= _factory();
    return _value!;
  }

  bool get isInitialized => _value != null;

  void reset() {
    _value = null;
  }
}

/// Frame rate limiter for smooth animations
class FrameRateLimiter {
  final int targetFps;
  DateTime _lastFrameTime = DateTime.now();

  FrameRateLimiter({this.targetFps = 60});

  /// Check if enough time has passed for the next frame
  bool shouldRender() {
    final now = DateTime.now();
    final minFrameTime = Duration(milliseconds: (1000 / targetFps).round());
    
    if (now.difference(_lastFrameTime) >= minFrameTime) {
      _lastFrameTime = now;
      return true;
    }
    return false;
  }
}

/// Widget rebuild tracker for debugging
class RebuildTracker {
  static final Map<String, int> _rebuildCounts = {};

  /// Track a widget rebuild
  static void track(String widgetName) {
    _rebuildCounts[widgetName] = (_rebuildCounts[widgetName] ?? 0) + 1;
    if (kDebugMode && (_rebuildCounts[widgetName]! % 100 == 0)) {
      debugPrint('🔄 $widgetName rebuilt ${_rebuildCounts[widgetName]} times');
    }
  }

  /// Get rebuild count for a widget
  static int getCount(String widgetName) => _rebuildCounts[widgetName] ?? 0;

  /// Reset all counts
  static void reset() => _rebuildCounts.clear();

  /// Get all tracked widgets
  static Map<String, int> get allCounts => Map.unmodifiable(_rebuildCounts);
}
