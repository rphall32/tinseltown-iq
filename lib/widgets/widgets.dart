// Widgets barrel file
//
// Re-exports all reusable widgets for easy importing.
// Widgets remain in main.dart for backward compatibility,
// but can be imported individually through this barrel.

// Export accessibility widgets
export '../core/utils/accessibility.dart' show 
  A11y,
  SemanticWrapper,
  AccessibleScoreDisplay,
  AccessibleButton;

// Loading and progress widgets
export 'loading_widgets.dart';

// Offline mode widgets
export 'offline_indicator.dart';

// App tour and onboarding
export 'app_tour.dart';

// Dialog and sheet components
export 'dialogs/app_dialogs.dart';
export 'dialogs/app_sheets.dart';

// Notification components
export 'notifications/app_snackbar.dart';

// Card components
export 'cards/app_cards.dart';

// Input components
export 'inputs/app_inputs.dart';

// Button components
export 'buttons/app_buttons.dart';
