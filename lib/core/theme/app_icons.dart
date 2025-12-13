// App Icons - Centralized Icon Definitions
//
// Provides semantic icon names for consistent usage throughout the app.
// Using Material Icons with Tinseltown IQ-specific naming conventions.

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_radius.dart';

/// Centralized icon definitions with semantic naming
/// 
/// Usage:
/// ```dart
/// Icon(AppIcons.home)
/// AppIconWidget(AppIcons.analysis)
/// ```
abstract class AppIcons {
  AppIcons._();

  // ═══════════════════════════════════════════════════════════════
  // NAVIGATION & ACTIONS
  // ═══════════════════════════════════════════════════════════════
  
  /// Home/Dashboard icon
  static const IconData home = Icons.home_rounded;
  
  /// Back navigation
  static const IconData back = Icons.arrow_back_ios_new_rounded;
  
  /// Forward navigation
  static const IconData forward = Icons.arrow_forward_ios_rounded;
  
  /// Close/dismiss
  static const IconData close = Icons.close_rounded;
  
  /// Menu hamburger
  static const IconData menu = Icons.menu_rounded;
  
  /// More options (vertical dots)
  static const IconData moreVert = Icons.more_vert_rounded;
  
  /// More options (horizontal dots)
  static const IconData moreHoriz = Icons.more_horiz_rounded;
  
  /// Settings
  static const IconData settings = Icons.settings_rounded;
  
  /// Search
  static const IconData search = Icons.search_rounded;
  
  /// Filter
  static const IconData filter = Icons.filter_list_rounded;
  
  /// Sort
  static const IconData sort = Icons.sort_rounded;
  
  /// Refresh
  static const IconData refresh = Icons.refresh_rounded;
  
  /// Share
  static const IconData share = Icons.share_rounded;
  
  /// Edit
  static const IconData edit = Icons.edit_rounded;
  
  /// Delete
  static const IconData delete = Icons.delete_outline_rounded;
  
  /// Add/Create
  static const IconData add = Icons.add_rounded;
  
  /// Remove
  static const IconData remove = Icons.remove_rounded;
  
  /// Check/Confirm
  static const IconData check = Icons.check_rounded;
  
  /// Expand
  static const IconData expand = Icons.expand_more_rounded;
  
  /// Collapse
  static const IconData collapse = Icons.expand_less_rounded;

  // ═══════════════════════════════════════════════════════════════
  // TINSELTOWN IQ - FILM INDUSTRY
  // ═══════════════════════════════════════════════════════════════
  
  /// Movie/Film
  static const IconData movie = Icons.movie_rounded;
  
  /// Movie filter/analysis
  static const IconData movieFilter = Icons.movie_filter_rounded;
  
  /// TV/Series
  static const IconData tv = Icons.tv_rounded;
  
  /// Script/Document
  static const IconData script = Icons.description_rounded;
  
  /// Analysis/Chart
  static const IconData analysis = Icons.analytics_rounded;
  
  /// Results/Score
  static const IconData results = Icons.assessment_rounded;
  
  /// Trending
  static const IconData trending = Icons.trending_up_rounded;
  
  /// Trending down
  static const IconData trendingDown = Icons.trending_down_rounded;
  
  /// Genre/Category
  static const IconData genre = Icons.category_rounded;
  
  /// Star/Rating
  static const IconData star = Icons.star_rounded;
  
  /// Star outline
  static const IconData starOutline = Icons.star_outline_rounded;
  
  /// Bookmark/Save
  static const IconData bookmark = Icons.bookmark_rounded;
  
  /// Bookmark outline
  static const IconData bookmarkOutline = Icons.bookmark_outline_rounded;
  
  /// Favorite/Heart
  static const IconData favorite = Icons.favorite_rounded;
  
  /// Favorite outline
  static const IconData favoriteOutline = Icons.favorite_outline_rounded;
  
  /// Projects/Folder
  static const IconData projects = Icons.folder_rounded;
  
  /// Project open
  static const IconData projectOpen = Icons.folder_open_rounded;
  
  /// Compare
  static const IconData compare = Icons.compare_arrows_rounded;
  
  /// History
  static const IconData history = Icons.history_rounded;
  
  /// Calendar/Schedule
  static const IconData calendar = Icons.calendar_today_rounded;
  
  /// Timer/Duration
  static const IconData timer = Icons.timer_rounded;
  
  /// Award/Trophy
  static const IconData award = Icons.emoji_events_rounded;
  
  /// Lightbulb/Idea
  static const IconData idea = Icons.lightbulb_rounded;
  
  /// Target/Goal
  static const IconData target = Icons.gps_fixed_rounded;

  // ═══════════════════════════════════════════════════════════════
  // USER & PROFILE
  // ═══════════════════════════════════════════════════════════════
  
  /// User/Person
  static const IconData user = Icons.person_rounded;
  
  /// User outline
  static const IconData userOutline = Icons.person_outline_rounded;
  
  /// Users/Team
  static const IconData users = Icons.people_rounded;
  
  /// Profile
  static const IconData profile = Icons.account_circle_rounded;
  
  /// Account settings
  static const IconData accountSettings = Icons.manage_accounts_rounded;
  
  /// Logout
  static const IconData logout = Icons.logout_rounded;
  
  /// Login
  static const IconData login = Icons.login_rounded;

  // ═══════════════════════════════════════════════════════════════
  // PAYMENT & SUBSCRIPTION
  // ═══════════════════════════════════════════════════════════════
  
  /// Credit card
  static const IconData creditCard = Icons.credit_card_rounded;
  
  /// Credit card off
  static const IconData creditCardOff = Icons.credit_card_off_rounded;
  
  /// Payment
  static const IconData payment = Icons.payment_rounded;
  
  /// Wallet
  static const IconData wallet = Icons.account_balance_wallet_rounded;
  
  /// Subscription/Crown
  static const IconData subscription = Icons.workspace_premium_rounded;
  
  /// Receipt
  static const IconData receipt = Icons.receipt_long_rounded;
  
  /// Price tag
  static const IconData priceTag = Icons.local_offer_rounded;

  // ═══════════════════════════════════════════════════════════════
  // STATUS & FEEDBACK
  // ═══════════════════════════════════════════════════════════════
  
  /// Info
  static const IconData info = Icons.info_outline_rounded;
  
  /// Success/Check circle
  static const IconData success = Icons.check_circle_outline_rounded;
  
  /// Warning
  static const IconData warning = Icons.warning_amber_rounded;
  
  /// Error
  static const IconData error = Icons.error_outline_rounded;
  
  /// Help/Question
  static const IconData help = Icons.help_outline_rounded;
  
  /// Notification/Bell
  static const IconData notification = Icons.notifications_rounded;
  
  /// Notification outline
  static const IconData notificationOutline = Icons.notifications_outlined;
  
  /// Notification off
  static const IconData notificationOff = Icons.notifications_off_rounded;

  // ═══════════════════════════════════════════════════════════════
  // CONNECTIVITY & SYNC
  // ═══════════════════════════════════════════════════════════════
  
  /// Online/Cloud
  static const IconData online = Icons.cloud_done_rounded;
  
  /// Offline
  static const IconData offline = Icons.cloud_off_rounded;
  
  /// Sync
  static const IconData sync = Icons.sync_rounded;
  
  /// Upload
  static const IconData upload = Icons.cloud_upload_rounded;
  
  /// Download
  static const IconData download = Icons.cloud_download_rounded;
  
  /// Link
  static const IconData link = Icons.link_rounded;
  
  /// Wifi
  static const IconData wifi = Icons.wifi_rounded;
  
  /// Wifi off
  static const IconData wifiOff = Icons.wifi_off_rounded;

  // ═══════════════════════════════════════════════════════════════
  // MEDIA & CONTENT
  // ═══════════════════════════════════════════════════════════════
  
  /// Camera
  static const IconData camera = Icons.camera_alt_rounded;
  
  /// Gallery/Photo
  static const IconData gallery = Icons.photo_library_rounded;
  
  /// Image
  static const IconData image = Icons.image_rounded;
  
  /// Video
  static const IconData video = Icons.videocam_rounded;
  
  /// Audio/Mic
  static const IconData audio = Icons.mic_rounded;
  
  /// Play
  static const IconData play = Icons.play_arrow_rounded;
  
  /// Pause
  static const IconData pause = Icons.pause_rounded;
  
  /// Stop
  static const IconData stop = Icons.stop_rounded;
  
  /// Volume
  static const IconData volume = Icons.volume_up_rounded;
  
  /// Volume off
  static const IconData volumeOff = Icons.volume_off_rounded;

  // ═══════════════════════════════════════════════════════════════
  // MISC
  // ═══════════════════════════════════════════════════════════════
  
  /// Copy
  static const IconData copy = Icons.content_copy_rounded;
  
  /// Paste
  static const IconData paste = Icons.content_paste_rounded;
  
  /// Export/External
  static const IconData export = Icons.open_in_new_rounded;
  
  /// Print
  static const IconData print = Icons.print_rounded;
  
  /// Lock
  static const IconData lock = Icons.lock_rounded;
  
  /// Unlock
  static const IconData unlock = Icons.lock_open_rounded;
  
  /// Visibility/Eye
  static const IconData visibility = Icons.visibility_rounded;
  
  /// Visibility off
  static const IconData visibilityOff = Icons.visibility_off_rounded;
  
  /// Dark mode
  static const IconData darkMode = Icons.dark_mode_rounded;
  
  /// Light mode
  static const IconData lightMode = Icons.light_mode_rounded;
  
  /// Language
  static const IconData language = Icons.language_rounded;
  
  /// Email
  static const IconData email = Icons.email_rounded;
  
  /// Phone
  static const IconData phone = Icons.phone_rounded;
  
  /// Location
  static const IconData location = Icons.location_on_rounded;

  // ═══════════════════════════════════════════════════════════════
  // SOCIAL & AUTH
  // ═══════════════════════════════════════════════════════════════
  
  /// Google
  static const IconData google = Icons.g_mobiledata_rounded;
  
  /// Apple
  static const IconData apple = Icons.apple_rounded;
  
  /// Facebook
  static const IconData facebook = Icons.facebook_rounded;
}

/// Icon sizes for consistent scaling
abstract class AppIconSizes {
  AppIconSizes._();

  /// Extra small icon (12px)
  static const double xs = 12.0;

  /// Small icon (16px)
  static const double sm = 16.0;

  /// Medium icon (20px) - Default
  static const double md = 20.0;

  /// Large icon (24px)
  static const double lg = 24.0;

  /// Extra large icon (32px)
  static const double xl = 32.0;

  /// Extra extra large icon (48px)
  static const double xxl = 48.0;

  /// Hero icon (64px)
  static const double hero = 64.0;
}

/// Styled icon widget with optional container
class AppIconWidget extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final double? backgroundPadding;
  final BoxShape backgroundShape;
  final List<BoxShadow>? shadows;

  const AppIconWidget(
    this.icon, {
    super.key,
    this.size = AppIconSizes.lg,
    this.color,
    this.backgroundColor,
    this.backgroundPadding,
    this.backgroundShape = BoxShape.circle,
    this.shadows,
  });

  /// Create a primary colored icon
  factory AppIconWidget.primary(IconData icon, {double? size}) {
    return AppIconWidget(
      icon,
      size: size ?? AppIconSizes.lg,
      color: AppColors.oscarGold,
    );
  }

  /// Create an icon with circular background
  factory AppIconWidget.withBackground(
    IconData icon, {
    Color? color,
    Color? backgroundColor,
    double? size,
  }) {
    return AppIconWidget(
      icon,
      size: size ?? AppIconSizes.lg,
      color: color ?? AppColors.oscarGold,
      backgroundColor: backgroundColor ?? AppColors.oscarGold.withValues(alpha: 0.15),
      backgroundPadding: AppSpacing.md,
    );
  }

  /// Create a success icon
  factory AppIconWidget.success({double? size}) {
    return AppIconWidget.withBackground(
      AppIcons.success,
      color: AppColors.greenlightNeon,
      backgroundColor: AppColors.greenlightNeon.withValues(alpha: 0.15),
      size: size,
    );
  }

  /// Create an error icon
  factory AppIconWidget.error({double? size}) {
    return AppIconWidget.withBackground(
      AppIcons.error,
      color: AppColors.cutRed,
      backgroundColor: AppColors.cutRed.withValues(alpha: 0.15),
      size: size,
    );
  }

  /// Create a warning icon
  factory AppIconWidget.warning({double? size}) {
    return AppIconWidget.withBackground(
      AppIcons.warning,
      color: AppColors.champagneGold,
      backgroundColor: AppColors.champagneGold.withValues(alpha: 0.15),
      size: size,
    );
  }

  /// Create an info icon
  factory AppIconWidget.info({double? size}) {
    return AppIconWidget.withBackground(
      AppIcons.info,
      color: AppColors.rewriteBlue,
      backgroundColor: AppColors.rewriteBlue.withValues(alpha: 0.15),
      size: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(
      icon,
      size: size,
      color: color ?? AppColors.dialogueSecondary,
    );

    if (backgroundColor == null) {
      return iconWidget;
    }

    return Container(
      padding: EdgeInsets.all(backgroundPadding ?? AppSpacing.sm),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: backgroundShape,
        borderRadius: backgroundShape == BoxShape.rectangle
            ? BorderRadius.circular(AppRadius.sm)
            : null,
        boxShadow: shadows,
      ),
      child: iconWidget,
    );
  }
}

/// Icon button with consistent styling
class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final String? tooltip;
  final EdgeInsets? padding;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = AppIconSizes.lg,
    this.color,
    this.backgroundColor,
    this.tooltip,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding ?? const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(
          icon,
          size: size,
          color: onPressed != null
              ? (color ?? AppColors.dialogueSecondary)
              : AppColors.stageDirection,
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}

/// Animated icon that pulses for attention
class PulsingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;

  const PulsingIcon({
    super.key,
    required this.icon,
    this.color = AppColors.oscarGold,
    this.size = AppIconSizes.lg,
  });

  @override
  State<PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<PulsingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: 0.9 + (_animation.value * 0.1),
            child: Icon(
              widget.icon,
              color: widget.color,
              size: widget.size,
            ),
          ),
        );
      },
    );
  }
}
