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
///    - tinseltown_iq_professional_monthly ($29.99/month)
///    - tinseltown_iq_studio_monthly ($99.99/month)
/// 3. Submit for review in App Store Connect
class InAppPurchaseService extends ChangeNotifier {
  static final InAppPurchaseService _instance = InAppPurchaseService._internal();
  factory InAppPurchaseService() => _instance;
  InAppPurchaseService._internal();

  // ═══════════════════════════════════════════════════════════════
  // PRODUCT IDS - Configure these in App Store Connect
  // ═══════════════════════════════════════════════════════════════
  
  /// Product ID for Professional Monthly subscription ($29.99/month)
  static const String professionalMonthlyProductId = 'tinseltown_iq_professional_monthly';
  
  /// Product ID for Studio Monthly subscription ($99.99/month)
  static const String studioMonthlyProductId = 'tinseltown_iq_studio_monthly';
  
  /// All available product IDs
  static const Set<String> productIds = {
    professionalMonthlyProductId,
    studioMonthlyProductId,
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
  
  /// Get Professional subscription product
  ProductDetails? get professionalProduct => getProduct(professionalMonthlyProductId);
  
  /// Get Studio subscription product
  ProductDetails? get studioProduct => getProduct(studioMonthlyProductId);

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
  
  /// Purchase Professional subscription
  Future<bool> purchaseProfessional() async {
    return purchaseSubscription(professionalMonthlyProductId);
  }
  
  /// Purchase Studio subscription
  Future<bool> purchaseStudio() async {
    return purchaseSubscription(studioMonthlyProductId);
  }

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

  /// Check if user has active Professional subscription
  bool get hasProfessionalSubscription {
    return _purchases.any((p) => 
      p.productID == professionalMonthlyProductId &&
      (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored)
    );
  }
  
  /// Check if user has active Studio subscription
  bool get hasStudioSubscription {
    return _purchases.any((p) => 
      p.productID == studioMonthlyProductId &&
      (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored)
    );
  }
  
  /// Check if user has any active subscription
  bool get hasActiveSubscription => hasProfessionalSubscription || hasStudioSubscription;
  
  /// Get the current subscription product ID (if any)
  String? get activeSubscriptionId {
    if (hasStudioSubscription) return studioMonthlyProductId;
    if (hasProfessionalSubscription) return professionalMonthlyProductId;
    return null;
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
