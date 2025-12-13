// Payment Models - Core data classes for payment functionality
//
// These models are used by payment services throughout the app.
// Currently re-exported from main.dart for backward compatibility.
// Infrastructure prepared for future full extraction.

import 'package:flutter/material.dart';

/// Payment result class
class PaymentResult {
  final bool success;
  final String message;
  final String? errorCode;
  final String? transactionId;
  final DateTime? timestamp;

  PaymentResult({
    required this.success,
    required this.message,
    this.errorCode,
    this.transactionId,
    this.timestamp,
  });

  factory PaymentResult.successful({
    required String message,
    String? transactionId,
  }) {
    return PaymentResult(
      success: true,
      message: message,
      transactionId: transactionId ?? 'txn_${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
    );
  }

  factory PaymentResult.failed({
    required String message,
    String? errorCode,
  }) {
    return PaymentResult(
      success: false,
      message: message,
      errorCode: errorCode,
    );
  }

  factory PaymentResult.cancelled() {
    return PaymentResult(
      success: false,
      message: 'Payment was cancelled.',
      errorCode: 'cancelled',
    );
  }
}

/// Subscription plan details for payment
class PlanDetails {
  final String id;
  final String name;
  final int priceInCents;
  final String priceDisplay;
  final List<String> features;
  final int scansPerMonth;
  final bool isPopular;
  final Color? accentColor;

  const PlanDetails({
    required this.id,
    required this.name,
    required this.priceInCents,
    required this.priceDisplay,
    required this.features,
    required this.scansPerMonth,
    this.isPopular = false,
    this.accentColor,
  });

  bool get isFree => priceInCents == 0;
  
  double get priceInDollars => priceInCents / 100;

  String get formattedPrice {
    if (isFree) return 'Free';
    return '\$${priceInDollars.toStringAsFixed(2)}';
  }
}

/// Transaction record for payment history
class TransactionRecord {
  final String id;
  final String planName;
  final int amountCents;
  final String currency;
  final String status; // 'succeeded', 'failed', 'pending', 'refunded'
  final DateTime createdAt;
  final String? paymentMethodLast4;
  final String? paymentMethodBrand;
  final String? receiptUrl;
  final String? failureMessage;

  TransactionRecord({
    required this.id,
    required this.planName,
    required this.amountCents,
    required this.currency,
    required this.status,
    required this.createdAt,
    this.paymentMethodLast4,
    this.paymentMethodBrand,
    this.receiptUrl,
    this.failureMessage,
  });

  String get formattedAmount {
    final dollars = amountCents / 100;
    return '\$${dollars.toStringAsFixed(2)}';
  }

  String get formattedDate {
    return '${createdAt.month}/${createdAt.day}/${createdAt.year}';
  }

  bool get isSuccessful => status == 'succeeded';
  bool get isFailed => status == 'failed';
  bool get isPending => status == 'pending';
  bool get isRefunded => status == 'refunded';

  Map<String, dynamic> toJson() => {
    'id': id,
    'planName': planName,
    'amountCents': amountCents,
    'currency': currency,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'paymentMethodLast4': paymentMethodLast4,
    'paymentMethodBrand': paymentMethodBrand,
    'receiptUrl': receiptUrl,
    'failureMessage': failureMessage,
  };

  factory TransactionRecord.fromJson(Map<String, dynamic> json) => TransactionRecord(
    id: json['id'] as String,
    planName: json['planName'] as String,
    amountCents: json['amountCents'] as int,
    currency: json['currency'] as String? ?? 'usd',
    status: json['status'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    paymentMethodLast4: json['paymentMethodLast4'] as String?,
    paymentMethodBrand: json['paymentMethodBrand'] as String?,
    receiptUrl: json['receiptUrl'] as String?,
    failureMessage: json['failureMessage'] as String?,
  );
}

/// Saved payment method (card)
class SavedPaymentMethod {
  final String id;
  final String brand; // 'Visa', 'Mastercard', 'Amex', etc.
  final String last4;
  final int expMonth;
  final int expYear;
  final bool isDefault;
  final DateTime addedAt;

  SavedPaymentMethod({
    required this.id,
    required this.brand,
    required this.last4,
    required this.expMonth,
    required this.expYear,
    required this.isDefault,
    required this.addedAt,
  });

  String get expiryDisplay => '${expMonth.toString().padLeft(2, '0')}/${expYear.toString().substring(2)}';
  
  bool get isExpired {
    final now = DateTime.now();
    return expYear < now.year || (expYear == now.year && expMonth < now.month);
  }

  bool get isExpiringSoon {
    final now = DateTime.now();
    final threeMonthsFromNow = DateTime(now.year, now.month + 3, now.day);
    final expiryDate = DateTime(expYear, expMonth + 1, 0); // Last day of expiry month
    return expiryDate.isBefore(threeMonthsFromNow) && !isExpired;
  }

  IconData get brandIcon {
    switch (brand.toLowerCase()) {
      case 'visa':
        return Icons.credit_card;
      case 'mastercard':
        return Icons.credit_card;
      case 'amex':
      case 'american express':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'brand': brand,
    'last4': last4,
    'expMonth': expMonth,
    'expYear': expYear,
    'isDefault': isDefault,
    'addedAt': addedAt.toIso8601String(),
  };

  factory SavedPaymentMethod.fromJson(Map<String, dynamic> json) => SavedPaymentMethod(
    id: json['id'] as String,
    brand: json['brand'] as String,
    last4: json['last4'] as String,
    expMonth: json['expMonth'] as int,
    expYear: json['expYear'] as int,
    isDefault: json['isDefault'] as bool? ?? false,
    addedAt: DateTime.parse(json['addedAt'] as String),
  );

  SavedPaymentMethod copyWith({bool? isDefault}) => SavedPaymentMethod(
    id: id,
    brand: brand,
    last4: last4,
    expMonth: expMonth,
    expYear: expYear,
    isDefault: isDefault ?? this.isDefault,
    addedAt: addedAt,
  );
}

/// Promo code model
class PromoCode {
  final String code;
  final String type; // 'percentage', 'fixed', 'trial_extension'
  final int value; // percentage (10 = 10%) or cents for fixed
  final DateTime? expiresAt;
  final List<String> applicablePlans; // Empty = all plans
  final int? maxUses;
  final int currentUses;
  final String? description;

  PromoCode({
    required this.code,
    required this.type,
    required this.value,
    this.expiresAt,
    this.applicablePlans = const [],
    this.maxUses,
    this.currentUses = 0,
    this.description,
  });

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isMaxedOut {
    if (maxUses == null) return false;
    return currentUses >= maxUses!;
  }

  bool get isValid => !isExpired && !isMaxedOut;

  bool isApplicableToPlan(String planId) {
    if (applicablePlans.isEmpty) return true;
    return applicablePlans.contains(planId);
  }

  int calculateDiscount(int originalPriceCents) {
    switch (type) {
      case 'percentage':
        return (originalPriceCents * value / 100).round();
      case 'fixed':
        return value > originalPriceCents ? originalPriceCents : value;
      case 'trial_extension':
        return 0; // Trial extensions don't affect price directly
      default:
        return 0;
    }
  }

  String get displayValue {
    switch (type) {
      case 'percentage':
        return '$value% off';
      case 'fixed':
        return '\$${(value / 100).toStringAsFixed(2)} off';
      case 'trial_extension':
        return '$value days free trial';
      default:
        return '';
    }
  }
}

/// Promo code validation result
class PromoCodeResult {
  final bool isValid;
  final PromoCode? promoCode;
  final String message;
  final int? discountCents;

  PromoCodeResult({
    required this.isValid,
    this.promoCode,
    required this.message,
    this.discountCents,
  });

  factory PromoCodeResult.valid(PromoCode code, int discountCents) {
    return PromoCodeResult(
      isValid: true,
      promoCode: code,
      message: 'Promo code applied: ${code.displayValue}',
      discountCents: discountCents,
    );
  }

  factory PromoCodeResult.invalid(String reason) {
    return PromoCodeResult(
      isValid: false,
      message: reason,
    );
  }
}

/// Renewal reminder model
class RenewalReminder {
  final String planId;
  final DateTime renewalDate;
  final int amountCents;
  final bool reminderSent;
  final DateTime? reminderSentAt;
  final bool autoRenewEnabled;

  RenewalReminder({
    required this.planId,
    required this.renewalDate,
    required this.amountCents,
    this.reminderSent = false,
    this.reminderSentAt,
    this.autoRenewEnabled = true,
  });

  bool get isDueSoon {
    final daysUntilRenewal = renewalDate.difference(DateTime.now()).inDays;
    return daysUntilRenewal <= 7 && daysUntilRenewal >= 0;
  }

  bool get isOverdue {
    return DateTime.now().isAfter(renewalDate);
  }

  int get daysUntilRenewal {
    return renewalDate.difference(DateTime.now()).inDays;
  }

  Map<String, dynamic> toJson() => {
    'planId': planId,
    'renewalDate': renewalDate.toIso8601String(),
    'amountCents': amountCents,
    'reminderSent': reminderSent,
    'reminderSentAt': reminderSentAt?.toIso8601String(),
    'autoRenewEnabled': autoRenewEnabled,
  };

  factory RenewalReminder.fromJson(Map<String, dynamic> json) => RenewalReminder(
    planId: json['planId'] as String,
    renewalDate: DateTime.parse(json['renewalDate'] as String),
    amountCents: json['amountCents'] as int,
    reminderSent: json['reminderSent'] as bool? ?? false,
    reminderSentAt: json['reminderSentAt'] != null 
        ? DateTime.parse(json['reminderSentAt'] as String) 
        : null,
    autoRenewEnabled: json['autoRenewEnabled'] as bool? ?? true,
  );
}

/// Payment analytics data
class PaymentAnalytics {
  final int totalSpentCents;
  final int transactionCount;
  final int successfulTransactions;
  final int failedTransactions;
  final String? mostUsedPlan;
  final DateTime? firstPaymentDate;
  final DateTime? lastPaymentDate;

  PaymentAnalytics({
    required this.totalSpentCents,
    required this.transactionCount,
    required this.successfulTransactions,
    required this.failedTransactions,
    this.mostUsedPlan,
    this.firstPaymentDate,
    this.lastPaymentDate,
  });

  double get totalSpentDollars => totalSpentCents / 100;
  
  double get successRate {
    if (transactionCount == 0) return 0;
    return successfulTransactions / transactionCount * 100;
  }

  double get averageTransactionDollars {
    if (successfulTransactions == 0) return 0;
    return totalSpentDollars / successfulTransactions;
  }
}

/// Monthly spending data for charts
class MonthlySpending {
  final int year;
  final int month;
  final int amountCents;
  final int transactionCount;

  MonthlySpending({
    required this.year,
    required this.month,
    required this.amountCents,
    required this.transactionCount,
  });

  String get monthLabel {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  double get amountDollars => amountCents / 100;
}

/// Subscription sync status
enum SyncStatus { idle, syncing, success, error }
