import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode, ChangeNotifier, debugPrint;
import 'package:in_app_purchase/in_app_purchase.dart';

/// In-App Purchase Service for iOS Subscriptions
/// 
/// This service handles Apple StoreKit integration for subscription purchases.
/// Required by Apple for apps with subscriptions on iOS.
/// 
/// SETUP INSTRUCTIONS:
/// 1. Configure products in App Store Connect → In-App Purchases
/// 2. Add the following Product IDs:
///    MONTHLY:
///    - tinseltown_iq_pro_monthly ($29.99/month)
///    - tinseltown_iq_studio_sub_monthly ($99.99/month)
///    ANNUAL (v2.0):
///    - tinseltown_iq_pro_annual ($249.99/year - saves $109.89)
///    - tinseltown_iq_studio_annual ($999.99/year - saves $198.89)
/// 3. Submit for review in App Store Connect
class InAppPurchaseService extends ChangeNotifier {
  static final InAppPurchaseService _instance = InAppPurchaseService._internal();
  factory InAppPurchaseService() => _instance;
  InAppPurchaseService._internal();

  // ═══════════════════════════════════════════════════════════════
  // PRODUCT IDS - Configure these in App Store Connect
  // ═══════════════════════════════════════════════════════════════
  
  // MONTHLY SUBSCRIPTIONS
  /// Product ID for Professional Monthly subscription ($29.99/month)
  static const String professionalMonthlyProductId = 'tinseltown_iq_pro_monthly';
  
  /// Product ID for Studio Monthly subscription ($99.99/month)
  static const String studioMonthlyProductId = 'tinseltown_iq_studio_sub_monthly';
  
  // ANNUAL SUBSCRIPTIONS (v2.0)
  /// Product ID for Professional Annual subscription ($249.99/year)
  static const String professionalAnnualProductId = 'tinseltown_iq_pro_annual';
  
  /// Product ID for Studio Annual subscription ($999.99/year)
  static const String studioAnnualProductId = 'tinseltown_iq_studio_annual';
  
  /// All available product IDs
  static const Set<String> productIds = {
    professionalMonthlyProductId,
    studioMonthlyProductId,
    professionalAnnualProductId,
    studioAnnualProductId,
  };
  
  /// Monthly product IDs only
  static const Set<String> monthlyProductIds = {
    professionalMonthlyProductId,
    studioMonthlyProductId,
  };
  
  /// Annual product IDs only
  static const Set<String> annualProductIds = {
    professionalAnnualProductId,
    studioAnnualProductId,
  };

  // ═══════════════════════════════════════════════════════════════
  // STATE
  // ═══════════════════════════════════════════════════════════════
  
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  
  bool _isAvailable = false;
  bool _isInitialized = false;
  bool _purchasePending = false;
  String? _pendingError;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  
  // Callbacks
  Function(PurchaseDetails)? onPurchaseSuccess;
  Function(String error)? onPurchaseError;
  Function()? onPurchaseCancelled;
  
  // Getters
  bool get isAvailable => _isAvailable;
  bool get isInitialized => _isInitialized;
  bool get purchasePending => _purchasePending;
  String? get pendingError => _pendingError;
  List<ProductDetails> get products => List.unmodifiable(_products);
  List<PurchaseDetails> get purchases => List.unmodifiable(_purchases);
  
  /// Check if running on iOS/macOS (Apple platforms)
  bool get isApplePlatform => Platform.isIOS || Platform.isMacOS;
  
  /// Get product details by ID
  ProductDetails? getProduct(String productId) {
    try {
      return _products.firstWhere((p) => p.id == productId);
    } catch (e) {
      return null;
    }
  }
  
  /// Get Professional Monthly subscription product
  ProductDetails? get professionalMonthlyProduct => getProduct(professionalMonthlyProductId);
  
  /// Get Professional Annual subscription product
  ProductDetails? get professionalAnnualProduct => getProduct(professionalAnnualProductId);
  
  /// Get Studio Monthly subscription product
  ProductDetails? get studioMonthlyProduct => getProduct(studioMonthlyProductId);
  
  /// Get Studio Annual subscription product
  ProductDetails? get studioAnnualProduct => getProduct(studioAnnualProductId);
  
  // Legacy getters for backward compatibility
  ProductDetails? get professionalProduct => professionalMonthlyProduct;
  ProductDetails? get studioProduct => studioMonthlyProduct;
  
  /// Get all Professional products (monthly and annual)
  List<ProductDetails> get professionalProducts {
    return _products.where((p) => 
      p.id == professionalMonthlyProductId || 
      p.id == professionalAnnualProductId
    ).toList();
  }
  
  /// Get all Studio products (monthly and annual)
  List<ProductDetails> get studioProducts {
    return _products.where((p) => 
      p.id == studioMonthlyProductId || 
      p.id == studioAnnualProductId
    ).toList();
  }
  
  /// Check if a product is annual
  bool isAnnualProduct(String productId) => annualProductIds.contains(productId);
  
  /// Check if a product is monthly
  bool isMonthlyProduct(String productId) => monthlyProductIds.contains(productId);

  // ═══════════════════════════════════════════════════════════════
  // INITIALIZATION
  // ═══════════════════════════════════════════════════════════════

  /// Initialize the In-App Purchase service
  /// Must be called before any purchase operations
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // Check if IAP is available on this platform
    _isAvailable = await _inAppPurchase.isAvailable();
    
    if (!_isAvailable) {
      if (kDebugMode) {
        debugPrint('⚠️ In-App Purchase not available on this platform');
      }
      _isInitialized = true;
      notifyListeners();
      return;
    }
    
    // Listen for purchase updates
    _subscription = _inAppPurchase.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: _onPurchaseStreamDone,
      onError: _onPurchaseStreamError,
    );
    
    // Load available products
    await _loadProducts();
    
    _isInitialized = true;
    notifyListeners();
    
    if (kDebugMode) {
      debugPrint('✅ In-App Purchase initialized');
      debugPrint('📦 Available products: ${_products.map((p) => p.id).join(', ')}');
    }
  }
  
  /// Load products from App Store
  Future<void> _loadProducts() async {
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(productIds);
    
    if (response.notFoundIDs.isNotEmpty) {
      if (kDebugMode) {
        debugPrint('⚠️ Products not found: ${response.notFoundIDs.join(', ')}');
        debugPrint('💡 Make sure products are configured in App Store Connect');
      }
    }
    
    if (response.error != null) {
      if (kDebugMode) {
        debugPrint('❌ Error loading products: ${response.error}');
      }
      _pendingError = response.error?.message;
    }
    
    _products = response.productDetails;
    notifyListeners();
  }
  
  /// Refresh products from App Store
  Future<void> refreshProducts() async {
    await _loadProducts();
  }

  // ═══════════════════════════════════════════════════════════════
  // PURCHASE FLOW
  // ═══════════════════════════════════════════════════════════════

  /// Purchase a subscription product
  /// 
  /// This shows the Apple payment sheet and handles the purchase flow.
  /// Returns true if purchase was initiated successfully.
  Future<bool> purchaseSubscription(String productId) async {
    if (!_isAvailable) {
      _pendingError = 'In-App Purchase not available';
      notifyListeners();
      return false;
    }
    
    final product = getProduct(productId);
    if (product == null) {
      _pendingError = 'Product not found: $productId';
      notifyListeners();
      return false;
    }
    
    if (kDebugMode) {
      debugPrint('🛒 Initiating purchase for: ${product.id} (${product.price})');
    }
    
    _purchasePending = true;
    _pendingError = null;
    notifyListeners();
    
    try {
      // Create purchase param for subscription
      final purchaseParam = PurchaseParam(productDetails: product);
      
      // This will show the Apple payment sheet
      final bool success = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
      
      if (!success) {
        _purchasePending = false;
        _pendingError = 'Failed to initiate purchase';
        notifyListeners();
        return false;
      }
      
      return true;
    } catch (e) {
      _purchasePending = false;
      _pendingError = 'Purchase error: $e';
      notifyListeners();
      
      if (kDebugMode) {
        debugPrint('❌ Purchase failed: $e');
      }
      
      return false;
    }
  }
  
  /// Purchase Professional Monthly subscription
  Future<bool> purchaseProfessionalMonthly() async {
    return purchaseSubscription(professionalMonthlyProductId);
  }
  
  /// Purchase Professional Annual subscription
  Future<bool> purchaseProfessionalAnnual() async {
    return purchaseSubscription(professionalAnnualProductId);
  }
  
  /// Purchase Studio Monthly subscription
  Future<bool> purchaseStudioMonthly() async {
    return purchaseSubscription(studioMonthlyProductId);
  }
  
  /// Purchase Studio Annual subscription
  Future<bool> purchaseStudioAnnual() async {
    return purchaseSubscription(studioAnnualProductId);
  }
  
  // Legacy methods for backward compatibility
  Future<bool> purchaseProfessional() async => purchaseProfessionalMonthly();
  Future<bool> purchaseStudio() async => purchaseStudioMonthly();

  // ═══════════════════════════════════════════════════════════════
  // PURCHASE CALLBACKS
  // ═══════════════════════════════════════════════════════════════

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchaseDetails in purchaseDetailsList) {
      if (kDebugMode) {
        debugPrint('📱 Purchase update: ${purchaseDetails.productID} - ${purchaseDetails.status}');
      }
      
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          _purchasePending = true;
          notifyListeners();
          break;
          
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _purchasePending = false;
          _purchases.add(purchaseDetails);
          
          // Complete the purchase on App Store
          _completePurchase(purchaseDetails);
          
          // Notify success
          onPurchaseSuccess?.call(purchaseDetails);
          notifyListeners();
          
          if (kDebugMode) {
            debugPrint('✅ Purchase successful: ${purchaseDetails.productID}');
          }
          break;
          
        case PurchaseStatus.error:
          _purchasePending = false;
          _pendingError = purchaseDetails.error?.message ?? 'Purchase failed';
          
          // Complete the purchase to clear it
          _completePurchase(purchaseDetails);
          
          // Notify error
          onPurchaseError?.call(_pendingError!);
          notifyListeners();
          
          if (kDebugMode) {
            debugPrint('❌ Purchase error: ${purchaseDetails.error}');
          }
          break;
          
        case PurchaseStatus.canceled:
          _purchasePending = false;
          _pendingError = null;
          
          // Notify cancellation
          onPurchaseCancelled?.call();
          notifyListeners();
          
          if (kDebugMode) {
            debugPrint('🚫 Purchase cancelled');
          }
          break;
      }
    }
  }
  
  void _onPurchaseStreamDone() {
    _subscription?.cancel();
  }
  
  void _onPurchaseStreamError(dynamic error) {
    _pendingError = 'Purchase stream error: $error';
    notifyListeners();
    
    if (kDebugMode) {
      debugPrint('❌ Purchase stream error: $error');
    }
  }
  
  Future<void> _completePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.pendingCompletePurchase) {
      await _inAppPurchase.completePurchase(purchaseDetails);
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // RESTORE PURCHASES
  // ═══════════════════════════════════════════════════════════════

  /// Restore previous purchases
  /// Call this when user wants to restore their subscription on a new device
  Future<void> restorePurchases() async {
    if (!_isAvailable) {
      _pendingError = 'In-App Purchase not available';
      notifyListeners();
      return;
    }
    
    _purchasePending = true;
    _pendingError = null;
    notifyListeners();
    
    if (kDebugMode) {
      debugPrint('🔄 Restoring purchases...');
    }
    
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      _purchasePending = false;
      _pendingError = 'Restore failed: $e';
      notifyListeners();
      
      if (kDebugMode) {
        debugPrint('❌ Restore failed: $e');
      }
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // SUBSCRIPTION STATUS
  // ═══════════════════════════════════════════════════════════════

  /// Check if user has active Professional subscription (monthly or annual)
  bool get hasProfessionalSubscription {
    return _purchases.any((p) => 
      (p.productID == professionalMonthlyProductId || p.productID == professionalAnnualProductId) &&
      (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored)
    );
  }
  
  /// Check if user has active Studio subscription (monthly or annual)
  bool get hasStudioSubscription {
    return _purchases.any((p) => 
      (p.productID == studioMonthlyProductId || p.productID == studioAnnualProductId) &&
      (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored)
    );
  }
  
  /// Check if user has any active subscription
  bool get hasActiveSubscription => hasProfessionalSubscription || hasStudioSubscription;
  
  /// Check if user has annual subscription
  bool get hasAnnualSubscription {
    return _purchases.any((p) => 
      annualProductIds.contains(p.productID) &&
      (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored)
    );
  }
  
  /// Get the current subscription product ID (if any)
  String? get activeSubscriptionId {
    // Check for Studio subscriptions first (higher tier)
    for (final purchase in _purchases) {
      if ((purchase.productID == studioAnnualProductId || purchase.productID == studioMonthlyProductId) &&
          (purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored)) {
        return purchase.productID;
      }
    }
    // Then check Professional subscriptions
    for (final purchase in _purchases) {
      if ((purchase.productID == professionalAnnualProductId || purchase.productID == professionalMonthlyProductId) &&
          (purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored)) {
        return purchase.productID;
      }
    }
    return null;
  }
  
  /// Get subscription tier name from product ID
  String getSubscriptionTierName(String productId) {
    if (productId == professionalMonthlyProductId || productId == professionalAnnualProductId) {
      return 'Professional';
    } else if (productId == studioMonthlyProductId || productId == studioAnnualProductId) {
      return 'Studio';
    }
    return 'Free';
  }
  
  /// Get subscription billing period from product ID
  String getSubscriptionPeriod(String productId) {
    if (annualProductIds.contains(productId)) {
      return 'Annual';
    }
    return 'Monthly';
  }

  // ═══════════════════════════════════════════════════════════════
  // CLEANUP
  // ═══════════════════════════════════════════════════════════════

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

/// Result of a purchase operation
class IAPPurchaseResult {
  final bool success;
  final String message;
  final String? productId;
  final PurchaseDetails? purchaseDetails;
  
  IAPPurchaseResult({
    required this.success,
    required this.message,
    this.productId,
    this.purchaseDetails,
  });
  
  factory IAPPurchaseResult.success(PurchaseDetails details) {
    return IAPPurchaseResult(
      success: true,
      message: 'Purchase successful',
      productId: details.productID,
      purchaseDetails: details,
    );
  }
  
  factory IAPPurchaseResult.error(String error) {
    return IAPPurchaseResult(
      success: false,
      message: error,
    );
  }
  
  factory IAPPurchaseResult.cancelled() {
    return IAPPurchaseResult(
      success: false,
      message: 'Purchase was cancelled',
    );
  }
}
