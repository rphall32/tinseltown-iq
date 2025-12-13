import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../analysis/analysis_service.dart';
import '../analysis/industry_data.dart';

// ============================================================================
// PORTFOLIO ANALYTICS SERVICE
// Strategic portfolio management for film/TV concepts
// ============================================================================

/// Portfolio summary with aggregate metrics
class PortfolioSummary {
  final int totalConcepts;
  final double averageScore;
  final double highestScore;
  final double lowestScore;
  final String strongestGenre;
  final String weakestGenre;
  final double portfolioHealth;
  final String marketPosition;
  final List<String> recommendations;
  final DateTime lastUpdated;

  PortfolioSummary({
    required this.totalConcepts,
    required this.averageScore,
    required this.highestScore,
    required this.lowestScore,
    required this.strongestGenre,
    required this.weakestGenre,
    required this.portfolioHealth,
    required this.marketPosition,
    required this.recommendations,
    required this.lastUpdated,
  });
}

/// Genre diversification analysis
class GenreDiversification {
  final String genre;
  final int conceptCount;
  final double averageScore;
  final double marketDemand;
  final double portfolioPercentage;
  final String status; // 'over-indexed', 'balanced', 'under-indexed'
  final Color statusColor;
  final String recommendation;

  GenreDiversification({
    required this.genre,
    required this.conceptCount,
    required this.averageScore,
    required this.marketDemand,
    required this.portfolioPercentage,
    required this.status,
    required this.statusColor,
    required this.recommendation,
  });
}

/// Score progression tracking
class ScoreProgression {
  final DateTime date;
  final String conceptTitle;
  final String conceptId;
  final double score;
  final String genre;
  final int version;
  final double? previousScore;
  final double improvement;

  ScoreProgression({
    required this.date,
    required this.conceptTitle,
    required this.conceptId,
    required this.score,
    required this.genre,
    required this.version,
    this.previousScore,
    required this.improvement,
  });
}

/// Market fit analysis for a concept
class MarketFitScore {
  final String conceptId;
  final String conceptTitle;
  final String genre;
  final double overallScore;
  final double genreTimingScore;
  final double platformFitScore;
  final double budgetFeasibilityScore;
  final double audienceAppealScore;
  final double competitivePositionScore;
  final String bestPlatform;
  final String marketWindow;
  final List<String> strengths;
  final List<String> concerns;

  MarketFitScore({
    required this.conceptId,
    required this.conceptTitle,
    required this.genre,
    required this.overallScore,
    required this.genreTimingScore,
    required this.platformFitScore,
    required this.budgetFeasibilityScore,
    required this.audienceAppealScore,
    required this.competitivePositionScore,
    required this.bestPlatform,
    required this.marketWindow,
    required this.strengths,
    required this.concerns,
  });
}

/// Portfolio concept with history
class PortfolioConcept {
  final String id;
  final String title;
  final String logline;
  final String genre;
  final String format;
  final double currentScore;
  final List<ScoreProgression> scoreHistory;
  final DateTime createdAt;
  final DateTime lastModified;
  final String status; // 'developing', 'ready', 'submitted', 'optioned', 'sold'
  final MarketFitScore? marketFit;
  final int revisionCount;
  final String? notes;

  PortfolioConcept({
    required this.id,
    required this.title,
    required this.logline,
    required this.genre,
    required this.format,
    required this.currentScore,
    required this.scoreHistory,
    required this.createdAt,
    required this.lastModified,
    required this.status,
    this.marketFit,
    required this.revisionCount,
    this.notes,
  });
}

/// Strategic recommendation
class StrategicRecommendation {
  final String title;
  final String description;
  final String actionItem;
  final String priority; // 'high', 'medium', 'low'
  final String category; // 'diversification', 'improvement', 'timing', 'submission'
  final IconData icon;
  final Color color;

  StrategicRecommendation({
    required this.title,
    required this.description,
    required this.actionItem,
    required this.priority,
    required this.category,
    required this.icon,
    required this.color,
  });
}

/// Competitive analysis for portfolio
class CompetitiveAnalysis {
  final String genre;
  final int marketSaturation; // 1-10
  final int recentReleases;
  final List<String> topCompetitors;
  final String opportunityWindow;
  final double differentiationScore;
  final String recommendation;

  CompetitiveAnalysis({
    required this.genre,
    required this.marketSaturation,
    required this.recentReleases,
    required this.topCompetitors,
    required this.opportunityWindow,
    required this.differentiationScore,
    required this.recommendation,
  });
}

/// Portfolio analytics service
class PortfolioAnalyticsService {
  static final PortfolioAnalyticsService _instance = PortfolioAnalyticsService._internal();
  factory PortfolioAnalyticsService() => _instance;
  PortfolioAnalyticsService._internal();

  // Simulated portfolio data (in production, this would come from persistent storage)
  List<PortfolioConcept> _portfolioConcepts = [];
  
  /// Initialize with sample data for demo
  void initializeWithSampleData() {
    if (_portfolioConcepts.isNotEmpty) return;
    
    final now = DateTime.now();
    final random = math.Random(42);
    
    _portfolioConcepts = [
      PortfolioConcept(
        id: 'concept_001',
        title: 'The Last Algorithm',
        logline: 'A burned-out Silicon Valley engineer discovers her AI creation has developed consciousness and must choose between corporate loyalty and protecting a new form of life.',
        genre: 'Sci-Fi',
        format: 'Feature Film',
        currentScore: 87.5,
        scoreHistory: _generateScoreHistory('concept_001', 'The Last Algorithm', 'Sci-Fi', 87.5, 5, random, now),
        createdAt: now.subtract(const Duration(days: 90)),
        lastModified: now.subtract(const Duration(days: 3)),
        status: 'ready',
        revisionCount: 5,
        notes: 'Strong concept, ready for pitch meetings',
      ),
      PortfolioConcept(
        id: 'concept_002',
        title: 'Midnight in Marrakech',
        logline: 'An American travel writer stranded in Morocco during a political uprising finds unexpected love with a local journalist fighting to expose government corruption.',
        genre: 'Romance',
        format: 'Feature Film',
        currentScore: 72.0,
        scoreHistory: _generateScoreHistory('concept_002', 'Midnight in Marrakech', 'Romance', 72.0, 3, random, now),
        createdAt: now.subtract(const Duration(days: 45)),
        lastModified: now.subtract(const Duration(days: 10)),
        status: 'developing',
        revisionCount: 3,
        notes: 'Needs stronger third act',
      ),
      PortfolioConcept(
        id: 'concept_003',
        title: 'Dead Drop',
        logline: 'A retired CIA operative is pulled back into the spy game when classified documents surface that could expose a decades-old operation—and her own dark past.',
        genre: 'Thriller',
        format: 'Limited Series',
        currentScore: 91.2,
        scoreHistory: _generateScoreHistory('concept_003', 'Dead Drop', 'Thriller', 91.2, 7, random, now),
        createdAt: now.subtract(const Duration(days: 180)),
        lastModified: now.subtract(const Duration(days: 1)),
        status: 'submitted',
        revisionCount: 7,
        notes: 'Submitted to Netflix, Apple TV+',
      ),
      PortfolioConcept(
        id: 'concept_004',
        title: 'The Haunting of Bellwood Manor',
        logline: 'A family moves into a Victorian mansion only to discover the house feeds on fear—and their darkest secrets are being used against them.',
        genre: 'Horror',
        format: 'Feature Film',
        currentScore: 84.3,
        scoreHistory: _generateScoreHistory('concept_004', 'The Haunting of Bellwood Manor', 'Horror', 84.3, 4, random, now),
        createdAt: now.subtract(const Duration(days: 60)),
        lastModified: now.subtract(const Duration(days: 7)),
        status: 'ready',
        revisionCount: 4,
        notes: 'Target: A24, Blumhouse',
      ),
      PortfolioConcept(
        id: 'concept_005',
        title: 'Last Laugh Comedy Club',
        logline: 'A struggling stand-up comedian inherits her late father\'s failing comedy club and must save it while confronting the family secrets hidden in his final jokes.',
        genre: 'Comedy',
        format: 'Feature Film',
        currentScore: 68.5,
        scoreHistory: _generateScoreHistory('concept_005', 'Last Laugh Comedy Club', 'Comedy', 68.5, 2, random, now),
        createdAt: now.subtract(const Duration(days: 21)),
        lastModified: now.subtract(const Duration(days: 14)),
        status: 'developing',
        revisionCount: 2,
        notes: 'Early draft, needs more comedy beats',
      ),
      PortfolioConcept(
        id: 'concept_006',
        title: 'Kingdom of Ash',
        logline: 'A disgraced knight must unite fractured kingdoms against an ancient evil awakening beneath the mountains, even as her own cursed bloodline threatens to consume her.',
        genre: 'Fantasy',
        format: 'TV Series',
        currentScore: 79.8,
        scoreHistory: _generateScoreHistory('concept_006', 'Kingdom of Ash', 'Fantasy', 79.8, 4, random, now),
        createdAt: now.subtract(const Duration(days: 120)),
        lastModified: now.subtract(const Duration(days: 20)),
        status: 'developing',
        revisionCount: 4,
        notes: 'World-building complete, refining pilot',
      ),
      PortfolioConcept(
        id: 'concept_007',
        title: 'Zero Hour',
        logline: 'When terrorists take over the world\'s largest particle accelerator, a disgraced physicist must use her knowledge of the facility to stop them before they create a black hole that could destroy Europe.',
        genre: 'Action',
        format: 'Feature Film',
        currentScore: 82.1,
        scoreHistory: _generateScoreHistory('concept_007', 'Zero Hour', 'Action', 82.1, 3, random, now),
        createdAt: now.subtract(const Duration(days: 35)),
        lastModified: now.subtract(const Duration(days: 5)),
        status: 'ready',
        revisionCount: 3,
        notes: 'High concept, strong visuals',
      ),
      PortfolioConcept(
        id: 'concept_008',
        title: 'The Inheritance',
        logline: 'Three estranged siblings return home for their mother\'s funeral only to discover she\'s left them a fortune—but only if they can live together in the family home for one year.',
        genre: 'Drama',
        format: 'Feature Film',
        currentScore: 75.4,
        scoreHistory: _generateScoreHistory('concept_008', 'The Inheritance', 'Drama', 75.4, 3, random, now),
        createdAt: now.subtract(const Duration(days: 55)),
        lastModified: now.subtract(const Duration(days: 12)),
        status: 'developing',
        revisionCount: 3,
        notes: 'Character work strong, plot needs tightening',
      ),
    ];
  }
  
  List<ScoreProgression> _generateScoreHistory(
    String conceptId, 
    String title, 
    String genre, 
    double currentScore, 
    int revisions,
    math.Random random,
    DateTime now,
  ) {
    final history = <ScoreProgression>[];
    double score = currentScore - (revisions * 5) - random.nextDouble() * 10;
    if (score < 45) score = 45 + random.nextDouble() * 10;
    
    for (int i = 0; i < revisions; i++) {
      final improvement = (i == 0) ? 0.0 : (random.nextDouble() * 8 + 2);
      final newScore = (i == revisions - 1) ? currentScore : score + improvement;
      
      history.add(ScoreProgression(
        date: now.subtract(Duration(days: (revisions - i) * 15)),
        conceptTitle: title,
        conceptId: conceptId,
        score: newScore,
        genre: genre,
        version: i + 1,
        previousScore: i > 0 ? history[i - 1].score : null,
        improvement: improvement,
      ));
      
      score = newScore;
    }
    
    return history;
  }

  /// Get all portfolio concepts
  List<PortfolioConcept> getPortfolioConcepts() {
    initializeWithSampleData();
    return List.unmodifiable(_portfolioConcepts);
  }

  /// Get portfolio summary
  PortfolioSummary getPortfolioSummary() {
    initializeWithSampleData();
    
    if (_portfolioConcepts.isEmpty) {
      return PortfolioSummary(
        totalConcepts: 0,
        averageScore: 0,
        highestScore: 0,
        lowestScore: 0,
        strongestGenre: 'N/A',
        weakestGenre: 'N/A',
        portfolioHealth: 0,
        marketPosition: 'No concepts yet',
        recommendations: ['Add your first concept to get started!'],
        lastUpdated: DateTime.now(),
      );
    }

    final scores = _portfolioConcepts.map((c) => c.currentScore).toList();
    final avgScore = scores.reduce((a, b) => a + b) / scores.length;
    
    // Calculate genre performance
    final genreScores = <String, List<double>>{};
    for (final concept in _portfolioConcepts) {
      genreScores.putIfAbsent(concept.genre, () => []);
      genreScores[concept.genre]!.add(concept.currentScore);
    }
    
    final genreAvgs = genreScores.map((genre, scores) => 
      MapEntry(genre, scores.reduce((a, b) => a + b) / scores.length));
    
    final sortedGenres = genreAvgs.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    final strongestGenre = sortedGenres.first.key;
    final weakestGenre = sortedGenres.last.key;
    
    // Calculate portfolio health (0-100)
    final diversificationScore = _calculateDiversificationScore();
    final avgScoreHealth = (avgScore / 100) * 40; // 40% weight
    final diversificationHealth = diversificationScore * 30; // 30% weight
    final conceptCountHealth = math.min(_portfolioConcepts.length / 10, 1.0) * 30; // 30% weight
    final portfolioHealth = avgScoreHealth + diversificationHealth + conceptCountHealth;
    
    // Determine market position
    String marketPosition;
    if (avgScore >= 85) {
      marketPosition = 'Premium - Ready for top-tier buyers';
    } else if (avgScore >= 75) {
      marketPosition = 'Competitive - Strong market positioning';
    } else if (avgScore >= 65) {
      marketPosition = 'Developing - Good potential, needs refinement';
    } else {
      marketPosition = 'Early Stage - Focus on concept development';
    }
    
    // Generate recommendations
    final recommendations = _generatePortfolioRecommendations();
    
    return PortfolioSummary(
      totalConcepts: _portfolioConcepts.length,
      averageScore: avgScore,
      highestScore: scores.reduce(math.max),
      lowestScore: scores.reduce(math.min),
      strongestGenre: strongestGenre,
      weakestGenre: weakestGenre,
      portfolioHealth: portfolioHealth,
      marketPosition: marketPosition,
      recommendations: recommendations,
      lastUpdated: DateTime.now(),
    );
  }

  double _calculateDiversificationScore() {
    if (_portfolioConcepts.isEmpty) return 0;
    
    final genreCounts = <String, int>{};
    for (final concept in _portfolioConcepts) {
      genreCounts[concept.genre] = (genreCounts[concept.genre] ?? 0) + 1;
    }
    
    // Calculate entropy-based diversification
    final total = _portfolioConcepts.length;
    double entropy = 0;
    for (final count in genreCounts.values) {
      final p = count / total;
      entropy -= p * math.log(p) / math.log(2);
    }
    
    // Normalize to 0-1 (max entropy for 9 genres = log2(9) ≈ 3.17)
    final maxEntropy = math.log(9) / math.log(2);
    return entropy / maxEntropy;
  }

  List<String> _generatePortfolioRecommendations() {
    final recommendations = <String>[];
    
    if (_portfolioConcepts.isEmpty) {
      return ['Start by adding your first concept to build your portfolio'];
    }
    
    // Check for genre gaps
    final genreCounts = <String, int>{};
    for (final concept in _portfolioConcepts) {
      genreCounts[concept.genre] = (genreCounts[concept.genre] ?? 0) + 1;
    }
    
    // High-demand genres to suggest
    final hotGenres = ['Horror', 'Thriller', 'Sci-Fi'];
    for (final genre in hotGenres) {
      if (!genreCounts.containsKey(genre)) {
        recommendations.add('Consider adding a $genre concept - high market demand');
        break;
      }
    }
    
    // Check for concepts needing improvement
    final lowScoreConcepts = _portfolioConcepts.where((c) => c.currentScore < 70).toList();
    if (lowScoreConcepts.isNotEmpty) {
      recommendations.add('${lowScoreConcepts.length} concept(s) below 70 score - focus on development');
    }
    
    // Check submission status
    final readyConcepts = _portfolioConcepts.where((c) => c.status == 'ready').toList();
    if (readyConcepts.length >= 3) {
      recommendations.add('${readyConcepts.length} concepts ready for submission - consider pitching');
    }
    
    // Check for stale concepts
    final staleConcepts = _portfolioConcepts.where((c) => 
      DateTime.now().difference(c.lastModified).inDays > 30 && c.status == 'developing'
    ).toList();
    if (staleConcepts.isNotEmpty) {
      recommendations.add('${staleConcepts.length} concept(s) haven\'t been updated in 30+ days');
    }
    
    // Portfolio size recommendation
    if (_portfolioConcepts.length < 5) {
      recommendations.add('Build portfolio to 5+ concepts for better market coverage');
    } else if (_portfolioConcepts.length >= 10) {
      recommendations.add('Strong portfolio size - focus on quality over quantity');
    }
    
    return recommendations.take(5).toList();
  }

  /// Get genre diversification analysis
  List<GenreDiversification> getGenreDiversification() {
    initializeWithSampleData();
    
    final genreData = <String, List<PortfolioConcept>>{};
    for (final concept in _portfolioConcepts) {
      genreData.putIfAbsent(concept.genre, () => []);
      genreData[concept.genre]!.add(concept);
    }
    
    final totalConcepts = _portfolioConcepts.length;
    final diversifications = <GenreDiversification>[];
    
    // Market demand data (from industry_data.dart insights)
    final marketDemand = {
      'Action': 0.85,
      'Adventure': 0.75,
      'Comedy': 0.70,
      'Drama': 0.65,
      'Horror': 0.90,
      'Thriller': 0.88,
      'Sci-Fi': 0.82,
      'Fantasy': 0.72,
      'Romance': 0.60,
    };
    
    for (final entry in genreData.entries) {
      final genre = entry.key;
      final concepts = entry.value;
      final avgScore = concepts.map((c) => c.currentScore).reduce((a, b) => a + b) / concepts.length;
      final percentage = (concepts.length / totalConcepts) * 100;
      final demand = marketDemand[genre] ?? 0.5;
      
      // Determine status
      String status;
      Color statusColor;
      String recommendation;
      
      final idealPercentage = 100 / 9; // Balanced across 9 genres
      
      if (percentage > idealPercentage * 2) {
        status = 'over-indexed';
        statusColor = Colors.orange;
        recommendation = 'Consider diversifying - heavy concentration in $genre';
      } else if (percentage < idealPercentage * 0.5 && demand > 0.75) {
        status = 'under-indexed';
        statusColor = Colors.blue;
        recommendation = 'Opportunity - $genre has high market demand';
      } else {
        status = 'balanced';
        statusColor = Colors.green;
        recommendation = 'Good balance for $genre in your portfolio';
      }
      
      diversifications.add(GenreDiversification(
        genre: genre,
        conceptCount: concepts.length,
        averageScore: avgScore,
        marketDemand: demand * 100,
        portfolioPercentage: percentage,
        status: status,
        statusColor: statusColor,
        recommendation: recommendation,
      ));
    }
    
    // Sort by concept count descending
    diversifications.sort((a, b) => b.conceptCount.compareTo(a.conceptCount));
    
    return diversifications;
  }

  /// Get score progression for all concepts
  List<ScoreProgression> getAllScoreProgressions() {
    initializeWithSampleData();
    
    final allProgressions = <ScoreProgression>[];
    for (final concept in _portfolioConcepts) {
      allProgressions.addAll(concept.scoreHistory);
    }
    
    // Sort by date
    allProgressions.sort((a, b) => a.date.compareTo(b.date));
    
    return allProgressions;
  }

  /// Get market fit matrix for all concepts
  List<MarketFitScore> getMarketFitMatrix() {
    initializeWithSampleData();
    
    final random = math.Random(42);
    final fitScores = <MarketFitScore>[];
    
    final platformRecommendations = {
      'Action': 'Netflix / Amazon Prime',
      'Adventure': 'Disney+ / Apple TV+',
      'Comedy': 'Hulu / Peacock',
      'Drama': 'HBO Max / Apple TV+',
      'Horror': 'Shudder / Peacock',
      'Thriller': 'Netflix / Hulu',
      'Sci-Fi': 'Apple TV+ / Netflix',
      'Fantasy': 'HBO Max / Amazon Prime',
      'Romance': 'Netflix / Hallmark',
    };
    
    final marketWindows = {
      'Action': 'Summer blockbuster season (May-Aug)',
      'Adventure': 'Holiday season (Nov-Dec)',
      'Comedy': 'Year-round, peak summer',
      'Drama': 'Awards season (Oct-Feb)',
      'Horror': 'Halloween season (Sep-Oct)',
      'Thriller': 'Fall release (Sep-Nov)',
      'Sci-Fi': 'Year-round, prefer Q4',
      'Fantasy': 'Holiday season (Nov-Dec)',
      'Romance': 'Valentine\'s / Summer',
    };
    
    for (final concept in _portfolioConcepts) {
      // Calculate component scores
      final genreData = genreMarketDatabase[concept.genre];
      final baseScore = concept.currentScore / 100;
      
      final genreTimingScore = 70 + random.nextDouble() * 25;
      final platformFitScore = 65 + random.nextDouble() * 30;
      final budgetFeasibilityScore = 60 + random.nextDouble() * 35;
      final audienceAppealScore = concept.currentScore * 0.9 + random.nextDouble() * 10;
      final competitivePositionScore = 55 + random.nextDouble() * 40;
      
      final overallScore = (genreTimingScore + platformFitScore + budgetFeasibilityScore + 
        audienceAppealScore + competitivePositionScore) / 5;
      
      // Generate strengths and concerns
      final strengths = <String>[];
      final concerns = <String>[];
      
      if (concept.currentScore >= 80) strengths.add('Strong concept score');
      if (genreData?.growthRate != null && genreData!.growthRate > 10) {
        strengths.add('${concept.genre} genre trending upward');
      }
      if (platformFitScore > 80) strengths.add('Excellent platform alignment');
      if (audienceAppealScore > 85) strengths.add('High audience appeal potential');
      
      if (concept.currentScore < 70) concerns.add('Concept needs development');
      if (concept.revisionCount < 3) concerns.add('Limited revision history');
      if (competitivePositionScore < 65) concerns.add('Crowded competitive landscape');
      if (budgetFeasibilityScore < 70) concerns.add('Budget positioning unclear');
      
      if (strengths.isEmpty) strengths.add('Solid foundation for development');
      if (concerns.isEmpty) concerns.add('Monitor market conditions');
      
      fitScores.add(MarketFitScore(
        conceptId: concept.id,
        conceptTitle: concept.title,
        genre: concept.genre,
        overallScore: overallScore,
        genreTimingScore: genreTimingScore,
        platformFitScore: platformFitScore,
        budgetFeasibilityScore: budgetFeasibilityScore,
        audienceAppealScore: audienceAppealScore,
        competitivePositionScore: competitivePositionScore,
        bestPlatform: platformRecommendations[concept.genre] ?? 'Multiple platforms',
        marketWindow: marketWindows[concept.genre] ?? 'Year-round',
        strengths: strengths,
        concerns: concerns,
      ));
    }
    
    // Sort by overall score descending
    fitScores.sort((a, b) => b.overallScore.compareTo(a.overallScore));
    
    return fitScores;
  }

  /// Get strategic recommendations
  List<StrategicRecommendation> getStrategicRecommendations() {
    initializeWithSampleData();
    
    final recommendations = <StrategicRecommendation>[];
    
    // Analyze portfolio state
    final summary = getPortfolioSummary();
    final diversification = getGenreDiversification();
    final marketFit = getMarketFitMatrix();
    
    // Diversification recommendations
    final underIndexedGenres = diversification.where((d) => d.status == 'under-indexed').toList();
    if (underIndexedGenres.isNotEmpty) {
      final genre = underIndexedGenres.first;
      recommendations.add(StrategicRecommendation(
        title: 'Diversify into ${genre.genre}',
        description: '${genre.genre} has ${genre.marketDemand.toStringAsFixed(0)}% market demand but is underrepresented in your portfolio.',
        actionItem: 'Develop a new ${genre.genre} concept to capture market opportunity',
        priority: 'high',
        category: 'diversification',
        icon: Icons.pie_chart,
        color: Colors.blue,
      ));
    }
    
    // Improvement recommendations
    final lowScoreConcepts = _portfolioConcepts.where((c) => c.currentScore < 70).toList();
    if (lowScoreConcepts.isNotEmpty) {
      final concept = lowScoreConcepts.first;
      recommendations.add(StrategicRecommendation(
        title: 'Improve "${concept.title}"',
        description: 'Current score of ${concept.currentScore.toStringAsFixed(1)} is below market threshold. Focus on concept development.',
        actionItem: 'Run analysis and apply AI-powered suggestions to strengthen the concept',
        priority: 'high',
        category: 'improvement',
        icon: Icons.trending_up,
        color: Colors.orange,
      ));
    }
    
    // Timing recommendations
    final readyConcepts = _portfolioConcepts.where((c) => c.status == 'ready' && c.currentScore >= 80).toList();
    if (readyConcepts.isNotEmpty) {
      final concept = readyConcepts.first;
      final fit = marketFit.firstWhere((m) => m.conceptId == concept.id, orElse: () => marketFit.first);
      recommendations.add(StrategicRecommendation(
        title: 'Submit "${concept.title}"',
        description: 'Score of ${concept.currentScore.toStringAsFixed(1)} is submission-ready. Optimal market window: ${fit.marketWindow}',
        actionItem: 'Generate pitch materials and target ${fit.bestPlatform}',
        priority: 'high',
        category: 'submission',
        icon: Icons.send,
        color: Colors.green,
      ));
    }
    
    // Genre timing opportunity
    final horrorConcepts = _portfolioConcepts.where((c) => c.genre == 'Horror' && c.currentScore >= 75).toList();
    if (horrorConcepts.isNotEmpty && DateTime.now().month >= 7 && DateTime.now().month <= 9) {
      recommendations.add(StrategicRecommendation(
        title: 'Halloween Season Opportunity',
        description: 'You have ${horrorConcepts.length} horror concept(s) ready. Peak submission window approaching.',
        actionItem: 'Prioritize horror submissions for October release consideration',
        priority: 'medium',
        category: 'timing',
        icon: Icons.calendar_today,
        color: Colors.purple,
      ));
    }
    
    // Portfolio health recommendation
    if (summary.portfolioHealth < 60) {
      recommendations.add(StrategicRecommendation(
        title: 'Strengthen Portfolio Health',
        description: 'Portfolio health at ${summary.portfolioHealth.toStringAsFixed(0)}%. Focus on quality and diversification.',
        actionItem: 'Aim to improve average score above 75 and add concepts in 3+ genres',
        priority: 'medium',
        category: 'improvement',
        icon: Icons.health_and_safety,
        color: Colors.red,
      ));
    }
    
    // Development backlog
    final developingConcepts = _portfolioConcepts.where((c) => c.status == 'developing').toList();
    if (developingConcepts.length > 5) {
      recommendations.add(StrategicRecommendation(
        title: 'Clear Development Backlog',
        description: '${developingConcepts.length} concepts in development. Consider focusing on fewer projects.',
        actionItem: 'Prioritize top 3 concepts for focused development',
        priority: 'low',
        category: 'improvement',
        icon: Icons.filter_list,
        color: Colors.grey,
      ));
    }
    
    // Success recognition
    final highScoreConcepts = _portfolioConcepts.where((c) => c.currentScore >= 90).toList();
    if (highScoreConcepts.isNotEmpty) {
      recommendations.add(StrategicRecommendation(
        title: 'Premium Concepts Available',
        description: '${highScoreConcepts.length} concept(s) scoring 90+. These are ready for top-tier buyers.',
        actionItem: 'Target A24, Netflix, Apple TV+ for premium submissions',
        priority: 'high',
        category: 'submission',
        icon: Icons.star,
        color: Colors.amber,
      ));
    }
    
    // Sort by priority
    final priorityOrder = {'high': 0, 'medium': 1, 'low': 2};
    recommendations.sort((a, b) => priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!));
    
    return recommendations;
  }

  /// Get competitive analysis by genre
  List<CompetitiveAnalysis> getCompetitiveAnalysis() {
    final analyses = <CompetitiveAnalysis>[];
    final random = math.Random(42);
    
    final competitorsByGenre = {
      'Action': ['Mission: Impossible', 'John Wick', 'Fast & Furious', 'Top Gun'],
      'Horror': ['A Quiet Place', 'Get Out', 'Hereditary', 'The Conjuring'],
      'Thriller': ['Gone Girl', 'Knives Out', 'Parasite', 'The Girl on the Train'],
      'Sci-Fi': ['Dune', 'Interstellar', 'Ex Machina', 'Arrival'],
      'Comedy': ['Barbie', 'Glass Onion', 'The Menu', 'Bodies Bodies Bodies'],
      'Drama': ['Oppenheimer', 'The Whale', 'Everything Everywhere', 'Tar'],
      'Fantasy': ['House of the Dragon', 'Rings of Power', 'Sandman', 'Willow'],
      'Romance': ['Anyone But You', 'Purple Hearts', 'The Notebook', 'Crazy Rich Asians'],
      'Adventure': ['Indiana Jones', 'Jurassic World', 'Avatar', 'Uncharted'],
    };
    
    final windows = {
      'Action': 'Strong year-round, peak summer',
      'Horror': 'October peak, year-round demand',
      'Thriller': 'Fall season optimal',
      'Sci-Fi': 'Consistent demand, prefer Q4',
      'Comedy': 'Summer peak, holiday secondary',
      'Drama': 'Awards season (Oct-Feb)',
      'Fantasy': 'Holiday season preferred',
      'Romance': 'February + Summer peaks',
      'Adventure': 'Holiday tentpole season',
    };
    
    for (final genre in competitorsByGenre.keys) {
      final saturation = 4 + random.nextInt(6);
      final releases = 10 + random.nextInt(20);
      final differentiation = 50 + random.nextDouble() * 45;
      
      String recommendation;
      if (saturation > 7) {
        recommendation = 'Highly competitive - focus on unique angles';
      } else if (saturation > 5) {
        recommendation = 'Moderate competition - differentiation key';
      } else {
        recommendation = 'Open opportunity - faster path to market';
      }
      
      analyses.add(CompetitiveAnalysis(
        genre: genre,
        marketSaturation: saturation,
        recentReleases: releases,
        topCompetitors: competitorsByGenre[genre]!,
        opportunityWindow: windows[genre]!,
        differentiationScore: differentiation,
        recommendation: recommendation,
      ));
    }
    
    // Sort by opportunity (lower saturation = better opportunity)
    analyses.sort((a, b) => a.marketSaturation.compareTo(b.marketSaturation));
    
    return analyses;
  }

  /// Add a new concept to portfolio (simplified version)
  void addConceptToPortfolio({
    required String title,
    required String logline,
    required String genre,
    required String format,
    required double score,
  }) {
    final id = 'concept_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();
    
    _portfolioConcepts.add(PortfolioConcept(
      id: id,
      title: title,
      logline: logline,
      genre: genre,
      format: format,
      currentScore: score,
      scoreHistory: [
        ScoreProgression(
          date: now,
          conceptTitle: title,
          conceptId: id,
          score: score,
          genre: genre,
          version: 1,
          improvement: 0,
        ),
      ],
      createdAt: now,
      lastModified: now,
      status: 'developing',
      revisionCount: 1,
    ));
  }

  /// Update concept score after re-analysis
  void updateConceptScore(String conceptId, double newScore) {
    final index = _portfolioConcepts.indexWhere((c) => c.id == conceptId);
    if (index == -1) return;
    
    final concept = _portfolioConcepts[index];
    final now = DateTime.now();
    final newHistory = List<ScoreProgression>.from(concept.scoreHistory);
    
    newHistory.add(ScoreProgression(
      date: now,
      conceptTitle: concept.title,
      conceptId: conceptId,
      score: newScore,
      genre: concept.genre,
      version: concept.revisionCount + 1,
      previousScore: concept.currentScore,
      improvement: newScore - concept.currentScore,
    ));
    
    _portfolioConcepts[index] = PortfolioConcept(
      id: concept.id,
      title: concept.title,
      logline: concept.logline,
      genre: concept.genre,
      format: concept.format,
      currentScore: newScore,
      scoreHistory: newHistory,
      createdAt: concept.createdAt,
      lastModified: now,
      status: concept.status,
      revisionCount: concept.revisionCount + 1,
      notes: concept.notes,
    );
  }
}
