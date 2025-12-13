import 'package:flutter_test/flutter_test.dart';
import 'package:tinseltown_iq/main.dart';

void main() {
  group('UserProfile', () {
    test('creates instance with required fields', () {
      final profile = UserProfile(
        id: 'user123',
        email: 'test@example.com',
        name: 'Test User',
        createdAt: DateTime(2024, 1, 1),
        scansUsed: 0,
      );

      expect(profile.id, equals('user123'));
      expect(profile.email, equals('test@example.com'));
      expect(profile.name, equals('Test User'));
      expect(profile.scansUsed, equals(0));
    });

    test('copyWith creates new instance with updated fields', () {
      final original = UserProfile(
        id: 'user123',
        email: 'test@example.com',
        name: 'Test User',
        createdAt: DateTime(2024, 1, 1),
        scansUsed: 0,
      );

      final updated = original.copyWith(
        name: 'Updated Name',
        scansUsed: 5,
      );

      expect(updated.id, equals('user123'));
      expect(updated.email, equals('test@example.com'));
      expect(updated.name, equals('Updated Name'));
      expect(updated.scansUsed, equals(5));
      // Original should be unchanged
      expect(original.name, equals('Test User'));
      expect(original.scansUsed, equals(0));
    });

    test('toJson serializes all fields', () {
      final profile = UserProfile(
        id: 'user123',
        email: 'test@example.com',
        name: 'Test User',
        createdAt: DateTime(2024, 1, 1),
        scansUsed: 3,
      );

      final json = profile.toJson();

      expect(json['id'], equals('user123'));
      expect(json['email'], equals('test@example.com'));
      expect(json['name'], equals('Test User'));
      expect(json['scansUsed'], equals(3));
    });

    test('fromJson deserializes correctly', () {
      final json = {
        'id': 'user456',
        'email': 'another@example.com',
        'name': 'Another User',
        'createdAt': DateTime(2024, 1, 1).toIso8601String(),
        'scansUsed': 7,
        'lastScanReset': DateTime(2024, 1, 1).toIso8601String(),
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.id, equals('user456'));
      expect(profile.email, equals('another@example.com'));
      expect(profile.name, equals('Another User'));
      expect(profile.scansUsed, equals(7));
    });

    test('initials returns correct value', () {
      final profile = UserProfile(
        id: 'user123',
        email: 'test@example.com',
        name: 'John Doe',
        createdAt: DateTime(2024, 1, 1),
        scansUsed: 0,
      );

      expect(profile.initials, equals('JD'));
    });

    test('initials handles single name', () {
      final profile = UserProfile(
        id: 'user123',
        email: 'test@example.com',
        name: 'Madonna',
        createdAt: DateTime(2024, 1, 1),
        scansUsed: 0,
      );

      expect(profile.initials, equals('M'));
    });
  });

  group('SubscriptionPlan', () {
    test('has correct enum values', () {
      expect(SubscriptionPlan.values, contains(SubscriptionPlan.free));
      expect(SubscriptionPlan.values, contains(SubscriptionPlan.professional));
      expect(SubscriptionPlan.values, contains(SubscriptionPlan.studio));
    });
  });

  group('AuthResult', () {
    test('creates successful result', () {
      final result = AuthResult(success: true);

      expect(result.success, isTrue);
      expect(result.error, isNull);
    });

    test('creates failed result with error', () {
      final result = AuthResult(
        success: false,
        error: 'Invalid credentials',
      );

      expect(result.success, isFalse);
      expect(result.error, equals('Invalid credentials'));
    });
  });
}
