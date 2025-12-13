/// ═══════════════════════════════════════════════════════════════════════════
/// V4 COMPARABLE ANALYSIS ENGINE
/// The most advanced concept analysis system for Hollywood
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// V4 Features:
/// 1. Box office prediction based on comparable performance
/// 2. Buyer/studio affinity matching with decision maker info
/// 3. Talent packaging suggestions (directors, actors, writers)
/// 4. Franchise/IP potential scoring
/// 5. Advanced logline analysis with hook strength detection
/// 6. Competitive landscape awareness
/// 7. Integrated market intelligence

import 'v4_box_office_predictor.dart';
import 'v4_buyer_affinity.dart';
import 'v4_talent_packager.dart';
import 'v4_franchise_analyzer.dart';
import 'v4_semantic_matcher.dart';
import 'enhanced_comparable_engine.dart';

/// Main V4 Analysis Result
class V4AnalysisResult {
  // Core comparable analysis (from v2)
  final List<ComparableMatchResult> topComparables;
  
  // V4 Enhancements
  final BoxOfficePrediction boxOfficePrediction;
  final List<BuyerAffinityResult> buyerMatches;
  final TalentPackage talentSuggestions;
  final FranchisePotential franchisePotential;
  final LoglineAnalysis loglineAnalysis;
  final MarketPositioning marketPositioning;
  
  // Meta
  final String analysisVersion;
  final DateTime analyzedAt;
  
  V4AnalysisResult({
    required this.topComparables,
    required this.boxOfficePrediction,
    required this.buyerMatches,
    required this.talentSuggestions,
    required this.franchisePotential,
    required this.loglineAnalysis,
    required this.marketPositioning,
    this.analysisVersion = '4.0',
    DateTime? analyzedAt,
  }) : analyzedAt = analyzedAt ?? DateTime.now();
}

/// Advanced logline analysis
class LoglineAnalysis {
  final int hookStrength; // 0-100
  final String hookType; // "Mystery", "Irony", "Contrast", "Stakes", "Unique World"
  final int clarityScore; // 0-100
  final int emotionalHook; // 0-100
  final int marketabilityScore; // 0-100
  final List<String> strengths;
  final List<String> improvements;
  final String pitchRecommendation;
  final int wordCount;
  final bool optimalLength;
  
  LoglineAnalysis({
    required this.hookStrength,
    required this.hookType,
    required this.clarityScore,
    required this.emotionalHook,
    required this.marketabilityScore,
    required this.strengths,
    required this.improvements,
    required this.pitchRecommendation,
    required this.wordCount,
    required this.optimalLength,
  });
}

/// Market positioning analysis
class MarketPositioning {
  final String competitiveSpace;
  final String targetQuadrant; // "Four Quadrant", "Male-Skewing", "Female-Skewing", "Niche"
  final String releaseWindowRecommendation;
  final List<String> competingProjects;
  final String differentiationStrategy;
  final int crowdednessScore; // 0-100 (100 = very crowded)
  
  MarketPositioning({
    required this.competitiveSpace,
    required this.targetQuadrant,
    required this.releaseWindowRecommendation,
    required this.competingProjects,
    required this.differentiationStrategy,
    required this.crowdednessScore,
  });
}

/// Main V4 Engine
class V4ComparableEngine {
  static final V4ComparableEngine _instance = V4ComparableEngine._internal();
  factory V4ComparableEngine() => _instance;
  V4ComparableEngine._internal();
  
  // Sub-engines
  final _enhancedEngine = EnhancedComparableEngine();
  final _boxOfficePredictor = BoxOfficePredictor();
  final _buyerAnalyzer = BuyerAffinityAnalyzer();
  final _talentPackager = TalentPackager();
  final _franchiseAnalyzer = FranchiseAnalyzer();
  final _semanticMatcher = SemanticMatcher(); // V4.5 Precision matcher
  
  /// Main analysis entry point
  V4AnalysisResult analyze({
    required String logline,
    required String genre,
    required String format,
    String? synopsis,
    String? secondaryGenre,
    String? tone,
    String? targetAudience,
    String? budgetTier,
    String? userComparable,
  }) {
    // 1. Get base comparables from enhanced engine
    final topComparables = _enhancedEngine.findComparables(
      logline: logline,
      genre: genre,
      format: format,
      secondaryGenre: secondaryGenre,
      tone: tone,
      targetAudience: targetAudience,
      budgetTier: budgetTier,
      userComparable: userComparable,
      maxResults: 5,
    );
    
    // 2. Analyze logline
    final loglineAnalysis = _analyzeLogline(logline, genre);
    
    // 3. Extract narrative elements for other analyses
    final narrativeElements = _extractNarrativeElements(logline);
    
    // V4.5: PRECISION SEMANTIC MATCHING FOR BOX OFFICE PREDICTION
    // Use deep semantic analysis to find truly comparable titles
    final preciseMatches = _semanticMatcher.findPreciseMatches(
      logline: logline,
      genre: genre,
      format: format,
      synopsis: synopsis,
      tone: tone,
      budgetTier: budgetTier,
      userComparable: userComparable,
      maxResults: 5,
    );
    
    // 4. Box office prediction - USE PRECISION MATCHES instead of basic genre matching
    BoxOfficePrediction boxOfficePrediction;
    if (preciseMatches.isNotEmpty) {
      // Convert precision matches to comparable performance for prediction
      final precisionBoxOffice = _semanticMatcher.predictBoxOffice(
        matches: preciseMatches,
        genre: genre,
        format: format,
        budgetTier: budgetTier,
      );
      
      // Convert PrecisionBoxOfficePrediction to BoxOfficePrediction
      boxOfficePrediction = BoxOfficePrediction(
        predictedDomesticLow: precisionBoxOffice.predictedDomesticLow,
        predictedDomesticHigh: precisionBoxOffice.predictedDomesticHigh,
        predictedWorldwideLow: precisionBoxOffice.predictedWorldwideLow,
        predictedWorldwideHigh: precisionBoxOffice.predictedWorldwideHigh,
        predictedROI: precisionBoxOffice.predictedROI,
        confidence: precisionBoxOffice.confidenceLevel,
        basedOnTitles: precisionBoxOffice.basedOnTitles,
        rationale: precisionBoxOffice.rationale,
      );
    } else {
      // Fallback to basic prediction if semantic matching fails
      final comparablePerformance = topComparables.map((c) => ComparablePerformance(
        title: c.title.title,
        domesticGross: c.title.domesticGrossMillions,
        worldwideGross: c.title.worldwideGrossMillions,
        budget: c.title.budgetMillions,
        roi: c.title.roi,
      )).toList();
      
      boxOfficePrediction = _boxOfficePredictor.predict(
        genre: genre,
        format: format,
        budgetTier: budgetTier,
        comparables: comparablePerformance,
      );
    }
    
    // 5. Buyer affinity analysis
    final buyerMatches = _buyerAnalyzer.analyze(
      genre: genre,
      format: format,
      secondaryGenre: secondaryGenre,
      tone: tone,
      budgetTier: budgetTier,
      themes: narrativeElements['themes'] ?? [],
      comparableTitles: topComparables.map((c) => c.title.title).toList(),
    );
    
    // 6. Talent packaging
    final talentSuggestions = _talentPackager.suggest(
      genre: genre,
      format: format,
      tone: tone,
      budgetTier: budgetTier,
      protagonistType: narrativeElements['protagonistType'],
      themes: narrativeElements['themes'] ?? [],
      comparableTitles: topComparables.map((c) => c.title.title).toList(),
    );
    
    // 7. Franchise potential
    final franchisePotential = _franchiseAnalyzer.analyze(
      logline: logline,
      genre: genre,
      format: format,
      setting: narrativeElements['setting'],
      protagonistType: narrativeElements['protagonistType'],
      themes: narrativeElements['themes'] ?? [],
      genreElements: narrativeElements['genreElements'] ?? [],
    );
    
    // 8. Market positioning
    final marketPositioning = _analyzeMarketPositioning(
      genre: genre,
      format: format,
      tone: tone,
      targetAudience: targetAudience,
      topComparables: topComparables,
    );
    
    return V4AnalysisResult(
      topComparables: topComparables,
      boxOfficePrediction: boxOfficePrediction,
      buyerMatches: buyerMatches,
      talentSuggestions: talentSuggestions,
      franchisePotential: franchisePotential,
      loglineAnalysis: loglineAnalysis,
      marketPositioning: marketPositioning,
    );
  }
  
  /// Analyze logline for hook strength, clarity, and marketability
  LoglineAnalysis _analyzeLogline(String logline, String genre) {
    final words = logline.split(' ');
    final wordCount = words.length;
    final optimalLength = wordCount >= 20 && wordCount <= 40;
    final lowerLogline = logline.toLowerCase();
    
    // Hook strength analysis
    int hookStrength = 40;
    String hookType = 'Standard';
    
    // Mystery hook
    if (lowerLogline.contains('discovers') || lowerLogline.contains('uncover') ||
        lowerLogline.contains('secret') || lowerLogline.contains('truth')) {
      hookStrength += 15;
      hookType = 'Mystery';
    }
    
    // Irony hook
    if (lowerLogline.contains('but') || lowerLogline.contains('however') ||
        lowerLogline.contains('only to') || lowerLogline.contains('instead')) {
      hookStrength += 20;
      hookType = 'Irony';
    }
    
    // Contrast hook
    if (lowerLogline.contains('between') || lowerLogline.contains('versus') ||
        lowerLogline.contains('against') || lowerLogline.contains('unlikely')) {
      hookStrength += 15;
      hookType = 'Contrast';
    }
    
    // Stakes hook
    if (lowerLogline.contains('must') || lowerLogline.contains('before') ||
        lowerLogline.contains('or else') || lowerLogline.contains('only chance')) {
      hookStrength += 20;
      hookType = 'Stakes';
    }
    
    // Unique world hook
    if (lowerLogline.contains('world where') || lowerLogline.contains('future') ||
        lowerLogline.contains('society') || lowerLogline.contains('dimension')) {
      hookStrength += 15;
      hookType = 'Unique World';
    }
    
    // Clarity score
    int clarityScore = 50;
    if (logline.contains(',')) clarityScore += 10; // Structure
    if (words.length >= 15 && words.length <= 35) clarityScore += 15; // Good length
    if (lowerLogline.contains('when') || lowerLogline.contains('after')) clarityScore += 10; // Clear inciting incident
    if (!logline.contains('...')) clarityScore += 10; // Complete thought
    
    // Check for clarity issues
    if (words.length > 50) clarityScore -= 15;
    if (logline.split(',').length > 4) clarityScore -= 10; // Too complex
    
    // Emotional hook
    int emotionalHook = 40;
    final emotionalWords = ['love', 'death', 'family', 'revenge', 'betrayal', 'survival',
                           'hope', 'fear', 'loss', 'redemption', 'sacrifice', 'dream'];
    for (final word in emotionalWords) {
      if (lowerLogline.contains(word)) {
        emotionalHook += 10;
        break;
      }
    }
    
    // Character emotional states
    if (lowerLogline.contains('desperate') || lowerLogline.contains('haunted') ||
        lowerLogline.contains('struggling') || lowerLogline.contains('torn')) {
      emotionalHook += 15;
    }
    
    // Marketability score
    int marketabilityScore = 50;
    
    // High-concept indicators
    if (hookStrength >= 70) marketabilityScore += 15;
    
    // Genre clarity
    final genreKeywords = _getGenreKeywords(genre);
    if (genreKeywords.any((k) => lowerLogline.contains(k))) {
      marketabilityScore += 10;
    }
    
    // Star vehicle potential
    if (lowerLogline.contains('young') || lowerLogline.contains('legendary') ||
        lowerLogline.contains('brilliant') || lowerLogline.contains('former')) {
      marketabilityScore += 10;
    }
    
    // Identify strengths and improvements
    final strengths = <String>[];
    final improvements = <String>[];
    
    if (hookStrength >= 70) {
      strengths.add('Strong hook that grabs attention');
    }
    if (clarityScore >= 70) {
      strengths.add('Clear, well-structured premise');
    }
    if (emotionalHook >= 60) {
      strengths.add('Emotionally resonant stakes');
    }
    if (optimalLength) {
      strengths.add('Optimal length for pitch effectiveness');
    }
    
    if (hookStrength < 60) {
      improvements.add('Add stronger hook - what makes this unique?');
    }
    if (clarityScore < 60) {
      improvements.add('Simplify structure for clearer understanding');
    }
    if (emotionalHook < 50) {
      improvements.add('Emphasize emotional stakes');
    }
    if (!optimalLength) {
      if (wordCount < 20) {
        improvements.add('Expand to include more specific details');
      } else {
        improvements.add('Tighten to 25-35 words for pitch meetings');
      }
    }
    
    // Pitch recommendation
    String pitchRecommendation;
    final avgScore = (hookStrength + clarityScore + emotionalHook + marketabilityScore) / 4;
    if (avgScore >= 75) {
      pitchRecommendation = 'Excellent pitch-ready logline. Lead with this in all meetings.';
    } else if (avgScore >= 60) {
      pitchRecommendation = 'Solid logline. Consider polishing weak areas before major pitches.';
    } else if (avgScore >= 45) {
      pitchRecommendation = 'Needs refinement. Focus on hook and emotional stakes.';
    } else {
      pitchRecommendation = 'Significant revision recommended before pitching.';
    }
    
    return LoglineAnalysis(
      hookStrength: hookStrength.clamp(0, 100),
      hookType: hookType,
      clarityScore: clarityScore.clamp(0, 100),
      emotionalHook: emotionalHook.clamp(0, 100),
      marketabilityScore: marketabilityScore.clamp(0, 100),
      strengths: strengths,
      improvements: improvements,
      pitchRecommendation: pitchRecommendation,
      wordCount: wordCount,
      optimalLength: optimalLength,
    );
  }
  
  List<String> _getGenreKeywords(String genre) {
    final keywords = {
      'Horror': ['terror', 'haunted', 'evil', 'nightmare', 'creature', 'demon', 'ghost'],
      'Thriller': ['dangerous', 'conspiracy', 'deadly', 'race against', 'hunted'],
      'Action': ['fight', 'battle', 'mission', 'hero', 'save', 'warrior'],
      'Comedy': ['hilarious', 'chaos', 'mishap', 'unlikely', 'wacky'],
      'Drama': ['struggle', 'relationship', 'journey', 'life', 'family'],
      'Sci-Fi': ['future', 'technology', 'space', 'alien', 'experiment'],
      'Romance': ['love', 'heart', 'relationship', 'falls for', 'chemistry'],
    };
    return keywords[genre] ?? [];
  }
  
  /// Extract narrative elements from logline
  Map<String, dynamic> _extractNarrativeElements(String logline) {
    final lowerLogline = logline.toLowerCase();
    
    // Protagonist type
    String? protagonistType;
    final protagonistMap = {
      'detective': ['detective', 'investigator', 'cop', 'agent', 'fbi'],
      'parent': ['mother', 'father', 'parent', 'mom', 'dad'],
      'survivor': ['survivor', 'victim', 'witness'],
      'scientist': ['scientist', 'doctor', 'researcher', 'professor'],
      'soldier': ['soldier', 'veteran', 'marine', 'military'],
      'criminal': ['thief', 'hitman', 'criminal', 'con artist'],
      'artist': ['writer', 'artist', 'musician', 'filmmaker'],
    };
    
    for (final entry in protagonistMap.entries) {
      if (entry.value.any((w) => lowerLogline.contains(w))) {
        protagonistType = entry.key;
        break;
      }
    }
    
    // Setting
    String? setting;
    final settingMap = {
      'urban': ['city', 'urban', 'new york', 'los angeles', 'downtown'],
      'small town': ['small town', 'rural', 'countryside', 'village'],
      'space': ['space', 'spaceship', 'planet', 'galaxy'],
      'isolated': ['isolated', 'remote', 'cabin', 'island'],
      'institutional': ['hospital', 'prison', 'school', 'asylum'],
      'historical': ['1800s', '1900s', 'victorian', 'medieval'],
      'future': ['future', 'dystopian', '2050', 'post-apocalyptic'],
    };
    
    for (final entry in settingMap.entries) {
      if (entry.value.any((w) => lowerLogline.contains(w))) {
        setting = entry.key;
        break;
      }
    }
    
    // Themes
    final themes = <String>[];
    final themeMap = {
      'family': ['family', 'father', 'mother', 'child', 'sibling'],
      'trauma': ['trauma', 'haunted', 'past', 'nightmares'],
      'identity': ['identity', 'who am i', 'discover', 'true self'],
      'power': ['power', 'control', 'dominance'],
      'redemption': ['redemption', 'second chance', 'forgiveness'],
      'survival': ['survive', 'survival', 'escape'],
    };
    
    for (final entry in themeMap.entries) {
      if (entry.value.any((w) => lowerLogline.contains(w))) {
        themes.add(entry.key);
      }
    }
    
    // Genre elements
    final genreElements = <String>[];
    final elementMap = {
      'twist ending': ['twist', 'revelation', 'shocking'],
      'unreliable narrator': ['unreliable', 'memory', 'imagining'],
      'ensemble': ['group', 'team', 'crew', 'ensemble'],
      'contained thriller': ['trapped', 'confined', 'locked'],
      'cat and mouse': ['chase', 'hunt', 'pursue'],
    };
    
    for (final entry in elementMap.entries) {
      if (entry.value.any((w) => lowerLogline.contains(w))) {
        genreElements.add(entry.key);
      }
    }
    
    return {
      'protagonistType': protagonistType,
      'setting': setting,
      'themes': themes,
      'genreElements': genreElements,
    };
  }
  
  /// Analyze market positioning and competitive landscape
  MarketPositioning _analyzeMarketPositioning({
    required String genre,
    required String format,
    String? tone,
    String? targetAudience,
    required List<ComparableMatchResult> topComparables,
  }) {
    // Determine competitive space
    String competitiveSpace;
    if (genre == 'Horror' || genre == 'Thriller') {
      competitiveSpace = 'Genre space - moderate competition';
    } else if (genre == 'Action' || genre == 'Sci-Fi') {
      competitiveSpace = 'Tentpole space - high competition';
    } else if (genre == 'Drama' || genre == 'Romance') {
      competitiveSpace = 'Prestige/indie space - selective competition';
    } else {
      competitiveSpace = 'General entertainment space';
    }
    
    // Target quadrant
    String targetQuadrant;
    if (targetAudience != null) {
      if (targetAudience.toLowerCase().contains('family') ||
          targetAudience.toLowerCase().contains('all')) {
        targetQuadrant = 'Four Quadrant';
      } else if (targetAudience.toLowerCase().contains('male') ||
                 targetAudience.toLowerCase().contains('18-34')) {
        targetQuadrant = 'Male-Skewing 18-34';
      } else if (targetAudience.toLowerCase().contains('female') ||
                 targetAudience.toLowerCase().contains('women')) {
        targetQuadrant = 'Female-Skewing';
      } else {
        targetQuadrant = 'General Adult';
      }
    } else {
      // Infer from genre
      if (genre == 'Action' || genre == 'Sci-Fi') {
        targetQuadrant = 'Male-Skewing 18-34';
      } else if (genre == 'Romance' || genre == 'Drama') {
        targetQuadrant = 'Female-Skewing';
      } else if (genre == 'Horror') {
        targetQuadrant = 'Young Adult 16-30';
      } else {
        targetQuadrant = 'General Adult';
      }
    }
    
    // Release window recommendation
    String releaseWindow;
    if (genre == 'Horror') {
      releaseWindow = 'October (Halloween) or January (dump month genre success)';
    } else if (genre == 'Action' || genre == 'Sci-Fi') {
      releaseWindow = 'Summer (May-July) or Holiday (November-December)';
    } else if (genre == 'Drama') {
      releaseWindow = 'Fall (September-November) for awards season';
    } else if (genre == 'Comedy') {
      releaseWindow = 'Summer or Holiday counter-programming';
    } else if (genre == 'Romance') {
      releaseWindow = 'February (Valentine\'s) or Summer counter-programming';
    } else {
      releaseWindow = 'Flexible - quality-dependent release';
    }
    
    // Competing projects (simulated based on genre)
    final competingProjects = _getCompetingProjects(genre, format);
    
    // Differentiation strategy
    String differentiationStrategy;
    if (topComparables.isNotEmpty) {
      final topComp = topComparables.first;
      if (topComp.similarity.overallScore > 70) {
        differentiationStrategy = 'HIGH SIMILARITY WARNING: Emphasize unique elements to avoid comparison fatigue';
      } else {
        differentiationStrategy = 'Position as fresh take on genre with distinct voice';
      }
    } else {
      differentiationStrategy = 'Unique concept - lean into originality as selling point';
    }
    
    // Crowdedness score
    int crowdednessScore;
    if (genre == 'Superhero' || genre == 'Action') {
      crowdednessScore = 85;
    } else if (genre == 'Horror' || genre == 'Thriller') {
      crowdednessScore = 70;
    } else if (genre == 'Drama') {
      crowdednessScore = 50;
    } else if (genre == 'Romance') {
      crowdednessScore = 40;
    } else {
      crowdednessScore = 55;
    }
    
    return MarketPositioning(
      competitiveSpace: competitiveSpace,
      targetQuadrant: targetQuadrant,
      releaseWindowRecommendation: releaseWindow,
      competingProjects: competingProjects,
      differentiationStrategy: differentiationStrategy,
      crowdednessScore: crowdednessScore,
    );
  }
  
  List<String> _getCompetingProjects(String genre, String format) {
    // Real 2024-2025 projects in development (sample)
    final projectsByGenre = {
      'Horror': [
        'A Quiet Place: Day One sequel',
        'Untitled Blumhouse horror',
        'The Black Phone 2',
        'New Conjuring universe film',
      ],
      'Thriller': [
        'Untitled David Fincher project',
        'New Knives Out sequel',
        'Various Netflix thriller acquisitions',
      ],
      'Action': [
        'John Wick: Ballerina',
        'Mission: Impossible 8',
        'Multiple superhero releases',
      ],
      'Drama': [
        'Various A24 prestige projects',
        'Searchlight awards contenders',
        'Limited series adaptations',
      ],
      'Comedy': [
        'Various Netflix comedy films',
        'Studio comedy projects',
      ],
      'Sci-Fi': [
        'Dune 3',
        'Various streaming sci-fi series',
        'New franchise attempts',
      ],
    };
    
    return projectsByGenre[genre] ?? ['Various genre projects in development'];
  }
}
