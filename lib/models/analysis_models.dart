import 'package:flutter/material.dart';

/// String extension for capitalize
extension StringCapitalize on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

/// Concept data model for analysis input
class ConceptData {
  final String logline;
  final String synopsis;
  final String genre;
  final String format;
  final String? secondaryGenre;
  final String? tone;
  final String? seriesStructure;
  final String? targetAudience;
  final String? budgetTier;
  final String? comparableTitle;

  ConceptData({
    required this.logline,
    required this.synopsis,
    required this.genre,
    required this.format,
    this.secondaryGenre,
    this.tone,
    this.seriesStructure,
    this.targetAudience,
    this.budgetTier,
    this.comparableTitle,
  });

  String get projectTitle {
    if (logline.isEmpty) return 'Untitled Project';
    final words = logline.split(' ').where((w) => w.length > 3).take(3).toList();
    if (words.length >= 2) {
      return '${words[0].capitalize()} ${words[1].capitalize()}';
    }
    return 'Untitled $genre';
  }

  bool get isSeries => format.contains('Series');

  String get fullGenre => secondaryGenre != null 
      ? '$genre / $secondaryGenre' 
      : genre;

  Map<String, dynamic> toJson() => {
    'logline': logline,
    'synopsis': synopsis,
    'genre': genre,
    'format': format,
    'secondaryGenre': secondaryGenre,
    'tone': tone,
    'seriesStructure': seriesStructure,
    'targetAudience': targetAudience,
    'budgetTier': budgetTier,
    'comparableTitle': comparableTitle,
  };

  factory ConceptData.fromJson(Map<String, dynamic> json) => ConceptData(
    logline: json['logline'] as String? ?? '',
    synopsis: json['synopsis'] as String? ?? '',
    genre: json['genre'] as String? ?? 'Drama',
    format: json['format'] as String? ?? 'Feature Film',
    secondaryGenre: json['secondaryGenre'] as String?,
    tone: json['tone'] as String?,
    seriesStructure: json['seriesStructure'] as String?,
    targetAudience: json['targetAudience'] as String?,
    budgetTier: json['budgetTier'] as String?,
    comparableTitle: json['comparableTitle'] as String?,
  );
}

/// Analysis result from the analysis engine
class AnalysisResult {
  final int greenlightScore;
  final String verdict;
  final String verdictDescription;
  final String similarityRisk;
  final Color similarityRiskColor;
  final String similarityDescription;
  final List<BuyerMatch> topBuyers;
  final List<ProducerMatch> topProducers;
  final List<SimilarTitle> similarTitles;
  final List<CreativeFeedback> creativeFeedback;
  final MarketInsights marketInsights;
  final String projectTitle;
  final ConceptData concept;

  AnalysisResult({
    required this.greenlightScore,
    required this.verdict,
    required this.verdictDescription,
    required this.similarityRisk,
    required this.similarityRiskColor,
    required this.similarityDescription,
    required this.topBuyers,
    required this.topProducers,
    required this.similarTitles,
    required this.creativeFeedback,
    required this.marketInsights,
    required this.projectTitle,
    required this.concept,
  });
}

/// Buyer match result
class BuyerMatch {
  final String name;
  final String type;
  final int matchPercent;
  final String reason;
  final List<String> recentHits;
  final String lookingFor;

  BuyerMatch({
    required this.name,
    required this.type,
    required this.matchPercent,
    required this.reason,
    required this.recentHits,
    required this.lookingFor,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    'matchPercent': matchPercent,
    'reason': reason,
    'recentHits': recentHits,
    'lookingFor': lookingFor,
  };
}

/// Producer match result
class ProducerMatch {
  final String name;
  final String company;
  final int matchPercent;
  final String specialty;
  final List<String> notableProjects;
  final String budgetRange;

  ProducerMatch({
    required this.name,
    required this.company,
    required this.matchPercent,
    required this.specialty,
    required this.notableProjects,
    required this.budgetRange,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'company': company,
    'matchPercent': matchPercent,
    'specialty': specialty,
    'notableProjects': notableProjects,
    'budgetRange': budgetRange,
  };
}

/// Similar title found during analysis
class SimilarTitle {
  final String title;
  final int year;
  final int similarityPercent;
  final String platform;
  final String differentiator;

  SimilarTitle({
    required this.title,
    required this.year,
    required this.similarityPercent,
    required this.platform,
    required this.differentiator,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'year': year,
    'similarityPercent': similarityPercent,
    'platform': platform,
    'differentiator': differentiator,
  };
}

/// Creative feedback item
class CreativeFeedback {
  final String category;
  final String strength;
  final String suggestion;
  final IconData icon;
  final Color color;

  CreativeFeedback({
    required this.category,
    required this.strength,
    required this.suggestion,
    required this.icon,
    required this.color,
  });
}

/// Market insights data
class MarketInsights {
  final String genreTrend;
  final int genreTrendPercent;
  final bool genreTrendUp;
  final String platformFit;
  final String budgetRecommendation;
  final String targetAudience;
  final String timingAdvice;

  MarketInsights({
    required this.genreTrend,
    required this.genreTrendPercent,
    required this.genreTrendUp,
    required this.platformFit,
    required this.budgetRecommendation,
    required this.targetAudience,
    required this.timingAdvice,
  });

  Map<String, dynamic> toJson() => {
    'genreTrend': genreTrend,
    'genreTrendPercent': genreTrendPercent,
    'genreTrendUp': genreTrendUp,
    'platformFit': platformFit,
    'budgetRecommendation': budgetRecommendation,
    'targetAudience': targetAudience,
    'timingAdvice': timingAdvice,
  };
}

/// Creative feedback severity levels
enum FeedbackSeverity { critical, improve, strong }

/// Enhanced creative feedback item with severity
class CreativeFeedbackItem {
  final String title;
  final String description;
  final FeedbackSeverity severity;
  final IconData icon;

  CreativeFeedbackItem({
    required this.title,
    required this.description,
    required this.severity,
    required this.icon,
  });
}
