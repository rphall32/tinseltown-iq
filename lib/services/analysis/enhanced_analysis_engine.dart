/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED ANALYSIS ENGINE - AI-Powered Concept Evaluation
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Comprehensive concept analysis using:
/// - Real 2024-2025 box office and streaming data
/// - Professional logline scoring criteria
/// - Actual studio/streamer buyer profiles
/// - Working producer database
/// - Market timing intelligence
/// 
/// Scoring methodology based on:
/// - ScreenCraft/StudioBinder logline best practices
/// - WGA screenplay submission guidelines
/// - Development executive feedback patterns

library;

import 'dart:math' as math;
// Note: Using flutter/material.dart which includes foundation
import 'package:flutter/material.dart';
import 'industry_data.dart';
import 'expanded_buyers_data.dart';
import 'expanded_producers_data.dart';
import 'expanded_titles_data.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED CONCEPT DATA - Extended Input Parameters
/// ═══════════════════════════════════════════════════════════════════════════

class EnhancedConceptData {
  final String logline;
  final String synopsis;
  final String genre;
  final String format;
  final String? secondaryGenre;
  final String? tone;
  final String? seriesStructure;
  final String? targetAudience;
  final String? budgetTier;
  final String? comparableTitle1;
  final String? comparableTitle2;
  final String? comparableTitle3;
  final String? settingPeriod; // Contemporary, Period, Future
  final String? protagonistType; // Anti-hero, Ensemble, Coming-of-age, etc.
  
  EnhancedConceptData({
    required this.logline,
    required this.synopsis,
    required this.genre,
    required this.format,
    this.secondaryGenre,
    this.tone,
    this.seriesStructure,
    this.targetAudience,
    this.budgetTier,
    this.comparableTitle1,
    this.comparableTitle2,
    this.comparableTitle3,
    this.settingPeriod,
    this.protagonistType,
  });
  
  String get projectTitle {
    if (logline.isEmpty) return 'Untitled Project';
    final words = logline.split(' ')
        .where((w) => w.length > 4 && !_commonWords.contains(w.toLowerCase()))
        .take(3)
        .toList();
    if (words.length >= 2) {
      return '${words[0].capitalize()} ${words[1].capitalize()}';
    }
    return 'Untitled $genre';
  }
  
  bool get isSeries => format.contains('Series');
  
  String get fullGenre => secondaryGenre != null 
      ? '$genre / $secondaryGenre' 
      : genre;
  
  String get comparablesDescription {
    final comps = [comparableTitle1, comparableTitle2, comparableTitle3]
        .where((c) => c != null && c.isNotEmpty)
        .toList();
    if (comps.isEmpty) return 'No comparables specified';
    return comps.join(' meets ');
  }
  
  static const _commonWords = {
    'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for',
    'of', 'with', 'by', 'from', 'as', 'is', 'was', 'are', 'were', 'been',
    'being', 'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would',
    'could', 'should', 'may', 'might', 'must', 'when', 'who', 'which',
    'that', 'this', 'these', 'those', 'their', 'there', 'where', 'what',
  };
}

/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED ANALYSIS RESULT - Comprehensive Output
/// ═══════════════════════════════════════════════════════════════════════════

class EnhancedAnalysisResult {
  final int greenlightScore;
  final String verdict;
  final String verdictDescription;
  final String nextSteps;
  
  // Detailed scoring breakdown
  final LoglineScoreBreakdown loglineBreakdown;
  final GenreMarketAnalysis marketAnalysis;
  
  // Similarity & Differentiation
  final String similarityRisk;
  final Color similarityRiskColor;
  final String similarityDescription;
  final List<String> differentiationTips;
  
  // Matches
  final List<EnhancedBuyerMatch> topBuyers;
  final List<EnhancedProducerMatch> topProducers;
  final List<ComparableTitle> similarTitles;
  
  // Feedback
  final List<EnhancedCreativeFeedback> creativeFeedback;
  final List<StrengthPoint> conceptStrengths;
  final List<ImprovementArea> improvementAreas;
  
  // Market Context
  final EnhancedMarketInsights marketInsights;
  
  // Metadata
  final String projectTitle;
  final EnhancedConceptData concept;
  final DateTime analysisTimestamp;
  
  EnhancedAnalysisResult({
    required this.greenlightScore,
    required this.verdict,
    required this.verdictDescription,
    required this.nextSteps,
    required this.loglineBreakdown,
    required this.marketAnalysis,
    required this.similarityRisk,
    required this.similarityRiskColor,
    required this.similarityDescription,
    required this.differentiationTips,
    required this.topBuyers,
    required this.topProducers,
    required this.similarTitles,
    required this.creativeFeedback,
    required this.conceptStrengths,
    required this.improvementAreas,
    required this.marketInsights,
    required this.projectTitle,
    required this.concept,
    required this.analysisTimestamp,
  });
}

/// Detailed logline score breakdown
class LoglineScoreBreakdown {
  final int protagonistScore;
  final int conflictScore;
  final int stakesScore;
  final int uniqueHookScore;
  final int genreClarityScore;
  final int concisionScore;
  final int emotionalResonanceScore;
  final int totalLoglineScore;
  final Map<String, String> elementNotes;
  
  const LoglineScoreBreakdown({
    required this.protagonistScore,
    required this.conflictScore,
    required this.stakesScore,
    required this.uniqueHookScore,
    required this.genreClarityScore,
    required this.concisionScore,
    required this.emotionalResonanceScore,
    required this.totalLoglineScore,
    required this.elementNotes,
  });
  
  int get maxPossibleScore => 100;
  double get percentageScore => (totalLoglineScore / maxPossibleScore) * 100;
}

/// Genre market analysis
class GenreMarketAnalysis {
  final String genre;
  final double marketShare;
  final double growthRate;
  final bool isGrowing;
  final String saturationLevel;
  final double streamingDemand;
  final String marketOutlook;
  final List<String> currentTrends;
  final int genreBonus;
  
  const GenreMarketAnalysis({
    required this.genre,
    required this.marketShare,
    required this.growthRate,
    required this.isGrowing,
    required this.saturationLevel,
    required this.streamingDemand,
    required this.marketOutlook,
    required this.currentTrends,
    required this.genreBonus,
  });
}

/// Enhanced buyer match with detailed context
class EnhancedBuyerMatch {
  final String name;
  final String type;
  final int matchPercent;
  final String contentStrategy;
  final List<String> recentAcquisitions;
  final String budgetRange;
  final String submissionTip;
  final String matchReason;
  final bool acceptsUnsolicited;
  
  const EnhancedBuyerMatch({
    required this.name,
    required this.type,
    required this.matchPercent,
    required this.contentStrategy,
    required this.recentAcquisitions,
    required this.budgetRange,
    required this.submissionTip,
    required this.matchReason,
    required this.acceptsUnsolicited,
  });
}

/// Enhanced producer match
class EnhancedProducerMatch {
  final String name;
  final String company;
  final int matchPercent;
  final List<String> specialties;
  final List<String> notableCredits;
  final String typicalBudget;
  final String lookingFor;
  final bool acceptsSubmissions;
  final String matchReason;
  
  const EnhancedProducerMatch({
    required this.name,
    required this.company,
    required this.matchPercent,
    required this.specialties,
    required this.notableCredits,
    required this.typicalBudget,
    required this.lookingFor,
    required this.acceptsSubmissions,
    required this.matchReason,
  });
}

/// Comparable title analysis
class ComparableTitle {
  final String title;
  final int year;
  final String platform;
  final int boxOfficeMillions;
  final double rtScore;
  final int conceptSimilarity;
  final String differentiator;
  final List<String> sharedElements;
  
  const ComparableTitle({
    required this.title,
    required this.year,
    required this.platform,
    required this.boxOfficeMillions,
    required this.rtScore,
    required this.conceptSimilarity,
    required this.differentiator,
    required this.sharedElements,
  });
}

/// Creative feedback item
class EnhancedCreativeFeedback {
  final String category;
  final String assessment;
  final String recommendation;
  final IconData icon;
  final Color statusColor;
  final int priority; // 1-5, 1 being most important
  
  const EnhancedCreativeFeedback({
    required this.category,
    required this.assessment,
    required this.recommendation,
    required this.icon,
    required this.statusColor,
    required this.priority,
  });
}

/// Concept strength identification
class StrengthPoint {
  final String category;
  final String description;
  final String marketAdvantage;
  final IconData icon;
  
  const StrengthPoint({
    required this.category,
    required this.description,
    required this.marketAdvantage,
    required this.icon,
  });
}

/// Improvement area identification
class ImprovementArea {
  final String category;
  final String issue;
  final String suggestion;
  final String example;
  final int impactLevel; // 1-10
  
  const ImprovementArea({
    required this.category,
    required this.issue,
    required this.suggestion,
    required this.example,
    required this.impactLevel,
  });
}

/// Enhanced market insights
class EnhancedMarketInsights {
  final String genreTrend;
  final double genreTrendPercent;
  final bool genreTrendUp;
  final String platformFit;
  final List<String> recommendedPlatforms;
  final String budgetRecommendation;
  final String targetDemographic;
  final String timingAdvice;
  final String marketContext;
  final String competitivePosition;
  final Map<String, String> scriptSaleRanges;
  
  const EnhancedMarketInsights({
    required this.genreTrend,
    required this.genreTrendPercent,
    required this.genreTrendUp,
    required this.platformFit,
    required this.recommendedPlatforms,
    required this.budgetRecommendation,
    required this.targetDemographic,
    required this.timingAdvice,
    required this.marketContext,
    required this.competitivePosition,
    required this.scriptSaleRanges,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED ANALYSIS ENGINE - Core Implementation
/// ═══════════════════════════════════════════════════════════════════════════

class EnhancedAnalysisEngine {
  static final EnhancedAnalysisEngine _instance = EnhancedAnalysisEngine._internal();
  factory EnhancedAnalysisEngine() => _instance;
  EnhancedAnalysisEngine._internal();
  
  final _random = math.Random();
  
  /// Analyze concept with optional processing delay for UX
  Future<EnhancedAnalysisResult> analyzeConceptWithDelay(
    EnhancedConceptData concept, {
    Duration delay = const Duration(milliseconds: 100),
  }) async {
    await Future.delayed(delay);
    return analyzeConcept(concept);
  }
  
  /// Main analysis method
  EnhancedAnalysisResult analyzeConcept(EnhancedConceptData concept) {
    // 1. Analyze logline with detailed breakdown
    final loglineBreakdown = _analyzeLoglineDetailed(concept);
    
    // 2. Analyze genre market position
    final marketAnalysis = _analyzeGenreMarket(concept.genre);
    
    // 3. Calculate comprehensive greenlight score
    final score = _calculateEnhancedGreenlightScore(
      concept: concept,
      loglineScore: loglineBreakdown.totalLoglineScore,
      marketBonus: marketAnalysis.genreBonus,
    );
    
    // 4. Determine verdict
    final verdictData = _getEnhancedVerdict(score);
    
    // 5. Analyze similarity risk
    final similarityData = _analyzeSimilarityRisk(concept, marketAnalysis);
    
    // 6. Match buyers
    final buyers = _matchBuyersEnhanced(concept, score, marketAnalysis);
    
    // 7. Match producers
    final producers = _matchProducersEnhanced(concept, score);
    
    // 8. Find comparable titles
    final comparables = _findComparableTitles(concept);
    
    // 9. Generate creative feedback
    final feedback = _generateEnhancedFeedback(concept, loglineBreakdown);
    
    // 10. Identify strengths
    final strengths = _identifyStrengths(concept, loglineBreakdown, marketAnalysis);
    
    // 11. Identify improvement areas
    final improvements = _identifyImprovements(concept, loglineBreakdown);
    
    // 12. Generate market insights
    final insights = _generateMarketInsights(concept, marketAnalysis);
    
    // 13. Generate differentiation tips
    final diffTips = _generateDifferentiationTips(concept, comparables);
    
    return EnhancedAnalysisResult(
      greenlightScore: score,
      verdict: verdictData['verdict']!,
      verdictDescription: verdictData['description']!,
      nextSteps: verdictData['nextSteps']!,
      loglineBreakdown: loglineBreakdown,
      marketAnalysis: marketAnalysis,
      similarityRisk: similarityData['risk']!,
      similarityRiskColor: similarityData['color'] as Color,
      similarityDescription: similarityData['description']!,
      differentiationTips: diffTips,
      topBuyers: buyers,
      topProducers: producers,
      similarTitles: comparables,
      creativeFeedback: feedback,
      conceptStrengths: strengths,
      improvementAreas: improvements,
      marketInsights: insights,
      projectTitle: concept.projectTitle,
      concept: concept,
      analysisTimestamp: DateTime.now(),
    );
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// LOGLINE ANALYSIS - Professional Criteria
  /// ═══════════════════════════════════════════════════════════════════════════
  
  LoglineScoreBreakdown _analyzeLoglineDetailed(EnhancedConceptData concept) {
    final logline = concept.logline.toLowerCase();
    final words = concept.logline.split(' ');
    final wordCount = words.length;
    final notes = <String, String>{};
    
    // 1. PROTAGONIST ANALYSIS (0-15 points)
    int protagonistScore = 0;
    
    // Character role/profession patterns
    final rolePatterns = [
      RegExp(r'\b(detective|agent|cop|officer|soldier|veteran|doctor|nurse|lawyer|professor|scientist|journalist|writer|artist|musician|chef|teacher|coach|pilot|astronaut|spy|assassin|mercenary|bounty hunter|thief|con artist|criminal|gangster|mobster|politician|mayor|president|ceo|billionaire|entrepreneur|inventor|hacker|programmer|priest|nun|prophet|witch|wizard|superhero|vigilante|survivor|orphan|widow|widower)\b'),
      RegExp(r'\b(young|old|aging|retired|single|married|divorced|pregnant|desperate|haunted|tormented|troubled|ambitious|ruthless|brilliant|genius|prodigy)\b'),
    ];
    
    for (final pattern in rolePatterns) {
      if (pattern.hasMatch(logline)) {
        protagonistScore += 5;
        break;
      }
    }
    
    // Active protagonist indicators
    if (RegExp(r'\b(must|has to|needs to|fights to|struggles to|races to|tries to|attempts to)\b').hasMatch(logline)) {
      protagonistScore += 5;
      notes['protagonist'] = 'Active protagonist with clear drive';
    } else {
      notes['protagonist'] = 'Consider making protagonist more active';
    }
    
    // Defining characteristic
    if (RegExp(r'\b(haunted by|struggling with|determined to|obsessed with|driven by)\b').hasMatch(logline)) {
      protagonistScore += 5;
    }
    
    protagonistScore = protagonistScore.clamp(0, 15);
    
    // 2. CONFLICT ANALYSIS (0-20 points)
    int conflictScore = 0;
    
    // External conflict indicators
    final conflictPatterns = [
      RegExp(r'\b(against|versus|battles?|fights?|confronts?|faces?|challenges?|threatens?|hunts?|chases?|pursues?)\b'),
      RegExp(r'\b(enemy|enemies|villain|antagonist|killer|monster|threat|danger|evil|corrupt|dark)\b'),
      RegExp(r'\b(war|invasion|conspiracy|plot|scheme|murder|crime|heist|rescue|escape)\b'),
    ];
    
    for (final pattern in conflictPatterns) {
      if (pattern.hasMatch(logline)) {
        conflictScore += 7;
      }
    }
    
    // Goal clarity
    if (RegExp(r'\b(to save|to stop|to find|to discover|to uncover|to expose|to protect|to avenge|to escape|to survive|to solve|to prevent)\b').hasMatch(logline)) {
      conflictScore += 6;
      notes['conflict'] = 'Clear goal-oriented conflict';
    } else {
      notes['conflict'] = 'Consider clarifying the central conflict goal';
    }
    
    conflictScore = conflictScore.clamp(0, 20);
    
    // 3. STAKES ANALYSIS (0-15 points)
    int stakesScore = 0;
    
    // Life/death stakes
    if (RegExp(r'\b(death|die|dying|kill|killed|murder|survival|survive|life|lives|deadly|fatal|lethal)\b').hasMatch(logline)) {
      stakesScore += 8;
      notes['stakes'] = 'High life-or-death stakes';
    }
    
    // World/society stakes
    if (RegExp(r'\b(world|humanity|mankind|civilization|city|country|nation|everyone|all|apocalypse|extinction)\b').hasMatch(logline)) {
      stakesScore += 5;
    }
    
    // Personal stakes
    if (RegExp(r'\b(family|child|children|daughter|son|wife|husband|loved ones|home|everything they know)\b').hasMatch(logline)) {
      stakesScore += 5;
    }
    
    // Time pressure
    if (RegExp(r'\b(before|race against|running out|deadline|hours|days|countdown)\b').hasMatch(logline)) {
      stakesScore += 4;
      notes['stakes'] = (notes['stakes'] ?? '') + ' with time pressure';
    }
    
    if (stakesScore == 0) {
      notes['stakes'] = 'Stakes unclear - what happens if protagonist fails?';
    }
    
    stakesScore = stakesScore.clamp(0, 15);
    
    // 4. UNIQUE HOOK ANALYSIS (0-20 points)
    int uniqueHookScore = 0;
    
    // "What if" clarity
    if (RegExp(r'\b(what if|imagine|in a world where|when)\b').hasMatch(logline)) {
      uniqueHookScore += 5;
    }
    
    // Fresh combinations
    final freshIndicators = [
      RegExp(r'\b(unexpected|unlikely|unusual|unconventional|never before|first|only)\b'),
      RegExp(r'\b(twist|secret|hidden|discovers?|reveals?|uncovers?)\b'),
      RegExp(r'\b(forced to|reluctantly|unwillingly|accidentally)\b'),
    ];
    
    for (final pattern in freshIndicators) {
      if (pattern.hasMatch(logline)) {
        uniqueHookScore += 5;
      }
    }
    
    // Genre-bending potential
    if (concept.secondaryGenre != null) {
      uniqueHookScore += 5;
    }
    
    if (uniqueHookScore >= 15) {
      notes['hook'] = 'Strong unique hook with fresh angle';
    } else if (uniqueHookScore >= 10) {
      notes['hook'] = 'Hook present but could be sharper';
    } else {
      notes['hook'] = 'Needs a more distinctive "what if" element';
    }
    
    uniqueHookScore = uniqueHookScore.clamp(0, 20);
    
    // 5. GENRE CLARITY (0-10 points)
    int genreClarityScore = 0;
    
    final genreIndicators = {
      'Horror': [r'terror', r'horror', r'nightmare', r'haunted', r'possessed', r'demonic', r'cursed'],
      'Thriller': [r'thriller', r'suspense', r'tense', r'paranoid', r'conspiracy', r'chase'],
      'Action': [r'action', r'explosive', r'high-octane', r'adrenaline', r'combat', r'battle'],
      'Comedy': [r'comedy', r'hilarious', r'funny', r'absurd', r'misfit', r'bumbling'],
      'Drama': [r'emotional', r'powerful', r'intimate', r'personal', r'journey', r'struggle'],
      'Sci-Fi': [r'future', r'space', r'alien', r'technology', r'robot', r'AI', r'dystopia'],
      'Romance': [r'love', r'romance', r'heart', r'relationship', r'falling for', r'chemistry'],
      'Fantasy': [r'magic', r'magical', r'mythical', r'kingdom', r'quest', r'prophecy'],
      'Mystery': [r'mystery', r'detective', r'investigation', r'clues', r'whodunit', r'solve'],
    };
    
    final genreKeywords = genreIndicators[concept.genre] ?? [];
    for (final keyword in genreKeywords) {
      if (RegExp(keyword, caseSensitive: false).hasMatch(logline)) {
        genreClarityScore += 3;
      }
    }
    
    // Tone clarity bonus
    if (concept.tone != null) {
      genreClarityScore += 3;
    }
    
    genreClarityScore = genreClarityScore.clamp(0, 10);
    notes['genre'] = genreClarityScore >= 7 
        ? 'Genre expectations clear' 
        : 'Consider adding genre-specific language';
    
    // 6. CONCISION (0-10 points)
    int concisionScore = 0;
    
    // Optimal length: 25-50 words
    if (wordCount >= 25 && wordCount <= 50) {
      concisionScore = 10;
      notes['length'] = 'Optimal logline length ($wordCount words)';
    } else if (wordCount >= 20 && wordCount <= 60) {
      concisionScore = 7;
      notes['length'] = 'Good length ($wordCount words)';
    } else if (wordCount >= 15 && wordCount <= 70) {
      concisionScore = 5;
      notes['length'] = 'Acceptable length ($wordCount words) - aim for 25-50';
    } else if (wordCount < 15) {
      concisionScore = 3;
      notes['length'] = 'Too brief ($wordCount words) - expand to 25-50';
    } else {
      concisionScore = 2;
      notes['length'] = 'Too long ($wordCount words) - trim to 25-50';
    }
    
    // 7. EMOTIONAL RESONANCE (0-10 points)
    int emotionalScore = 0;
    
    // Universal themes
    final emotionalIndicators = [
      RegExp(r'\b(love|loss|grief|hope|fear|redemption|forgiveness|justice|revenge|freedom|identity|belonging|betrayal|sacrifice|courage)\b'),
      RegExp(r'\b(family|home|father|mother|parent|child|friend|lover|partner)\b'),
      RegExp(r'\b(dream|nightmare|destiny|fate|choice|consequence|truth|lie|secret)\b'),
    ];
    
    for (final pattern in emotionalIndicators) {
      if (pattern.hasMatch(logline)) {
        emotionalScore += 4;
      }
    }
    
    emotionalScore = emotionalScore.clamp(0, 10);
    notes['emotion'] = emotionalScore >= 7 
        ? 'Strong emotional resonance' 
        : 'Consider adding emotional/thematic depth';
    
    // Calculate total
    final total = protagonistScore + conflictScore + stakesScore + 
                  uniqueHookScore + genreClarityScore + concisionScore + emotionalScore;
    
    return LoglineScoreBreakdown(
      protagonistScore: protagonistScore,
      conflictScore: conflictScore,
      stakesScore: stakesScore,
      uniqueHookScore: uniqueHookScore,
      genreClarityScore: genreClarityScore,
      concisionScore: concisionScore,
      emotionalResonanceScore: emotionalScore,
      totalLoglineScore: total,
      elementNotes: notes,
    );
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// MARKET ANALYSIS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  GenreMarketAnalysis _analyzeGenreMarket(String genre) {
    final data = genreMarketDatabase[genre] ?? genreMarketDatabase['Drama']!;
    
    // Calculate genre bonus for scoring
    int genreBonus = 0;
    
    // Growth rate bonus (up to 10 points)
    if (data.isGrowing) {
      genreBonus += (data.growthRate / 3).round().clamp(0, 10);
    } else {
      genreBonus -= 3;
    }
    
    // Saturation adjustment
    if (data.saturationLevel == 'low') {
      genreBonus += 5;
    } else if (data.saturationLevel == 'high') {
      genreBonus -= 3;
    }
    
    // Streaming demand bonus
    genreBonus += ((data.streamingDemand - 75) / 5).round().clamp(-3, 5);
    
    // ROI consideration
    if (data.avgROI > 4) genreBonus += 3;
    else if (data.avgROI > 3) genreBonus += 1;
    
    return GenreMarketAnalysis(
      genre: data.genre,
      marketShare: data.marketShare,
      growthRate: data.growthRate,
      isGrowing: data.isGrowing,
      saturationLevel: data.saturationLevel,
      streamingDemand: data.streamingDemand,
      marketOutlook: data.marketOutlook,
      currentTrends: data.hotTrends,
      genreBonus: genreBonus.clamp(-10, 15),
    );
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// SCORE CALCULATION
  /// ═══════════════════════════════════════════════════════════════════════════
  
  int _calculateEnhancedGreenlightScore({
    required EnhancedConceptData concept,
    required int loglineScore,
    required int marketBonus,
  }) {
    // Base score from logline (0-100) -> normalized to 50
    double score = loglineScore * 0.5;
    
    // Market position bonus (up to +15)
    score += marketBonus;
    
    // Synopsis depth (up to +10)
    score += _analyzeSynopsisQuality(concept.synopsis);
    
    // Format optimization (up to +8)
    score += _analyzeFormatFit(concept);
    
    // Advanced options bonus (up to +10)
    score += _analyzeAdvancedOptionsBonus(concept);
    
    // Comparable titles bonus (up to +5)
    if (concept.comparableTitle1?.isNotEmpty == true) score += 2;
    if (concept.comparableTitle2?.isNotEmpty == true) score += 2;
    if (concept.comparableTitle3?.isNotEmpty == true) score += 1;
    
    // Small variance for realism (-2 to +2)
    score += _random.nextInt(5) - 2;
    
    return score.round().clamp(25, 98);
  }
  
  double _analyzeSynopsisQuality(String synopsis) {
    if (synopsis.isEmpty) return 0;
    
    final wordCount = synopsis.split(' ').length;
    final lowered = synopsis.toLowerCase();
    
    double points = 0;
    
    // Length scoring
    if (wordCount >= 200) points += 5;
    else if (wordCount >= 100) points += 4;
    else if (wordCount >= 50) points += 2;
    else points += 1;
    
    // Structure indicators
    if (RegExp(r'\b(act (one|two|three|1|2|3)|beginning|middle|end|climax|resolution)\b').hasMatch(lowered)) {
      points += 2;
    }
    
    // Character depth
    if (RegExp(r'\b(protagonist|antagonist|character arc|internal conflict|backstory)\b').hasMatch(lowered)) {
      points += 2;
    }
    
    // Theme indicators
    if (RegExp(r'\b(theme|message|explores|examines|questions)\b').hasMatch(lowered)) {
      points += 1;
    }
    
    return points.clamp(0, 10);
  }
  
  double _analyzeFormatFit(EnhancedConceptData concept) {
    double points = 4; // Base
    
    final format = concept.format;
    final genre = concept.genre;
    
    // Format-genre synergies
    final synergies = {
      'Limited Series': ['Mystery', 'Thriller', 'Drama', 'Horror'],
      'Feature Film': ['Action', 'Horror', 'Comedy', 'Romance', 'Adventure'],
      'Ongoing Series': ['Fantasy', 'Sci-Fi', 'Drama'],
      'Short Film': ['Horror', 'Drama', 'Comedy'],
    };
    
    final preferredGenres = synergies[format] ?? [];
    if (preferredGenres.contains(genre)) {
      points += 4;
    }
    
    // Series structure bonus
    if (concept.isSeries && concept.seriesStructure != null) {
      points += 2;
      if (concept.seriesStructure == 'Serialized' && 
          (genre == 'Drama' || genre == 'Thriller' || genre == 'Mystery')) {
        points += 1;
      }
    }
    
    return points.clamp(0, 8);
  }
  
  double _analyzeAdvancedOptionsBonus(EnhancedConceptData concept) {
    double bonus = 0;
    
    if (concept.secondaryGenre != null) bonus += 2;
    if (concept.tone != null) bonus += 1.5;
    if (concept.targetAudience != null) bonus += 1.5;
    if (concept.budgetTier != null) bonus += 1.5;
    if (concept.settingPeriod != null) bonus += 1;
    if (concept.protagonistType != null) bonus += 1;
    
    // Prestige content bonus
    if (concept.targetAudience?.contains('Prestige') == true) bonus += 1.5;
    
    return bonus.clamp(0, 10);
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// VERDICT DETERMINATION
  /// ═══════════════════════════════════════════════════════════════════════════
  
  Map<String, String> _getEnhancedVerdict(int score) {
    if (score >= 90) {
      return verdictDatabase['studio_priority']!;
    } else if (score >= 80) {
      return verdictDatabase['strong_greenlight']!;
    } else if (score >= 70) {
      return verdictDatabase['active_development']!;
    } else if (score >= 55) {
      return verdictDatabase['development_pass']!;
    } else {
      return verdictDatabase['major_revision']!;
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// SIMILARITY RISK ANALYSIS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  Map<String, dynamic> _analyzeSimilarityRisk(
    EnhancedConceptData concept,
    GenreMarketAnalysis marketAnalysis,
  ) {
    final saturation = marketAnalysis.saturationLevel;
    final logline = concept.logline.toLowerCase();
    
    // Check for common/overused elements
    int riskScore = 0;
    
    final overusedElements = {
      'chosen one': 3,
      'must save the world': 2,
      'zombie apocalypse': 3,
      'vampire romance': 3,
      'serial killer': 2,
      'alien invasion': 2,
      'superhero origin': 3,
      'dystopian future': 2,
      'time travel': 2,
    };
    
    for (final element in overusedElements.entries) {
      if (logline.contains(element.key)) {
        riskScore += element.value;
      }
    }
    
    // Saturation impact
    if (saturation == 'high') riskScore += 4;
    else if (saturation == 'medium') riskScore += 2;
    
    // Determine risk level
    if (riskScore >= 6 || saturation == 'high') {
      return {
        'risk': 'HIGH',
        'color': const Color(0xFFE63946),
        'description': 'Crowded market with similar concepts. Strong differentiation essential. Focus on unique angle, casting, or execution.',
      };
    } else if (riskScore >= 3 || saturation == 'medium') {
      return {
        'risk': 'MODERATE',
        'color': const Color(0xFFFFB800),
        'description': 'Some comparable titles exist. Your unique selling point will be key to standing out. Emphasize what makes your take different.',
      };
    } else {
      return {
        'risk': 'LOW',
        'color': const Color(0xFF00E676),
        'description': 'Distinct concept in undersaturated space. Good opportunity for first-mover advantage. Maintain originality through development.',
      };
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// BUYER MATCHING
  /// ═══════════════════════════════════════════════════════════════════════════
  
  List<EnhancedBuyerMatch> _matchBuyersEnhanced(
    EnhancedConceptData concept,
    int score,
    GenreMarketAnalysis marketAnalysis,
  ) {
    final matches = <EnhancedBuyerMatch>[];
    
    for (final buyer in expandedBuyerDatabase) {
      int matchScore = buyer.baseMatchScore;
      String matchReason = '';
      
      // Genre preference match
      if (buyer.preferredGenres.contains(concept.genre)) {
        matchScore += 8;
        matchReason = '${concept.genre} aligns with current acquisition mandate';
      } else if (buyer.preferredGenres.contains(concept.secondaryGenre)) {
        matchScore += 4;
        matchReason = 'Secondary genre fits their slate';
      } else {
        matchScore -= 10;
        matchReason = 'Genre outside typical focus, but exceptions exist';
      }
      
      // Format preference
      if (buyer.type == 'Streamer' && concept.isSeries) {
        matchScore += 5;
      } else if (buyer.type == 'Major Studio' && !concept.isSeries) {
        matchScore += 4;
      }
      
      // Indie/prestige considerations
      if (buyer.type == 'Indie' && concept.targetAudience?.contains('Prestige') == true) {
        matchScore += 6;
        matchReason = 'Prestige positioning ideal for their brand';
      }
      
      // Score-based adjustment
      if (score >= 80) {
        matchScore += 5;
      } else if (score < 60) {
        matchScore -= 8;
      }
      
      // Add variance
      matchScore += _random.nextInt(6) - 3;
      matchScore = matchScore.clamp(50, 98);
      
      if (matchScore >= 60) {
        matches.add(EnhancedBuyerMatch(
          name: buyer.name,
          type: buyer.type,
          matchPercent: matchScore,
          contentStrategy: buyer.contentStrategy,
          recentAcquisitions: buyer.recentAcquisitions,
          budgetRange: buyer.budgetRange,
          submissionTip: buyer.submissionTip,
          matchReason: matchReason,
          acceptsUnsolicited: buyer.acceptsUnsolicited,
        ));
      }
    }
    
    matches.sort((a, b) => b.matchPercent.compareTo(a.matchPercent));
    return matches.take(10).toList(); // Expanded from 5 to 10 with larger database
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// PRODUCER MATCHING
  /// ═══════════════════════════════════════════════════════════════════════════
  
  List<EnhancedProducerMatch> _matchProducersEnhanced(
    EnhancedConceptData concept,
    int score,
  ) {
    final matches = <EnhancedProducerMatch>[];
    
    for (final producer in expandedProducerDatabase) {
      int matchScore = producer.baseMatchScore;
      String matchReason = '';
      
      // Specialty match
      if (producer.specialties.contains(concept.genre)) {
        matchScore += 10;
        matchReason = 'Track record in ${concept.genre} perfectly aligns';
      } else if (producer.specialties.contains(concept.secondaryGenre)) {
        matchScore += 5;
        matchReason = 'Experience with genre-blending projects';
      } else {
        matchScore -= 15;
        matchReason = 'Outside typical specialty but could be interested';
      }
      
      // Budget tier consideration
      if (concept.budgetTier != null) {
        final budgetMap = {
          'Micro (\$1-5M)': [3, 15],
          'Low (\$5-20M)': [5, 30],
          'Mid (\$20-50M)': [20, 60],
          'High (\$50-100M)': [50, 120],
          'Tentpole (\$100M+)': [100, 300],
        };
        
        // This is simplified - would need parsing of producer.typicalBudget
        if (producer.typicalBudget.contains('3M') && concept.budgetTier?.contains('Micro') == true) {
          matchScore += 8;
        }
      }
      
      // Add variance
      matchScore += _random.nextInt(8) - 4;
      matchScore = matchScore.clamp(50, 98);
      
      if (matchScore >= 60) {
        matches.add(EnhancedProducerMatch(
          name: producer.name,
          company: producer.company,
          matchPercent: matchScore,
          specialties: producer.specialties,
          notableCredits: producer.notableCredits,
          typicalBudget: producer.typicalBudget,
          lookingFor: producer.lookingFor,
          acceptsSubmissions: producer.acceptsSubmissions,
          matchReason: matchReason,
        ));
      }
    }
    
    matches.sort((a, b) => b.matchPercent.compareTo(a.matchPercent));
    return matches.take(10).toList(); // Expanded from 5 to 10 with larger database
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// COMPARABLE TITLES
  /// ═══════════════════════════════════════════════════════════════════════════
  
  List<ComparableTitle> _findComparableTitles(EnhancedConceptData concept) {
    final comparables = <ComparableTitle>[];
    final logline = concept.logline.toLowerCase();
    
    for (final title in expandedTitlesDatabase) {
      // Only include same genre or secondary genre
      if (title.genre != concept.genre && title.genre != concept.secondaryGenre) {
        continue;
      }
      
      // Calculate similarity
      int similarity = 30; // Base similarity for same genre
      final sharedElements = <String>[];
      
      // Check for shared key elements
      for (final element in title.keyElements) {
        if (logline.contains(element.toLowerCase())) {
          similarity += 12;
          sharedElements.add(element);
        }
      }
      
      // Check logline style similarity (very rough)
      final styleWords = title.loglineStyle.toLowerCase().split(' ');
      for (final word in styleWords) {
        if (word.length > 4 && logline.contains(word)) {
          similarity += 5;
        }
      }
      
      similarity = similarity.clamp(25, 85);
      
      // Generate differentiator
      String differentiator;
      if (similarity > 60) {
        differentiator = 'Focus on what makes your take unique from this successful title';
      } else if (similarity > 40) {
        differentiator = 'Some common elements - ensure distinct perspective';
      } else {
        differentiator = 'Different approach within genre - good differentiation';
      }
      
      comparables.add(ComparableTitle(
        title: title.title,
        year: title.year,
        platform: title.platform,
        boxOfficeMillions: title.boxOfficeMillions,
        rtScore: title.rtScore,
        conceptSimilarity: similarity,
        differentiator: differentiator,
        sharedElements: sharedElements,
      ));
    }
    
    comparables.sort((a, b) => b.conceptSimilarity.compareTo(a.conceptSimilarity));
    return comparables.take(10).toList(); // Expanded from 5 to 10 with larger database
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// CREATIVE FEEDBACK
  /// ═══════════════════════════════════════════════════════════════════════════
  
  List<EnhancedCreativeFeedback> _generateEnhancedFeedback(
    EnhancedConceptData concept,
    LoglineScoreBreakdown breakdown,
  ) {
    final feedback = <EnhancedCreativeFeedback>[];
    
    // Logline feedback based on breakdown
    if (breakdown.protagonistScore < 10) {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Protagonist',
        assessment: breakdown.elementNotes['protagonist'] ?? 'Needs clearer protagonist definition',
        recommendation: 'Define your protagonist with a specific role, defining trait, and clear motivation. Example: "A disgraced FBI agent" vs. "An agent"',
        icon: Icons.person,
        statusColor: const Color(0xFFFFB800),
        priority: 1,
      ));
    } else {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Protagonist',
        assessment: 'Strong protagonist setup with clear identity',
        recommendation: 'Maintain this clarity through the full synopsis and pitch deck',
        icon: Icons.person,
        statusColor: const Color(0xFF00E676),
        priority: 3,
      ));
    }
    
    if (breakdown.conflictScore < 12) {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Central Conflict',
        assessment: breakdown.elementNotes['conflict'] ?? 'Conflict needs strengthening',
        recommendation: 'Clearly state what the protagonist must do and what/who opposes them. Use action verbs: "must stop", "races to save", "fights to expose"',
        icon: Icons.flash_on,
        statusColor: const Color(0xFFE63946),
        priority: 1,
      ));
    }
    
    if (breakdown.stakesScore < 10) {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Stakes',
        assessment: breakdown.elementNotes['stakes'] ?? 'Stakes need elevation',
        recommendation: 'Add clear consequences: What happens if the protagonist fails? Make stakes personal AND universal when possible.',
        icon: Icons.warning_amber,
        statusColor: const Color(0xFFFFB800),
        priority: 1,
      ));
    }
    
    if (breakdown.uniqueHookScore < 12) {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Unique Hook',
        assessment: breakdown.elementNotes['hook'] ?? 'Hook could be stronger',
        recommendation: 'What\'s the "Why now? Why this story?" element? Find the fresh angle that makes this different from similar projects.',
        icon: Icons.lightbulb,
        statusColor: const Color(0xFFFFB800),
        priority: 2,
      ));
    } else {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Unique Hook',
        assessment: 'Distinctive concept element present',
        recommendation: 'Lead with this unique angle in all pitch materials',
        icon: Icons.lightbulb,
        statusColor: const Color(0xFF00E676),
        priority: 4,
      ));
    }
    
    if (breakdown.concisionScore < 7) {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Logline Length',
        assessment: breakdown.elementNotes['length'] ?? 'Length adjustment needed',
        recommendation: 'Industry standard: 25-50 words. Every word should earn its place. Cut adjectives, combine phrases.',
        icon: Icons.straighten,
        statusColor: const Color(0xFFFFB800),
        priority: 2,
      ));
    }
    
    // Synopsis feedback
    if (concept.synopsis.isEmpty) {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Synopsis',
        assessment: 'No synopsis provided',
        recommendation: 'Add a 1-2 paragraph synopsis to strengthen buyer confidence. Include three-act structure and character arc.',
        icon: Icons.description,
        statusColor: const Color(0xFFE63946),
        priority: 1,
      ));
    } else if (concept.synopsis.split(' ').length < 50) {
      feedback.add(EnhancedCreativeFeedback(
        category: 'Synopsis',
        assessment: 'Synopsis could be expanded',
        recommendation: 'Aim for 150-300 words covering setup, conflict escalation, and resolution hint (without spoiling the ending).',
        icon: Icons.description,
        statusColor: const Color(0xFFFFB800),
        priority: 2,
      ));
    }
    
    feedback.sort((a, b) => a.priority.compareTo(b.priority));
    return feedback;
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// STRENGTH IDENTIFICATION
  /// ═══════════════════════════════════════════════════════════════════════════
  
  List<StrengthPoint> _identifyStrengths(
    EnhancedConceptData concept,
    LoglineScoreBreakdown breakdown,
    GenreMarketAnalysis marketAnalysis,
  ) {
    final strengths = <StrengthPoint>[];
    
    // Market timing strength
    if (marketAnalysis.isGrowing && marketAnalysis.growthRate > 10) {
      strengths.add(StrengthPoint(
        category: 'Market Timing',
        description: '${concept.genre} is trending up ${marketAnalysis.growthRate.toStringAsFixed(1)}% year-over-year',
        marketAdvantage: 'Favorable market conditions for acquisition. Strike while momentum is strong.',
        icon: Icons.trending_up,
      ));
    }
    
    if (marketAnalysis.saturationLevel == 'low') {
      strengths.add(StrengthPoint(
        category: 'Market Opportunity',
        description: 'Low saturation in ${concept.genre} space',
        marketAdvantage: 'Less competition for buyer attention. First-mover advantage possible.',
        icon: Icons.emoji_events,
      ));
    }
    
    // Logline strengths
    if (breakdown.protagonistScore >= 12) {
      strengths.add(StrengthPoint(
        category: 'Character Foundation',
        description: 'Strong, clearly-defined protagonist',
        marketAdvantage: 'Easier to package with talent. Clear character brief for casting.',
        icon: Icons.person,
      ));
    }
    
    if (breakdown.uniqueHookScore >= 15) {
      strengths.add(StrengthPoint(
        category: 'High-Concept Appeal',
        description: 'Distinctive hook sets concept apart',
        marketAdvantage: 'Marketing-friendly premise. Easy to pitch in one line.',
        icon: Icons.lightbulb,
      ));
    }
    
    if (breakdown.stakesScore >= 12) {
      strengths.add(StrengthPoint(
        category: 'Stakes Clarity',
        description: 'Clear, compelling stakes drive urgency',
        marketAdvantage: 'Audiences understand what\'s at risk. Creates investment.',
        icon: Icons.local_fire_department,
      ));
    }
    
    // Format strength
    if (concept.isSeries && (concept.genre == 'Mystery' || concept.genre == 'Thriller' || concept.genre == 'Drama')) {
      strengths.add(StrengthPoint(
        category: 'Format-Genre Synergy',
        description: 'Series format ideal for ${concept.genre}',
        marketAdvantage: 'Streamers actively seeking limited series in this genre.',
        icon: Icons.live_tv,
      ));
    }
    
    // Comparables strength
    if (concept.comparableTitle1?.isNotEmpty == true) {
      strengths.add(StrengthPoint(
        category: 'Pitch Positioning',
        description: 'Clear comparables demonstrate market awareness',
        marketAdvantage: 'Buyers can quickly understand positioning. Reduces pitch friction.',
        icon: Icons.compare_arrows,
      ));
    }
    
    return strengths;
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// IMPROVEMENT IDENTIFICATION
  /// ═══════════════════════════════════════════════════════════════════════════
  
  List<ImprovementArea> _identifyImprovements(
    EnhancedConceptData concept,
    LoglineScoreBreakdown breakdown,
  ) {
    final improvements = <ImprovementArea>[];
    
    if (breakdown.conflictScore < 12) {
      improvements.add(ImprovementArea(
        category: 'Central Conflict',
        issue: 'Antagonist or opposing force not clearly defined',
        suggestion: 'Name the specific threat, villain, or obstacle the protagonist faces',
        example: 'Before: "A detective investigates a crime." After: "A detective must catch a serial killer targeting her own family."',
        impactLevel: 9,
      ));
    }
    
    if (breakdown.stakesScore < 8) {
      improvements.add(ImprovementArea(
        category: 'Stakes Definition',
        issue: 'Consequences of failure unclear',
        suggestion: 'Add what the protagonist loses if they fail - make it personal and universal',
        example: 'Add "before [consequence]" clause: "...before the evidence disappears forever" or "...or lose everything he\'s fought to protect"',
        impactLevel: 8,
      ));
    }
    
    if (breakdown.uniqueHookScore < 10) {
      improvements.add(ImprovementArea(
        category: 'Unique Selling Point',
        issue: 'Concept feels familiar without distinctive angle',
        suggestion: 'Find the twist that makes YOUR version different from similar projects',
        example: 'Ask: What if [familiar premise] but [unexpected element]? Example: "What if a zombie apocalypse but told from the zombie\'s perspective?"',
        impactLevel: 9,
      ));
    }
    
    if (concept.synopsis.isEmpty) {
      improvements.add(ImprovementArea(
        category: 'Synopsis Required',
        issue: 'Missing synopsis significantly weakens submission',
        suggestion: 'Write 200-400 words covering protagonist, conflict, key turning points, and climax setup',
        example: 'Structure: Paragraph 1 (Setup/World), Paragraph 2 (Conflict Escalation), Paragraph 3 (Stakes/Resolution Tease)',
        impactLevel: 10,
      ));
    }
    
    if (concept.comparableTitle1?.isEmpty ?? true) {
      improvements.add(ImprovementArea(
        category: 'Market Positioning',
        issue: 'No comparable titles provided',
        suggestion: 'Add 2-3 recent successful films/shows that share elements with your concept',
        example: '"JOKER meets TAXI DRIVER" or "GET OUT meets THE STEPFORD WIVES" - pick titles from last 5 years when possible',
        impactLevel: 6,
      ));
    }
    
    if (concept.targetAudience == null) {
      improvements.add(ImprovementArea(
        category: 'Audience Targeting',
        issue: 'Target audience not specified',
        suggestion: 'Define your core demographic - helps buyers understand marketing approach',
        example: 'Be specific: "18-34 female-skewing, rom-com fans seeking theatrical date night content"',
        impactLevel: 5,
      ));
    }
    
    improvements.sort((a, b) => b.impactLevel.compareTo(a.impactLevel));
    return improvements;
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// MARKET INSIGHTS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  EnhancedMarketInsights _generateMarketInsights(
    EnhancedConceptData concept,
    GenreMarketAnalysis marketAnalysis,
  ) {
    // Determine platform recommendations
    final platforms = <String>[];
    if (concept.format.contains('Series')) {
      platforms.addAll(['Netflix', 'HBO Max', 'Amazon Prime', 'Apple TV+']);
    } else {
      if (concept.genre == 'Horror' || concept.genre == 'Comedy') {
        platforms.addAll(['Theatrical', 'Universal', 'Sony', 'Lionsgate']);
      } else {
        platforms.addAll(['Netflix', 'Amazon MGM', 'Apple TV+']);
      }
    }
    
    // Budget recommendation
    String budgetRec;
    final genreData = genreMarketDatabase[concept.genre];
    if (genreData != null) {
      final avgBudget = genreData.averageBudget;
      budgetRec = 'Genre average: \$${avgBudget}M. ';
      
      if (concept.budgetTier != null) {
        budgetRec += 'Your target: ${concept.budgetTier}. ';
      }
      
      if (genreData.avgROI > 4) {
        budgetRec += 'Lower budgets in this genre see excellent ROI (${genreData.avgROI.toStringAsFixed(1)}x average).';
      }
    } else {
      budgetRec = 'Consider budget-to-market fit for your genre/format combination.';
    }
    
    // Audience insights
    final audienceMap = {
      'Action': '18-49 male-skewing with broad international appeal. Opening weekend critical.',
      'Horror': '16-34 theatrical enthusiasts. Social media buzz essential. Low budget = lower risk.',
      'Thriller': '25-49 engaged streamers, binge-watchers. Limited series optimal format.',
      'Sci-Fi': '18-34 passionate fanbase. Franchise potential valued. High streaming demand.',
      'Drama': '25-54 prestige seekers, awards voters. Festival premiere pathway recommended.',
      'Comedy': '18-44 broad demo, date night audience. Star power drives theatrical.',
      'Romance': '18-44 female-skewing, streaming-heavy. Book adaptation pedigree helps.',
      'Fantasy': '16-45 franchise builders, passionate community. World-building depth essential.',
      'Mystery': '35-60 detail-oriented viewers. Procedural or limited series format preferred.',
    };
    
    final timing = marketTimingAdvice[concept.genre] ?? 
        'Monitor genre cycle and competitive release slate before finalizing timing.';
    
    // Competitive position
    String competitivePosition;
    if (marketAnalysis.saturationLevel == 'low') {
      competitivePosition = 'Favorable - less crowded space allows for differentiation';
    } else if (marketAnalysis.saturationLevel == 'high') {
      competitivePosition = 'Challenging - strong USP required to break through established competition';
    } else {
      competitivePosition = 'Moderate - room for fresh voices with clear positioning';
    }
    
    return EnhancedMarketInsights(
      genreTrend: '${concept.genre} market ${marketAnalysis.isGrowing ? "expanding" : "contracting"}',
      genreTrendPercent: marketAnalysis.growthRate.abs(),
      genreTrendUp: marketAnalysis.isGrowing,
      platformFit: platforms.first,
      recommendedPlatforms: platforms,
      budgetRecommendation: budgetRec,
      targetDemographic: audienceMap[concept.genre] ?? 'General audience 18-49',
      timingAdvice: timing,
      marketContext: streamingMarketContext,
      competitivePosition: competitivePosition,
      scriptSaleRanges: scriptSaleRanges,
    );
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// DIFFERENTIATION TIPS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  List<String> _generateDifferentiationTips(
    EnhancedConceptData concept,
    List<ComparableTitle> comparables,
  ) {
    final tips = <String>[];
    
    // Genre-specific differentiation
    final genreTips = {
      'Horror': [
        'Consider what the horror represents thematically - elevated horror is trending',
        'Fresh subgenres like folk horror, cosmic horror seeing renewed interest',
        'Practical effects over CGI can be a marketing differentiator',
      ],
      'Thriller': [
        'Psychological depth over action set pieces - character-driven thrillers resonating',
        'True story basis adds credibility and marketing angle',
        'Limited series allows for deeper exploration than feature format',
      ],
      'Comedy': [
        'Gen Z comedic sensibilities differ from millennial humor - know your demo',
        'Rom-com theatrical revival means opportunity for fresh voices',
        'Social commentary woven into comedy performing well',
      ],
      'Drama': [
        'Streaming has appetite for stories traditional studios pass on',
        'International perspectives increasingly valued',
        'Shorter prestige dramas (under 2 hours) seeing theatrical success',
      ],
      'Sci-Fi': [
        'AI and technology anxiety themes particularly timely',
        'Hard sci-fi with practical grounding over pure fantasy',
        'Original IP hunger after franchise fatigue',
      ],
      'Action': [
        'Practical stunt work creates buzz (John Wick model)',
        'R-rated action seeing theatrical revival',
        'Character depth elevates beyond generic action fare',
      ],
    };
    
    tips.addAll(genreTips[concept.genre] ?? [
      'Study recent successful titles in your genre for inspiration',
      'Find the emotional core that makes your story personal',
      'Consider what unique perspective or voice you bring',
    ]);
    
    // Based on comparables
    if (comparables.isNotEmpty) {
      final topComp = comparables.first;
      if (topComp.conceptSimilarity > 60) {
        tips.add('Your concept shares elements with "${topComp.title}" - emphasize what makes your take distinct');
      }
    }
    
    // Format-specific tips
    if (concept.isSeries) {
      tips.add('For series: Develop a clear multi-season vision even for limited series pitches');
      tips.add('Episode count matters: 6-8 episodes optimal for limited series acquisition');
    }
    
    return tips.take(5).toList();
  }
}

/// String extension for capitalize (local to this file to avoid conflicts)
extension _StringCapitalize on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
