// Services barrel file
//
// Re-exports all service classes for easy importing.
// Services remain in main.dart for backward compatibility,
// but can be imported individually through this barrel.

// Export services (currently in main.dart - will be extracted incrementally)
export '../main.dart' show 
  FirebaseService,
  ConnectivityService,
  NotificationService,
  PaymentService,
  UserService,
  AnalysisEngine,
  AnalysisApiService,
  ProjectStorageService,
  OAuthService,
  OfflineQueueService,
  TransactionService,
  PaymentMethodsService,
  RenewalReminderService,
  PromoCodeService,
  SubscriptionSyncService;

// Deep linking service
export 'deep_link_service.dart';

// Analytics service
export 'analytics_service.dart';

// Payment module (models extracted, services coming soon)
export 'payment/payment.dart';
