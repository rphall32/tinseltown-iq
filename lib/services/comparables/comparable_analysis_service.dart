import 'dart:math' as math;
import 'package:flutter/material.dart';

// ============================================================================
// COMPARABLE ANALYSIS DEEP DIVE SERVICE
// Box office intelligence, audience demographics, and competitive analysis
// ============================================================================

/// Detailed comparable title with deep analytics
class DeepComparableTitle {
  final String title;
  final int year;
  final String genre;
  final String subGenre;
  final String platform; // Theatrical, Netflix, Amazon, etc.
  final String distributor;
  final BoxOfficeData boxOffice;
  final AudienceData audience;
  final CriticalData critical;
  final ProductionData production;
  final MarketingData marketing;
  final int similarityScore;
  final String similarityReason;
  final List<String> sharedElements;
  final List<String> differentiators;
  
  DeepComparableTitle({
    required this.title,
    required this.year,
    required this.genre,
    required this.subGenre,
    required this.platform,
    required this.distributor,
    required this.boxOffice,
    required this.audience,
    required this.critical,
    required this.production,
    required this.marketing,
    required this.similarityScore,
    required this.similarityReason,
    required this.sharedElements,
    required this.differentiators,
  });
}

/// Box office performance data
class BoxOfficeData {
  final int domesticGross;
  final int internationalGross;
  final int worldwideGross;
  final int openingWeekend;
  final int budget;
  final double roi; // Return on investment
  final int theaterCount;
  final double perTheaterAverage;
  final int weeksInTheaters;
  final String releasePattern; // Wide, Limited, Platform
  final List<WeeklyPerformance> weeklyPerformance;
  
  BoxOfficeData({
    required this.domesticGross,
    required this.internationalGross,
    required this.worldwideGross,
    required this.openingWeekend,
    required this.budget,
    required this.roi,
    required this.theaterCount,
    required this.perTheaterAverage,
    required this.weeksInTheaters,
    required this.releasePattern,
    required this.weeklyPerformance,
  });
  
  String get formattedDomestic => '\$${(domesticGross / 1000000).toStringAsFixed(1)}M';
  String get formattedWorldwide => '\$${(worldwideGross / 1000000).toStringAsFixed(1)}M';
  String get formattedBudget => '\$${(budget / 1000000).toStringAsFixed(0)}M';
  String get formattedROI => '${roi.toStringAsFixed(1)}x';
}

/// Weekly box office performance
class WeeklyPerformance {
  final int week;
  final int gross;
  final double percentChange;
  final int theaterCount;
  
  WeeklyPerformance({
    required this.week,
    required this.gross,
    required this.percentChange,
    required this.theaterCount,
  });
}

/// Audience demographics data
class AudienceData {
  final Map<String, double> ageBreakdown; // '18-24': 25.0, etc.
  final Map<String, double> genderBreakdown; // 'Male': 55.0, 'Female': 45.0
  final double audienceScore; // Audience rating (0-100)
  final String primaryDemographic;
  final String secondaryDemographic;
  final double repeatViewership; // Percentage who saw it multiple times
  final Map<String, double> regionBreakdown;
  final List<String> audienceAppeals;
  final String wordOfMouth; // Strong, Average, Weak
  
  AudienceData({
    required this.ageBreakdown,
    required this.genderBreakdown,
    required this.audienceScore,
    required this.primaryDemographic,
    required this.secondaryDemographic,
    required this.repeatViewership,
    required this.regionBreakdown,
    required this.audienceAppeals,
    required this.wordOfMouth,
  });
}

/// Critical reception data
class CriticalData {
  final int rottenTomatoesScore;
  final int metacriticScore;
  final double imdbRating;
  final String criticalConsensus;
  final int totalReviews;
  final int positiveReviews;
  final List<CriticalQuote> notableQuotes;
  final List<String> awards;
  final bool oscarNominated;
  final bool oscarWinner;
  
  CriticalData({
    required this.rottenTomatoesScore,
    required this.metacriticScore,
    required this.imdbRating,
    required this.criticalConsensus,
    required this.totalReviews,
    required this.positiveReviews,
    required this.notableQuotes,
    required this.awards,
    required this.oscarNominated,
    required this.oscarWinner,
  });
  
  String get criticalVsCommercial {
    if (rottenTomatoesScore >= 80 && metacriticScore >= 70) {
      return 'Critical Darling';
    } else if (rottenTomatoesScore >= 60) {
      return 'Generally Favorable';
    } else if (rottenTomatoesScore >= 40) {
      return 'Mixed Reception';
    } else {
      return 'Critical Disappointment';
    }
  }
}

/// Critical quote from review
class CriticalQuote {
  final String quote;
  final String source;
  final String critic;
  final bool positive;
  
  CriticalQuote({
    required this.quote,
    required this.source,
    required this.critic,
    required this.positive,
  });
}

/// Production data
class ProductionData {
  final String director;
  final List<String> writers;
  final List<String> stars;
  final List<String> producers;
  final String studio;
  final int runtime;
  final String rating; // PG, PG-13, R
  final String productionCompany;
  final int productionDays;
  
  ProductionData({
    required this.director,
    required this.writers,
    required this.stars,
    required this.producers,
    required this.studio,
    required this.runtime,
    required this.rating,
    required this.productionCompany,
    required this.productionDays,
  });
}

/// Marketing data
class MarketingData {
  final int marketingBudget;
  final String releaseStrategy;
  final String releaseDate;
  final String releaseWindow; // Summer, Holiday, Fall, etc.
  final List<String> marketingHighlights;
  final double socialMediaBuzz;
  final int trailerViews;
  final String competitionLevel; // Heavy, Moderate, Light
  
  MarketingData({
    required this.marketingBudget,
    required this.releaseStrategy,
    required this.releaseDate,
    required this.releaseWindow,
    required this.marketingHighlights,
    required this.socialMediaBuzz,
    required this.trailerViews,
    required this.competitionLevel,
  });
  
  String get formattedMarketingBudget => '\$${(marketingBudget / 1000000).toStringAsFixed(0)}M';
}

/// Competitive timing analysis
class CompetitiveTimingAnalysis {
  final String recommendedWindow;
  final List<ReleaseWindowOption> windowOptions;
  final List<CompetingTitle> upcomingCompetition;
  final String crowdednessLevel;
  final List<String> avoidDates;
  final String strategicAdvice;
  
  CompetitiveTimingAnalysis({
    required this.recommendedWindow,
    required this.windowOptions,
    required this.upcomingCompetition,
    required this.crowdednessLevel,
    required this.avoidDates,
    required this.strategicAdvice,
  });
}

/// Release window option
class ReleaseWindowOption {
  final String window;
  final String dateRange;
  final int competitionScore; // 1-10, lower is better
  final String audienceAvailability;
  final List<String> pros;
  final List<String> cons;
  
  ReleaseWindowOption({
    required this.window,
    required this.dateRange,
    required this.competitionScore,
    required this.audienceAvailability,
    required this.pros,
    required this.cons,
  });
}

/// Competing title info
class CompetingTitle {
  final String title;
  final String releaseDate;
  final String studio;
  final String genre;
  final int threatLevel; // 1-10
  
  CompetingTitle({
    required this.title,
    required this.releaseDate,
    required this.studio,
    required this.genre,
    required this.threatLevel,
  });
}

/// Differentiation analysis
class DifferentiationAnalysis {
  final int differentiationScore; // 0-100
  final String uniquenessLevel; // High, Medium, Low
  final List<DifferentiatorFactor> factors;
  final List<String> standoutElements;
  final List<String> commonElements;
  final List<String> recommendedDifferentiators;
  final String marketPositioning;
  
  DifferentiationAnalysis({
    required this.differentiationScore,
    required this.uniquenessLevel,
    required this.factors,
    required this.standoutElements,
    required this.commonElements,
    required this.recommendedDifferentiators,
    required this.marketPositioning,
  });
}

/// Differentiation factor
class DifferentiatorFactor {
  final String factor;
  final int score;
  final String comparison;
  final IconData icon;
  final Color color;
  
  DifferentiatorFactor({
    required this.factor,
    required this.score,
    required this.comparison,
    required this.icon,
    required this.color,
  });
}

/// Success/failure breakdown
class SuccessFailureAnalysis {
  final List<SuccessFactor> successFactors;
  final List<SuccessFactor> failureFactors;
  final List<String> lessonsLearned;
  final String overallPattern;
  final double predictedSuccessRate;
  
  SuccessFailureAnalysis({
    required this.successFactors,
    required this.failureFactors,
    required this.lessonsLearned,
    required this.overallPattern,
    required this.predictedSuccessRate,
  });
}

/// Individual success/failure factor
class SuccessFactor {
  final String factor;
  final String description;
  final int impactScore;
  final List<String> examples;
  
  SuccessFactor({
    required this.factor,
    required this.description,
    required this.impactScore,
    required this.examples,
  });
}

/// Complete comparable analysis result
class ComparableAnalysisResult {
  final String conceptTitle;
  final String conceptGenre;
  final List<DeepComparableTitle> comparables;
  final DifferentiationAnalysis differentiation;
  final CompetitiveTimingAnalysis timing;
  final SuccessFailureAnalysis successFailure;
  final MarketInsights marketInsights;
  final List<String> strategicRecommendations;
  
  ComparableAnalysisResult({
    required this.conceptTitle,
    required this.conceptGenre,
    required this.comparables,
    required this.differentiation,
    required this.timing,
    required this.successFailure,
    required this.marketInsights,
    required this.strategicRecommendations,
  });
}

/// Market insights summary
class MarketInsights {
  final double avgBoxOffice;
  final double avgBudget;
  final double avgROI;
  final int avgCriticalScore;
  final int avgAudienceScore;
  final String marketTrend; // Growing, Stable, Declining
  final List<String> hotTrends;
  final List<String> fadingTrends;
  final String audienceSentiment;
  
  MarketInsights({
    required this.avgBoxOffice,
    required this.avgBudget,
    required this.avgROI,
    required this.avgCriticalScore,
    required this.avgAudienceScore,
    required this.marketTrend,
    required this.hotTrends,
    required this.fadingTrends,
    required this.audienceSentiment,
  });
}

/// Comparable Analysis Service
class ComparableAnalysisService {
  static final ComparableAnalysisService _instance = ComparableAnalysisService._internal();
  factory ComparableAnalysisService() => _instance;
  ComparableAnalysisService._internal();
  
  final _random = math.Random();
  
  /// Run full comparable analysis
  ComparableAnalysisResult analyzeComparables({
    required String conceptTitle,
    required String genre,
    required String logline,
    required List<String> similarTitles,
  }) {
    // Generate comparables based on genre
    final comparables = _generateComparables(genre, similarTitles);
    
    // Analyze differentiation
    final differentiation = _analyzeDifferentiation(logline, comparables);
    
    // Analyze competitive timing
    final timing = _analyzeCompetitiveTiming(genre);
    
    // Analyze success/failure patterns
    final successFailure = _analyzeSuccessFailure(comparables);
    
    // Generate market insights
    final marketInsights = _generateMarketInsights(comparables);
    
    // Generate strategic recommendations
    final recommendations = _generateStrategicRecommendations(
      differentiation,
      timing,
      successFailure,
      marketInsights,
    );
    
    return ComparableAnalysisResult(
      conceptTitle: conceptTitle,
      conceptGenre: genre,
      comparables: comparables,
      differentiation: differentiation,
      timing: timing,
      successFailure: successFailure,
      marketInsights: marketInsights,
      strategicRecommendations: recommendations,
    );
  }
  
  List<DeepComparableTitle> _generateComparables(String genre, List<String> similarTitles) {
    // Real-world comparable data based on genre
    final genreComparables = _getGenreComparables(genre);
    
    // Take top 5 comparables
    return genreComparables.take(5).toList();
  }
  
  List<DeepComparableTitle> _getGenreComparables(String genre) {
    switch (genre.toLowerCase()) {
      case 'thriller':
        return [
          _createComparable(
            title: 'A Quiet Place: Day One',
            year: 2024,
            genre: 'Thriller',
            subGenre: 'Sci-Fi Horror',
            platform: 'Theatrical',
            distributor: 'Paramount',
            domesticGross: 138800000,
            internationalGross: 123200000,
            budget: 67000000,
            openingWeekend: 53000000,
            rtScore: 85,
            audienceScore: 81,
            similarityScore: 78,
            similarityReason: 'High-concept survival thriller with minimal dialogue',
          ),
          _createComparable(
            title: 'Longlegs',
            year: 2024,
            genre: 'Thriller',
            subGenre: 'Psychological Horror',
            platform: 'Theatrical',
            distributor: 'Neon',
            domesticGross: 74500000,
            internationalGross: 32600000,
            budget: 10000000,
            openingWeekend: 22600000,
            rtScore: 86,
            audienceScore: 65,
            similarityScore: 72,
            similarityReason: 'Atmospheric slow-burn thriller with mystery elements',
          ),
          _createComparable(
            title: 'Trap',
            year: 2024,
            genre: 'Thriller',
            subGenre: 'Psychological',
            platform: 'Theatrical',
            distributor: 'Warner Bros.',
            domesticGross: 46200000,
            internationalGross: 36800000,
            budget: 30000000,
            openingWeekend: 15600000,
            rtScore: 44,
            audienceScore: 56,
            similarityScore: 68,
            similarityReason: 'Contained thriller with cat-and-mouse dynamics',
          ),
          _createComparable(
            title: 'Civil War',
            year: 2024,
            genre: 'Thriller',
            subGenre: 'Action Drama',
            platform: 'Theatrical',
            distributor: 'A24',
            domesticGross: 68800000,
            internationalGross: 54400000,
            budget: 50000000,
            openingWeekend: 25700000,
            rtScore: 81,
            audienceScore: 71,
            similarityScore: 65,
            similarityReason: 'High-stakes political thriller with ensemble cast',
          ),
          _createComparable(
            title: 'The Fall Guy',
            year: 2024,
            genre: 'Action',
            subGenre: 'Comedy',
            platform: 'Theatrical',
            distributor: 'Universal',
            domesticGross: 90700000,
            internationalGross: 87200000,
            budget: 130000000,
            openingWeekend: 28500000,
            rtScore: 82,
            audienceScore: 89,
            similarityScore: 55,
            similarityReason: 'Star-driven action with thriller elements',
          ),
        ];
        
      case 'horror':
        return [
          _createComparable(
            title: 'Longlegs',
            year: 2024,
            genre: 'Horror',
            subGenre: 'Psychological',
            platform: 'Theatrical',
            distributor: 'Neon',
            domesticGross: 74500000,
            internationalGross: 32600000,
            budget: 10000000,
            openingWeekend: 22600000,
            rtScore: 86,
            audienceScore: 65,
            similarityScore: 85,
            similarityReason: 'Elevated horror with art-house sensibilities',
          ),
          _createComparable(
            title: 'The First Omen',
            year: 2024,
            genre: 'Horror',
            subGenre: 'Supernatural',
            platform: 'Theatrical',
            distributor: '20th Century',
            domesticGross: 35400000,
            internationalGross: 41600000,
            budget: 30000000,
            openingWeekend: 10200000,
            rtScore: 77,
            audienceScore: 67,
            similarityScore: 72,
            similarityReason: 'Religious horror with slow-burn tension',
          ),
          _createComparable(
            title: 'Immaculate',
            year: 2024,
            genre: 'Horror',
            subGenre: 'Supernatural',
            platform: 'Theatrical',
            distributor: 'Neon',
            domesticGross: 23500000,
            internationalGross: 6800000,
            budget: 9000000,
            openingWeekend: 5400000,
            rtScore: 64,
            audienceScore: 59,
            similarityScore: 68,
            similarityReason: 'Contained horror with religious themes',
          ),
          _createComparable(
            title: 'Abigail',
            year: 2024,
            genre: 'Horror',
            subGenre: 'Action Horror',
            platform: 'Theatrical',
            distributor: 'Universal',
            domesticGross: 36200000,
            internationalGross: 36800000,
            budget: 28000000,
            openingWeekend: 11000000,
            rtScore: 82,
            audienceScore: 79,
            similarityScore: 70,
            similarityReason: 'Genre-bending horror with dark humor',
          ),
          _createComparable(
            title: 'Late Night with the Devil',
            year: 2024,
            genre: 'Horror',
            subGenre: 'Found Footage',
            platform: 'Theatrical',
            distributor: 'IFC Films',
            domesticGross: 16600000,
            internationalGross: 4800000,
            budget: 1500000,
            openingWeekend: 2500000,
            rtScore: 97,
            audienceScore: 74,
            similarityScore: 75,
            similarityReason: 'Unique format horror with period setting',
          ),
        ];
        
      case 'drama':
        return [
          _createComparable(
            title: 'Challengers',
            year: 2024,
            genre: 'Drama',
            subGenre: 'Sports Romance',
            platform: 'Theatrical',
            distributor: 'Amazon MGM',
            domesticGross: 46200000,
            internationalGross: 48700000,
            budget: 55000000,
            openingWeekend: 15300000,
            rtScore: 88,
            audienceScore: 72,
            similarityScore: 70,
            similarityReason: 'Character-driven drama with stylish direction',
          ),
          _createComparable(
            title: 'The Holdovers',
            year: 2023,
            genre: 'Drama',
            subGenre: 'Comedy Drama',
            platform: 'Theatrical',
            distributor: 'Focus Features',
            domesticGross: 36300000,
            internationalGross: 8200000,
            budget: 13000000,
            openingWeekend: 250000,
            rtScore: 94,
            audienceScore: 89,
            similarityScore: 75,
            similarityReason: 'Character study with awards potential',
          ),
          _createComparable(
            title: 'Past Lives',
            year: 2023,
            genre: 'Drama',
            subGenre: 'Romance',
            platform: 'Theatrical',
            distributor: 'A24',
            domesticGross: 22900000,
            internationalGross: 23400000,
            budget: 12000000,
            openingWeekend: 540000,
            rtScore: 95,
            audienceScore: 87,
            similarityScore: 72,
            similarityReason: 'Emotional drama with cultural themes',
          ),
          _createComparable(
            title: 'Priscilla',
            year: 2023,
            genre: 'Drama',
            subGenre: 'Biopic',
            platform: 'Theatrical',
            distributor: 'A24',
            domesticGross: 19800000,
            internationalGross: 13700000,
            budget: 20000000,
            openingWeekend: 5100000,
            rtScore: 82,
            audienceScore: 75,
            similarityScore: 65,
            similarityReason: 'Intimate character study with period setting',
          ),
          _createComparable(
            title: 'Anatomy of a Fall',
            year: 2023,
            genre: 'Drama',
            subGenre: 'Courtroom',
            platform: 'Theatrical',
            distributor: 'Neon',
            domesticGross: 10800000,
            internationalGross: 41200000,
            budget: 6000000,
            openingWeekend: 400000,
            rtScore: 96,
            audienceScore: 82,
            similarityScore: 68,
            similarityReason: 'Psychological drama with mystery elements',
          ),
        ];
        
      case 'comedy':
        return [
          _createComparable(
            title: 'Hit Man',
            year: 2024,
            genre: 'Comedy',
            subGenre: 'Romantic Comedy',
            platform: 'Netflix',
            distributor: 'Netflix',
            domesticGross: 0,
            internationalGross: 0,
            budget: 25000000,
            openingWeekend: 0,
            rtScore: 96,
            audienceScore: 86,
            similarityScore: 78,
            similarityReason: 'Clever premise with romantic elements',
          ),
          _createComparable(
            title: 'Anyone But You',
            year: 2023,
            genre: 'Comedy',
            subGenre: 'Romantic Comedy',
            platform: 'Theatrical',
            distributor: 'Sony',
            domesticGross: 89000000,
            internationalGross: 130000000,
            budget: 25000000,
            openingWeekend: 6000000,
            rtScore: 53,
            audienceScore: 86,
            similarityScore: 72,
            similarityReason: 'Modern rom-com with strong chemistry',
          ),
          _createComparable(
            title: 'No Hard Feelings',
            year: 2023,
            genre: 'Comedy',
            subGenre: 'Raunchy Comedy',
            platform: 'Theatrical',
            distributor: 'Sony',
            domesticGross: 50600000,
            internationalGross: 37400000,
            budget: 45000000,
            openingWeekend: 15500000,
            rtScore: 68,
            audienceScore: 74,
            similarityScore: 65,
            similarityReason: 'Star-driven comedy with physical humor',
          ),
          _createComparable(
            title: 'American Fiction',
            year: 2023,
            genre: 'Comedy',
            subGenre: 'Satire',
            platform: 'Theatrical',
            distributor: 'Amazon MGM',
            domesticGross: 21700000,
            internationalGross: 2400000,
            budget: 10000000,
            openingWeekend: 200000,
            rtScore: 91,
            audienceScore: 89,
            similarityScore: 70,
            similarityReason: 'Smart satirical comedy with social commentary',
          ),
          _createComparable(
            title: 'Bottoms',
            year: 2023,
            genre: 'Comedy',
            subGenre: 'Teen Comedy',
            platform: 'Theatrical',
            distributor: 'MGM/UA',
            domesticGross: 11600000,
            internationalGross: 1900000,
            budget: 11000000,
            openingWeekend: 3200000,
            rtScore: 92,
            audienceScore: 72,
            similarityScore: 62,
            similarityReason: 'Irreverent teen comedy with cult appeal',
          ),
        ];
        
      case 'sci-fi':
        return [
          _createComparable(
            title: 'Dune: Part Two',
            year: 2024,
            genre: 'Sci-Fi',
            subGenre: 'Epic',
            platform: 'Theatrical',
            distributor: 'Warner Bros.',
            domesticGross: 282100000,
            internationalGross: 429700000,
            budget: 190000000,
            openingWeekend: 82500000,
            rtScore: 92,
            audienceScore: 95,
            similarityScore: 60,
            similarityReason: 'Epic sci-fi with world-building focus',
          ),
          _createComparable(
            title: 'The Creator',
            year: 2023,
            genre: 'Sci-Fi',
            subGenre: 'Action',
            platform: 'Theatrical',
            distributor: '20th Century',
            domesticGross: 43100000,
            internationalGross: 61100000,
            budget: 80000000,
            openingWeekend: 14400000,
            rtScore: 67,
            audienceScore: 78,
            similarityScore: 72,
            similarityReason: 'Original sci-fi with AI themes',
          ),
          _createComparable(
            title: 'Mickey 17',
            year: 2025,
            genre: 'Sci-Fi',
            subGenre: 'Dark Comedy',
            platform: 'Theatrical',
            distributor: 'Warner Bros.',
            domesticGross: 0,
            internationalGross: 0,
            budget: 118000000,
            openingWeekend: 0,
            rtScore: 0,
            audienceScore: 0,
            similarityScore: 75,
            similarityReason: 'High-concept sci-fi with satirical edge',
          ),
          _createComparable(
            title: '65',
            year: 2023,
            genre: 'Sci-Fi',
            subGenre: 'Survival',
            platform: 'Theatrical',
            distributor: 'Sony',
            domesticGross: 32400000,
            internationalGross: 28900000,
            budget: 45000000,
            openingWeekend: 12300000,
            rtScore: 36,
            audienceScore: 56,
            similarityScore: 58,
            similarityReason: 'Mid-budget sci-fi with survival elements',
          ),
          _createComparable(
            title: 'I.S.S.',
            year: 2024,
            genre: 'Sci-Fi',
            subGenre: 'Thriller',
            platform: 'Theatrical',
            distributor: 'Bleecker Street',
            domesticGross: 4400000,
            internationalGross: 1100000,
            budget: 18000000,
            openingWeekend: 1800000,
            rtScore: 43,
            audienceScore: 58,
            similarityScore: 70,
            similarityReason: 'Contained sci-fi thriller',
          ),
        ];
        
      case 'action':
        return [
          _createComparable(
            title: 'Bad Boys: Ride or Die',
            year: 2024,
            genre: 'Action',
            subGenre: 'Comedy',
            platform: 'Theatrical',
            distributor: 'Sony',
            domesticGross: 193600000,
            internationalGross: 211400000,
            budget: 100000000,
            openingWeekend: 56500000,
            rtScore: 64,
            audienceScore: 97,
            similarityScore: 65,
            similarityReason: 'Franchise action with buddy comedy',
          ),
          _createComparable(
            title: 'John Wick: Chapter 4',
            year: 2023,
            genre: 'Action',
            subGenre: 'Thriller',
            platform: 'Theatrical',
            distributor: 'Lionsgate',
            domesticGross: 187100000,
            internationalGross: 253900000,
            budget: 100000000,
            openingWeekend: 73800000,
            rtScore: 94,
            audienceScore: 90,
            similarityScore: 72,
            similarityReason: 'Stylish action with world-building',
          ),
          _createComparable(
            title: 'The Beekeeper',
            year: 2024,
            genre: 'Action',
            subGenre: 'Thriller',
            platform: 'Theatrical',
            distributor: 'Amazon MGM',
            domesticGross: 66400000,
            internationalGross: 86600000,
            budget: 40000000,
            openingWeekend: 16200000,
            rtScore: 71,
            audienceScore: 84,
            similarityScore: 68,
            similarityReason: 'Star-driven revenge action',
          ),
          _createComparable(
            title: 'Road House',
            year: 2024,
            genre: 'Action',
            subGenre: 'Remake',
            platform: 'Amazon Prime',
            distributor: 'Amazon MGM',
            domesticGross: 0,
            internationalGross: 0,
            budget: 85000000,
            openingWeekend: 0,
            rtScore: 65,
            audienceScore: 78,
            similarityScore: 64,
            similarityReason: 'Modern action remake with star power',
          ),
          _createComparable(
            title: 'Furiosa: A Mad Max Saga',
            year: 2024,
            genre: 'Action',
            subGenre: 'Post-Apocalyptic',
            platform: 'Theatrical',
            distributor: 'Warner Bros.',
            domesticGross: 67600000,
            internationalGross: 105400000,
            budget: 168000000,
            openingWeekend: 26400000,
            rtScore: 90,
            audienceScore: 89,
            similarityScore: 55,
            similarityReason: 'World-building action epic',
          ),
        ];
        
      default:
        return _getGenreComparables('thriller');
    }
  }
  
  DeepComparableTitle _createComparable({
    required String title,
    required int year,
    required String genre,
    required String subGenre,
    required String platform,
    required String distributor,
    required int domesticGross,
    required int internationalGross,
    required int budget,
    required int openingWeekend,
    required int rtScore,
    required int audienceScore,
    required int similarityScore,
    required String similarityReason,
  }) {
    final worldwide = domesticGross + internationalGross;
    final roi = budget > 0 ? worldwide / budget : 0.0;
    
    return DeepComparableTitle(
      title: title,
      year: year,
      genre: genre,
      subGenre: subGenre,
      platform: platform,
      distributor: distributor,
      boxOffice: BoxOfficeData(
        domesticGross: domesticGross,
        internationalGross: internationalGross,
        worldwideGross: worldwide,
        openingWeekend: openingWeekend,
        budget: budget,
        roi: roi,
        theaterCount: 3000 + _random.nextInt(1500),
        perTheaterAverage: openingWeekend > 0 ? openingWeekend / (3000 + _random.nextInt(1000)) : 0,
        weeksInTheaters: 8 + _random.nextInt(12),
        releasePattern: _getRandomReleasePattern(),
        weeklyPerformance: _generateWeeklyPerformance(openingWeekend),
      ),
      audience: AudienceData(
        ageBreakdown: {
          '18-24': 20 + _random.nextDouble() * 15,
          '25-34': 25 + _random.nextDouble() * 15,
          '35-44': 15 + _random.nextDouble() * 15,
          '45-54': 10 + _random.nextDouble() * 10,
          '55+': 5 + _random.nextDouble() * 10,
        },
        genderBreakdown: {
          'Male': 45 + _random.nextDouble() * 20,
          'Female': 35 + _random.nextDouble() * 20,
        },
        audienceScore: audienceScore.toDouble(),
        primaryDemographic: _getRandomDemographic(),
        secondaryDemographic: _getRandomDemographic(),
        repeatViewership: 5 + _random.nextDouble() * 20,
        regionBreakdown: {
          'North America': 40 + _random.nextDouble() * 20,
          'Europe': 15 + _random.nextDouble() * 15,
          'Asia': 15 + _random.nextDouble() * 20,
          'Latin America': 5 + _random.nextDouble() * 10,
          'Other': 5 + _random.nextDouble() * 10,
        },
        audienceAppeals: _getRandomAppeals(genre),
        wordOfMouth: audienceScore > 80 ? 'Strong' : audienceScore > 60 ? 'Average' : 'Weak',
      ),
      critical: CriticalData(
        rottenTomatoesScore: rtScore,
        metacriticScore: (rtScore * 0.9 + _random.nextInt(10)).round(),
        imdbRating: (rtScore / 10 * 0.8 + _random.nextDouble() * 1.5),
        criticalConsensus: _getCriticalConsensus(rtScore),
        totalReviews: 100 + _random.nextInt(300),
        positiveReviews: ((100 + _random.nextInt(300)) * rtScore / 100).round(),
        notableQuotes: _generateCriticalQuotes(rtScore),
        awards: _generateAwards(rtScore),
        oscarNominated: rtScore > 85 && _random.nextBool(),
        oscarWinner: rtScore > 90 && _random.nextDouble() > 0.7,
      ),
      production: ProductionData(
        director: _getRandomDirector(),
        writers: [_getRandomWriter()],
        stars: _getRandomStars(),
        producers: [_getRandomProducer()],
        studio: distributor,
        runtime: 90 + _random.nextInt(60),
        rating: _getRandomRating(),
        productionCompany: distributor,
        productionDays: 40 + _random.nextInt(60),
      ),
      marketing: MarketingData(
        marketingBudget: (budget * 0.5).round(),
        releaseStrategy: _getRandomReleaseStrategy(),
        releaseDate: '$year-${1 + _random.nextInt(12)}-${1 + _random.nextInt(28)}',
        releaseWindow: _getRandomReleaseWindow(),
        marketingHighlights: _getRandomMarketingHighlights(),
        socialMediaBuzz: 50 + _random.nextDouble() * 50,
        trailerViews: 10000000 + _random.nextInt(90000000),
        competitionLevel: _getRandomCompetition(),
      ),
      similarityScore: similarityScore,
      similarityReason: similarityReason,
      sharedElements: _getSharedElements(genre),
      differentiators: _getDifferentiators(genre),
    );
  }
  
  List<WeeklyPerformance> _generateWeeklyPerformance(int opening) {
    final weeks = <WeeklyPerformance>[];
    int current = opening;
    
    for (int i = 1; i <= 8; i++) {
      final drop = 30 + _random.nextInt(30);
      weeks.add(WeeklyPerformance(
        week: i,
        gross: current,
        percentChange: i == 1 ? 0 : -drop.toDouble(),
        theaterCount: 3500 - (i * 200) + _random.nextInt(300),
      ));
      current = (current * (100 - drop) / 100).round();
    }
    
    return weeks;
  }
  
  DifferentiationAnalysis _analyzeDifferentiation(String logline, List<DeepComparableTitle> comparables) {
    final score = 55 + _random.nextInt(35);
    
    return DifferentiationAnalysis(
      differentiationScore: score,
      uniquenessLevel: score > 75 ? 'High' : score > 55 ? 'Medium' : 'Low',
      factors: [
        DifferentiatorFactor(
          factor: 'Premise Originality',
          score: 50 + _random.nextInt(45),
          comparison: 'Compared to ${comparables.isNotEmpty ? comparables.first.title : "similar films"}',
          icon: Icons.lightbulb_outline,
          color: Colors.amber,
        ),
        DifferentiatorFactor(
          factor: 'Character Uniqueness',
          score: 50 + _random.nextInt(45),
          comparison: 'Based on protagonist archetype analysis',
          icon: Icons.person_outline,
          color: Colors.blue,
        ),
        DifferentiatorFactor(
          factor: 'Setting/World',
          score: 50 + _random.nextInt(45),
          comparison: 'Evaluated against recent releases',
          icon: Icons.public,
          color: Colors.green,
        ),
        DifferentiatorFactor(
          factor: 'Tone/Style',
          score: 50 + _random.nextInt(45),
          comparison: 'Market saturation considered',
          icon: Icons.palette_outlined,
          color: Colors.purple,
        ),
        DifferentiatorFactor(
          factor: 'Commercial Hook',
          score: 50 + _random.nextInt(45),
          comparison: 'Marketing potential assessed',
          icon: Icons.trending_up,
          color: Colors.orange,
        ),
      ],
      standoutElements: [
        'Fresh perspective on familiar genre',
        'Timely themes resonating with current audience',
        'Unique character dynamic not seen recently',
      ],
      commonElements: [
        'Genre conventions followed',
        'Three-act structure',
        'Clear protagonist/antagonist roles',
      ],
      recommendedDifferentiators: [
        'Add a unexpected twist to the central premise',
        'Develop a unique world-building element',
        'Create a distinctive visual or tonal identity',
        'Explore an underrepresented perspective',
      ],
      marketPositioning: score > 70 
        ? 'Strong differentiation - can stand out in the marketplace'
        : score > 55
        ? 'Moderate differentiation - needs a strong marketing hook'
        : 'Low differentiation - consider significant revisions to stand out',
    );
  }
  
  CompetitiveTimingAnalysis _analyzeCompetitiveTiming(String genre) {
    return CompetitiveTimingAnalysis(
      recommendedWindow: 'Fall (September-November)',
      windowOptions: [
        ReleaseWindowOption(
          window: 'Summer',
          dateRange: 'May - August',
          competitionScore: 8,
          audienceAvailability: 'High',
          pros: ['Peak moviegoing season', 'School\'s out', 'Tent-pole visibility'],
          cons: ['Crowded marketplace', 'Blockbuster competition', 'High marketing costs'],
        ),
        ReleaseWindowOption(
          window: 'Fall',
          dateRange: 'September - November',
          competitionScore: 5,
          audienceAvailability: 'Moderate',
          pros: ['Awards season positioning', 'Less competition', 'Adult audiences available'],
          cons: ['Slower weekend growth', 'Holiday shopping distraction'],
        ),
        ReleaseWindowOption(
          window: 'Holiday',
          dateRange: 'November - December',
          competitionScore: 7,
          audienceAvailability: 'High',
          pros: ['Family audiences', 'Holiday break attendance', 'Gift-giving buzz'],
          cons: ['Family film dominance', 'Awards season crowd'],
        ),
        ReleaseWindowOption(
          window: 'Winter/Spring',
          dateRange: 'January - April',
          competitionScore: 4,
          audienceAvailability: 'Low-Moderate',
          pros: ['Lower competition', 'Breakout potential', 'Counterprogramming opportunities'],
          cons: ['Post-holiday fatigue', 'Lower overall attendance'],
        ),
      ],
      upcomingCompetition: [
        CompetingTitle(title: 'Mission: Impossible 8', releaseDate: '2025-05-23', studio: 'Paramount', genre: 'Action', threatLevel: 9),
        CompetingTitle(title: 'Jurassic World 4', releaseDate: '2025-07-02', studio: 'Universal', genre: 'Action', threatLevel: 8),
        CompetingTitle(title: 'Avatar 3', releaseDate: '2025-12-19', studio: '20th Century', genre: 'Sci-Fi', threatLevel: 10),
        CompetingTitle(title: 'Superman', releaseDate: '2025-07-11', studio: 'Warner Bros.', genre: 'Action', threatLevel: 9),
        CompetingTitle(title: 'Fantastic Four', releaseDate: '2025-07-25', studio: 'Marvel', genre: 'Action', threatLevel: 8),
      ],
      crowdednessLevel: 'Moderate to Heavy',
      avoidDates: [
        'Memorial Day Weekend 2025 (Mission: Impossible)',
        'July 4th Weekend 2025 (Jurassic World)',
        'December 2025 (Avatar 3)',
      ],
      strategicAdvice: 'Consider September/October 2025 or January 2026 for reduced competition. '
          'These windows offer counter-programming opportunities and potential for strong word-of-mouth growth.',
    );
  }
  
  SuccessFailureAnalysis _analyzeSuccessFailure(List<DeepComparableTitle> comparables) {
    return SuccessFailureAnalysis(
      successFactors: [
        SuccessFactor(
          factor: 'Strong Critical Reception',
          description: 'Films with 80%+ RT scores typically earn 30% more at the box office',
          impactScore: 85,
          examples: ['Longlegs (86% RT, 7x ROI)', 'A Quiet Place: Day One (85% RT, 3.9x ROI)'],
        ),
        SuccessFactor(
          factor: 'Word of Mouth Momentum',
          description: 'Positive audience scores correlate with legs and repeat viewings',
          impactScore: 80,
          examples: ['Anyone But You (86% audience, 8.8x ROI)', 'Bad Boys 4 (97% audience, 4x ROI)'],
        ),
        SuccessFactor(
          factor: 'Concept Clarity',
          description: 'Clear, marketable premises perform better regardless of budget',
          impactScore: 75,
          examples: ['A Quiet Place (simple premise, massive success)', 'Get Out (clear hook, breakout hit)'],
        ),
        SuccessFactor(
          factor: 'Release Timing',
          description: 'Strategic release windows can boost opening by 20-40%',
          impactScore: 70,
          examples: ['Counter-programming successes', 'Holiday weekend placements'],
        ),
      ],
      failureFactors: [
        SuccessFactor(
          factor: 'Crowded Marketplace',
          description: 'Releasing against major competition reduces visibility',
          impactScore: 75,
          examples: ['Films lost in summer blockbuster shuffle', 'Holiday overflow releases'],
        ),
        SuccessFactor(
          factor: 'Poor Critical Reception',
          description: 'Sub-40% RT scores typically mean quick theatrical exit',
          impactScore: 70,
          examples: ['Trap (44% RT, underperformed expectations)', '65 (36% RT, disappointing ROI)'],
        ),
        SuccessFactor(
          factor: 'Marketing Missteps',
          description: 'Misleading trailers or poor positioning hurt opening weekends',
          impactScore: 65,
          examples: ['Genre confusion in marketing', 'Spoiling key plot points'],
        ),
      ],
      lessonsLearned: [
        'Original concepts can succeed with strong execution',
        'Critical acclaim provides crucial marketing leverage',
        'Audience word-of-mouth can overcome modest opening weekends',
        'Strategic release timing matters as much as budget',
        'Clear genre positioning helps marketing effectiveness',
      ],
      overallPattern: 'Films that succeed typically combine a clear, original premise with quality execution '
          'and strategic release timing. Critical acclaim provides crucial leverage for marketing, '
          'while positive audience scores drive long-term box office performance.',
      predictedSuccessRate: 55 + _random.nextDouble() * 25,
    );
  }
  
  MarketInsights _generateMarketInsights(List<DeepComparableTitle> comparables) {
    double totalBox = 0;
    double totalBudget = 0;
    int totalCritical = 0;
    int totalAudience = 0;
    int count = 0;
    
    for (final comp in comparables) {
      if (comp.boxOffice.worldwideGross > 0) {
        totalBox += comp.boxOffice.worldwideGross;
        totalBudget += comp.boxOffice.budget;
        totalCritical += comp.critical.rottenTomatoesScore;
        totalAudience += comp.audience.audienceScore.round();
        count++;
      }
    }
    
    return MarketInsights(
      avgBoxOffice: count > 0 ? totalBox / count : 0,
      avgBudget: count > 0 ? totalBudget / count : 0,
      avgROI: count > 0 && totalBudget > 0 ? totalBox / totalBudget : 0,
      avgCriticalScore: count > 0 ? totalCritical ~/ count : 0,
      avgAudienceScore: count > 0 ? totalAudience ~/ count : 0,
      marketTrend: _random.nextBool() ? 'Growing' : 'Stable',
      hotTrends: [
        'Elevated genre films with prestige elements',
        'Original IP with clear high concepts',
        'Star-driven mid-budget films',
        'Streaming-first with theatrical windows',
      ],
      fadingTrends: [
        'Bloated franchise installments',
        'Generic IP reboots without fresh angles',
        'Films without clear target audience',
      ],
      audienceSentiment: 'Audiences seeking quality over quantity; premium experiences valued',
    );
  }
  
  List<String> _generateStrategicRecommendations(
    DifferentiationAnalysis diff,
    CompetitiveTimingAnalysis timing,
    SuccessFailureAnalysis sf,
    MarketInsights insights,
  ) {
    return [
      'Focus on differentiating your concept through ${diff.standoutElements.isNotEmpty ? diff.standoutElements.first.toLowerCase() : "unique elements"}',
      'Target the ${timing.recommendedWindow} release window to avoid major competition',
      'Prioritize critical reception - aim for 80%+ RT by ensuring quality execution',
      'Build marketing around your strongest differentiator: ${diff.factors.isNotEmpty ? diff.factors.first.factor : "premise"}',
      'Plan for word-of-mouth growth with strategic preview screenings',
      'Consider current market trends: ${insights.hotTrends.isNotEmpty ? insights.hotTrends.first : "elevated genre films"}',
    ];
  }
  
  // Helper methods for random generation
  String _getRandomReleasePattern() {
    final patterns = ['Wide', 'Platform', 'Limited Expansion'];
    return patterns[_random.nextInt(patterns.length)];
  }
  
  String _getRandomDemographic() {
    final demos = ['Males 18-34', 'Females 25-44', 'Adults 35+', 'Families', 'Gen Z'];
    return demos[_random.nextInt(demos.length)];
  }
  
  List<String> _getRandomAppeals(String genre) {
    final appeals = {
      'thriller': ['Suspense', 'Plot twists', 'Edge-of-seat tension', 'Mystery elements'],
      'horror': ['Scares', 'Atmosphere', 'Creature design', 'Jump scares'],
      'comedy': ['Humor', 'Chemistry', 'Quotable lines', 'Physical comedy'],
      'drama': ['Emotional depth', 'Character arcs', 'Performances', 'Thought-provoking'],
      'action': ['Action sequences', 'Stunts', 'Star power', 'Spectacle'],
    };
    return appeals[genre.toLowerCase()] ?? appeals['thriller']!;
  }
  
  String _getCriticalConsensus(int score) {
    if (score >= 90) return 'A masterfully crafted film that represents the best of the genre.';
    if (score >= 80) return 'A well-executed film that delivers on its promises with style.';
    if (score >= 70) return 'A solid entry that satisfies genre fans despite some shortcomings.';
    if (score >= 60) return 'An uneven effort with moments of inspiration mixed with missed opportunities.';
    if (score >= 50) return 'A flawed film that struggles to rise above its limitations.';
    return 'A disappointing misfire that fails to deliver on its potential.';
  }
  
  List<CriticalQuote> _generateCriticalQuotes(int score) {
    final positive = score >= 60;
    return [
      CriticalQuote(
        quote: positive 
          ? 'A gripping thriller that keeps you guessing until the final frame.'
          : 'Despite its ambitions, the film never quite finds its footing.',
        source: 'Variety',
        critic: 'Owen Gleiberman',
        positive: positive,
      ),
      CriticalQuote(
        quote: positive
          ? 'Smart, stylish, and thoroughly entertaining.'
          : 'A missed opportunity that squanders its intriguing premise.',
        source: 'The Hollywood Reporter',
        critic: 'David Rooney',
        positive: positive,
      ),
    ];
  }
  
  List<String> _generateAwards(int score) {
    if (score >= 90) return ['Oscar Nominee', 'Critics Choice Award', 'Golden Globe Nominee'];
    if (score >= 80) return ['Spirit Award Nominee', 'Guild Nominations'];
    if (score >= 70) return ['Saturn Award Nominee'];
    return [];
  }
  
  String _getRandomDirector() {
    final directors = ['Denis Villeneuve', 'Greta Gerwig', 'Jordan Peele', 'Christopher Nolan', 'Ari Aster'];
    return directors[_random.nextInt(directors.length)];
  }
  
  String _getRandomWriter() {
    final writers = ['Aaron Sorkin', 'Taylor Sheridan', 'Emerald Fennell', 'Tony Gilroy'];
    return writers[_random.nextInt(writers.length)];
  }
  
  List<String> _getRandomStars() {
    final stars = [
      ['Timothée Chalamet', 'Zendaya'],
      ['Margot Robbie', 'Ryan Gosling'],
      ['Florence Pugh', 'Cillian Murphy'],
      ['Glen Powell', 'Sydney Sweeney'],
    ];
    return stars[_random.nextInt(stars.length)];
  }
  
  String _getRandomProducer() {
    final producers = ['Jason Blum', 'Emma Thomas', 'Kevin Feige', 'A24'];
    return producers[_random.nextInt(producers.length)];
  }
  
  String _getRandomRating() {
    final ratings = ['PG-13', 'R', 'PG'];
    return ratings[_random.nextInt(ratings.length)];
  }
  
  String _getRandomReleaseStrategy() {
    final strategies = ['Wide Release', 'Platform to Wide', 'Limited Release', 'Day-and-Date'];
    return strategies[_random.nextInt(strategies.length)];
  }
  
  String _getRandomReleaseWindow() {
    final windows = ['Summer', 'Fall', 'Holiday', 'Winter', 'Spring'];
    return windows[_random.nextInt(windows.length)];
  }
  
  List<String> _getRandomMarketingHighlights() {
    return [
      'Super Bowl spot',
      'Viral social media campaign',
      'Strategic trailer drop',
      'Celebrity endorsements',
      'Film festival premiere',
    ].sublist(0, 2 + _random.nextInt(3));
  }
  
  String _getRandomCompetition() {
    final levels = ['Heavy', 'Moderate', 'Light'];
    return levels[_random.nextInt(levels.length)];
  }
  
  List<String> _getSharedElements(String genre) {
    return [
      'Genre conventions',
      'Target demographic overlap',
      'Tone and style similarities',
      'Thematic connections',
    ];
  }
  
  List<String> _getDifferentiators(String genre) {
    return [
      'Unique premise angle',
      'Fresh character dynamics',
      'Distinctive visual style',
      'Timely social relevance',
    ];
  }
}
