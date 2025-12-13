import 'analysis_models.dart';

/// Score history entry for tracking project revisions
class ScoreHistory {
  final int score;
  final DateTime analyzedAt;
  final int version;

  ScoreHistory({
    required this.score,
    required this.analyzedAt,
    required this.version,
  });

  Map<String, dynamic> toJson() => {
    'score': score,
    'analyzedAt': analyzedAt.toIso8601String(),
    'version': version,
  };

  factory ScoreHistory.fromJson(Map<String, dynamic> json) => ScoreHistory(
    score: json['score'] as int,
    analyzedAt: DateTime.parse(json['analyzedAt'] as String),
    version: json['version'] as int,
  );
}

/// Saved project model with revision tracking
class SavedProject {
  final String id;
  final String title;
  final String logline;
  final String synopsis;
  final String genre;
  final String? secondaryGenre;
  final String format;
  final String? tone;
  final String? seriesStructure;
  final String? targetAudience;
  final String? budgetTier;
  final String? comparableTitle;
  final int score;
  final String verdict;
  final DateTime analyzedAt;
  final int version;
  final List<ScoreHistory> scoreHistory;
  final String? parentId;
  final bool isFavorite;

  SavedProject({
    required this.id,
    required this.title,
    required this.logline,
    required this.synopsis,
    required this.genre,
    this.secondaryGenre,
    required this.format,
    this.tone,
    this.seriesStructure,
    this.targetAudience,
    this.budgetTier,
    this.comparableTitle,
    required this.score,
    required this.verdict,
    required this.analyzedAt,
    this.version = 1,
    this.scoreHistory = const [],
    this.parentId,
    this.isFavorite = false,
  });

  SavedProject copyWith({
    String? id,
    String? title,
    String? logline,
    String? synopsis,
    String? genre,
    String? secondaryGenre,
    String? format,
    String? tone,
    String? seriesStructure,
    String? targetAudience,
    String? budgetTier,
    String? comparableTitle,
    int? score,
    String? verdict,
    DateTime? analyzedAt,
    int? version,
    List<ScoreHistory>? scoreHistory,
    String? parentId,
    bool? isFavorite,
  }) {
    return SavedProject(
      id: id ?? this.id,
      title: title ?? this.title,
      logline: logline ?? this.logline,
      synopsis: synopsis ?? this.synopsis,
      genre: genre ?? this.genre,
      secondaryGenre: secondaryGenre ?? this.secondaryGenre,
      format: format ?? this.format,
      tone: tone ?? this.tone,
      seriesStructure: seriesStructure ?? this.seriesStructure,
      targetAudience: targetAudience ?? this.targetAudience,
      budgetTier: budgetTier ?? this.budgetTier,
      comparableTitle: comparableTitle ?? this.comparableTitle,
      score: score ?? this.score,
      verdict: verdict ?? this.verdict,
      analyzedAt: analyzedAt ?? this.analyzedAt,
      version: version ?? this.version,
      scoreHistory: scoreHistory ?? this.scoreHistory,
      parentId: parentId ?? this.parentId,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory SavedProject.fromAnalysisResult(
    AnalysisResult result, {
    int version = 1,
    List<ScoreHistory>? previousHistory,
    String? parentId,
  }) {
    final List<ScoreHistory> history = [
      ...(previousHistory ?? <ScoreHistory>[]),
      ScoreHistory(
        score: result.greenlightScore,
        analyzedAt: DateTime.now(),
        version: version,
      ),
    ];
    return SavedProject(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: result.projectTitle,
      logline: result.concept.logline,
      synopsis: result.concept.synopsis,
      genre: result.concept.genre,
      secondaryGenre: result.concept.secondaryGenre,
      format: result.concept.format,
      tone: result.concept.tone,
      seriesStructure: result.concept.seriesStructure,
      targetAudience: result.concept.targetAudience,
      budgetTier: result.concept.budgetTier,
      comparableTitle: result.concept.comparableTitle,
      score: result.greenlightScore,
      verdict: result.verdict,
      analyzedAt: DateTime.now(),
      version: version,
      scoreHistory: history,
      parentId: parentId,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'logline': logline,
    'synopsis': synopsis,
    'genre': genre,
    'secondaryGenre': secondaryGenre,
    'format': format,
    'tone': tone,
    'seriesStructure': seriesStructure,
    'targetAudience': targetAudience,
    'budgetTier': budgetTier,
    'comparableTitle': comparableTitle,
    'score': score,
    'verdict': verdict,
    'analyzedAt': analyzedAt.toIso8601String(),
    'version': version,
    'scoreHistory': scoreHistory.map((h) => h.toJson()).toList(),
    'parentId': parentId,
    'isFavorite': isFavorite,
  };

  factory SavedProject.fromJson(Map<String, dynamic> json) => SavedProject(
    id: json['id'] as String,
    title: json['title'] as String,
    logline: json['logline'] as String,
    synopsis: json['synopsis'] as String? ?? '',
    genre: json['genre'] as String,
    secondaryGenre: json['secondaryGenre'] as String?,
    format: json['format'] as String,
    tone: json['tone'] as String?,
    seriesStructure: json['seriesStructure'] as String?,
    targetAudience: json['targetAudience'] as String?,
    budgetTier: json['budgetTier'] as String?,
    comparableTitle: json['comparableTitle'] as String?,
    score: json['score'] as int,
    verdict: json['verdict'] as String,
    analyzedAt: DateTime.parse(json['analyzedAt'] as String),
    version: json['version'] as int? ?? 1,
    scoreHistory: (json['scoreHistory'] as List<dynamic>?)
        ?.map((h) => ScoreHistory.fromJson(h as Map<String, dynamic>))
        .toList() ?? [],
    parentId: json['parentId'] as String?,
    isFavorite: json['isFavorite'] as bool? ?? false,
  );

  int? get scoreChange {
    if (scoreHistory.length < 2) return null;
    final sorted = [...scoreHistory]..sort((a, b) => a.version.compareTo(b.version));
    return sorted.last.score - sorted[sorted.length - 2].score;
  }

  bool get hasImproved => (scoreChange ?? 0) > 0;

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

  String get subtitle {
    final genreDisplay = secondaryGenre != null ? '$genre/$secondaryGenre' : genre;
    return '$format • $genreDisplay';
  }

  ConceptData toConceptData() => ConceptData(
    logline: logline,
    synopsis: synopsis,
    genre: genre,
    format: format,
    secondaryGenre: secondaryGenre,
    tone: tone,
    seriesStructure: seriesStructure,
    targetAudience: targetAudience,
    budgetTier: budgetTier,
    comparableTitle: comparableTitle,
  );
}
