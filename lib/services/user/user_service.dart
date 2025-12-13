import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/foundation.dart' show kDebugMode, ChangeNotifier, debugPrint;
import 'package:shared_preferences/shared_preferences.dart';

// Models - import for use in this file, export for consumers
import 'user_models.dart';
export 'user_models.dart';

/// UserService - Authentication & User State Management
/// 
/// Handles user authentication, session management, and profile persistence.
/// Uses SharedPreferences for local storage.
class UserService extends ChangeNotifier {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // Storage keys
  static const String _userKey = 'tinseltown_user';
  static const String _planKey = 'tinseltown_plan';
  static const String _isLoggedInKey = 'tinseltown_logged_in';

  bool _isLoggedIn = false;
  UserProfile? _currentUser;
  SubscriptionPlan _currentPlan = SubscriptionPlan.free;
  bool _isLoaded = false;

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  UserProfile? get currentUser => _currentUser;
  SubscriptionPlan get currentPlan => _currentPlan;
  bool get isLoaded => _isLoaded;
  
  /// Allow updating user profile externally
  set currentUser(UserProfile? user) {
    _currentUser = user;
    _saveToStorage();
    notifyListeners();
  }
  
  /// Calculate remaining scans based on subscription plan
  int get scansRemaining {
    switch (_currentPlan) {
      case SubscriptionPlan.free:
        return math.max(0, 3 - (_currentUser?.scansUsed ?? 0));
      case SubscriptionPlan.professional:
        return math.max(0, 25 - (_currentUser?.scansUsed ?? 0));
      case SubscriptionPlan.studio:
        return 999; // Unlimited
    }
  }
  
  /// Get maximum scans allowed for current plan
  int get maxScans {
    switch (_currentPlan) {
      case SubscriptionPlan.free:
        return 3;
      case SubscriptionPlan.professional:
        return 25;
      case SubscriptionPlan.studio:
        return 999;
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // STORAGE OPERATIONS
  // ═══════════════════════════════════════════════════════════════

  /// Load user state from SharedPreferences
  Future<void> loadFromStorage() async {
    if (_isLoaded) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
      
      final planIndex = prefs.getInt(_planKey) ?? 0;
      _currentPlan = SubscriptionPlan.values[planIndex.clamp(0, SubscriptionPlan.values.length - 1)];
      
      final userJson = prefs.getString(_userKey);
      if (userJson != null && userJson.isNotEmpty) {
        final userData = json.decode(userJson) as Map<String, dynamic>;
        _currentUser = UserProfile.fromJson(userData);
        if (kDebugMode) {
          debugPrint('✅ User loaded from storage: $_isLoggedIn, ${_currentUser?.email}');
        }
      } else {
        if (kDebugMode) {
          debugPrint('ℹ️ No user data in storage');
        }
      }
      
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      _isLoaded = true;
      if (kDebugMode) {
        debugPrint('❌ Error loading from storage: $e');
      }
    }
  }

  /// Save user state to SharedPreferences
  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setBool(_isLoggedInKey, _isLoggedIn);
      await prefs.setInt(_planKey, _currentPlan.index);
      
      if (_currentUser != null) {
        final userJson = json.encode(_currentUser!.toJson());
        await prefs.setString(_userKey, userJson);
        if (kDebugMode) {
          debugPrint('✅ User saved to storage: $_isLoggedIn, ${_currentUser?.email}');
        }
      } else {
        await prefs.remove(_userKey);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error saving to storage: $e');
      }
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // AUTHENTICATION METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Sign up with email and password
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Use defaults if fields are empty (for demo purposes)
    String userEmail = email.trim().isNotEmpty ? email.trim() : 'newuser@tinseltowniq.com';
    String userName = name.trim().isNotEmpty ? name.trim() : 'New User';
    
    // Create user profile
    _currentUser = UserProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: userEmail,
      name: userName,
      createdAt: DateTime.now(),
      scansUsed: 0,
    );
    _isLoggedIn = true;
    _currentPlan = SubscriptionPlan.free;
    
    await _saveToStorage();
    notifyListeners();
    
    return AuthResult(success: true);
  }

  /// Sign in with email and password
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));
    
    // Allow demo login with any input or use test@test.com
    String userEmail = email.trim();
    String userName = 'Demo User';
    
    if (userEmail.isNotEmpty && userEmail.contains('@')) {
      userName = userEmail.split('@').first.replaceAll('.', ' ').split(' ').map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '').join(' ');
    } else {
      // Default demo account if empty
      userEmail = 'demo@tinseltowniq.com';
      userName = 'Demo User';
    }
    
    // Check if we have existing user data for this email
    final existingUser = _currentUser;
    if (existingUser != null && existingUser.email == userEmail) {
      // Restore existing user
      _isLoggedIn = true;
      await _saveToStorage();
      notifyListeners();
      return AuthResult(success: true);
    }
    
    // Create new user profile
    _currentUser = UserProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: userEmail,
      name: userName,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      scansUsed: 0, // Start fresh with 0 scans used
    );
    _isLoggedIn = true;
    _currentPlan = SubscriptionPlan.professional;
    
    await _saveToStorage();
    notifyListeners();
    
    return AuthResult(success: true);
  }

  /// Sign out current user
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn = false;
    // Keep user data for potential re-login, just mark as logged out
    await _saveToStorage();
    notifyListeners();
  }
  
  /// OAuth Sign-In (Google, Apple)
  Future<AuthResult> signInWithOAuth({
    required String provider,
    required String id,
    required String email,
    required String name,
    String? photoUrl,
  }) async {
    // Check if user already exists with this OAuth ID
    final existingUser = _currentUser;
    
    if (existingUser != null && existingUser.id == '${provider}_$id') {
      // User already exists, just log them in
      _isLoggedIn = true;
      await _saveToStorage();
      notifyListeners();
      return AuthResult(success: true);
    }
    
    // Create new user with OAuth data
    _currentUser = UserProfile(
      id: '${provider}_$id',
      email: email,
      name: name,
      createdAt: DateTime.now(),
      scansUsed: 0,
      avatarUrl: photoUrl,
    );
    _isLoggedIn = true;
    _currentPlan = SubscriptionPlan.free; // Default to free plan
    
    await _saveToStorage();
    notifyListeners();
    
    return AuthResult(success: true);
  }
  
  /// Clear all user data completely
  Future<void> clearAllData() async {
    _isLoggedIn = false;
    _currentUser = null;
    _currentPlan = SubscriptionPlan.free;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_planKey);
    await prefs.remove(_isLoggedInKey);
    
    notifyListeners();
  }

  // ═══════════════════════════════════════════════════════════════
  // SUBSCRIPTION & SCAN MANAGEMENT
  // ═══════════════════════════════════════════════════════════════

  /// Upgrade to a new subscription plan
  Future<bool> upgradePlan(SubscriptionPlan plan) async {
    await Future.delayed(const Duration(seconds: 2));
    _currentPlan = plan;
    await _saveToStorage();
    notifyListeners();
    return true;
  }
  
  /// Use one scan credit
  void useScan() {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(scansUsed: _currentUser!.scansUsed + 1);
      _saveToStorage();
      notifyListeners();
    }
  }
  
  /// Reset scans for new billing period
  Future<void> resetScans() async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(scansUsed: 0);
      await _saveToStorage();
      notifyListeners();
    }
  }
}
