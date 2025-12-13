// Payment Module Barrel File
//
// Central export point for all payment-related services and models.
// This establishes the infrastructure for a complete payment module.
//
// Currently, services remain in main.dart for backward compatibility.
// Models are extracted and ready for use.
//
// Usage:
//   import 'package:flutter_app/services/payment/payment.dart';
//
// Available exports:
// - PaymentResult, PlanDetails, TransactionRecord
// - SavedPaymentMethod, PromoCode, PromoCodeResult
// - RenewalReminder, PaymentAnalytics, MonthlySpending
// - SyncStatus

// Export all payment models
export 'payment_models.dart';

// NOTE: Payment services are currently in main.dart
// They will be extracted in a future refactoring pass.
// 
// Services to be extracted:
// - PaymentService (Stripe integration)
// - TransactionService (payment history)
// - PaymentMethodsService (saved cards)
// - SubscriptionSyncService (Firebase sync)
// - RenewalReminderService (payment reminders)
// - PromoCodeService (promotional codes)
// - PaymentAnalyticsService (spending analytics)
//
// For now, import services from main.dart:
// import '../../main.dart' show PaymentService, TransactionService;
