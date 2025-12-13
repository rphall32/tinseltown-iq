// User-related data models for Tinseltown IQ

/// Subscription plan levels
enum SubscriptionPlan { 
  free, 
  professional, 
  studio 
}

/// Extension methods for SubscriptionPlan
extension SubscriptionPlanExtension on SubscriptionPlan {
  String get displayName {
    switch (this) {
      case SubscriptionPlan.free:
        return 'Free';
      case SubscriptionPlan.professional:
        return 'Professional';
      case SubscriptionPlan.studio:
        return 'Studio';
    }
  }
  
  String get price {
    switch (this) {
      case SubscriptionPlan.free:
        return '\$0';
      case SubscriptionPlan.professional:
        return '\$29/mo';
      case SubscriptionPlan.studio:
        return '\$99/mo';
    }
  }
  
  int get maxScans {
    switch (this) {
      case SubscriptionPlan.free:
        return 3;
      case SubscriptionPlan.professional:
        return 25;
      case SubscriptionPlan.studio:
        return 999; // Unlimited
    }
  }
}

/// User profile data model
class UserProfile {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;
  final int scansUsed;
  final String? avatarUrl;
  final DateTime? lastScanReset; // Track when scans were last reset

  UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.scansUsed,
    this.avatarUrl,
    this.lastScanReset,
  });
  
  /// Create a copy with updated fields
  UserProfile copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
    int? scansUsed,
    String? avatarUrl,
    DateTime? lastScanReset,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      scansUsed: scansUsed ?? this.scansUsed,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastScanReset: lastScanReset ?? this.lastScanReset,
    );
  }
  
  /// JSON serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'scansUsed': scansUsed,
    'avatarUrl': avatarUrl,
    'lastScanReset': lastScanReset?.toIso8601String(),
  };
  
  /// Create UserProfile from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    scansUsed: json['scansUsed'] as int? ?? 0,
    avatarUrl: json['avatarUrl'] as String?,
    lastScanReset: json['lastScanReset'] != null 
        ? DateTime.parse(json['lastScanReset'] as String)
        : null,
  );
  
  /// Get user initials for avatar display
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
  
  @override
  String toString() => 'UserProfile(id: $id, email: $email, name: $name)';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}

/// Authentication result
class AuthResult {
  final bool success;
  final String? error;
  
  AuthResult({required this.success, this.error});
  
  factory AuthResult.success() => AuthResult(success: true);
  
  factory AuthResult.failure(String error) => AuthResult(success: false, error: error);
  
  @override
  String toString() => 'AuthResult(success: $success, error: $error)';
}
