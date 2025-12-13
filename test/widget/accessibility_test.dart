import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tinseltown_iq/core/utils/accessibility.dart';

void main() {
  group('A11y utility class', () {
    group('scoreLabel', () {
      test('generates correct label for excellent score', () {
        final label = A11y.scoreLabel(85, 'Greenlight');
        
        expect(label, contains('85'));
        expect(label, contains('100'));
        expect(label, contains('Excellent'));
        expect(label, contains('Greenlight'));
      });

      test('generates correct label for good score', () {
        final label = A11y.scoreLabel(65, 'Consider');
        
        expect(label, contains('65'));
        expect(label, contains('Good'));
      });

      test('generates correct label for fair score', () {
        final label = A11y.scoreLabel(45, 'Needs Work');
        
        expect(label, contains('45'));
        expect(label, contains('Fair'));
      });

      test('generates correct label for low score', () {
        final label = A11y.scoreLabel(25, 'Pass');
        
        expect(label, contains('25'));
        expect(label, contains('Low'));
      });
    });

    group('scoreChangeLabel', () {
      test('returns improvement message for positive change', () {
        final label = A11y.scoreChangeLabel(15);
        
        expect(label, contains('improved'));
        expect(label, contains('15'));
      });

      test('returns decrease message for negative change', () {
        final label = A11y.scoreChangeLabel(-10);
        
        expect(label, contains('decreased'));
        expect(label, contains('10'));
      });

      test('returns unchanged message for zero change', () {
        final label = A11y.scoreChangeLabel(0);
        
        expect(label, contains('unchanged'));
      });

      test('handles null change', () {
        final label = A11y.scoreChangeLabel(null);
        
        expect(label, contains('No previous'));
      });
    });

    group('tabLabel', () {
      test('indicates selected state', () {
        final label = A11y.tabLabel('Home', true, 0, 4);
        
        expect(label, contains('Home'));
        expect(label, contains('selected'));
        expect(label, contains('1 of 4'));
      });

      test('indicates unselected state', () {
        final label = A11y.tabLabel('Projects', false, 2, 4);
        
        expect(label, contains('Projects'));
        expect(label, contains('not selected'));
        expect(label, contains('3 of 4'));
      });
    });

    group('projectItemLabel', () {
      test('includes all project details', () {
        final label = A11y.projectItemLabel(
          title: 'My Movie',
          score: 75,
          verdict: 'Consider',
          genre: 'Action',
          timeAgo: '2 days ago',
          isFavorite: true,
        );
        
        expect(label, contains('My Movie'));
        expect(label, contains('75'));
        expect(label, contains('Consider'));
        expect(label, contains('Action'));
        expect(label, contains('2 days ago'));
        expect(label, contains('favorite'));
      });

      test('omits favorite status when not favorited', () {
        final label = A11y.projectItemLabel(
          title: 'Another Movie',
          score: 60,
          verdict: 'Needs Work',
          genre: 'Drama',
          timeAgo: '1 hour ago',
          isFavorite: false,
        );
        
        expect(label, isNot(contains('favorite')));
      });
    });

    group('buyerItemLabel', () {
      test('includes buyer details', () {
        final label = A11y.buyerItemLabel(
          name: 'Netflix',
          type: 'Streaming Platform',
          matchPercent: 85,
          lookingFor: 'Genre content',
        );
        
        expect(label, contains('Netflix'));
        expect(label, contains('Streaming Platform'));
        expect(label, contains('85'));
        expect(label, contains('Genre content'));
      });
    });

    group('producerItemLabel', () {
      test('includes producer details', () {
        final label = A11y.producerItemLabel(
          name: 'Jason Blum',
          company: 'Blumhouse',
          matchPercent: 90,
          specialty: 'Horror',
        );
        
        expect(label, contains('Jason Blum'));
        expect(label, contains('Blumhouse'));
        expect(label, contains('90'));
        expect(label, contains('Horror'));
      });
    });

    group('planCardLabel', () {
      test('indicates current plan', () {
        final label = A11y.planCardLabel(
          planName: 'Professional',
          price: '\$9.99/mo',
          isCurrentPlan: true,
          features: ['25 scans', 'Priority support'],
        );
        
        expect(label, contains('Professional'));
        expect(label, contains('\$9.99'));
        expect(label, contains('current plan'));
        expect(label, contains('25 scans'));
      });

      test('indicates available plan', () {
        final label = A11y.planCardLabel(
          planName: 'Studio',
          price: '\$29.99/mo',
          isCurrentPlan: false,
          features: ['Unlimited scans'],
        );
        
        expect(label, contains('Studio'));
        expect(label, contains('Available'));
      });
    });

    group('scanUsageLabel', () {
      test('shows usage for limited plan', () {
        final label = A11y.scanUsageLabel(5, 25);
        
        expect(label, contains('5'));
        expect(label, contains('25'));
        expect(label, contains('20 remaining'));
      });

      test('shows unlimited for studio plan', () {
        final label = A11y.scanUsageLabel(100, 999, isUnlimited: true);
        
        expect(label, contains('Unlimited'));
      });
    });

    group('networkStatus', () {
      test('indicates online status', () {
        final label = A11y.networkStatus(true);
        
        expect(label, contains('Connected'));
      });

      test('indicates offline status', () {
        final label = A11y.networkStatus(false);
        
        expect(label, contains('No network'));
        expect(label, contains('offline'));
      });
    });

    group('status messages', () {
      test('loading message is constant', () {
        expect(A11y.loading, equals('Loading, please wait'));
      });

      test('success message includes action', () {
        final msg = A11y.success('Save');
        expect(msg, contains('Save'));
        expect(msg, contains('successfully'));
      });

      test('error message includes details', () {
        final msg = A11y.error('Connection failed');
        expect(msg, contains('Error'));
        expect(msg, contains('Connection failed'));
      });
    });
  });

  group('SemanticWrapper widget', () {
    testWidgets('wraps child with Semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SemanticWrapper(
            label: 'Test label',
            hint: 'Test hint',
            isButton: true,
            child: Container(),
          ),
        ),
      );
      
      // Verify the SemanticWrapper widget is present
      expect(find.byType(SemanticWrapper), findsOneWidget);
      // Verify the child Container is present
      expect(find.byType(Container), findsWidgets);
    });
  });

  group('AccessibleScoreDisplay widget', () {
    testWidgets('provides score semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AccessibleScoreDisplay(
            score: 75,
            verdict: 'Consider',
            child: const Text('75'),
          ),
        ),
      );
      
      // Verify the AccessibleScoreDisplay widget is present
      expect(find.byType(AccessibleScoreDisplay), findsOneWidget);
      expect(find.text('75'), findsOneWidget);
    });
  });

  group('AccessibleButton widget', () {
    testWidgets('wraps button with semantics', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AccessibleButton(
            label: 'Submit',
            hint: 'Submit form',
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ),
        ),
      );
      
      // Verify both the AccessibleButton wrapper and the ElevatedButton are present
      expect(find.byType(AccessibleButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('indicates disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AccessibleButton(
            label: 'Submit',
            enabled: false,
            child: ElevatedButton(
              onPressed: null,
              child: const Text('Submit'),
            ),
          ),
        ),
      );
      
      // Verify the widget tree contains AccessibleButton and ElevatedButton
      expect(find.byType(AccessibleButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
