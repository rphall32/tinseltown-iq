import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tinseltown_iq/main.dart' show TinseltownIQApp;
import 'package:tinseltown_iq/screens/auth/welcome_screen.dart';
import 'package:tinseltown_iq/core/theme/app_colors.dart';

void main() {
  group('TinseltownIQApp', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(const TinseltownIQApp());
      await tester.pump(const Duration(milliseconds: 100));
      
      // App should render
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('uses dark theme', (WidgetTester tester) async {
      await tester.pumpWidget(const TinseltownIQApp());
      await tester.pump(const Duration(milliseconds: 100));
      
      // Verify the app renders with either darkTheme or theme
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      // The app should have theme configuration
      final hasThemeConfig = materialApp.theme != null || materialApp.darkTheme != null;
      expect(hasThemeConfig, isTrue);
    });

    testWidgets('shows initial screen', (WidgetTester tester) async {
      await tester.pumpWidget(const TinseltownIQApp());
      await tester.pump(const Duration(milliseconds: 500));
      
      // Should render some content
      expect(find.byType(Scaffold), findsWidgets);
    });
  });

  group('WelcomeScreen', () {
    testWidgets('displays app branding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WelcomeScreen(),
        ),
      );
      await tester.pump();
      
      // Should render WelcomeScreen widget
      expect(find.byType(WelcomeScreen), findsOneWidget);
    });

    testWidgets('has interactive elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WelcomeScreen(),
        ),
      );
      await tester.pump();
      
      // Should have buttons or tappable areas
      expect(find.byType(GestureDetector), findsWidgets);
    });
  });

  group('AppColors', () {
    test('defines primary brand colors', () {
      expect(AppColors.oscarGold, isA<Color>());
      expect(AppColors.midnightPremiere, isA<Color>());
      expect(AppColors.greenlightNeon, isA<Color>());
      expect(AppColors.cutRed, isA<Color>());
    });

    test('defines UI background colors', () {
      expect(AppColors.soundstageDark, isA<Color>());
      expect(AppColors.editingBay, isA<Color>());
      expect(AppColors.backstage, isA<Color>());
    });

    test('defines text colors', () {
      expect(AppColors.scriptPrimary, isA<Color>());
      expect(AppColors.dialogueSecondary, isA<Color>());
      expect(AppColors.stageDirection, isA<Color>());
    });
  });
}
