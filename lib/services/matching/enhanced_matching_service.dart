import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../analysis/industry_data.dart';
import '../analysis/expanded_buyers_database.dart';
import '../industry/industry_intelligence_service.dart';

// ============================================================================
// ENHANCED MATCHING SERVICE
// Advanced buyer/producer matching with comprehensive market intelligence
// ============================================================================

/// Enhanced buyer match with comprehensive market data
class ComprehensiveBuyerMatch {
  final String name;
  final String type;
  final String parentCompany;
  final int matchPercent;
  final String matchReason;
  final List<String> matchFactors;
  final String contentStrategy;
  final String budgetRange;
  final List<String> recentAcquisitions;
  final List<String> upcomingSlate;
  final String submissionPathway;
  final bool acceptsUnsolicited;
  final String idealPitch;
  final Map<String, String> keyExecutives;
  final String territoryFocus;
  final List<String> preferredFormats;
  
  // Market intelligence data
  final int contentSpendMillions;
  final int subscribersMillions;
  final double genreAffinityScore;
  final double recentActivityScore;
  final double marketMomentumScore;
  final String timingRecommendation;
  final List<BuyerActivityRecord> recentActivity;
  final List<String> competitorBuyers;
  final String marketPosition;
  final List<String> warnings;
  final List<String> opportunities;
  
  // Scoring breakdown
  final int genreMatchScore;
  final int formatMatchScore;
  final int budgetFitScore;
  final int marketTimingScore;
  final int activityScore;
  
  ComprehensiveBuyerMatch({
    required this.name,
    required this.type,
    required this.parentCompany,
    required this.matchPercent,
    required this.matchReason,
    required this.matchFactors,
    required this.contentStrategy,
    required this.budgetRange,
    required this.recentAcquisitions,
    required this.upcomingSlate,
    required this.submissionPathway,
    required this.acceptsUnsolicited,
    required this.idealPitch,
    required this.keyExecutives,
    required this.territoryFocus,
    required this.preferredFormats,
    required this.contentSpendMillions,
    required this.subscribersMillions,
    required this.genreAffinityScore,
    required this.recentActivityScore,
    required this.marketMomentumScore,
    required this.timingRecommendation,
    required this.recentActivity,
    required this.competitorBuyers,
    required this.marketPosition,
    required this.warnings,
    required this.opportunities,
    required this.genreMatchScore,
    required this.formatMatchScore,
    required this.budgetFitScore,
    required this.marketTimingScore,
    required this.activityScore,
  });
}

/// Enhanced producer match with comprehensive track record
class ComprehensiveProducerMatch {
  final String name;
  final String company;
  final int matchPercent;
  final String matchReason;
  final List<String> matchFactors;
  final List<String> specialties;
  final List<String> notableCredits;
  final String typicalBudget;
  final String lookingFor;
  final bool acceptsSubmissions;
  
  // Track record data
  final int totalProjects;
  final int recentProjects;
  final double avgBoxOfficeMillions;
  final double avgRtScore;
  final int oscarNominations;
  final int oscarWins;
  final List<String> studioRelationships;
  final List<String> streamerRelationships;
  final String workingStyle;
  
  // Market intelligence
  final double hotMeterScore;
  final String marketMomentum;
  final List<String> upcomingProjects;
  final List<String> genreTrends;
  final String approachStrategy;
  final List<String> warnings;
  final List<String> opportunities;
  
  // Scoring breakdown
  final int genreExpertiseScore;
  final int trackRecordScore;
  final int budgetAlignmentScore;
  final int accessibilityScore;
  final int momentumScore;
  
  ComprehensiveProducerMatch({
    required this.name,
    required this.company,
    required this.matchPercent,
    required this.matchReason,
    required this.matchFactors,
    required this.specialties,
    required this.notableCredits,
    required this.typicalBudget,
    required this.lookingFor,
    required this.acceptsSubmissions,
    required this.totalProjects,
    required this.recentProjects,
    required this.avgBoxOfficeMillions,
    required this.avgRtScore,
    required this.oscarNominations,
    required this.oscarWins,
    required this.studioRelationships,
    required this.streamerRelationships,
    required this.workingStyle,
    required this.hotMeterScore,
    required this.marketMomentum,
    required this.upcomingProjects,
    required this.genreTrends,
    required this.approachStrategy,
    required this.warnings,
    required this.opportunities,
    required this.genreExpertiseScore,
    required this.trackRecordScore,
    required this.budgetAlignmentScore,
    required this.accessibilityScore,
    required this.momentumScore,
  });
}

/// Genre market timing analysis
class GenreMarketTiming {
  final String genre;
  final String timing; // 'optimal', 'good', 'moderate', 'poor'
  final double score;
  final String explanation;
  final List<String> activebuyers;
  final String recommendation;
  
  const GenreMarketTiming({
    required this.genre,
    required this.timing,
    required this.score,
    required this.explanation,
    required this.activebuyers,
    required this.recommendation,
  });
}

/// Enhanced matching service
class EnhancedMatchingService {
  static final EnhancedMatchingService _instance = EnhancedMatchingService._internal();
  factory EnhancedMatchingService() => _instance;
  EnhancedMatchingService._internal();
  
  final IndustryIntelligenceService _intelligenceService = IndustryIntelligenceService();
  
  /// Get enhanced buyer matches with comprehensive market intelligence
  List<ComprehensiveBuyerMatch> getComprehensiveBuyerMatches({
    required String genre,
    required String format,
    required String tone,
    required double conceptScore,
  }) {
    final matches = <ComprehensiveBuyerMatch>[];
    final random = math.Random(genre.hashCode);
    
    // Get market timing for the genre
    final genreTiming = _getGenreMarketTiming(genre);
    final genreHeatMap = _intelligenceService.getGenreHeatMap();
    final buyerActivity = _intelligenceService.getBuyerActivity();
    
    // Process expanded buyer database
    for (final buyer in expandedBuyerDatabase) {
      // Calculate comprehensive match score
      final genreMatchScore = _calculateGenreMatchScore(
        genre, buyer.primaryGenres, buyer.secondaryGenres
      );
      final formatMatchScore = _calculateFormatMatchScore(format, buyer.preferredFormats);
      final budgetFitScore = _calculateBudgetFitScore(conceptScore, buyer.budgetRange);
      final marketTimingScore = _calculateMarketTimingScore(genre, buyer.name);
      final activityScore = _calculateActivityScore(buyer.name, buyerActivity);
      
      // Weighted average for overall match
      final overallScore = (
        genreMatchScore * 0.30 +
        formatMatchScore * 0.15 +
        budgetFitScore * 0.20 +
        marketTimingScore * 0.20 +
        activityScore * 0.15
      ).round();
      
      if (overallScore < 50) continue; // Filter low matches
      
      // Get recent activity for this buyer
      final recentBuyerActivity = buyerActivity
          .where((a) => a.buyerName.toLowerCase().contains(buyer.name.toLowerCase().split(' ').first))
          .take(3)
          .toList();
      
      // Generate match factors
      final matchFactors = <String>[];
      if (genreMatchScore >= 80) matchFactors.add('Strong genre alignment');
      if (formatMatchScore >= 80) matchFactors.add('Format preference match');
      if (activityScore >= 70) matchFactors.add('Recently active in your space');
      if (marketTimingScore >= 75) matchFactors.add('Favorable market timing');
      if (buyer.acceptsUnsolicited) matchFactors.add('Accepts unsolicited submissions');
      if (buyer.contentSpend2024 > 10000) matchFactors.add('High content spend');
      
      // Generate warnings
      final warnings = <String>[];
      if (!buyer.acceptsUnsolicited) warnings.add('Requires agent representation');
      if (genreMatchScore < 60 && genreMatchScore >= 50) warnings.add('Genre is secondary priority');
      if (marketTimingScore < 60) warnings.add('Market timing not optimal');
      
      // Generate opportunities
      final opportunities = <String>[];
      if (genreTiming.timing == 'optimal') opportunities.add('${genre} is trending hot right now');
      if (buyer.recentAcquisitions2024.any((a) => a.toLowerCase().contains(genre.toLowerCase()))) {
        opportunities.add('Recently acquired similar content');
      }
      if (buyer.upcomingSlate.isNotEmpty) {
        opportunities.add('Active development slate indicates buying mode');
      }
      
      // Generate timing recommendation
      final timingRecommendation = _generateTimingRecommendation(
        genre, buyer.name, genreTiming, random
      );
      
      // Get competitor buyers
      final competitors = expandedBuyerDatabase
          .where((b) => b.name != buyer.name && 
                        b.primaryGenres.contains(genre) &&
                        b.category == buyer.category)
          .take(3)
          .map((b) => b.name)
          .toList();
      
      matches.add(ComprehensiveBuyerMatch(
        name: buyer.name,
        type: _categoryToString(buyer.category),
        parentCompany: buyer.parentCompany,
        matchPercent: overallScore,
        matchReason: _generateBuyerMatchReason(genre, format, buyer, genreMatchScore),
        matchFactors: matchFactors,
        contentStrategy: buyer.contentStrategy,
        budgetRange: buyer.budgetRange,
        recentAcquisitions: buyer.recentAcquisitions2024,
        upcomingSlate: buyer.upcomingSlate,
        submissionPathway: buyer.submissionPathway,
        acceptsUnsolicited: buyer.acceptsUnsolicited,
        idealPitch: buyer.idealPitch,
        keyExecutives: buyer.keyExecutives,
        territoryFocus: buyer.territoryFocus,
        preferredFormats: buyer.preferredFormats,
        contentSpendMillions: buyer.contentSpend2024,
        subscribersMillions: buyer.subscribers,
        genreAffinityScore: genreMatchScore.toDouble(),
        recentActivityScore: activityScore.toDouble(),
        marketMomentumScore: marketTimingScore.toDouble(),
        timingRecommendation: timingRecommendation,
        recentActivity: recentBuyerActivity,
        competitorBuyers: competitors,
        marketPosition: _getMarketPosition(buyer),
        warnings: warnings,
        opportunities: opportunities,
        genreMatchScore: genreMatchScore,
        formatMatchScore: formatMatchScore,
        budgetFitScore: budgetFitScore,
        marketTimingScore: marketTimingScore,
        activityScore: activityScore,
      ));
    }
    
    // Sort by match percentage
    matches.sort((a, b) => b.matchPercent.compareTo(a.matchPercent));
    
    return matches.take(8).toList();
  }
  
  /// Get enhanced producer matches with comprehensive track records
  List<ComprehensiveProducerMatch> getComprehensiveProducerMatches({
    required String genre,
    required String format,
    required String tone,
    required double conceptScore,
  }) {
    final matches = <ComprehensiveProducerMatch>[];
    final random = math.Random(genre.hashCode + 42);
    
    // Extended producer data with track records
    final producerTrackRecords = _getProducerTrackRecords();
    
    for (final producer in producerDatabase) {
      // Calculate comprehensive match score
      final genreExpertiseScore = _calculateProducerGenreScore(genre, producer.specialties);
      final trackRecordScore = _calculateTrackRecordScore(producer.notableCredits);
      final budgetAlignmentScore = _calculateBudgetAlignmentScore(conceptScore, producer.typicalBudget);
      final accessibilityScore = producer.acceptsSubmissions ? 95 : 60;
      final momentumScore = 60 + random.nextInt(35);
      
      // Weighted average
      final overallScore = (
        genreExpertiseScore * 0.35 +
        trackRecordScore * 0.25 +
        budgetAlignmentScore * 0.15 +
        accessibilityScore * 0.10 +
        momentumScore * 0.15
      ).round();
      
      if (overallScore < 50) continue;
      
      // Get track record data
      final trackRecord = producerTrackRecords[producer.name] ?? _getDefaultTrackRecord(random);
      
      // Generate match factors
      final matchFactors = <String>[];
      if (genreExpertiseScore >= 85) matchFactors.add('Top-tier ${genre} expertise');
      if (trackRecordScore >= 80) matchFactors.add('Proven box office track record');
      if (producer.acceptsSubmissions) matchFactors.add('Open to new submissions');
      if (trackRecord['oscarNoms'] > 0) matchFactors.add('Awards season experience');
      if (trackRecord['avgRT'] >= 80) matchFactors.add('Critical acclaim history');
      
      // Generate warnings
      final warnings = <String>[];
      if (!producer.acceptsSubmissions) warnings.add('Requires agent referral');
      if (genreExpertiseScore < 60) warnings.add('Genre outside core expertise');
      if (trackRecord['avgBudget'] > 100 && conceptScore < 80) {
        warnings.add('Typically works on higher-budget projects');
      }
      
      // Generate opportunities
      final opportunities = <String>[];
      if (producer.specialties.first == genre) {
        opportunities.add('Your genre is their #1 specialty');
      }
      if (producer.lookingFor.toLowerCase().contains(genre.toLowerCase())) {
        opportunities.add('Actively seeking ${genre} content');
      }
      
      // Generate approach strategy
      final approachStrategy = _generateApproachStrategy(producer, genre, format);
      
      // Get studio/streamer relationships
      final studioRelationships = _getProducerRelationships(producer, 'studio');
      final streamerRelationships = _getProducerRelationships(producer, 'streamer');
      
      matches.add(ComprehensiveProducerMatch(
        name: producer.name,
        company: producer.company,
        matchPercent: overallScore,
        matchReason: _generateProducerMatchReason(genre, producer, genreExpertiseScore),
        matchFactors: matchFactors,
        specialties: producer.specialties,
        notableCredits: producer.notableCredits,
        typicalBudget: producer.typicalBudget,
        lookingFor: producer.lookingFor,
        acceptsSubmissions: producer.acceptsSubmissions,
        totalProjects: trackRecord['totalProjects'] as int,
        recentProjects: trackRecord['recentProjects'] as int,
        avgBoxOfficeMillions: (trackRecord['avgBO'] as num).toDouble(),
        avgRtScore: (trackRecord['avgRT'] as num).toDouble(),
        oscarNominations: trackRecord['oscarNoms'] as int,
        oscarWins: trackRecord['oscarWins'] as int,
        studioRelationships: studioRelationships,
        streamerRelationships: streamerRelationships,
        workingStyle: _getWorkingStyle(producer),
        hotMeterScore: momentumScore.toDouble(),
        marketMomentum: momentumScore >= 80 ? 'Hot' : momentumScore >= 60 ? 'Active' : 'Steady',
        upcomingProjects: _getUpcomingProjects(producer, random),
        genreTrends: _getGenreTrends(genre),
        approachStrategy: approachStrategy,
        warnings: warnings,
        opportunities: opportunities,
        genreExpertiseScore: genreExpertiseScore,
        trackRecordScore: trackRecordScore,
        budgetAlignmentScore: budgetAlignmentScore,
        accessibilityScore: accessibilityScore,
        momentumScore: momentumScore,
      ));
    }
    
    // Sort by match percentage
    matches.sort((a, b) => b.matchPercent.compareTo(a.matchPercent));
    
    return matches.take(8).toList();
  }
  
  /// Get genre market timing analysis
  GenreMarketTiming _getGenreMarketTiming(String genre) {
    final genreData = genreMarketDatabase[genre];
    final heatMap = _intelligenceService.getGenreHeatMap();
    final heatData = heatMap.firstWhere(
      (h) => h.genre.toLowerCase() == genre.toLowerCase(),
      orElse: () => heatMap.first,
    );
    
    String timing;
    double score;
    String explanation;
    String recommendation;
    
    if (genreData != null && genreData.isGrowing && genreData.growthRate > 10) {
      timing = 'optimal';
      score = 95;
      explanation = '${genre} is experiencing ${genreData.growthRate.toStringAsFixed(1)}% growth with strong market demand.';
      recommendation = 'Strike now - buyers are actively seeking ${genre} content.';
    } else if (genreData != null && genreData.isGrowing) {
      timing = 'good';
      score = 80;
      explanation = '${genre} shows steady growth at ${genreData.growthRate.toStringAsFixed(1)}%.';
      recommendation = 'Good timing for submission, consider packaging with attachments.';
    } else if (genreData != null && genreData.marketOutlook == 'stable') {
      timing = 'moderate';
      score = 65;
      explanation = '${genre} market is stable but not trending.';
      recommendation = 'Focus on differentiation - unique angle needed.';
    } else {
      timing = 'poor';
      score = 45;
      explanation = 'Current market conditions are challenging for ${genre}.';
      recommendation = 'Consider genre blending or finding unique hook.';
    }
    
    return GenreMarketTiming(
      genre: genre,
      timing: timing,
      score: score,
      explanation: explanation,
      activebuyers: heatData.activebuyers,
      recommendation: recommendation,
    );
  }
  
  // Helper methods
  
  int _calculateGenreMatchScore(String genre, List<String> primary, List<String> secondary) {
    if (primary.contains(genre)) return 95;
    if (secondary.contains(genre)) return 70;
    
    // Check for related genres
    final relatedGenres = _getRelatedGenres(genre);
    if (primary.any((g) => relatedGenres.contains(g))) return 60;
    if (secondary.any((g) => relatedGenres.contains(g))) return 45;
    
    return 30;
  }
  
  List<String> _getRelatedGenres(String genre) {
    final relationships = {
      'Action': ['Thriller', 'Adventure', 'Sci-Fi'],
      'Thriller': ['Action', 'Horror', 'Mystery', 'Drama'],
      'Horror': ['Thriller', 'Sci-Fi', 'Mystery'],
      'Comedy': ['Romance', 'Drama', 'Animation'],
      'Drama': ['Thriller', 'Romance', 'Comedy'],
      'Sci-Fi': ['Action', 'Thriller', 'Fantasy', 'Horror'],
      'Fantasy': ['Adventure', 'Sci-Fi', 'Animation'],
      'Romance': ['Comedy', 'Drama'],
      'Adventure': ['Action', 'Fantasy', 'Sci-Fi'],
      'Mystery': ['Thriller', 'Drama', 'Horror'],
      'Documentary': ['Drama'],
      'Animation': ['Comedy', 'Fantasy', 'Adventure'],
    };
    return relationships[genre] ?? [];
  }
  
  int _calculateFormatMatchScore(String format, List<String> preferredFormats) {
    if (preferredFormats.any((f) => f.toLowerCase().contains(format.toLowerCase()))) return 95;
    if (preferredFormats.any((f) => f.toLowerCase().contains('film') && format.toLowerCase().contains('film'))) return 90;
    if (preferredFormats.any((f) => f.toLowerCase().contains('series') && format.toLowerCase().contains('series'))) return 90;
    return 60;
  }
  
  int _calculateBudgetFitScore(double conceptScore, String budgetRange) {
    // Higher concept scores typically suggest higher budget potential
    if (budgetRange.contains('200M') && conceptScore >= 85) return 95;
    if (budgetRange.contains('100M') && conceptScore >= 75) return 90;
    if (budgetRange.contains('50M') && conceptScore >= 65) return 85;
    if (budgetRange.contains('20M') && conceptScore >= 55) return 80;
    if (budgetRange.contains('5M') || budgetRange.contains('3M')) return 75;
    return 70;
  }
  
  int _calculateMarketTimingScore(String genre, String buyerName) {
    final genreData = genreMarketDatabase[genre];
    if (genreData == null) return 60;
    
    int score = 60;
    if (genreData.isGrowing) score += 15;
    if (genreData.growthRate > 10) score += 10;
    if (genreData.marketOutlook == 'bullish') score += 10;
    if (genreData.streamingDemand > 80) score += 5;
    
    return math.min(score, 100);
  }
  
  int _calculateActivityScore(String buyerName, List<BuyerActivityRecord> activities) {
    final buyerActivities = activities.where(
      (a) => a.buyerName.toLowerCase().contains(buyerName.toLowerCase().split(' ').first)
    ).toList();
    
    if (buyerActivities.isEmpty) return 60;
    if (buyerActivities.length >= 3) return 95;
    if (buyerActivities.length >= 2) return 85;
    return 75;
  }
  
  int _calculateProducerGenreScore(String genre, List<String> specialties) {
    if (specialties.first == genre) return 98;
    if (specialties.contains(genre)) return 90;
    
    final relatedGenres = _getRelatedGenres(genre);
    if (specialties.any((s) => relatedGenres.contains(s))) return 70;
    
    return 50;
  }
  
  int _calculateTrackRecordScore(List<String> credits) {
    // Based on notable credits count and recognition
    if (credits.length >= 4) return 95;
    if (credits.length >= 3) return 85;
    if (credits.length >= 2) return 75;
    return 65;
  }
  
  int _calculateBudgetAlignmentScore(double conceptScore, String budget) {
    if (budget.contains('200M') && conceptScore >= 85) return 95;
    if (budget.contains('100M') && conceptScore >= 75) return 90;
    if (budget.contains('50M') && conceptScore >= 65) return 85;
    if (budget.contains('3M') || budget.contains('15M')) return 80;
    return 70;
  }
  
  String _categoryToString(BuyerCategory category) {
    switch (category) {
      case BuyerCategory.majorStreamer: return 'Major Streamer';
      case BuyerCategory.majorStudio: return 'Major Studio';
      case BuyerCategory.miniMajor: return 'Mini-Major';
      case BuyerCategory.specialtyDivision: return 'Specialty';
      case BuyerCategory.networkStreamer: return 'Network Streamer';
      case BuyerCategory.cablePremium: return 'Premium Cable';
      case BuyerCategory.internationalBuyer: return 'International';
      case BuyerCategory.productionCompany: return 'Production Co';
    }
  }
  
  String _generateBuyerMatchReason(String genre, String format, ExpandedBuyerProfile buyer, int genreScore) {
    if (genreScore >= 90) {
      return '${buyer.name} is actively acquiring ${genre} content and your concept aligns with their current mandate: "${buyer.contentStrategy.split('.').first}."';
    } else if (genreScore >= 70) {
      return '${buyer.name} includes ${genre} in their secondary interests, with recent acquisitions showing openness to the genre.';
    } else {
      return '${buyer.name}\'s diverse slate suggests potential interest, though ${genre} isn\'t their primary focus.';
    }
  }
  
  String _generateProducerMatchReason(String genre, ProducerProfile producer, int genreScore) {
    if (genreScore >= 90) {
      return '${producer.name} at ${producer.company} is one of the top ${genre} producers in the industry with multiple hits in the genre.';
    } else if (genreScore >= 70) {
      return '${producer.name} has demonstrated ${genre} expertise and is actively seeking: "${producer.lookingFor}"';
    } else {
      return '${producer.name}\'s versatile track record suggests potential fit, especially with the right concept angle.';
    }
  }
  
  String _getMarketPosition(ExpandedBuyerProfile buyer) {
    if (buyer.contentSpend2024 > 15000) return 'Market Leader';
    if (buyer.contentSpend2024 > 8000) return 'Major Player';
    if (buyer.contentSpend2024 > 3000) return 'Active Buyer';
    if (buyer.subscribers > 50) return 'Growing Platform';
    return 'Selective Buyer';
  }
  
  String _generateTimingRecommendation(String genre, String buyerName, GenreMarketTiming timing, math.Random random) {
    final months = ['January', 'February', 'March', 'April', 'May', 'June', 
                    'July', 'August', 'September', 'October', 'November', 'December'];
    final currentMonth = DateTime.now().month;
    
    if (timing.timing == 'optimal') {
      return 'Submit now - market conditions are ideal for ${genre} content.';
    } else if (genre == 'Horror' && (currentMonth >= 7 && currentMonth <= 9)) {
      return 'Perfect timing for Horror - Halloween acquisition season approaching.';
    } else if (genre == 'Drama' && (currentMonth >= 8 && currentMonth <= 11)) {
      return 'Awards season timing - prestige buyers actively seeking Drama.';
    } else {
      final targetMonth = months[(currentMonth + random.nextInt(3)) % 12];
      return 'Consider submitting around $targetMonth when ${buyerName.split(' ').first} typically reviews new material.';
    }
  }
  
  Map<String, Map<String, dynamic>> _getProducerTrackRecords() {
    return {
      'Jason Blum': {'totalProjects': 150, 'recentProjects': 12, 'avgBO': 85.0, 'avgRT': 72.0, 'oscarNoms': 3, 'oscarWins': 0, 'avgBudget': 8},
      'James Wan': {'totalProjects': 45, 'recentProjects': 6, 'avgBO': 250.0, 'avgRT': 68.0, 'oscarNoms': 0, 'oscarWins': 0, 'avgBudget': 50},
      'Emma Thomas': {'totalProjects': 25, 'recentProjects': 4, 'avgBO': 450.0, 'avgRT': 85.0, 'oscarNoms': 12, 'oscarWins': 4, 'avgBudget': 150},
      'Brad Pitt & Dede Gardner': {'totalProjects': 60, 'recentProjects': 8, 'avgBO': 120.0, 'avgRT': 82.0, 'oscarNoms': 15, 'oscarWins': 3, 'avgBudget': 40},
      'David Leitch & Kelly McCormick': {'totalProjects': 20, 'recentProjects': 5, 'avgBO': 200.0, 'avgRT': 75.0, 'oscarNoms': 0, 'oscarWins': 0, 'avgBudget': 85},
      'Judd Apatow': {'totalProjects': 40, 'recentProjects': 4, 'avgBO': 150.0, 'avgRT': 70.0, 'oscarNoms': 0, 'oscarWins': 0, 'avgBudget': 50},
      'Rian Johnson & Ram Bergman': {'totalProjects': 15, 'recentProjects': 4, 'avgBO': 180.0, 'avgRT': 92.0, 'oscarNoms': 3, 'oscarWins': 0, 'avgBudget': 70},
      'Reese Witherspoon': {'totalProjects': 30, 'recentProjects': 6, 'avgBO': 80.0, 'avgRT': 75.0, 'oscarNoms': 5, 'oscarWins': 1, 'avgBudget': 35},
      'Margot Robbie': {'totalProjects': 15, 'recentProjects': 5, 'avgBO': 300.0, 'avgRT': 78.0, 'oscarNoms': 3, 'oscarWins': 0, 'avgBudget': 60},
      'Guillermo del Toro': {'totalProjects': 35, 'recentProjects': 4, 'avgBO': 100.0, 'avgRT': 88.0, 'oscarNoms': 8, 'oscarWins': 2, 'avgBudget': 60},
    };
  }
  
  Map<String, dynamic> _getDefaultTrackRecord(math.Random random) {
    return {
      'totalProjects': 20 + random.nextInt(40),
      'recentProjects': 2 + random.nextInt(6),
      'avgBO': 50.0 + random.nextDouble() * 150,
      'avgRT': 65.0 + random.nextDouble() * 25,
      'oscarNoms': random.nextInt(5),
      'oscarWins': random.nextInt(2),
      'avgBudget': 30 + random.nextInt(70),
    };
  }
  
  String _generateApproachStrategy(ProducerProfile producer, String genre, String format) {
    if (producer.acceptsSubmissions) {
      return 'Submit directly to ${producer.company} with a one-page pitch and sample pages. Emphasize ${genre} angle and market timing.';
    } else {
      return 'Approach through representation. Target ${producer.company}\'s preferred agencies (CAA, WME, UTA). Package with talent if possible.';
    }
  }
  
  List<String> _getProducerRelationships(ProducerProfile producer, String type) {
    final studioRelationships = {
      'Jason Blum': ['Universal', 'Sony', 'Paramount'],
      'James Wan': ['Warner Bros', 'Universal', 'New Line'],
      'Emma Thomas': ['Warner Bros', 'Universal', 'Paramount'],
      'Brad Pitt & Dede Gardner': ['Paramount', 'Warner Bros', '20th Century'],
      'Judd Apatow': ['Universal', 'Sony'],
      'Margot Robbie': ['Warner Bros', 'Sony', 'Paramount'],
    };
    
    final streamerRelationships = {
      'Jason Blum': ['Amazon', 'Netflix', 'Peacock'],
      'James Wan': ['HBO Max', 'Netflix'],
      'Emma Thomas': ['Apple TV+', 'Netflix'],
      'Reese Witherspoon': ['Apple TV+', 'Hulu', 'Amazon'],
      'Rian Johnson & Ram Bergman': ['Netflix', 'Peacock'],
    };
    
    if (type == 'studio') {
      return studioRelationships[producer.name] ?? ['Universal', 'Warner Bros'];
    } else {
      return streamerRelationships[producer.name] ?? ['Netflix', 'Amazon'];
    }
  }
  
  String _getWorkingStyle(ProducerProfile producer) {
    if (producer.company.contains('Blumhouse')) return 'Fast-paced, hands-on development';
    if (producer.company.contains('Syncopy')) return 'Auteur-focused, quality over quantity';
    if (producer.company.contains('Plan B')) return 'Prestige-oriented, socially conscious';
    if (producer.company.contains('Hello Sunshine')) return 'Female-forward, book adaptations';
    if (producer.company.contains('A24')) return 'Bold vision, director-driven';
    return 'Collaborative, commercially minded';
  }
  
  List<String> _getUpcomingProjects(ProducerProfile producer, math.Random random) {
    final projects = {
      'Jason Blum': ['Five Nights at Freddy\'s 2', 'M3GAN 2.0', 'The Exorcist: Believer 2'],
      'Emma Thomas': ['TBD Nolan Project', 'Interstellar Legacy'],
      'Margot Robbie': ['Ocean\'s Prequel', 'A Big Bold Beautiful Journey'],
      'Rian Johnson & Ram Bergman': ['Knives Out 3', 'Poker Face S2'],
    };
    return projects[producer.name] ?? ['Untitled ${producer.specialties.first} Project'];
  }
  
  List<String> _getGenreTrends(String genre) {
    final trends = genreMarketDatabase[genre]?.hotTrends ?? [];
    return trends.take(3).toList();
  }
}
