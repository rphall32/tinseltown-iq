// Screens barrel file
//
// Re-exports all screen widgets for easy importing.
// 
// MIGRATION STATUS:
// ✅ Screen stub files created with re-exports from main.dart
// ⏳ Actual extraction pending (screens still in main.dart)
// 
// This pattern allows gradual migration while maintaining stability:
// 1. Stub files re-export from main.dart (current state)
// 2. Each screen can be extracted independently
// 3. Tests verify no regressions after each extraction
// 4. Eventually main.dart will import from these files

// ═══════════════════════════════════════════════════════════════
// AUTHENTICATION SCREENS
// ═══════════════════════════════════════════════════════════════
export 'auth/welcome_screen.dart';
export 'auth/sign_in_screen.dart';
export 'auth/sign_up_screen.dart';
export 'auth/plan_selection_screen.dart';

// ═══════════════════════════════════════════════════════════════
// ONBOARDING SCREENS
// ═══════════════════════════════════════════════════════════════
export 'onboarding/onboarding_screen.dart';

// ═══════════════════════════════════════════════════════════════
// SPLASH SCREEN
// ═══════════════════════════════════════════════════════════════
export 'splash/splash_screen.dart';

// ═══════════════════════════════════════════════════════════════
// HOME & MAIN APP SCREENS
// ═══════════════════════════════════════════════════════════════
export 'home/home_screen.dart';

// ═══════════════════════════════════════════════════════════════
// ANALYSIS SCREENS
// ═══════════════════════════════════════════════════════════════
export 'analysis/analysis_screen.dart';

// ═══════════════════════════════════════════════════════════════
// RESULTS SCREENS
// ═══════════════════════════════════════════════════════════════
export 'results/results_screen.dart';

// ═══════════════════════════════════════════════════════════════
// TABS (still in main.dart - will be extracted to components)
// ═══════════════════════════════════════════════════════════════
export '../main.dart' show 
  ProjectsTab,
  SettingsTab;
