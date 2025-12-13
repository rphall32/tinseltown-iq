import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// ============================================================================
// SUBMISSION TRACKER SERVICE
// Pipeline management for tracking concept submissions to buyers/producers
// ============================================================================

/// Submission status enum
enum SubmissionStatus {
  draft,        // Not yet submitted
  submitted,    // Sent to buyer
  received,     // Confirmed received
  underReview,  // Being evaluated
  requested,    // Materials requested
  meeting,      // Meeting scheduled
  negotiating,  // In negotiations
  passed,       // Declined
  optioned,     // Option agreement
  sold,         // Sale completed
}

/// Submission priority level
enum SubmissionPriority {
  high,    // Top targets
  medium,  // Good fits
  low,     // Long shots
}

/// A single submission record
class Submission {
  final String id;
  final String conceptId;
  final String conceptTitle;
  final String buyerName;
  final String buyerType; // Studio, Streamer, Production Company, Agent, Manager
  final String contactName;
  final String contactEmail;
  final SubmissionStatus status;
  final SubmissionPriority priority;
  final DateTime submittedDate;
  final DateTime? lastContactDate;
  final DateTime? followUpDate;
  final DateTime? responseDeadline;
  final List<SubmissionNote> notes;
  final List<String> materialsSubmitted; // Logline, Synopsis, Treatment, Script
  final String? responseNotes;
  final int matchScore;
  
  Submission({
    required this.id,
    required this.conceptId,
    required this.conceptTitle,
    required this.buyerName,
    required this.buyerType,
    required this.contactName,
    required this.contactEmail,
    required this.status,
    required this.priority,
    required this.submittedDate,
    this.lastContactDate,
    this.followUpDate,
    this.responseDeadline,
    required this.notes,
    required this.materialsSubmitted,
    this.responseNotes,
    required this.matchScore,
  });
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'conceptId': conceptId,
    'conceptTitle': conceptTitle,
    'buyerName': buyerName,
    'buyerType': buyerType,
    'contactName': contactName,
    'contactEmail': contactEmail,
    'status': status.index,
    'priority': priority.index,
    'submittedDate': submittedDate.toIso8601String(),
    'lastContactDate': lastContactDate?.toIso8601String(),
    'followUpDate': followUpDate?.toIso8601String(),
    'responseDeadline': responseDeadline?.toIso8601String(),
    'notes': notes.map((n) => n.toJson()).toList(),
    'materialsSubmitted': materialsSubmitted,
    'responseNotes': responseNotes,
    'matchScore': matchScore,
  };
  
  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    id: json['id'],
    conceptId: json['conceptId'],
    conceptTitle: json['conceptTitle'],
    buyerName: json['buyerName'],
    buyerType: json['buyerType'],
    contactName: json['contactName'],
    contactEmail: json['contactEmail'],
    status: SubmissionStatus.values[json['status']],
    priority: SubmissionPriority.values[json['priority']],
    submittedDate: DateTime.parse(json['submittedDate']),
    lastContactDate: json['lastContactDate'] != null ? DateTime.parse(json['lastContactDate']) : null,
    followUpDate: json['followUpDate'] != null ? DateTime.parse(json['followUpDate']) : null,
    responseDeadline: json['responseDeadline'] != null ? DateTime.parse(json['responseDeadline']) : null,
    notes: (json['notes'] as List).map((n) => SubmissionNote.fromJson(n)).toList(),
    materialsSubmitted: List<String>.from(json['materialsSubmitted']),
    responseNotes: json['responseNotes'],
    matchScore: json['matchScore'],
  );
  
  Submission copyWith({
    SubmissionStatus? status,
    DateTime? lastContactDate,
    DateTime? followUpDate,
    DateTime? responseDeadline,
    List<SubmissionNote>? notes,
    List<String>? materialsSubmitted,
    String? responseNotes,
    SubmissionPriority? priority,
  }) => Submission(
    id: id,
    conceptId: conceptId,
    conceptTitle: conceptTitle,
    buyerName: buyerName,
    buyerType: buyerType,
    contactName: contactName,
    contactEmail: contactEmail,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    submittedDate: submittedDate,
    lastContactDate: lastContactDate ?? this.lastContactDate,
    followUpDate: followUpDate ?? this.followUpDate,
    responseDeadline: responseDeadline ?? this.responseDeadline,
    notes: notes ?? this.notes,
    materialsSubmitted: materialsSubmitted ?? this.materialsSubmitted,
    responseNotes: responseNotes ?? this.responseNotes,
    matchScore: matchScore,
  );
}

/// Note attached to a submission
class SubmissionNote {
  final String id;
  final DateTime date;
  final String content;
  final String type; // 'note', 'call', 'email', 'meeting'
  
  SubmissionNote({
    required this.id,
    required this.date,
    required this.content,
    required this.type,
  });
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'content': content,
    'type': type,
  };
  
  factory SubmissionNote.fromJson(Map<String, dynamic> json) => SubmissionNote(
    id: json['id'],
    date: DateTime.parse(json['date']),
    content: json['content'],
    type: json['type'],
  );
}

/// Follow-up reminder
class FollowUpReminder {
  final String submissionId;
  final String buyerName;
  final String conceptTitle;
  final DateTime dueDate;
  final int daysSinceContact;
  final String suggestedAction;
  final bool isOverdue;
  
  FollowUpReminder({
    required this.submissionId,
    required this.buyerName,
    required this.conceptTitle,
    required this.dueDate,
    required this.daysSinceContact,
    required this.suggestedAction,
    required this.isOverdue,
  });
}

/// AI-generated follow-up email
class FollowUpEmail {
  final String subject;
  final String body;
  final String tone; // 'professional', 'friendly', 'persistent'
  final List<String> keyPoints;
  final String callToAction;
  
  FollowUpEmail({
    required this.subject,
    required this.body,
    required this.tone,
    required this.keyPoints,
    required this.callToAction,
  });
}

/// Pipeline statistics
class PipelineStats {
  final int totalSubmissions;
  final int activeSubmissions;
  final int pendingResponses;
  final int positiveResponses;
  final int passes;
  final double responseRate;
  final double successRate;
  final int avgDaysToResponse;
  final Map<String, int> byStatus;
  final Map<String, int> byBuyerType;
  
  PipelineStats({
    required this.totalSubmissions,
    required this.activeSubmissions,
    required this.pendingResponses,
    required this.positiveResponses,
    required this.passes,
    required this.responseRate,
    required this.successRate,
    required this.avgDaysToResponse,
    required this.byStatus,
    required this.byBuyerType,
  });
}

/// Win/Loss analytics data
class WinLossAnalytics {
  final int totalWins;
  final int totalLosses;
  final double winRate;
  final String topWinningBuyerType;
  final String topLosingReason;
  final List<MonthlyStats> monthlyTrend;
  final Map<String, double> winRateByBuyerType;
  final Map<String, double> winRateByGenre;
  final List<String> insights;
  
  WinLossAnalytics({
    required this.totalWins,
    required this.totalLosses,
    required this.winRate,
    required this.topWinningBuyerType,
    required this.topLosingReason,
    required this.monthlyTrend,
    required this.winRateByBuyerType,
    required this.winRateByGenre,
    required this.insights,
  });
}

/// Monthly stats for trend analysis
class MonthlyStats {
  final String month;
  final int submissions;
  final int wins;
  final int losses;
  final double winRate;
  
  MonthlyStats({
    required this.month,
    required this.submissions,
    required this.wins,
    required this.losses,
    required this.winRate,
  });
}

/// Submission Tracker Service
class SubmissionTrackerService {
  static final SubmissionTrackerService _instance = SubmissionTrackerService._internal();
  factory SubmissionTrackerService() => _instance;
  SubmissionTrackerService._internal();
  
  final _random = math.Random();
  List<Submission> _submissions = [];
  
  /// Initialize with demo data
  Future<void> initialize() async {
    await _loadSubmissions();
    if (_submissions.isEmpty) {
      _submissions = _generateDemoSubmissions();
      await _saveSubmissions();
    }
  }
  
  Future<void> _loadSubmissions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('submission_tracker_data');
      if (data != null) {
        final List<dynamic> jsonList = jsonDecode(data);
        _submissions = jsonList.map((j) => Submission.fromJson(j)).toList();
      }
    } catch (e) {
      _submissions = [];
    }
  }
  
  Future<void> _saveSubmissions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(_submissions.map((s) => s.toJson()).toList());
      await prefs.setString('submission_tracker_data', data);
    } catch (e) {
      // Silently handle save errors
    }
  }
  
  /// Get all submissions
  List<Submission> getAllSubmissions() => List.unmodifiable(_submissions);
  
  /// Get submissions for a specific concept
  List<Submission> getSubmissionsForConcept(String conceptId) {
    return _submissions.where((s) => s.conceptId == conceptId).toList();
  }
  
  /// Get submissions by status
  List<Submission> getSubmissionsByStatus(SubmissionStatus status) {
    return _submissions.where((s) => s.status == status).toList();
  }
  
  /// Get active submissions (not passed or sold)
  List<Submission> getActiveSubmissions() {
    return _submissions.where((s) => 
      s.status != SubmissionStatus.passed && 
      s.status != SubmissionStatus.sold
    ).toList();
  }
  
  /// Add a new submission
  Future<Submission> addSubmission({
    required String conceptId,
    required String conceptTitle,
    required String buyerName,
    required String buyerType,
    required String contactName,
    required String contactEmail,
    required SubmissionPriority priority,
    required List<String> materials,
    required int matchScore,
  }) async {
    final submission = Submission(
      id: 'sub_${DateTime.now().millisecondsSinceEpoch}',
      conceptId: conceptId,
      conceptTitle: conceptTitle,
      buyerName: buyerName,
      buyerType: buyerType,
      contactName: contactName,
      contactEmail: contactEmail,
      status: SubmissionStatus.submitted,
      priority: priority,
      submittedDate: DateTime.now(),
      lastContactDate: DateTime.now(),
      followUpDate: DateTime.now().add(const Duration(days: 14)),
      responseDeadline: DateTime.now().add(const Duration(days: 60)),
      notes: [
        SubmissionNote(
          id: 'note_${DateTime.now().millisecondsSinceEpoch}',
          date: DateTime.now(),
          content: 'Initial submission sent with ${materials.join(", ")}',
          type: 'email',
        ),
      ],
      materialsSubmitted: materials,
      matchScore: matchScore,
    );
    
    _submissions.add(submission);
    await _saveSubmissions();
    return submission;
  }
  
  /// Update submission status
  Future<Submission> updateStatus(String submissionId, SubmissionStatus newStatus, {String? notes}) async {
    final index = _submissions.indexWhere((s) => s.id == submissionId);
    if (index == -1) throw Exception('Submission not found');
    
    final existing = _submissions[index];
    final updatedNotes = [...existing.notes];
    
    if (notes != null) {
      updatedNotes.add(SubmissionNote(
        id: 'note_${DateTime.now().millisecondsSinceEpoch}',
        date: DateTime.now(),
        content: notes,
        type: 'note',
      ));
    }
    
    // Add status change note
    updatedNotes.add(SubmissionNote(
      id: 'note_${DateTime.now().millisecondsSinceEpoch + 1}',
      date: DateTime.now(),
      content: 'Status changed to ${_getStatusLabel(newStatus)}',
      type: 'note',
    ));
    
    final updated = existing.copyWith(
      status: newStatus,
      lastContactDate: DateTime.now(),
      notes: updatedNotes,
      followUpDate: _calculateNextFollowUp(newStatus),
    );
    
    _submissions[index] = updated;
    await _saveSubmissions();
    return updated;
  }
  
  /// Add note to submission
  Future<Submission> addNote(String submissionId, String content, String type) async {
    final index = _submissions.indexWhere((s) => s.id == submissionId);
    if (index == -1) throw Exception('Submission not found');
    
    final existing = _submissions[index];
    final updatedNotes = [
      ...existing.notes,
      SubmissionNote(
        id: 'note_${DateTime.now().millisecondsSinceEpoch}',
        date: DateTime.now(),
        content: content,
        type: type,
      ),
    ];
    
    final updated = existing.copyWith(
      notes: updatedNotes,
      lastContactDate: DateTime.now(),
    );
    
    _submissions[index] = updated;
    await _saveSubmissions();
    return updated;
  }
  
  /// Get follow-up reminders
  List<FollowUpReminder> getFollowUpReminders() {
    final reminders = <FollowUpReminder>[];
    final now = DateTime.now();
    
    for (final sub in getActiveSubmissions()) {
      if (sub.followUpDate != null) {
        final daysSinceContact = sub.lastContactDate != null 
          ? now.difference(sub.lastContactDate!).inDays 
          : now.difference(sub.submittedDate).inDays;
        
        final isOverdue = sub.followUpDate!.isBefore(now);
        
        if (isOverdue || sub.followUpDate!.difference(now).inDays <= 7) {
          reminders.add(FollowUpReminder(
            submissionId: sub.id,
            buyerName: sub.buyerName,
            conceptTitle: sub.conceptTitle,
            dueDate: sub.followUpDate!,
            daysSinceContact: daysSinceContact,
            suggestedAction: _getSuggestedAction(sub, daysSinceContact),
            isOverdue: isOverdue,
          ));
        }
      }
    }
    
    // Sort by due date (overdue first)
    reminders.sort((a, b) {
      if (a.isOverdue && !b.isOverdue) return -1;
      if (!a.isOverdue && b.isOverdue) return 1;
      return a.dueDate.compareTo(b.dueDate);
    });
    
    return reminders;
  }
  
  /// Generate follow-up email
  FollowUpEmail generateFollowUpEmail({
    required Submission submission,
    required String tone,
  }) {
    final daysSinceContact = submission.lastContactDate != null
      ? DateTime.now().difference(submission.lastContactDate!).inDays
      : DateTime.now().difference(submission.submittedDate).inDays;
    
    String subject;
    String body;
    List<String> keyPoints;
    String callToAction;
    
    if (tone == 'professional') {
      subject = 'Following Up: ${submission.conceptTitle}';
      body = '''Dear ${submission.contactName},

I hope this email finds you well. I wanted to follow up on my submission of "${submission.conceptTitle}" that I sent ${daysSinceContact} days ago.

I understand you receive many submissions and your time is valuable. I remain very excited about this project and believe it would be an excellent fit for ${submission.buyerName}'s slate, particularly given your recent success with similar content.

Would you have a few minutes to discuss this project? I'm happy to provide any additional materials that might be helpful.

Thank you for your consideration.

Best regards''';
      keyPoints = [
        'Reference the original submission',
        'Acknowledge their busy schedule',
        'Reiterate fit with their slate',
        'Offer to provide additional materials',
      ];
      callToAction = 'Request a brief call or meeting';
    } else if (tone == 'friendly') {
      subject = 'Quick Check-In: ${submission.conceptTitle}';
      body = '''Hi ${submission.contactName},

Hope you're having a great week! Just wanted to touch base about "${submission.conceptTitle}" - I know things get crazy busy, so I totally understand if it's still in the queue.

I'm still really passionate about this project and think it could be something special. If you've had a chance to take a look, I'd love to hear your thoughts - even just initial impressions.

No rush at all, just wanted to keep the conversation going!

Cheers''';
      keyPoints = [
        'Keep it light and conversational',
        'Show understanding of their workload',
        'Express continued enthusiasm',
        'Low-pressure ask for feedback',
      ];
      callToAction = 'Ask for initial thoughts';
    } else { // persistent
      subject = 'Final Follow-Up: ${submission.conceptTitle}';
      body = '''Dear ${submission.contactName},

I'm reaching out one more time regarding "${submission.conceptTitle}" - I submitted this project ${daysSinceContact} days ago and haven't heard back yet.

I want to be respectful of your time, so this will be my final follow-up. However, I remain confident that this project has strong commercial potential and would be a great fit for ${submission.buyerName}.

If you've had a chance to review and have decided to pass, I completely understand - a quick response either way would be greatly appreciated so I can plan my next steps.

Thank you for your consideration throughout this process.

Best regards''';
      keyPoints = [
        'Acknowledge this is a final follow-up',
        'Maintain professionalism',
        'Request a definitive response',
        'Leave door open for future submissions',
      ];
      callToAction = 'Request definitive response';
    }
    
    return FollowUpEmail(
      subject: subject,
      body: body,
      tone: tone,
      keyPoints: keyPoints,
      callToAction: callToAction,
    );
  }
  
  /// Get pipeline statistics
  PipelineStats getPipelineStats() {
    final total = _submissions.length;
    final active = getActiveSubmissions().length;
    final pending = _submissions.where((s) => 
      s.status == SubmissionStatus.submitted || 
      s.status == SubmissionStatus.received ||
      s.status == SubmissionStatus.underReview
    ).length;
    
    final positive = _submissions.where((s) => 
      s.status == SubmissionStatus.requested ||
      s.status == SubmissionStatus.meeting ||
      s.status == SubmissionStatus.negotiating ||
      s.status == SubmissionStatus.optioned ||
      s.status == SubmissionStatus.sold
    ).length;
    
    final passes = _submissions.where((s) => s.status == SubmissionStatus.passed).length;
    
    final responded = positive + passes;
    final responseRate = total > 0 ? (responded / total * 100) : 0.0;
    final successRate = responded > 0 ? (positive / responded * 100) : 0.0;
    
    // Calculate average days to response
    final respondedSubs = _submissions.where((s) => 
      s.status == SubmissionStatus.passed || 
      s.status == SubmissionStatus.requested ||
      s.status == SubmissionStatus.sold
    ).toList();
    
    int totalDays = 0;
    for (final sub in respondedSubs) {
      final responseDate = sub.lastContactDate ?? DateTime.now();
      totalDays += responseDate.difference(sub.submittedDate).inDays;
    }
    final avgDays = respondedSubs.isNotEmpty ? (totalDays / respondedSubs.length).round() : 0;
    
    // By status
    final byStatus = <String, int>{};
    for (final status in SubmissionStatus.values) {
      final count = _submissions.where((s) => s.status == status).length;
      if (count > 0) {
        byStatus[_getStatusLabel(status)] = count;
      }
    }
    
    // By buyer type
    final byBuyerType = <String, int>{};
    for (final sub in _submissions) {
      byBuyerType[sub.buyerType] = (byBuyerType[sub.buyerType] ?? 0) + 1;
    }
    
    return PipelineStats(
      totalSubmissions: total,
      activeSubmissions: active,
      pendingResponses: pending,
      positiveResponses: positive,
      passes: passes,
      responseRate: responseRate,
      successRate: successRate,
      avgDaysToResponse: avgDays,
      byStatus: byStatus,
      byBuyerType: byBuyerType,
    );
  }
  
  /// Get win/loss analytics
  WinLossAnalytics getWinLossAnalytics() {
    final wins = _submissions.where((s) => 
      s.status == SubmissionStatus.optioned || 
      s.status == SubmissionStatus.sold ||
      s.status == SubmissionStatus.meeting ||
      s.status == SubmissionStatus.negotiating
    ).toList();
    
    final losses = _submissions.where((s) => s.status == SubmissionStatus.passed).toList();
    
    final totalWins = wins.length;
    final totalLosses = losses.length;
    final total = totalWins + totalLosses;
    final winRate = total > 0 ? (totalWins / total * 100) : 0.0;
    
    // Win rate by buyer type
    final winRateByBuyerType = <String, double>{};
    final buyerTypes = _submissions.map((s) => s.buyerType).toSet();
    for (final type in buyerTypes) {
      final typeWins = wins.where((s) => s.buyerType == type).length;
      final typeLosses = losses.where((s) => s.buyerType == type).length;
      final typeTotal = typeWins + typeLosses;
      if (typeTotal > 0) {
        winRateByBuyerType[type] = typeWins / typeTotal * 100;
      }
    }
    
    // Find top winning buyer type
    String topWinningType = 'N/A';
    double topWinRate = 0;
    winRateByBuyerType.forEach((type, rate) {
      if (rate > topWinRate) {
        topWinRate = rate;
        topWinningType = type;
      }
    });
    
    // Generate insights
    final insights = <String>[];
    if (winRate > 20) {
      insights.add('Your success rate of ${winRate.toStringAsFixed(1)}% is above industry average!');
    } else if (winRate > 0) {
      insights.add('Focus on improving your logline to boost your ${winRate.toStringAsFixed(1)}% success rate.');
    }
    
    if (topWinningType != 'N/A') {
      insights.add('You perform best with $topWinningType buyers.');
    }
    
    if (losses.isNotEmpty) {
      insights.add('Consider following up with passed buyers after significant revisions.');
    }
    
    return WinLossAnalytics(
      totalWins: totalWins,
      totalLosses: totalLosses,
      winRate: winRate,
      topWinningBuyerType: topWinningType,
      topLosingReason: 'Not the right fit at this time',
      monthlyTrend: _generateMonthlyTrend(),
      winRateByBuyerType: winRateByBuyerType,
      winRateByGenre: {'Thriller': 25.0, 'Drama': 18.0, 'Comedy': 15.0},
      insights: insights,
    );
  }
  
  // Helper methods
  String _getStatusLabel(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft: return 'Draft';
      case SubmissionStatus.submitted: return 'Submitted';
      case SubmissionStatus.received: return 'Received';
      case SubmissionStatus.underReview: return 'Under Review';
      case SubmissionStatus.requested: return 'Materials Requested';
      case SubmissionStatus.meeting: return 'Meeting Scheduled';
      case SubmissionStatus.negotiating: return 'Negotiating';
      case SubmissionStatus.passed: return 'Passed';
      case SubmissionStatus.optioned: return 'Optioned';
      case SubmissionStatus.sold: return 'Sold';
    }
  }
  
  DateTime _calculateNextFollowUp(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.submitted:
        return DateTime.now().add(const Duration(days: 14));
      case SubmissionStatus.received:
      case SubmissionStatus.underReview:
        return DateTime.now().add(const Duration(days: 21));
      case SubmissionStatus.requested:
        return DateTime.now().add(const Duration(days: 7));
      case SubmissionStatus.meeting:
        return DateTime.now().add(const Duration(days: 3));
      case SubmissionStatus.negotiating:
        return DateTime.now().add(const Duration(days: 5));
      default:
        return DateTime.now().add(const Duration(days: 30));
    }
  }
  
  String _getSuggestedAction(Submission sub, int daysSinceContact) {
    switch (sub.status) {
      case SubmissionStatus.submitted:
        if (daysSinceContact > 30) {
          return 'Send final follow-up or consider closing';
        } else if (daysSinceContact > 14) {
          return 'Send friendly follow-up email';
        }
        return 'Wait a few more days before following up';
      case SubmissionStatus.received:
      case SubmissionStatus.underReview:
        return 'Check in on review progress';
      case SubmissionStatus.requested:
        return 'Submit requested materials ASAP';
      case SubmissionStatus.meeting:
        return 'Prepare for upcoming meeting';
      case SubmissionStatus.negotiating:
        return 'Review latest terms and respond';
      default:
        return 'Review submission status';
    }
  }
  
  List<MonthlyStats> _generateMonthlyTrend() {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    return months.map((month) {
      final subs = 3 + _random.nextInt(5);
      final wins = _random.nextInt(3);
      final losses = _random.nextInt(4);
      return MonthlyStats(
        month: month,
        submissions: subs,
        wins: wins,
        losses: losses,
        winRate: (wins + losses) > 0 ? wins / (wins + losses) * 100 : 0,
      );
    }).toList();
  }
  
  List<Submission> _generateDemoSubmissions() {
    final now = DateTime.now();
    return [
      Submission(
        id: 'sub_001',
        conceptId: 'concept_001',
        conceptTitle: 'The Last Algorithm',
        buyerName: 'Netflix Film',
        buyerType: 'Streamer',
        contactName: 'Sarah Chen',
        contactEmail: 'sarah.chen@netflix.com',
        status: SubmissionStatus.underReview,
        priority: SubmissionPriority.high,
        submittedDate: now.subtract(const Duration(days: 18)),
        lastContactDate: now.subtract(const Duration(days: 5)),
        followUpDate: now.add(const Duration(days: 9)),
        responseDeadline: now.add(const Duration(days: 42)),
        notes: [
          SubmissionNote(id: 'n1', date: now.subtract(const Duration(days: 18)), content: 'Initial submission sent with logline and synopsis', type: 'email'),
          SubmissionNote(id: 'n2', date: now.subtract(const Duration(days: 10)), content: 'Received confirmation - being reviewed by development team', type: 'email'),
          SubmissionNote(id: 'n3', date: now.subtract(const Duration(days: 5)), content: 'Positive initial response - asked about treatment availability', type: 'call'),
        ],
        materialsSubmitted: ['Logline', 'Synopsis', 'Treatment'],
        matchScore: 87,
      ),
      Submission(
        id: 'sub_002',
        conceptId: 'concept_001',
        conceptTitle: 'The Last Algorithm',
        buyerName: 'A24',
        buyerType: 'Indie Studio',
        contactName: 'Michael Torres',
        contactEmail: 'mtorres@a24films.com',
        status: SubmissionStatus.submitted,
        priority: SubmissionPriority.high,
        submittedDate: now.subtract(const Duration(days: 25)),
        lastContactDate: now.subtract(const Duration(days: 25)),
        followUpDate: now.subtract(const Duration(days: 4)),
        responseDeadline: now.add(const Duration(days: 35)),
        notes: [
          SubmissionNote(id: 'n4', date: now.subtract(const Duration(days: 25)), content: 'Submitted via their online portal', type: 'email'),
        ],
        materialsSubmitted: ['Logline', 'Synopsis'],
        matchScore: 82,
      ),
      Submission(
        id: 'sub_003',
        conceptId: 'concept_002',
        conceptTitle: 'Midnight in Moscow',
        buyerName: 'Paramount Pictures',
        buyerType: 'Major Studio',
        contactName: 'Jessica Williams',
        contactEmail: 'jwilliams@paramount.com',
        status: SubmissionStatus.requested,
        priority: SubmissionPriority.high,
        submittedDate: now.subtract(const Duration(days: 45)),
        lastContactDate: now.subtract(const Duration(days: 3)),
        followUpDate: now.add(const Duration(days: 4)),
        responseDeadline: now.add(const Duration(days: 15)),
        notes: [
          SubmissionNote(id: 'n5', date: now.subtract(const Duration(days: 45)), content: 'Submitted through manager contact', type: 'email'),
          SubmissionNote(id: 'n6', date: now.subtract(const Duration(days: 20)), content: 'First follow-up sent', type: 'email'),
          SubmissionNote(id: 'n7', date: now.subtract(const Duration(days: 3)), content: 'GREAT NEWS! They want to see the full script', type: 'call'),
        ],
        materialsSubmitted: ['Logline', 'Synopsis', 'Treatment'],
        responseNotes: 'Requesting full script - very interested in the Cold War angle',
        matchScore: 79,
      ),
      Submission(
        id: 'sub_004',
        conceptId: 'concept_003',
        conceptTitle: 'Family Recipe',
        buyerName: 'Searchlight Pictures',
        buyerType: 'Indie Studio',
        contactName: 'David Park',
        contactEmail: 'dpark@searchlight.com',
        status: SubmissionStatus.passed,
        priority: SubmissionPriority.medium,
        submittedDate: now.subtract(const Duration(days: 60)),
        lastContactDate: now.subtract(const Duration(days: 15)),
        followUpDate: null,
        responseDeadline: null,
        notes: [
          SubmissionNote(id: 'n8', date: now.subtract(const Duration(days: 60)), content: 'Submitted indie drama', type: 'email'),
          SubmissionNote(id: 'n9', date: now.subtract(const Duration(days: 15)), content: 'Passed - similar project in development', type: 'email'),
        ],
        materialsSubmitted: ['Logline', 'Synopsis'],
        responseNotes: 'Pass - they have a similar multi-generational family drama in development',
        matchScore: 71,
      ),
      Submission(
        id: 'sub_005',
        conceptId: 'concept_001',
        conceptTitle: 'The Last Algorithm',
        buyerName: 'Blumhouse Productions',
        buyerType: 'Production Company',
        contactName: 'Amanda Foster',
        contactEmail: 'afoster@blumhouse.com',
        status: SubmissionStatus.meeting,
        priority: SubmissionPriority.high,
        submittedDate: now.subtract(const Duration(days: 30)),
        lastContactDate: now.subtract(const Duration(days: 1)),
        followUpDate: now.add(const Duration(days: 2)),
        responseDeadline: now.add(const Duration(days: 30)),
        notes: [
          SubmissionNote(id: 'n10', date: now.subtract(const Duration(days: 30)), content: 'Pitched as tech-thriller with horror elements', type: 'email'),
          SubmissionNote(id: 'n11', date: now.subtract(const Duration(days: 14)), content: 'They loved the AI angle - want to discuss', type: 'email'),
          SubmissionNote(id: 'n12', date: now.subtract(const Duration(days: 1)), content: 'Zoom meeting scheduled for next week!', type: 'call'),
        ],
        materialsSubmitted: ['Logline', 'Synopsis', 'Treatment', 'Pitch Deck'],
        matchScore: 91,
      ),
    ];
  }
  
  /// Get status color
  static Color getStatusColor(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft: return Colors.grey;
      case SubmissionStatus.submitted: return Colors.blue;
      case SubmissionStatus.received: return Colors.lightBlue;
      case SubmissionStatus.underReview: return Colors.orange;
      case SubmissionStatus.requested: return Colors.amber;
      case SubmissionStatus.meeting: return Colors.purple;
      case SubmissionStatus.negotiating: return Colors.deepPurple;
      case SubmissionStatus.passed: return Colors.red;
      case SubmissionStatus.optioned: return Colors.teal;
      case SubmissionStatus.sold: return Colors.green;
    }
  }
  
  /// Get status icon
  static IconData getStatusIcon(SubmissionStatus status) {
    switch (status) {
      case SubmissionStatus.draft: return Icons.edit_note;
      case SubmissionStatus.submitted: return Icons.send;
      case SubmissionStatus.received: return Icons.mark_email_read;
      case SubmissionStatus.underReview: return Icons.pending_actions;
      case SubmissionStatus.requested: return Icons.request_page;
      case SubmissionStatus.meeting: return Icons.event;
      case SubmissionStatus.negotiating: return Icons.handshake;
      case SubmissionStatus.passed: return Icons.cancel;
      case SubmissionStatus.optioned: return Icons.description;
      case SubmissionStatus.sold: return Icons.celebration;
    }
  }
  
  /// Get priority color
  static Color getPriorityColor(SubmissionPriority priority) {
    switch (priority) {
      case SubmissionPriority.high: return Colors.red;
      case SubmissionPriority.medium: return Colors.orange;
      case SubmissionPriority.low: return Colors.blue;
    }
  }
}
