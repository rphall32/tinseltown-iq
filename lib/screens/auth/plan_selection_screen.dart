import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import '../../core/theme/app_colors.dart';
import '../../main.dart' show HomeScreen, UserService, SubscriptionPlan;
import '../../services/payment/in_app_purchase_service.dart';

/// Subscription plan selection screen
/// 
/// Uses Apple In-App Purchase for iOS subscriptions (required by Apple guidelines).
/// Falls back to simpler flow for other platforms.
class PlanSelectionScreen extends StatefulWidget {
  const PlanSelectionScreen({super.key});

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  final UserService _userService = UserService();
  final InAppPurchaseService _iapService = InAppPurchaseService();
  int _selectedPlanIndex = 0;
  bool _isLoading = false;
  bool _iapInitialized = false;
  String? _errorMessage;

  final List<_PlanInfo> _plans = [
    _PlanInfo(
      name: 'Free',
      price: '\$0',
      period: 'forever',
      features: [
        '3 concept scans per month',
        'Basic GreenlightIQ™ score',
        'Genre analysis',
      ],
      plan: SubscriptionPlan.free,
      color: AppColors.stageDirection,
      productId: null, // Free plan - no IAP product
    ),
    _PlanInfo(
      name: 'Professional',
      price: '\$29',
      period: '/month',
      features: [
        '25 concept scans per month',
        'Advanced GreenlightIQ™ score',
        'Buyer & producer matching',
        'Comp title analysis',
        'Market trends access',
      ],
      plan: SubscriptionPlan.professional,
      color: AppColors.oscarGold,
      isPopular: true,
      productId: InAppPurchaseService.professionalMonthlyProductId,
    ),
    _PlanInfo(
      name: 'Studio',
      price: '\$99',
      period: '/month',
      features: [
        'Unlimited concept scans',
        'Premium GreenlightIQ™ score',
        'Priority buyer matching',
        'API access',
        'Team collaboration',
        'White-label reports',
      ],
      plan: SubscriptionPlan.studio,
      color: AppColors.greenlightNeon,
      productId: InAppPurchaseService.studioMonthlyProductId,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeIAP();
  }

  /// Initialize In-App Purchase service for iOS
  Future<void> _initializeIAP() async {
    if (!_isApplePlatform) {
      setState(() => _iapInitialized = true);
      return;
    }

    try {
      await _iapService.initialize();
      
      // Set up purchase callbacks
      _iapService.onPurchaseSuccess = _onPurchaseSuccess;
      _iapService.onPurchaseError = _onPurchaseError;
      _iapService.onPurchaseCancelled = _onPurchaseCancelled;
      
      // Update prices from App Store if available
      _updatePricesFromAppStore();
      
      setState(() => _iapInitialized = true);
      
      if (kDebugMode) {
        debugPrint('✅ IAP initialized for plan selection');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('⚠️ IAP initialization failed: $e');
      }
      // Continue without IAP - will fall back to basic flow
      setState(() => _iapInitialized = true);
    }
  }

  /// Update plan prices from App Store (if products are available)
  void _updatePricesFromAppStore() {
    final professionalProduct = _iapService.professionalProduct;
    final studioProduct = _iapService.studioProduct;
    
    // Update prices if products are loaded from App Store
    if (professionalProduct != null) {
      _plans[1] = _plans[1].copyWith(price: professionalProduct.price);
    }
    if (studioProduct != null) {
      _plans[2] = _plans[2].copyWith(price: studioProduct.price);
    }
  }

  bool get _isApplePlatform {
    try {
      return Platform.isIOS || Platform.isMacOS;
    } catch (e) {
      return false; // Web or other platforms
    }
  }

  /// Handle successful purchase from Apple
  void _onPurchaseSuccess(dynamic purchaseDetails) {
    if (kDebugMode) {
      debugPrint('✅ Purchase successful - updating user plan');
    }
    
    final selectedPlan = _plans[_selectedPlanIndex];
    
    // Update local user plan
    _userService.upgradePlan(selectedPlan.plan);
    
    setState(() {
      _isLoading = false;
      _errorMessage = null;
    });
    
    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Successfully subscribed to ${selectedPlan.name}!'),
          backgroundColor: AppColors.greenlightNeon,
        ),
      );
      
      // Navigate to home
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  /// Handle purchase error from Apple
  void _onPurchaseError(String error) {
    if (kDebugMode) {
      debugPrint('❌ Purchase error: $error');
    }
    
    setState(() {
      _isLoading = false;
      _errorMessage = error;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Purchase failed: $error'),
          backgroundColor: AppColors.cutRed,
        ),
      );
    }
  }

  /// Handle purchase cancellation by user
  void _onPurchaseCancelled() {
    if (kDebugMode) {
      debugPrint('🚫 Purchase cancelled by user');
    }
    
    setState(() {
      _isLoading = false;
      _errorMessage = null;
    });
  }

  /// Select and purchase a plan
  Future<void> _selectPlan() async {
    final selectedPlan = _plans[_selectedPlanIndex];
    
    // Free plan - no payment required
    if (selectedPlan.plan == SubscriptionPlan.free) {
      await _selectFreePlan();
      return;
    }
    
    // Paid plan on Apple platform - use In-App Purchase
    if (_isApplePlatform && selectedPlan.productId != null) {
      await _purchaseWithApple(selectedPlan);
      return;
    }
    
    // Non-Apple platform or IAP not available - show info message
    _showNonApplePlatformMessage(selectedPlan);
  }

  /// Select free plan (no payment)
  Future<void> _selectFreePlan() async {
    setState(() => _isLoading = true);

    try {
      await _userService.upgradePlan(SubscriptionPlan.free);
      
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to select plan. Please try again.'),
            backgroundColor: AppColors.cutRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Purchase subscription through Apple In-App Purchase
  Future<void> _purchaseWithApple(_PlanInfo plan) async {
    if (!_iapService.isAvailable) {
      setState(() {
        _errorMessage = 'In-App Purchase is not available. Please check your device settings.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: AppColors.cutRed,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    if (kDebugMode) {
      debugPrint('🛒 Initiating Apple purchase for: ${plan.productId}');
    }

    try {
      // This will show the Apple payment sheet
      final success = await _iapService.purchaseSubscription(plan.productId!);
      
      if (!success && mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = _iapService.pendingError ?? 'Failed to initiate purchase';
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: AppColors.cutRed,
          ),
        );
      }
      // If success, the purchase callbacks will handle the rest
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Purchase error: $e';
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: AppColors.cutRed,
          ),
        );
      }
    }
  }

  /// Show message for non-Apple platforms
  void _showNonApplePlatformMessage(_PlanInfo plan) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.editingBay,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.phone_iphone,
              size: 48,
              color: plan.color,
            ),
            const SizedBox(height: 16),
            Text(
              'Subscribe on iOS',
              style: TextStyle(
                color: AppColors.scriptPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'To subscribe to ${plan.name}, please use the Tinseltown IQ app on your iPhone or iPad.',
              style: const TextStyle(
                color: AppColors.stageDirection,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: plan.color,
                foregroundColor: AppColors.midnightPremiere,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Got it'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Restore previous purchases
  Future<void> _restorePurchases() async {
    if (!_isApplePlatform || !_iapService.isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Restore purchases is only available on iOS'),
          backgroundColor: AppColors.stageDirection,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _iapService.restorePurchases();
      
      // Check if any subscriptions were restored
      if (_iapService.hasActiveSubscription) {
        final restoredPlan = _iapService.hasStudioSubscription 
            ? SubscriptionPlan.studio 
            : SubscriptionPlan.professional;
        
        await _userService.upgradePlan(restoredPlan);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Purchases restored successfully!'),
              backgroundColor: AppColors.greenlightNeon,
            ),
          );
          
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No previous purchases found'),
              backgroundColor: AppColors.stageDirection,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Restore failed: $e'),
            backgroundColor: AppColors.cutRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _skipForNow() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.soundstageDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: _skipForNow,
            child: const Text(
              'Maybe later',
              style: TextStyle(color: AppColors.stageDirection, fontSize: 15),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    'Choose Your Plan',
                    style: TextStyle(
                      color: AppColors.scriptPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Select the plan that fits your creative needs',
                    style: TextStyle(
                      color: AppColors.stageDirection,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Plan cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  final plan = _plans[index];
                  final isSelected = _selectedPlanIndex == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPlanIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? plan.color.withValues(alpha: 0.1)
                              : AppColors.editingBay,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? plan.color : AppColors.backstage,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (plan.isPopular)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        margin: const EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          color: AppColors.oscarGold,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          'MOST POPULAR',
                                          style: TextStyle(
                                            color: AppColors.midnightPremiere,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    Text(
                                      plan.name,
                                      style: TextStyle(
                                        color: isSelected
                                            ? plan.color
                                            : AppColors.scriptPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      plan.price,
                                      style: TextStyle(
                                        color: isSelected
                                            ? plan.color
                                            : AppColors.scriptPrimary,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      plan.period,
                                      style: const TextStyle(
                                        color: AppColors.stageDirection,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),
                            const Divider(color: AppColors.backstage),
                            const SizedBox(height: 12),

                            // Features
                            ...plan.features.map((feature) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: isSelected
                                        ? plan.color
                                        : AppColors.greenlightNeon,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: const TextStyle(
                                        color: AppColors.dialogueSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),

                            // Selection indicator
                            if (isSelected) ...[
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: plan.color.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: plan.color,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Selected',
                                      style: TextStyle(
                                        color: plan.color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom button
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : _selectPlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _plans[_selectedPlanIndex].color,
                      foregroundColor: AppColors.midnightPremiere,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.midnightPremiere,
                              ),
                            ),
                          )
                        : Text(
                            _selectedPlanIndex == 0
                                ? 'Start Free'
                                : 'Upgrade to ${_plans[_selectedPlanIndex].name}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Cancel anytime • No commitments',
                    style: TextStyle(
                      color: AppColors.stageDirection,
                      fontSize: 13,
                    ),
                  ),
                  // Restore purchases button (iOS only)
                  if (_isApplePlatform) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _isLoading ? null : _restorePurchases,
                      child: const Text(
                        'Restore Purchases',
                        style: TextStyle(
                          color: AppColors.stageDirection,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanInfo {
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final SubscriptionPlan plan;
  final Color color;
  final bool isPopular;
  final String? productId; // Apple In-App Purchase product ID

  _PlanInfo({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    required this.plan,
    required this.color,
    this.isPopular = false,
    this.productId,
  });

  /// Create a copy with updated price (from App Store)
  _PlanInfo copyWith({String? price}) {
    return _PlanInfo(
      name: name,
      price: price ?? this.price,
      period: period,
      features: features,
      plan: plan,
      color: color,
      isPopular: isPopular,
      productId: productId,
    );
  }
}
