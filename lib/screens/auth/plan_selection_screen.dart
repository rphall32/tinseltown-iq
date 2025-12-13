import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../main.dart' show HomeScreen, UserService, SubscriptionPlan;

/// Subscription plan selection screen
class PlanSelectionScreen extends StatefulWidget {
  const PlanSelectionScreen({super.key});

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  final UserService _userService = UserService();
  int _selectedPlanIndex = 0;
  bool _isLoading = false;

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
    ),
  ];

  Future<void> _selectPlan() async {
    setState(() => _isLoading = true);

    try {
      final selectedPlan = _plans[_selectedPlanIndex];
      await _userService.upgradePlan(selectedPlan.plan);
      
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

  _PlanInfo({
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    required this.plan,
    required this.color,
    this.isPopular = false,
  });
}
