// Date/Time Utilities - Centralized Date Handling
//
// Provides consistent date formatting, relative time, and
// localized date handling throughout the app.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Date format presets for the Tinseltown IQ app
abstract class AppDateFormats {
  AppDateFormats._();

  // ═══════════════════════════════════════════════════════════════
  // DATE FORMATS
  // ═══════════════════════════════════════════════════════════════

  /// Full date: "January 15, 2024"
  static final DateFormat full = DateFormat.yMMMMd();

  /// Medium date: "Jan 15, 2024"
  static final DateFormat medium = DateFormat.yMMMd();

  /// Short date: "1/15/24"
  static final DateFormat short = DateFormat.yMd();

  /// Numeric date: "2024-01-15"
  static final DateFormat numeric = DateFormat('yyyy-MM-dd');

  /// Day and month: "Jan 15"
  static final DateFormat dayMonth = DateFormat.MMMd();

  /// Month and year: "January 2024"
  static final DateFormat monthYear = DateFormat.yMMMM();

  /// Day of week: "Monday"
  static final DateFormat weekday = DateFormat.EEEE();

  /// Short weekday: "Mon"
  static final DateFormat weekdayShort = DateFormat.E();

  // ═══════════════════════════════════════════════════════════════
  // TIME FORMATS
  // ═══════════════════════════════════════════════════════════════

  /// Time with AM/PM: "3:30 PM"
  static final DateFormat time = DateFormat.jm();

  /// 24-hour time: "15:30"
  static final DateFormat time24 = DateFormat.Hm();

  /// Time with seconds: "3:30:45 PM"
  static final DateFormat timeWithSeconds = DateFormat.jms();

  // ═══════════════════════════════════════════════════════════════
  // COMBINED FORMATS
  // ═══════════════════════════════════════════════════════════════

  /// Full date and time: "January 15, 2024 at 3:30 PM"
  static final DateFormat fullDateTime = DateFormat.yMMMMd().add_jm();

  /// Medium date and time: "Jan 15, 2024, 3:30 PM"
  static final DateFormat mediumDateTime = DateFormat.yMMMd().add_jm();

  /// Short date and time: "1/15/24 3:30 PM"
  static final DateFormat shortDateTime = DateFormat.yMd().add_jm();

  /// Timestamp: "2024-01-15 15:30:45"
  static final DateFormat timestamp = DateFormat('yyyy-MM-dd HH:mm:ss');

  // ═══════════════════════════════════════════════════════════════
  // FILM INDUSTRY SPECIFIC
  // ═══════════════════════════════════════════════════════════════

  /// Release year: "2024"
  static final DateFormat releaseYear = DateFormat.y();

  /// Season format: "Winter 2024"
  static String seasonFormat(DateTime date) {
    final season = _getSeason(date.month);
    return '$season ${date.year}';
  }

  static String _getSeason(int month) {
    if (month >= 3 && month <= 5) return 'Spring';
    if (month >= 6 && month <= 8) return 'Summer';
    if (month >= 9 && month <= 11) return 'Fall';
    return 'Winter';
  }
}

/// Date/Time utility class
class AppDateTime {
  AppDateTime._();

  // ═══════════════════════════════════════════════════════════════
  // FORMATTING METHODS
  // ═══════════════════════════════════════════════════════════════

  /// Format date with custom format
  static String format(DateTime? date, DateFormat format) {
    if (date == null) return '';
    return format.format(date);
  }

  /// Format date as full: "January 15, 2024"
  static String formatFull(DateTime? date) => format(date, AppDateFormats.full);

  /// Format date as medium: "Jan 15, 2024"
  static String formatMedium(DateTime? date) => format(date, AppDateFormats.medium);

  /// Format date as short: "1/15/24"
  static String formatShort(DateTime? date) => format(date, AppDateFormats.short);

  /// Format time: "3:30 PM"
  static String formatTime(DateTime? date) => format(date, AppDateFormats.time);

  /// Format full date and time: "January 15, 2024 at 3:30 PM"
  static String formatFullDateTime(DateTime? date) => format(date, AppDateFormats.fullDateTime);

  /// Format medium date and time: "Jan 15, 2024, 3:30 PM"
  static String formatMediumDateTime(DateTime? date) => format(date, AppDateFormats.mediumDateTime);

  // ═══════════════════════════════════════════════════════════════
  // RELATIVE TIME
  // ═══════════════════════════════════════════════════════════════

  /// Get relative time string: "2 hours ago", "in 3 days", etc.
  static String relativeTime(DateTime? date, {DateTime? from, bool short = false}) {
    if (date == null) return '';
    
    final now = from ?? DateTime.now();
    final difference = now.difference(date);
    final isPast = difference.isNegative == false;
    final absoluteDiff = difference.abs();

    String timeStr;
    
    if (absoluteDiff.inSeconds < 60) {
      timeStr = short ? 'now' : 'just now';
      return timeStr;
    } else if (absoluteDiff.inMinutes < 60) {
      final mins = absoluteDiff.inMinutes;
      timeStr = short ? '${mins}m' : '$mins ${mins == 1 ? 'minute' : 'minutes'}';
    } else if (absoluteDiff.inHours < 24) {
      final hours = absoluteDiff.inHours;
      timeStr = short ? '${hours}h' : '$hours ${hours == 1 ? 'hour' : 'hours'}';
    } else if (absoluteDiff.inDays < 7) {
      final days = absoluteDiff.inDays;
      timeStr = short ? '${days}d' : '$days ${days == 1 ? 'day' : 'days'}';
    } else if (absoluteDiff.inDays < 30) {
      final weeks = (absoluteDiff.inDays / 7).floor();
      timeStr = short ? '${weeks}w' : '$weeks ${weeks == 1 ? 'week' : 'weeks'}';
    } else if (absoluteDiff.inDays < 365) {
      final months = (absoluteDiff.inDays / 30).floor();
      timeStr = short ? '${months}mo' : '$months ${months == 1 ? 'month' : 'months'}';
    } else {
      final years = (absoluteDiff.inDays / 365).floor();
      timeStr = short ? '${years}y' : '$years ${years == 1 ? 'year' : 'years'}';
    }

    if (short) {
      return isPast ? timeStr : '+$timeStr';
    }
    return isPast ? '$timeStr ago' : 'in $timeStr';
  }

  /// Get smart date display (relative for recent, formatted for older)
  static String smartFormat(DateTime? date, {int recentDays = 7}) {
    if (date == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(date).abs();
    
    if (difference.inDays < 1) {
      // Today: show relative time
      return relativeTime(date);
    } else if (difference.inDays == 1) {
      // Yesterday/Tomorrow
      return date.isBefore(now) ? 'Yesterday' : 'Tomorrow';
    } else if (difference.inDays < recentDays) {
      // This week: show day name
      return AppDateFormats.weekday.format(date);
    } else if (date.year == now.year) {
      // This year: show month and day
      return AppDateFormats.dayMonth.format(date);
    } else {
      // Different year: show full date
      return AppDateFormats.medium.format(date);
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // DATE CALCULATIONS
  // ═══════════════════════════════════════════════════════════════

  /// Check if date is today
  static bool isToday(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime? date) {
    if (date == null) return false;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime? date) {
    if (date == null) return false;
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day;
  }

  /// Check if date is this week
  static bool isThisWeek(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) && 
           date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Check if date is this month
  static bool isThisMonth(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Check if date is this year
  static bool isThisYear(DateTime? date) {
    if (date == null) return false;
    return date.year == DateTime.now().year;
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get start of week (Monday)
  static DateTime startOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  /// Get days in month
  static int daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  // ═══════════════════════════════════════════════════════════════
  // DURATION FORMATTING
  // ═══════════════════════════════════════════════════════════════

  /// Format duration as "HH:MM:SS"
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Format duration as human readable: "2h 30m"
  static String formatDurationHuman(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      if (minutes > 0) {
        return '${hours}h ${minutes}m';
      }
      return '${hours}h';
    }
    if (minutes > 0) {
      if (seconds > 0 && minutes < 5) {
        return '${minutes}m ${seconds}s';
      }
      return '${minutes}m';
    }
    return '${seconds}s';
  }

  /// Format movie runtime: "2h 15min"
  static String formatRuntime(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    
    if (hours > 0) {
      return mins > 0 ? '${hours}h ${mins}min' : '${hours}h';
    }
    return '${mins}min';
  }

  // ═══════════════════════════════════════════════════════════════
  // PARSING
  // ═══════════════════════════════════════════════════════════════

  /// Parse date from various formats
  static DateTime? parse(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;

    // Try ISO 8601 format first
    try {
      return DateTime.parse(dateString);
    } catch (_) {}

    // Try common formats
    final formats = [
      'yyyy-MM-dd',
      'MM/dd/yyyy',
      'dd/MM/yyyy',
      'yyyy/MM/dd',
      'MMM dd, yyyy',
      'MMMM dd, yyyy',
    ];

    for (final format in formats) {
      try {
        return DateFormat(format).parse(dateString);
      } catch (_) {}
    }

    return null;
  }

  /// Parse time from string
  static TimeOfDay? parseTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) return null;

    try {
      final parts = timeString.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1].split(' ')[0]);
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (_) {}

    return null;
  }

  // ═══════════════════════════════════════════════════════════════
  // FILM INDUSTRY HELPERS
  // ═══════════════════════════════════════════════════════════════

  /// Get release window label
  static String getReleaseWindow(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.isNegative) {
      return 'Released';
    } else if (difference.inDays <= 7) {
      return 'This Week';
    } else if (difference.inDays <= 30) {
      return 'This Month';
    } else if (difference.inDays <= 90) {
      return 'Coming Soon';
    } else if (difference.inDays <= 365) {
      return AppDateFormats.seasonFormat(date);
    } else {
      return date.year.toString();
    }
  }

  /// Format deadline countdown
  static String formatDeadline(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    } else if (difference.inHours < 24) {
      return 'Due Today';
    } else if (difference.inDays == 1) {
      return 'Due Tomorrow';
    } else if (difference.inDays < 7) {
      return 'Due ${AppDateFormats.weekday.format(deadline)}';
    } else {
      return 'Due ${AppDateFormats.dayMonth.format(deadline)}';
    }
  }
}

/// Extension on DateTime for easy formatting
extension DateTimeFormatting on DateTime {
  /// Format as full date
  String get fullFormat => AppDateTime.formatFull(this);
  
  /// Format as medium date
  String get mediumFormat => AppDateTime.formatMedium(this);
  
  /// Format as short date
  String get shortFormat => AppDateTime.formatShort(this);
  
  /// Format time only
  String get timeFormat => AppDateTime.formatTime(this);
  
  /// Get relative time string
  String get relative => AppDateTime.relativeTime(this);
  
  /// Get smart format (relative for recent, formatted for older)
  String get smart => AppDateTime.smartFormat(this);
  
  /// Check if today
  bool get isToday => AppDateTime.isToday(this);
  
  /// Check if yesterday
  bool get isYesterday => AppDateTime.isYesterday(this);
  
  /// Check if this week
  bool get isThisWeek => AppDateTime.isThisWeek(this);
  
  /// Check if this month
  bool get isThisMonth => AppDateTime.isThisMonth(this);
  
  /// Check if this year
  bool get isThisYear => AppDateTime.isThisYear(this);
  
  /// Get start of this day
  DateTime get startOfDay => AppDateTime.startOfDay(this);
  
  /// Get end of this day
  DateTime get endOfDay => AppDateTime.endOfDay(this);
}

/// Extension on Duration for formatting
extension DurationFormatting on Duration {
  /// Format as "HH:MM:SS"
  String get formatted => AppDateTime.formatDuration(this);
  
  /// Format as human readable "2h 30m"
  String get human => AppDateTime.formatDurationHuman(this);
}
