import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/analysis_models.dart';

/// Enhanced Concept History Service for v2.0
/// 
/// Provides comprehensive concept history management including:
/// - Full analysis result storage with all details
/// - Search and filtering capabilities
/// - Export data preparation
/// - Statistics and insights
class ConceptHistoryService extends ChangeNotifier {
  static final ConceptHistoryService _instance = ConceptHistoryService._internal();
  factory ConceptHistoryService() => _instance;
  ConceptHistoryService._internal();

  static const String _storageKey = 'tinseltown_iq_concept_history_v2';
  static const int _maxHistoryItems = 100; // Limit storage size

  List<SavedAnalysis> _history = [];
  bool _isLoaded = false;

  // Getters
  List<SavedAnalysis> get history => List.unmodifiable(_history);
  bool get isLoaded => _isLoaded;
  int get historyCount => _history.length;
  bool get isEmpty => _history.isEmpty;

  /// Load history from storage
  Future<void> loadHistory() async {
    if (_isLoaded) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = json.decode(jsonString);
        _history = jsonList
            .map((json) => SavedAnalysis.fromJson(json as Map<String, dynamic>))
            .toList();
        // Sort by most recent first
        _history.sort((a, b) => b.analyzedAt.compareTo(a.analyzedAt));
      }

      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error loading concept history: $e');
      }
      _history = [];
      _isLoaded = true;
      notifyListeners();
    }
  }

  /// Save a new analysis to history
  Future<SavedAnalysis> saveAnalysis({
    required String projectTitle,
    required ConceptData concept,
    required int greenlightScore,
    required String verdict,
    required String verdictDescription,
    required List<Map<String, dynamic>> topBuyers,
    required List<Map<String, dynamic>> topProducers,
    required List<Map<String, dynamic>> similarTitles,
    required Map<String, dynamic> marketInsights,
    String? similarityRisk,
    String? similarityDescription,
  }) async {
    final savedAnalysis = SavedAnalysis(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      projectTitle: projectTitle,
      concept: concept,
      greenlightScore: greenlightScore,
      verdict: verdict,
      verdictDescription: verdictDescription,
      topBuyers: topBuyers,
      topProducers: topProducers,
      similarTitles: similarTitles,
      marketInsights: marketInsights,
      similarityRisk: similarityRisk,
      similarityDescription: similarityDescription,
      analyzedAt: DateTime.now(),
      isFavorite: false,
    );

    // Add to beginning of list
    _history.insert(0, savedAnalysis);

    // Limit history size
    if (_history.length > _maxHistoryItems) {
      // Remove oldest non-favorite items
      _history = _history.where((a) => a.isFavorite).toList() +
          _history.where((a) => !a.isFavorite).take(_maxHistoryItems - _history.where((a) => a.isFavorite).length).toList();
    }

    await _persistHistory();
    notifyListeners();

    return savedAnalysis;
  }

  /// Delete an analysis from history
  Future<void> deleteAnalysis(String id) async {
    _history.removeWhere((a) => a.id == id);
    await _persistHistory();
    notifyListeners();
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String id) async {
    final index = _history.indexWhere((a) => a.id == id);
    if (index == -1) return;

    final analysis = _history[index];
    _history[index] = analysis.copyWith(isFavorite: !analysis.isFavorite);

    await _persistHistory();
    notifyListeners();
  }

  /// Get analysis by ID
  SavedAnalysis? getAnalysisById(String id) {
    try {
      return _history.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get favorite analyses
  List<SavedAnalysis> get favorites => _history.where((a) => a.isFavorite).toList();

  /// Get analyses by genre
  List<SavedAnalysis> getByGenre(String genre) {
    return _history.where((a) => 
      a.concept.genre.toLowerCase() == genre.toLowerCase() ||
      a.concept.secondaryGenre?.toLowerCase() == genre.toLowerCase()
    ).toList();
  }

  /// Get analyses by format
  List<SavedAnalysis> getByFormat(String format) {
    return _history.where((a) => a.concept.format == format).toList();
  }

  /// Get analyses with score above threshold
  List<SavedAnalysis> getHighScoring({int threshold = 70}) {
    return _history.where((a) => a.greenlightScore >= threshold).toList();
  }

  /// Search analyses by keyword
  List<SavedAnalysis> search(String keyword) {
    final lowerKeyword = keyword.toLowerCase();
    return _history.where((a) =>
      a.projectTitle.toLowerCase().contains(lowerKeyword) ||
      a.concept.logline.toLowerCase().contains(lowerKeyword) ||
      a.concept.synopsis.toLowerCase().contains(lowerKeyword) ||
      a.concept.genre.toLowerCase().contains(lowerKeyword)
    ).toList();
  }

  /// Get statistics
  HistoryStatistics get statistics {
    if (_history.isEmpty) {
      return HistoryStatistics.empty();
    }

    final scores = _history.map((a) => a.greenlightScore).toList();
    final avgScore = scores.reduce((a, b) => a + b) / scores.length;
    final maxScore = scores.reduce((a, b) => a > b ? a : b);
    final minScore = scores.reduce((a, b) => a < b ? a : b);

    // Genre breakdown
    final genreCounts = <String, int>{};
    for (final analysis in _history) {
      genreCounts[analysis.concept.genre] = (genreCounts[analysis.concept.genre] ?? 0) + 1;
    }
    final topGenre = genreCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    // Format breakdown
    final formatCounts = <String, int>{};
    for (final analysis in _history) {
      formatCounts[analysis.concept.format] = (formatCounts[analysis.concept.format] ?? 0) + 1;
    }
    final topFormat = formatCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    // Verdict breakdown
    final verdictCounts = <String, int>{};
    for (final analysis in _history) {
      verdictCounts[analysis.verdict] = (verdictCounts[analysis.verdict] ?? 0) + 1;
    }

    return HistoryStatistics(
      totalAnalyses: _history.length,
      averageScore: avgScore,
      highestScore: maxScore,
      lowestScore: minScore,
      favoriteCount: favorites.length,
      topGenre: topGenre,
      topFormat: topFormat,
      genreBreakdown: genreCounts,
      formatBreakdown: formatCounts,
      verdictBreakdown: verdictCounts,
    );
  }

  /// Clear all history
  Future<void> clearHistory() async {
    _history.clear();
    await _persistHistory();
    notifyListeners();
  }

  /// Persist history to storage
  Future<void> _persistHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _history.map((a) => a.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error saving concept history: $e');
      }
    }
  }
}

/// Saved analysis model with full details
class SavedAnalysis {
  final String id;
  final String projectTitle;
  final ConceptData concept;
  final int greenlightScore;
  final String verdict;
  final String verdictDescription;
  final List<Map<String, dynamic>> topBuyers;
  final List<Map<String, dynamic>> topProducers;
  final List<Map<String, dynamic>> similarTitles;
  final Map<String, dynamic> marketInsights;
  final String? similarityRisk;
  final String? similarityDescription;
  final DateTime analyzedAt;
  final bool isFavorite;
  final String? notes;

  SavedAnalysis({
    required this.id,
    required this.projectTitle,
    required this.concept,
    required this.greenlightScore,
    required this.verdict,
    required this.verdictDescription,
    required this.topBuyers,
    required this.topProducers,
    required this.similarTitles,
    required this.marketInsights,
    this.similarityRisk,
    this.similarityDescription,
    required this.analyzedAt,
    this.isFavorite = false,
    this.notes,
  });

  SavedAnalysis copyWith({
    String? id,
    String? projectTitle,
    ConceptData? concept,
    int? greenlightScore,
    String? verdict,
    String? verdictDescription,
    List<Map<String, dynamic>>? topBuyers,
    List<Map<String, dynamic>>? topProducers,
    List<Map<String, dynamic>>? similarTitles,
    Map<String, dynamic>? marketInsights,
    String? similarityRisk,
    String? similarityDescription,
    DateTime? analyzedAt,
    bool? isFavorite,
    String? notes,
  }) {
    return SavedAnalysis(
      id: id ?? this.id,
      projectTitle: projectTitle ?? this.projectTitle,
      concept: concept ?? this.concept,
      greenlightScore: greenlightScore ?? this.greenlightScore,
      verdict: verdict ?? this.verdict,
      verdictDescription: verdictDescription ?? this.verdictDescription,
      topBuyers: topBuyers ?? this.topBuyers,
      topProducers: topProducers ?? this.topProducers,
      similarTitles: similarTitles ?? this.similarTitles,
      marketInsights: marketInsights ?? this.marketInsights,
      similarityRisk: similarityRisk ?? this.similarityRisk,
      similarityDescription: similarityDescription ?? this.similarityDescription,
      analyzedAt: analyzedAt ?? this.analyzedAt,
      isFavorite: isFavorite ?? this.isFavorite,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'projectTitle': projectTitle,
    'concept': concept.toJson(),
    'greenlightScore': greenlightScore,
    'verdict': verdict,
    'verdictDescription': verdictDescription,
    'topBuyers': topBuyers,
    'topProducers': topProducers,
    'similarTitles': similarTitles,
    'marketInsights': marketInsights,
    'similarityRisk': similarityRisk,
    'similarityDescription': similarityDescription,
    'analyzedAt': analyzedAt.toIso8601String(),
    'isFavorite': isFavorite,
    'notes': notes,
  };

  factory SavedAnalysis.fromJson(Map<String, dynamic> json) => SavedAnalysis(
    id: json['id'] as String,
    projectTitle: json['projectTitle'] as String,
    concept: ConceptData.fromJson(json['concept'] as Map<String, dynamic>),
    greenlightScore: json['greenlightScore'] as int,
    verdict: json['verdict'] as String,
    verdictDescription: json['verdictDescription'] as String? ?? '',
    topBuyers: (json['topBuyers'] as List<dynamic>?)
        ?.map((e) => Map<String, dynamic>.from(e as Map))
        .toList() ?? [],
    topProducers: (json['topProducers'] as List<dynamic>?)
        ?.map((e) => Map<String, dynamic>.from(e as Map))
        .toList() ?? [],
    similarTitles: (json['similarTitles'] as List<dynamic>?)
        ?.map((e) => Map<String, dynamic>.from(e as Map))
        .toList() ?? [],
    marketInsights: Map<String, dynamic>.from(json['marketInsights'] as Map? ?? {}),
    similarityRisk: json['similarityRisk'] as String?,
    similarityDescription: json['similarityDescription'] as String?,
    analyzedAt: DateTime.parse(json['analyzedAt'] as String),
    isFavorite: json['isFavorite'] as bool? ?? false,
    notes: json['notes'] as String?,
  );

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(analyzedAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }

  String get formattedDate {
    return '${analyzedAt.month}/${analyzedAt.day}/${analyzedAt.year}';
  }
}

/// History statistics model
class HistoryStatistics {
  final int totalAnalyses;
  final double averageScore;
  final int highestScore;
  final int lowestScore;
  final int favoriteCount;
  final String topGenre;
  final String topFormat;
  final Map<String, int> genreBreakdown;
  final Map<String, int> formatBreakdown;
  final Map<String, int> verdictBreakdown;

  HistoryStatistics({
    required this.totalAnalyses,
    required this.averageScore,
    required this.highestScore,
    required this.lowestScore,
    required this.favoriteCount,
    required this.topGenre,
    required this.topFormat,
    required this.genreBreakdown,
    required this.formatBreakdown,
    required this.verdictBreakdown,
  });

  factory HistoryStatistics.empty() => HistoryStatistics(
    totalAnalyses: 0,
    averageScore: 0,
    highestScore: 0,
    lowestScore: 0,
    favoriteCount: 0,
    topGenre: 'N/A',
    topFormat: 'N/A',
    genreBreakdown: {},
    formatBreakdown: {},
    verdictBreakdown: {},
  );
}
