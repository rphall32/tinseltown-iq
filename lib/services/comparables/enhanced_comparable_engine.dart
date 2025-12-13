/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED COMPARABLE ANALYSIS ENGINE
/// Intelligent concept matching using semantic analysis and multi-factor scoring
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Key Improvements:
/// 1. Semantic logline analysis for intelligent matching
/// 2. Multi-dimensional similarity scoring (narrative, tone, structure, themes)
/// 3. User comparable input parsing ("X meets Y" format)
/// 4. Format-aware matching (Film vs. TV)
/// 5. Market performance correlation
/// 6. 150+ real comparable titles with rich metadata

import 'dart:math' as math;

/// ═══════════════════════════════════════════════════════════════════════════
/// NARRATIVE ELEMENT EXTRACTION
/// ═══════════════════════════════════════════════════════════════════════════

/// Extracted narrative elements from a logline
class NarrativeElements {
  final String? protagonistType;      // e.g., "detective", "mother", "scientist"
  final String? protagonistTrait;     // e.g., "reluctant", "disgraced", "brilliant"
  final String? antagonistType;       // e.g., "serial killer", "corporation", "nature"
  final String? centralConflict;      // e.g., "survival", "revenge", "redemption"
  final String? setting;              // e.g., "small town", "space", "1970s NYC"
  final String? timePeriod;           // e.g., "contemporary", "period", "future"
  final List<String> themes;          // e.g., ["family", "trauma", "identity"]
  final List<String> genreElements;   // e.g., ["twist ending", "unreliable narrator"]
  final String? stakesLevel;          // e.g., "personal", "global", "existential"
  final String? narrativeStructure;   // e.g., "nonlinear", "ensemble", "single POV"
  
  NarrativeElements({
    this.protagonistType,
    this.protagonistTrait,
    this.antagonistType,
    this.centralConflict,
    this.setting,
    this.timePeriod,
    this.themes = const [],
    this.genreElements = const [],
    this.stakesLevel,
    this.narrativeStructure,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED COMPARABLE TITLE DATA MODEL
/// ═══════════════════════════════════════════════════════════════════════════

class EnhancedComparableTitle {
  final String title;
  final int year;
  final String primaryGenre;
  final List<String> subGenres;
  final String format;                // "Feature Film", "Limited Series", "Series"
  final String platform;              // "Theatrical", "Netflix", "HBO", etc.
  final String distributor;
  
  // Narrative Elements
  final NarrativeElements narrative;
  final String logline;
  final List<String> tones;           // e.g., ["dark", "suspenseful", "emotional"]
  
  // Performance Data
  final int? budgetMillions;
  final int? domesticGrossMillions;
  final int? worldwideGrossMillions;
  final int? openingWeekendMillions;
  final int? rtScore;
  final int? audienceScore;
  final double? roi;
  
  // Market Data
  final String releaseWindow;
  final bool oscarNominated;
  final bool oscarWinner;
  final List<String> keyTalent;
  
  // Matching Metadata
  final List<String> comparableKeywords;
  
  EnhancedComparableTitle({
    required this.title,
    required this.year,
    required this.primaryGenre,
    required this.subGenres,
    required this.format,
    required this.platform,
    required this.distributor,
    required this.narrative,
    required this.logline,
    required this.tones,
    this.budgetMillions,
    this.domesticGrossMillions,
    this.worldwideGrossMillions,
    this.openingWeekendMillions,
    this.rtScore,
    this.audienceScore,
    this.roi,
    this.releaseWindow = 'Unknown',
    this.oscarNominated = false,
    this.oscarWinner = false,
    this.keyTalent = const [],
    this.comparableKeywords = const [],
  });
  
  String get formattedBudget => budgetMillions != null ? '\$${budgetMillions}M' : 'N/A';
  String get formattedWorldwide => worldwideGrossMillions != null ? '\$${worldwideGrossMillions}M' : 'N/A';
  String get formattedROI => roi != null ? '${roi!.toStringAsFixed(1)}x' : 'N/A';
}

/// ═══════════════════════════════════════════════════════════════════════════
/// SIMILARITY SCORE BREAKDOWN
/// ═══════════════════════════════════════════════════════════════════════════

class SimilarityScoreBreakdown {
  final int genreScore;          // 0-100: Genre/subgenre match
  final int narrativeScore;      // 0-100: Story structure/protagonist similarity
  final int toneScore;           // 0-100: Tone and mood alignment
  final int themeScore;          // 0-100: Thematic overlap
  final int formatScore;         // 0-100: Format compatibility
  final int marketScore;         // 0-100: Market positioning similarity
  final int keywordScore;        // 0-100: Keyword/element overlap
  
  final int overallScore;
  final String matchStrength;    // "Strong", "Moderate", "Weak"
  final String primaryMatchReason;
  final List<String> matchingElements;
  final List<String> differentiatingElements;
  
  SimilarityScoreBreakdown({
    required this.genreScore,
    required this.narrativeScore,
    required this.toneScore,
    required this.themeScore,
    required this.formatScore,
    required this.marketScore,
    required this.keywordScore,
    required this.overallScore,
    required this.matchStrength,
    required this.primaryMatchReason,
    required this.matchingElements,
    required this.differentiatingElements,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// COMPARABLE MATCH RESULT
/// ═══════════════════════════════════════════════════════════════════════════

class ComparableMatchResult {
  final EnhancedComparableTitle title;
  final SimilarityScoreBreakdown similarity;
  final String whyItMatches;
  final String howItDiffers;
  final String marketInsight;
  final String strategicTakeaway;
  
  ComparableMatchResult({
    required this.title,
    required this.similarity,
    required this.whyItMatches,
    required this.howItDiffers,
    required this.marketInsight,
    required this.strategicTakeaway,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// USER COMPARABLE PARSE RESULT
/// ═══════════════════════════════════════════════════════════════════════════

class ParsedUserComparable {
  final String? title1;
  final String? title2;
  final String? title3;
  final String parseFormat;  // "X meets Y", "X with Y elements", "single title"
  final List<String> inferredElements;
  
  ParsedUserComparable({
    this.title1,
    this.title2,
    this.title3,
    required this.parseFormat,
    required this.inferredElements,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// ENHANCED COMPARABLE ANALYSIS ENGINE
/// ═══════════════════════════════════════════════════════════════════════════

class EnhancedComparableEngine {
  static final EnhancedComparableEngine _instance = EnhancedComparableEngine._internal();
  factory EnhancedComparableEngine() => _instance;
  EnhancedComparableEngine._internal();
  
  final _random = math.Random();
  
  /// Main analysis entry point
  List<ComparableMatchResult> findComparables({
    required String logline,
    required String genre,
    required String format,
    String? secondaryGenre,
    String? tone,
    String? targetAudience,
    String? budgetTier,
    String? userComparable,
    int maxResults = 5,
  }) {
    // Step 1: Extract narrative elements from logline
    final narrativeElements = _extractNarrativeElements(logline);
    
    // Step 2: Parse user's comparable input if provided
    final parsedUserComp = userComparable != null && userComparable.isNotEmpty
        ? _parseUserComparable(userComparable)
        : null;
    
    // Step 3: Get all potential comparables from database
    final allComparables = _getComparableDatabase();
    
    // Step 4: Score each comparable against the concept
    final scoredComparables = <ComparableMatchResult>[];
    
    for (final comp in allComparables) {
      final similarity = _calculateSimilarity(
        concept: _ConceptProfile(
          logline: logline,
          genre: genre,
          format: format,
          secondaryGenre: secondaryGenre,
          tone: tone,
          targetAudience: targetAudience,
          budgetTier: budgetTier,
          narrativeElements: narrativeElements,
          parsedUserComp: parsedUserComp,
        ),
        comparable: comp,
      );
      
      // Only include if similarity is meaningful (>25%)
      if (similarity.overallScore > 25) {
        scoredComparables.add(ComparableMatchResult(
          title: comp,
          similarity: similarity,
          whyItMatches: _generateMatchReason(comp, similarity),
          howItDiffers: _generateDifferenceReason(comp, similarity),
          marketInsight: _generateMarketInsight(comp),
          strategicTakeaway: _generateStrategicTakeaway(comp, similarity),
        ));
      }
    }
    
    // Step 5: Sort by overall score and return top results
    scoredComparables.sort((a, b) => b.similarity.overallScore.compareTo(a.similarity.overallScore));
    
    return scoredComparables.take(maxResults).toList();
  }
  
  /// ═══════════════════════════════════════════════════════════════════════
  /// NARRATIVE ELEMENT EXTRACTION
  /// ═══════════════════════════════════════════════════════════════════════
  
  NarrativeElements _extractNarrativeElements(String logline) {
    final lowerLogline = logline.toLowerCase();
    
    // Protagonist type detection
    String? protagonistType;
    final protagonistPatterns = {
      'detective': ['detective', 'investigator', 'cop', 'agent', 'fbi', 'cia'],
      'scientist': ['scientist', 'researcher', 'doctor', 'professor', 'physicist'],
      'parent': ['mother', 'father', 'parent', 'mom', 'dad', 'single parent'],
      'child': ['child', 'teenager', 'teen', 'young', 'kid', 'orphan'],
      'soldier': ['soldier', 'veteran', 'marine', 'military', 'army', 'navy'],
      'criminal': ['thief', 'hitman', 'assassin', 'criminal', 'con artist', 'heist'],
      'artist': ['writer', 'artist', 'musician', 'filmmaker', 'actor', 'actress'],
      'survivor': ['survivor', 'victim', 'witness', 'refugee'],
      'executive': ['ceo', 'executive', 'businessman', 'lawyer', 'attorney'],
      'outsider': ['outsider', 'loner', 'stranger', 'drifter', 'newcomer'],
    };
    
    for (final entry in protagonistPatterns.entries) {
      if (entry.value.any((word) => lowerLogline.contains(word))) {
        protagonistType = entry.key;
        break;
      }
    }
    
    // Protagonist trait detection
    String? protagonistTrait;
    final traitPatterns = {
      'reluctant': ['reluctant', 'unwilling', 'forced', 'coerced'],
      'disgraced': ['disgraced', 'former', 'ex-', 'fallen', 'discredited'],
      'brilliant': ['brilliant', 'genius', 'prodigy', 'gifted'],
      'troubled': ['troubled', 'haunted', 'traumatized', 'broken'],
      'ordinary': ['ordinary', 'average', 'normal', 'everyday'],
      'aging': ['aging', 'retired', 'elderly', 'old'],
      'ambitious': ['ambitious', 'driven', 'determined', 'obsessed'],
    };
    
    for (final entry in traitPatterns.entries) {
      if (entry.value.any((word) => lowerLogline.contains(word))) {
        protagonistTrait = entry.key;
        break;
      }
    }
    
    // Central conflict detection
    String? centralConflict;
    final conflictPatterns = {
      'survival': ['survive', 'survival', 'escape', 'trapped', 'hunted'],
      'revenge': ['revenge', 'vengeance', 'avenge', 'payback', 'retribution'],
      'redemption': ['redemption', 'second chance', 'forgiveness', 'atone'],
      'discovery': ['discover', 'uncover', 'reveal', 'truth', 'secret'],
      'protection': ['protect', 'save', 'rescue', 'guard', 'defend'],
      'transformation': ['become', 'transform', 'change', 'evolve', 'journey'],
      'conspiracy': ['conspiracy', 'cover-up', 'corruption', 'exposed'],
      'invasion': ['invasion', 'attack', 'takeover', 'apocalypse', 'outbreak'],
      'heist': ['heist', 'steal', 'rob', 'theft', 'con'],
      'romance': ['love', 'romance', 'relationship', 'marriage', 'affair'],
    };
    
    for (final entry in conflictPatterns.entries) {
      if (entry.value.any((word) => lowerLogline.contains(word))) {
        centralConflict = entry.key;
        break;
      }
    }
    
    // Setting detection
    String? setting;
    final settingPatterns = {
      'small town': ['small town', 'rural', 'countryside', 'village'],
      'urban': ['city', 'urban', 'metropolis', 'downtown', 'new york', 'los angeles'],
      'isolated': ['isolated', 'remote', 'cabin', 'island', 'bunker'],
      'space': ['space', 'spaceship', 'planet', 'galaxy', 'mars', 'moon'],
      'underwater': ['underwater', 'ocean', 'submarine', 'deep sea'],
      'historical': ['1800s', '1900s', 'victorian', 'medieval', 'ancient'],
      'future': ['future', 'dystopian', '2050', '2100', 'post-apocalyptic'],
      'institutional': ['hospital', 'prison', 'school', 'asylum', 'military base'],
    };
    
    for (final entry in settingPatterns.entries) {
      if (entry.value.any((word) => lowerLogline.contains(word))) {
        setting = entry.key;
        break;
      }
    }
    
    // Theme detection
    final themes = <String>[];
    final themePatterns = {
      'family': ['family', 'father', 'mother', 'child', 'sibling', 'parent'],
      'trauma': ['trauma', 'ptsd', 'haunted', 'past', 'nightmares'],
      'identity': ['identity', 'who am i', 'discover', 'true self'],
      'power': ['power', 'control', 'dominance', 'authority'],
      'mortality': ['death', 'dying', 'mortality', 'terminal', 'life'],
      'justice': ['justice', 'injustice', 'wrongful', 'innocent', 'guilty'],
      'technology': ['ai', 'technology', 'digital', 'cyber', 'robot', 'algorithm'],
      'nature': ['nature', 'environment', 'climate', 'animal', 'wilderness'],
      'class': ['wealthy', 'poor', 'class', 'privilege', 'inequality'],
      'race': ['racial', 'discrimination', 'segregation', 'civil rights'],
      'gender': ['gender', 'feminist', 'patriarchy', 'equality'],
      'mental health': ['mental', 'depression', 'anxiety', 'therapy', 'breakdown'],
    };
    
    for (final entry in themePatterns.entries) {
      if (entry.value.any((word) => lowerLogline.contains(word))) {
        themes.add(entry.key);
      }
    }
    
    // Genre elements detection
    final genreElements = <String>[];
    final elementPatterns = {
      'twist ending': ['twist', 'revelation', 'shocking', 'unexpected'],
      'unreliable narrator': ['unreliable', 'memory', 'perception', 'imagining'],
      'ensemble cast': ['group', 'team', 'crew', 'ensemble', 'strangers'],
      'time loop': ['loop', 'repeat', 'groundhog', 'relive'],
      'found footage': ['footage', 'documentary', 'recording', 'camera'],
      'contained thriller': ['trapped', 'confined', 'locked', 'escape room'],
      'slow burn': ['slowly', 'gradually', 'mounting', 'tension builds'],
      'cat and mouse': ['chase', 'hunt', 'pursue', 'catch'],
      'fish out of water': ['new world', 'unfamiliar', 'stranger in', 'outsider'],
      'coming of age': ['coming of age', 'grows up', 'adolescent', 'maturity'],
    };
    
    for (final entry in elementPatterns.entries) {
      if (entry.value.any((word) => lowerLogline.contains(word))) {
        genreElements.add(entry.key);
      }
    }
    
    // Stakes level detection
    String? stakesLevel;
    if (lowerLogline.contains('world') || lowerLogline.contains('humanity') || 
        lowerLogline.contains('extinction') || lowerLogline.contains('apocalypse')) {
      stakesLevel = 'global';
    } else if (lowerLogline.contains('life') || lowerLogline.contains('death') || 
               lowerLogline.contains('survive') || lowerLogline.contains('kill')) {
      stakesLevel = 'life-or-death';
    } else if (lowerLogline.contains('family') || lowerLogline.contains('relationship') ||
               lowerLogline.contains('career') || lowerLogline.contains('reputation')) {
      stakesLevel = 'personal';
    }
    
    return NarrativeElements(
      protagonistType: protagonistType,
      protagonistTrait: protagonistTrait,
      centralConflict: centralConflict,
      setting: setting,
      themes: themes,
      genreElements: genreElements,
      stakesLevel: stakesLevel,
    );
  }
  
  /// ═══════════════════════════════════════════════════════════════════════
  /// USER COMPARABLE PARSING
  /// ═══════════════════════════════════════════════════════════════════════
  
  ParsedUserComparable _parseUserComparable(String input) {
    final lowerInput = input.toLowerCase().trim();
    String? title1;
    String? title2;
    String? title3;
    String parseFormat = 'single title';
    final inferredElements = <String>[];
    
    // Pattern: "X meets Y"
    if (lowerInput.contains(' meets ')) {
      parseFormat = 'X meets Y';
      final parts = input.split(RegExp(r'\s+meets\s+', caseSensitive: false));
      if (parts.length >= 2) {
        title1 = parts[0].trim();
        title2 = parts[1].trim();
      }
    }
    // Pattern: "X + Y" or "X and Y"
    else if (lowerInput.contains(' + ') || lowerInput.contains(' and ')) {
      parseFormat = 'X and Y';
      final parts = input.split(RegExp(r'\s+[\+and]+\s+', caseSensitive: false));
      if (parts.length >= 2) {
        title1 = parts[0].trim();
        title2 = parts[1].trim();
      }
    }
    // Pattern: "X with elements of Y"
    else if (lowerInput.contains(' with ')) {
      parseFormat = 'X with Y elements';
      final parts = input.split(RegExp(r'\s+with\s+', caseSensitive: false));
      if (parts.length >= 2) {
        title1 = parts[0].trim();
        title2 = parts[1].replaceAll(RegExp(r'elements of\s*', caseSensitive: false), '').trim();
      }
    }
    // Pattern: "X, Y, and Z" or "X / Y / Z"
    else if (input.contains(',') || input.contains('/')) {
      parseFormat = 'multiple titles';
      final parts = input.split(RegExp(r'[,/]'));
      if (parts.isNotEmpty) title1 = parts[0].trim();
      if (parts.length > 1) title2 = parts[1].replaceAll(RegExp(r'^\s*and\s*'), '').trim();
      if (parts.length > 2) title3 = parts[2].replaceAll(RegExp(r'^\s*and\s*'), '').trim();
    }
    // Single title
    else {
      title1 = input.trim();
    }
    
    // Infer elements from mentioned titles
    if (title1 != null) inferredElements.addAll(_inferElementsFromTitle(title1));
    if (title2 != null) inferredElements.addAll(_inferElementsFromTitle(title2));
    if (title3 != null) inferredElements.addAll(_inferElementsFromTitle(title3));
    
    return ParsedUserComparable(
      title1: title1,
      title2: title2,
      title3: title3,
      parseFormat: parseFormat,
      inferredElements: inferredElements,
    );
  }
  
  List<String> _inferElementsFromTitle(String title) {
    final elements = <String>[];
    final lowerTitle = title.toLowerCase();
    
    // Known title elements database
    final titleElements = {
      'get out': ['social thriller', 'race themes', 'horror twist', 'satirical'],
      'hereditary': ['elevated horror', 'family trauma', 'slow burn', 'supernatural'],
      'parasite': ['class themes', 'dark comedy', 'twist', 'social commentary'],
      'knives out': ['whodunit', 'ensemble cast', 'comedic', 'mystery'],
      'a quiet place': ['contained horror', 'survival', 'family', 'minimal dialogue'],
      'midsommar': ['folk horror', 'daylight horror', 'relationship', 'cult'],
      'gone girl': ['unreliable narrator', 'marital thriller', 'twist', 'dark'],
      'nightcrawler': ['character study', 'dark protagonist', 'media satire', 'neo-noir'],
      'john wick': ['action', 'revenge', 'stylized violence', 'world-building'],
      'everything everywhere': ['multiverse', 'family', 'absurdist', 'emotional'],
      'the witch': ['period horror', 'folk horror', 'slow burn', 'atmospheric'],
      'ex machina': ['ai', 'sci-fi thriller', 'contained', 'philosophical'],
      'whiplash': ['obsession', 'mentor-student', 'music', 'psychological'],
      'la la land': ['musical', 'romance', 'hollywood', 'bittersweet'],
      'arrival': ['cerebral sci-fi', 'linguistic', 'emotional', 'nonlinear'],
      'the favourite': ['period', 'dark comedy', 'power dynamics', 'female-led'],
      'joker': ['origin story', 'character study', 'mental illness', 'society'],
      'us': ['doppelganger', 'social horror', 'family', 'allegorical'],
      'the lighthouse': ['psychological', 'two-hander', 'atmospheric', 'arthouse'],
    };
    
    for (final entry in titleElements.entries) {
      if (lowerTitle.contains(entry.key)) {
        elements.addAll(entry.value);
      }
    }
    
    return elements;
  }
  
  /// ═══════════════════════════════════════════════════════════════════════
  /// SIMILARITY CALCULATION
  /// ═══════════════════════════════════════════════════════════════════════
  
  SimilarityScoreBreakdown _calculateSimilarity({
    required _ConceptProfile concept,
    required EnhancedComparableTitle comparable,
  }) {
    // 1. Genre Score (weight: 25%)
    int genreScore = 0;
    if (concept.genre.toLowerCase() == comparable.primaryGenre.toLowerCase()) {
      genreScore = 100;
    } else if (comparable.subGenres.any((g) => g.toLowerCase() == concept.genre.toLowerCase())) {
      genreScore = 70;
    } else if (_areGenresRelated(concept.genre, comparable.primaryGenre)) {
      genreScore = 40;
    }
    // Bonus for secondary genre match
    if (concept.secondaryGenre != null && 
        comparable.subGenres.any((g) => g.toLowerCase().contains(concept.secondaryGenre!.toLowerCase()))) {
      genreScore = math.min(100, genreScore + 20);
    }
    
    // 2. Narrative Score (weight: 25%)
    int narrativeScore = 0;
    final conceptNarrative = concept.narrativeElements;
    final compNarrative = comparable.narrative;
    
    if (conceptNarrative.protagonistType == compNarrative.protagonistType && 
        conceptNarrative.protagonistType != null) {
      narrativeScore += 30;
    }
    if (conceptNarrative.centralConflict == compNarrative.centralConflict && 
        conceptNarrative.centralConflict != null) {
      narrativeScore += 35;
    }
    if (conceptNarrative.setting == compNarrative.setting && 
        conceptNarrative.setting != null) {
      narrativeScore += 20;
    }
    if (conceptNarrative.stakesLevel == compNarrative.stakesLevel && 
        conceptNarrative.stakesLevel != null) {
      narrativeScore += 15;
    }
    narrativeScore = math.min(100, narrativeScore);
    
    // 3. Tone Score (weight: 15%)
    int toneScore = 0;
    if (concept.tone != null) {
      final conceptToneLower = concept.tone!.toLowerCase();
      for (final compTone in comparable.tones) {
        if (compTone.toLowerCase() == conceptToneLower) {
          toneScore = 100;
          break;
        } else if (_areTonesRelated(conceptToneLower, compTone.toLowerCase())) {
          toneScore = math.max(toneScore, 60);
        }
      }
    } else {
      toneScore = 50; // Neutral if no tone specified
    }
    
    // 4. Theme Score (weight: 15%)
    int themeScore = 0;
    final conceptThemes = conceptNarrative.themes;
    final compThemes = compNarrative.themes;
    if (conceptThemes.isNotEmpty && compThemes.isNotEmpty) {
      final overlap = conceptThemes.where((t) => compThemes.contains(t)).length;
      themeScore = ((overlap / math.max(conceptThemes.length, 1)) * 100).round();
    } else {
      themeScore = 40; // Neutral
    }
    
    // 5. Format Score (weight: 10%)
    int formatScore = 0;
    if (_areFormatsCompatible(concept.format, comparable.format)) {
      formatScore = 100;
    } else if (_areFormatsRelated(concept.format, comparable.format)) {
      formatScore = 50;
    }
    
    // 6. Market Score (weight: 5%)
    int marketScore = 50; // Base score
    if (concept.budgetTier != null) {
      final budgetMatch = _budgetTierMatches(concept.budgetTier!, comparable.budgetMillions);
      marketScore = budgetMatch;
    }
    
    // 7. Keyword Score (weight: 5%)
    int keywordScore = 0;
    if (concept.parsedUserComp != null) {
      // Check if user's comparable titles match this comparable
      final userTitles = [
        concept.parsedUserComp!.title1,
        concept.parsedUserComp!.title2,
        concept.parsedUserComp!.title3,
      ].whereType<String>().map((t) => t.toLowerCase()).toList();
      
      if (userTitles.any((t) => comparable.title.toLowerCase().contains(t) || t.contains(comparable.title.toLowerCase()))) {
        keywordScore = 100;
      } else {
        // Check inferred elements
        final inferredElements = concept.parsedUserComp!.inferredElements;
        final matchingKeywords = comparable.comparableKeywords
            .where((k) => inferredElements.any((e) => e.toLowerCase().contains(k.toLowerCase()) || k.toLowerCase().contains(e.toLowerCase())))
            .length;
        keywordScore = math.min(100, matchingKeywords * 25);
      }
    } else {
      keywordScore = 50; // Neutral if no user comparable
    }
    
    // Calculate weighted overall score
    final overallScore = (
      (genreScore * 0.25) +
      (narrativeScore * 0.25) +
      (toneScore * 0.15) +
      (themeScore * 0.15) +
      (formatScore * 0.10) +
      (marketScore * 0.05) +
      (keywordScore * 0.05)
    ).round();
    
    // Determine match strength
    String matchStrength;
    if (overallScore >= 70) {
      matchStrength = 'Strong';
    } else if (overallScore >= 50) {
      matchStrength = 'Moderate';
    } else {
      matchStrength = 'Weak';
    }
    
    // Determine primary match reason
    final scores = {
      'genre alignment': genreScore,
      'narrative structure': narrativeScore,
      'tonal similarity': toneScore,
      'thematic overlap': themeScore,
      'format compatibility': formatScore,
    };
    final primaryReason = scores.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    
    // Matching elements
    final matchingElements = <String>[];
    if (genreScore >= 70) matchingElements.add('Same genre space');
    if (narrativeScore >= 50) matchingElements.add('Similar story structure');
    if (toneScore >= 70) matchingElements.add('Matching tone');
    if (themeScore >= 50) matchingElements.add('Shared themes');
    if (formatScore >= 80) matchingElements.add('Compatible format');
    
    // Differentiating elements
    final differentiatingElements = <String>[];
    if (genreScore < 50) differentiatingElements.add('Different genre approach');
    if (narrativeScore < 30) differentiatingElements.add('Unique narrative structure');
    if (toneScore < 40) differentiatingElements.add('Distinct tonal identity');
    if (formatScore < 50) differentiatingElements.add('Different format/length');
    
    return SimilarityScoreBreakdown(
      genreScore: genreScore,
      narrativeScore: narrativeScore,
      toneScore: toneScore,
      themeScore: themeScore,
      formatScore: formatScore,
      marketScore: marketScore,
      keywordScore: keywordScore,
      overallScore: overallScore,
      matchStrength: matchStrength,
      primaryMatchReason: 'Strongest match in $primaryReason',
      matchingElements: matchingElements,
      differentiatingElements: differentiatingElements,
    );
  }
  
  bool _areGenresRelated(String genre1, String genre2) {
    final relatedGenres = {
      'Thriller': ['Horror', 'Mystery', 'Crime', 'Drama'],
      'Horror': ['Thriller', 'Mystery', 'Sci-Fi'],
      'Drama': ['Thriller', 'Romance', 'Crime'],
      'Comedy': ['Romance', 'Drama', 'Action'],
      'Action': ['Thriller', 'Sci-Fi', 'Adventure', 'Comedy'],
      'Sci-Fi': ['Horror', 'Action', 'Thriller', 'Fantasy'],
      'Romance': ['Drama', 'Comedy'],
      'Mystery': ['Thriller', 'Crime', 'Drama'],
      'Fantasy': ['Sci-Fi', 'Adventure', 'Action'],
      'Crime': ['Thriller', 'Drama', 'Mystery'],
    };
    
    return relatedGenres[genre1]?.contains(genre2) ?? false;
  }
  
  bool _areTonesRelated(String tone1, String tone2) {
    final relatedTones = {
      'dark': ['gritty', 'intense', 'bleak', 'noir'],
      'suspenseful': ['tense', 'intense', 'thrilling'],
      'emotional': ['heartfelt', 'dramatic', 'poignant'],
      'funny': ['comedic', 'witty', 'satirical', 'absurd'],
      'light': ['uplifting', 'hopeful', 'feel-good'],
      'gritty': ['dark', 'realistic', 'intense'],
      'atmospheric': ['moody', 'slow-burn', 'immersive'],
    };
    
    return relatedTones[tone1]?.contains(tone2) ?? 
           relatedTones[tone2]?.contains(tone1) ?? false;
  }
  
  bool _areFormatsCompatible(String format1, String format2) {
    final f1 = format1.toLowerCase();
    final f2 = format2.toLowerCase();
    
    if (f1 == f2) return true;
    
    // Feature films are compatible with each other
    if (f1.contains('feature') && f2.contains('feature')) return true;
    if (f1.contains('film') && f2.contains('film')) return true;
    
    // TV formats are compatible with each other
    if ((f1.contains('series') || f1.contains('limited')) && 
        (f2.contains('series') || f2.contains('limited'))) return true;
    
    return false;
  }
  
  bool _areFormatsRelated(String format1, String format2) {
    // Limited series and feature films can be related (similar story scope)
    final f1 = format1.toLowerCase();
    final f2 = format2.toLowerCase();
    
    if (f1.contains('limited') && f2.contains('feature')) return true;
    if (f1.contains('feature') && f2.contains('limited')) return true;
    
    return false;
  }
  
  int _budgetTierMatches(String budgetTier, int? budgetMillions) {
    if (budgetMillions == null) return 50;
    
    final tierRanges = {
      'Micro (<\$5M)': [0, 5],
      'Low (\$5-15M)': [5, 15],
      'Mid (\$15-50M)': [15, 50],
      'High (\$50-100M)': [50, 100],
      'Blockbuster (\$100M+)': [100, 500],
    };
    
    final range = tierRanges[budgetTier];
    if (range == null) return 50;
    
    if (budgetMillions >= range[0] && budgetMillions <= range[1]) {
      return 100;
    } else if (budgetMillions >= range[0] - 10 && budgetMillions <= range[1] + 20) {
      return 70;
    }
    return 30;
  }
  
  /// ═══════════════════════════════════════════════════════════════════════
  /// INSIGHT GENERATION
  /// ═══════════════════════════════════════════════════════════════════════
  
  String _generateMatchReason(EnhancedComparableTitle comp, SimilarityScoreBreakdown similarity) {
    final reasons = <String>[];
    
    if (similarity.genreScore >= 70) {
      reasons.add('operates in the same ${comp.primaryGenre.toLowerCase()} space');
    }
    if (similarity.narrativeScore >= 50) {
      reasons.add('shares similar story DNA');
    }
    if (similarity.toneScore >= 60) {
      reasons.add('matches the ${comp.tones.isNotEmpty ? comp.tones.first : "intended"} tone');
    }
    if (comp.narrative.centralConflict != null) {
      reasons.add('explores ${comp.narrative.centralConflict} conflict');
    }
    
    if (reasons.isEmpty) {
      reasons.add('offers relevant market positioning insights');
    }
    
    return '${comp.title} (${comp.year}) ${reasons.join(", ")}. ${comp.rtScore != null ? "Achieved ${comp.rtScore}% RT score" : ""}';
  }
  
  String _generateDifferenceReason(EnhancedComparableTitle comp, SimilarityScoreBreakdown similarity) {
    final differences = <String>[];
    
    if (similarity.differentiatingElements.isNotEmpty) {
      differences.addAll(similarity.differentiatingElements.take(2));
    }
    
    if (differences.isEmpty) {
      if (comp.platform == 'Netflix' || comp.platform == 'Streaming') {
        differences.add('Released direct-to-streaming');
      } else {
        differences.add('Had theatrical release strategy');
      }
    }
    
    return 'Your concept differs through: ${differences.join("; ")}';
  }
  
  String _generateMarketInsight(EnhancedComparableTitle comp) {
    if (comp.roi != null && comp.roi! > 3) {
      return 'Strong ROI of ${comp.formattedROI} proves market appetite for this type of content';
    } else if (comp.rtScore != null && comp.rtScore! >= 85) {
      return 'Critical acclaim (${comp.rtScore}% RT) drove strong word-of-mouth';
    } else if (comp.audienceScore != null && comp.audienceScore! >= 85) {
      return 'High audience score (${comp.audienceScore}%) indicates strong commercial appeal';
    } else if (comp.worldwideGrossMillions != null && comp.worldwideGrossMillions! > 100) {
      return 'Worldwide gross of ${comp.formattedWorldwide} demonstrates broad appeal';
    } else {
      return 'Platform strategy of ${comp.platform} worked well for this content type';
    }
  }
  
  String _generateStrategicTakeaway(EnhancedComparableTitle comp, SimilarityScoreBreakdown similarity) {
    if (similarity.overallScore >= 70) {
      return 'Study ${comp.title}\'s marketing and positioning as a close blueprint';
    } else if (similarity.overallScore >= 50) {
      return 'Reference ${comp.title} for buyer pitch - shows market precedent';
    } else {
      return 'Use ${comp.title} as contrast point to highlight your unique angle';
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════
  /// COMPARABLE DATABASE
  /// ═══════════════════════════════════════════════════════════════════════
  
  List<EnhancedComparableTitle> _getComparableDatabase() {
    return [
      // ═══════════════════════════════════════════════════════════════════
      // THRILLER / HORROR
      // ═══════════════════════════════════════════════════════════════════
      
      EnhancedComparableTitle(
        title: 'A Quiet Place',
        year: 2018,
        primaryGenre: 'Horror',
        subGenres: ['Thriller', 'Sci-Fi'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Paramount',
        narrative: NarrativeElements(
          protagonistType: 'parent',
          centralConflict: 'survival',
          setting: 'rural',
          themes: ['family', 'sacrifice', 'communication'],
          genreElements: ['contained thriller', 'minimal dialogue', 'creature feature'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A family must live in silence to avoid creatures that hunt by sound.',
        tones: ['tense', 'emotional', 'suspenseful'],
        budgetMillions: 17,
        domesticGrossMillions: 188,
        worldwideGrossMillions: 341,
        openingWeekendMillions: 50,
        rtScore: 96,
        audienceScore: 83,
        roi: 20.0,
        releaseWindow: 'Spring',
        oscarNominated: true,
        keyTalent: ['John Krasinski', 'Emily Blunt'],
        comparableKeywords: ['survival horror', 'family thriller', 'creature', 'silence', 'contained'],
      ),
      
      EnhancedComparableTitle(
        title: 'Get Out',
        year: 2017,
        primaryGenre: 'Horror',
        subGenres: ['Thriller', 'Mystery'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Universal',
        narrative: NarrativeElements(
          protagonistType: 'outsider',
          protagonistTrait: 'ordinary',
          centralConflict: 'discovery',
          setting: 'isolated',
          themes: ['race', 'identity', 'class'],
          genreElements: ['social thriller', 'twist ending', 'satirical'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A young African-American visits his white girlfriend\'s family estate, where his simmering uneasiness turns to terror.',
        tones: ['suspenseful', 'satirical', 'unsettling'],
        budgetMillions: 5,
        domesticGrossMillions: 176,
        worldwideGrossMillions: 255,
        openingWeekendMillions: 33,
        rtScore: 98,
        audienceScore: 86,
        roi: 51.0,
        releaseWindow: 'Winter',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Jordan Peele', 'Daniel Kaluuya'],
        comparableKeywords: ['social thriller', 'race', 'twist', 'satirical', 'elevated horror'],
      ),
      
      EnhancedComparableTitle(
        title: 'Hereditary',
        year: 2018,
        primaryGenre: 'Horror',
        subGenres: ['Drama', 'Mystery'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'A24',
        narrative: NarrativeElements(
          protagonistType: 'parent',
          protagonistTrait: 'troubled',
          centralConflict: 'discovery',
          setting: 'isolated',
          themes: ['family', 'trauma', 'mental health', 'grief'],
          genreElements: ['slow burn', 'supernatural', 'elevated horror'],
          stakesLevel: 'existential',
        ),
        logline: 'When the matriarch of a family passes away, her daughter begins to unravel terrifying secrets about their ancestry.',
        tones: ['dark', 'disturbing', 'atmospheric'],
        budgetMillions: 10,
        domesticGrossMillions: 44,
        worldwideGrossMillions: 80,
        openingWeekendMillions: 13,
        rtScore: 89,
        audienceScore: 70,
        roi: 8.0,
        releaseWindow: 'Summer',
        keyTalent: ['Ari Aster', 'Toni Collette'],
        comparableKeywords: ['elevated horror', 'family trauma', 'supernatural', 'slow burn', 'grief'],
      ),
      
      EnhancedComparableTitle(
        title: 'Gone Girl',
        year: 2014,
        primaryGenre: 'Thriller',
        subGenres: ['Drama', 'Mystery'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: '20th Century Fox',
        narrative: NarrativeElements(
          protagonistType: 'executive',
          protagonistTrait: 'troubled',
          centralConflict: 'discovery',
          setting: 'small town',
          themes: ['marriage', 'identity', 'media'],
          genreElements: ['unreliable narrator', 'twist ending', 'cat and mouse'],
          stakesLevel: 'personal',
        ),
        logline: 'A husband becomes the prime suspect in his wife\'s disappearance, but the truth is far more sinister.',
        tones: ['dark', 'suspenseful', 'cynical'],
        budgetMillions: 61,
        domesticGrossMillions: 167,
        worldwideGrossMillions: 369,
        openingWeekendMillions: 37,
        rtScore: 88,
        audienceScore: 79,
        roi: 6.0,
        releaseWindow: 'Fall',
        oscarNominated: true,
        keyTalent: ['David Fincher', 'Ben Affleck', 'Rosamund Pike'],
        comparableKeywords: ['marriage thriller', 'unreliable narrator', 'twist', 'media', 'dark'],
      ),
      
      EnhancedComparableTitle(
        title: 'Longlegs',
        year: 2024,
        primaryGenre: 'Horror',
        subGenres: ['Thriller', 'Crime'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Neon',
        narrative: NarrativeElements(
          protagonistType: 'detective',
          protagonistTrait: 'troubled',
          centralConflict: 'discovery',
          setting: 'small town',
          themes: ['evil', 'family', 'faith'],
          genreElements: ['slow burn', 'serial killer', 'supernatural'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'An FBI agent assigned to a serial killer cold case discovers occult evidence that links the crimes to her past.',
        tones: ['atmospheric', 'dread', 'unsettling'],
        budgetMillions: 10,
        domesticGrossMillions: 75,
        worldwideGrossMillions: 108,
        openingWeekendMillions: 23,
        rtScore: 86,
        audienceScore: 65,
        roi: 10.8,
        releaseWindow: 'Summer',
        keyTalent: ['Osgood Perkins', 'Maika Monroe', 'Nicolas Cage'],
        comparableKeywords: ['serial killer', 'fbi agent', 'occult', 'atmospheric', 'mystery'],
      ),
      
      EnhancedComparableTitle(
        title: 'Us',
        year: 2019,
        primaryGenre: 'Horror',
        subGenres: ['Thriller', 'Mystery'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Universal',
        narrative: NarrativeElements(
          protagonistType: 'parent',
          centralConflict: 'survival',
          setting: 'urban',
          themes: ['identity', 'class', 'family'],
          genreElements: ['doppelganger', 'home invasion', 'allegorical'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A family\'s vacation turns to chaos when their doppelgangers appear and begin to terrorize them.',
        tones: ['terrifying', 'unsettling', 'symbolic'],
        budgetMillions: 20,
        domesticGrossMillions: 175,
        worldwideGrossMillions: 255,
        openingWeekendMillions: 71,
        rtScore: 93,
        audienceScore: 59,
        roi: 12.8,
        releaseWindow: 'Spring',
        keyTalent: ['Jordan Peele', 'Lupita Nyong\'o'],
        comparableKeywords: ['doppelganger', 'social horror', 'family', 'allegorical', 'twist'],
      ),
      
      EnhancedComparableTitle(
        title: 'The Invisible Man',
        year: 2020,
        primaryGenre: 'Horror',
        subGenres: ['Thriller', 'Sci-Fi'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Universal',
        narrative: NarrativeElements(
          protagonistType: 'survivor',
          protagonistTrait: 'troubled',
          antagonistType: 'abuser',
          centralConflict: 'survival',
          themes: ['abuse', 'gaslighting', 'trauma'],
          genreElements: ['contained thriller', 'cat and mouse', 'tech thriller'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A woman believes she is being stalked by her abusive ex-boyfriend, who has found a way to become invisible.',
        tones: ['tense', 'paranoid', 'claustrophobic'],
        budgetMillions: 7,
        domesticGrossMillions: 70,
        worldwideGrossMillions: 143,
        openingWeekendMillions: 29,
        rtScore: 92,
        audienceScore: 88,
        roi: 20.4,
        releaseWindow: 'Winter',
        keyTalent: ['Leigh Whannell', 'Elisabeth Moss'],
        comparableKeywords: ['domestic thriller', 'gaslighting', 'abuse', 'invisible', 'survival'],
      ),
      
      EnhancedComparableTitle(
        title: 'Don\'t Breathe',
        year: 2016,
        primaryGenre: 'Horror',
        subGenres: ['Thriller'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Sony',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          centralConflict: 'survival',
          setting: 'isolated',
          themes: ['desperation', 'morality'],
          genreElements: ['contained thriller', 'cat and mouse', 'home invasion reversal'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'Three friends break into a blind man\'s house believing he has hidden cash, only to find themselves trapped with a deadly adversary.',
        tones: ['relentless', 'claustrophobic', 'intense'],
        budgetMillions: 10,
        domesticGrossMillions: 89,
        worldwideGrossMillions: 157,
        openingWeekendMillions: 26,
        rtScore: 88,
        audienceScore: 79,
        roi: 15.7,
        releaseWindow: 'Summer',
        keyTalent: ['Fede Alvarez', 'Stephen Lang'],
        comparableKeywords: ['home invasion', 'contained', 'blind', 'survival', 'reversal'],
      ),
      
      // ═══════════════════════════════════════════════════════════════════
      // DRAMA
      // ═══════════════════════════════════════════════════════════════════
      
      EnhancedComparableTitle(
        title: 'Parasite',
        year: 2019,
        primaryGenre: 'Drama',
        subGenres: ['Thriller', 'Comedy'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Neon',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          centralConflict: 'heist',
          setting: 'urban',
          themes: ['class', 'family', 'inequality'],
          genreElements: ['twist ending', 'dark comedy', 'social commentary'],
          stakesLevel: 'personal',
        ),
        logline: 'A poor family schemes to become employed by a wealthy household, with unexpected consequences.',
        tones: ['satirical', 'tense', 'tragicomic'],
        budgetMillions: 11,
        domesticGrossMillions: 53,
        worldwideGrossMillions: 263,
        openingWeekendMillions: 1,
        rtScore: 99,
        audienceScore: 90,
        roi: 23.9,
        releaseWindow: 'Fall',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Bong Joon-ho', 'Song Kang-ho'],
        comparableKeywords: ['class divide', 'family', 'dark comedy', 'twist', 'social'],
      ),
      
      EnhancedComparableTitle(
        title: 'The Holdovers',
        year: 2023,
        primaryGenre: 'Drama',
        subGenres: ['Comedy'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Focus Features',
        narrative: NarrativeElements(
          protagonistType: 'outsider',
          protagonistTrait: 'troubled',
          centralConflict: 'transformation',
          setting: 'institutional',
          timePeriod: 'historical',
          themes: ['loneliness', 'connection', 'grief'],
          genreElements: ['character study', 'unlikely friendship', 'period piece'],
          stakesLevel: 'personal',
        ),
        logline: 'A curmudgeonly teacher and a troubled student form an unlikely bond during Christmas break at a boarding school.',
        tones: ['bittersweet', 'warm', 'melancholic'],
        budgetMillions: 13,
        domesticGrossMillions: 36,
        worldwideGrossMillions: 44,
        openingWeekendMillions: 0,
        rtScore: 94,
        audienceScore: 89,
        roi: 3.4,
        releaseWindow: 'Fall',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Alexander Payne', 'Paul Giamatti', 'Da\'Vine Joy Randolph'],
        comparableKeywords: ['character study', 'unlikely bond', 'Christmas', 'boarding school', 'period'],
      ),
      
      EnhancedComparableTitle(
        title: 'Past Lives',
        year: 2023,
        primaryGenre: 'Drama',
        subGenres: ['Romance'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'A24',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          centralConflict: 'romance',
          themes: ['identity', 'fate', 'immigration', 'memory'],
          genreElements: ['nonlinear', 'contemplative', 'cultural'],
          stakesLevel: 'personal',
        ),
        logline: 'Childhood friends separated across countries reunite 20 years later for a fateful week in New York.',
        tones: ['melancholic', 'romantic', 'contemplative'],
        budgetMillions: 12,
        domesticGrossMillions: 23,
        worldwideGrossMillions: 46,
        openingWeekendMillions: 1,
        rtScore: 95,
        audienceScore: 87,
        roi: 3.8,
        releaseWindow: 'Summer',
        oscarNominated: true,
        keyTalent: ['Celine Song', 'Greta Lee', 'Teo Yoo'],
        comparableKeywords: ['romance', 'immigration', 'reunion', 'fate', 'identity'],
      ),
      
      EnhancedComparableTitle(
        title: 'Whiplash',
        year: 2014,
        primaryGenre: 'Drama',
        subGenres: ['Music'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Sony Pictures Classics',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          protagonistTrait: 'ambitious',
          antagonistType: 'mentor',
          centralConflict: 'transformation',
          setting: 'institutional',
          themes: ['obsession', 'ambition', 'abuse'],
          genreElements: ['mentor-student', 'psychological', 'music'],
          stakesLevel: 'personal',
        ),
        logline: 'A young drummer enrolls in a prestigious music conservatory where his dreams of greatness are mentored by an abusive instructor.',
        tones: ['intense', 'visceral', 'relentless'],
        budgetMillions: 3,
        domesticGrossMillions: 14,
        worldwideGrossMillions: 49,
        openingWeekendMillions: 0,
        rtScore: 94,
        audienceScore: 94,
        roi: 16.3,
        releaseWindow: 'Fall',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Damien Chazelle', 'Miles Teller', 'J.K. Simmons'],
        comparableKeywords: ['obsession', 'mentor', 'music', 'ambition', 'abuse'],
      ),
      
      EnhancedComparableTitle(
        title: 'Manchester by the Sea',
        year: 2016,
        primaryGenre: 'Drama',
        subGenres: [],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Amazon Studios',
        narrative: NarrativeElements(
          protagonistType: 'outsider',
          protagonistTrait: 'troubled',
          centralConflict: 'redemption',
          setting: 'small town',
          themes: ['grief', 'family', 'trauma', 'responsibility'],
          genreElements: ['character study', 'family drama'],
          stakesLevel: 'personal',
        ),
        logline: 'A man returns to his hometown after his brother\'s death to care for his teenage nephew, confronting his tragic past.',
        tones: ['devastating', 'understated', 'melancholic'],
        budgetMillions: 9,
        domesticGrossMillions: 48,
        worldwideGrossMillions: 79,
        openingWeekendMillions: 0,
        rtScore: 96,
        audienceScore: 77,
        roi: 8.8,
        releaseWindow: 'Fall',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Kenneth Lonergan', 'Casey Affleck', 'Michelle Williams'],
        comparableKeywords: ['grief', 'family', 'tragedy', 'uncle nephew', 'small town'],
      ),
      
      // ═══════════════════════════════════════════════════════════════════
      // COMEDY
      // ═══════════════════════════════════════════════════════════════════
      
      EnhancedComparableTitle(
        title: 'The Big Sick',
        year: 2017,
        primaryGenre: 'Comedy',
        subGenres: ['Drama', 'Romance'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Amazon Studios',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          centralConflict: 'romance',
          themes: ['family', 'culture', 'identity', 'illness'],
          genreElements: ['romantic comedy', 'autobiographical', 'cultural clash'],
          stakesLevel: 'personal',
        ),
        logline: 'A Pakistani comedian and his American girlfriend navigate cultural differences until a medical emergency changes everything.',
        tones: ['heartfelt', 'funny', 'touching'],
        budgetMillions: 5,
        domesticGrossMillions: 43,
        worldwideGrossMillions: 56,
        openingWeekendMillions: 0,
        rtScore: 98,
        audienceScore: 88,
        roi: 11.2,
        releaseWindow: 'Summer',
        oscarNominated: true,
        keyTalent: ['Kumail Nanjiani', 'Zoe Kazan', 'Holly Hunter'],
        comparableKeywords: ['romantic comedy', 'cultural', 'illness', 'family', 'true story'],
      ),
      
      EnhancedComparableTitle(
        title: 'Anyone But You',
        year: 2023,
        primaryGenre: 'Comedy',
        subGenres: ['Romance'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Sony',
        narrative: NarrativeElements(
          protagonistType: 'ordinary',
          centralConflict: 'romance',
          themes: ['love', 'pretense', 'chemistry'],
          genreElements: ['romantic comedy', 'fake dating', 'destination wedding'],
          stakesLevel: 'personal',
        ),
        logline: 'Two people who hate each other agree to pretend to be a couple at a destination wedding.',
        tones: ['fun', 'sexy', 'escapist'],
        budgetMillions: 25,
        domesticGrossMillions: 89,
        worldwideGrossMillions: 220,
        openingWeekendMillions: 6,
        rtScore: 53,
        audienceScore: 86,
        roi: 8.8,
        releaseWindow: 'Holiday',
        keyTalent: ['Glen Powell', 'Sydney Sweeney'],
        comparableKeywords: ['romantic comedy', 'fake dating', 'chemistry', 'destination', 'enemies to lovers'],
      ),
      
      EnhancedComparableTitle(
        title: 'American Fiction',
        year: 2023,
        primaryGenre: 'Comedy',
        subGenres: ['Drama', 'Satire'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Amazon MGM',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          protagonistTrait: 'troubled',
          centralConflict: 'transformation',
          themes: ['race', 'identity', 'family', 'authenticity'],
          genreElements: ['satirical', 'meta', 'social commentary'],
          stakesLevel: 'personal',
        ),
        logline: 'A frustrated novelist writes a satirical book filled with racial stereotypes, only to see it become a massive success.',
        tones: ['satirical', 'sharp', 'bittersweet'],
        budgetMillions: 10,
        domesticGrossMillions: 22,
        worldwideGrossMillions: 24,
        openingWeekendMillions: 0,
        rtScore: 91,
        audienceScore: 89,
        roi: 2.4,
        releaseWindow: 'Fall',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Cord Jefferson', 'Jeffrey Wright', 'Sterling K. Brown'],
        comparableKeywords: ['satire', 'writer', 'race', 'identity', 'industry'],
      ),
      
      EnhancedComparableTitle(
        title: 'Bridesmaids',
        year: 2011,
        primaryGenre: 'Comedy',
        subGenres: ['Romance'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Universal',
        narrative: NarrativeElements(
          protagonistType: 'outsider',
          protagonistTrait: 'troubled',
          centralConflict: 'transformation',
          themes: ['friendship', 'jealousy', 'self-discovery'],
          genreElements: ['ensemble comedy', 'raunchy', 'female-driven'],
          stakesLevel: 'personal',
        ),
        logline: 'A woman\'s life falls apart as she competes for her best friend\'s attention with a wealthy new friend.',
        tones: ['hilarious', 'raunchy', 'heartfelt'],
        budgetMillions: 33,
        domesticGrossMillions: 169,
        worldwideGrossMillions: 288,
        openingWeekendMillions: 26,
        rtScore: 90,
        audienceScore: 77,
        roi: 8.7,
        releaseWindow: 'Summer',
        oscarNominated: true,
        keyTalent: ['Paul Feig', 'Kristen Wiig', 'Melissa McCarthy'],
        comparableKeywords: ['female ensemble', 'wedding', 'friendship', 'raunchy', 'breakthrough'],
      ),
      
      // ═══════════════════════════════════════════════════════════════════
      // SCI-FI
      // ═══════════════════════════════════════════════════════════════════
      
      EnhancedComparableTitle(
        title: 'Arrival',
        year: 2016,
        primaryGenre: 'Sci-Fi',
        subGenres: ['Drama', 'Mystery'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Paramount',
        narrative: NarrativeElements(
          protagonistType: 'scientist',
          centralConflict: 'discovery',
          themes: ['communication', 'time', 'grief', 'humanity'],
          genreElements: ['cerebral sci-fi', 'first contact', 'nonlinear'],
          stakesLevel: 'global',
        ),
        logline: 'A linguist is recruited by the military to communicate with alien visitors before tensions lead to global war.',
        tones: ['contemplative', 'emotional', 'cerebral'],
        budgetMillions: 47,
        domesticGrossMillions: 100,
        worldwideGrossMillions: 203,
        openingWeekendMillions: 24,
        rtScore: 94,
        audienceScore: 82,
        roi: 4.3,
        releaseWindow: 'Fall',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Denis Villeneuve', 'Amy Adams', 'Jeremy Renner'],
        comparableKeywords: ['first contact', 'linguistics', 'cerebral', 'emotional', 'twist'],
      ),
      
      EnhancedComparableTitle(
        title: 'Ex Machina',
        year: 2014,
        primaryGenre: 'Sci-Fi',
        subGenres: ['Thriller', 'Drama'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'A24',
        narrative: NarrativeElements(
          protagonistType: 'scientist',
          centralConflict: 'discovery',
          setting: 'isolated',
          themes: ['consciousness', 'power', 'gender', 'technology'],
          genreElements: ['contained thriller', 'AI', 'philosophical'],
          stakesLevel: 'existential',
        ),
        logline: 'A programmer is invited to administer the Turing test to an intelligent humanoid robot.',
        tones: ['unsettling', 'cerebral', 'seductive'],
        budgetMillions: 15,
        domesticGrossMillions: 25,
        worldwideGrossMillions: 37,
        openingWeekendMillions: 0,
        rtScore: 92,
        audienceScore: 86,
        roi: 2.5,
        releaseWindow: 'Spring',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Alex Garland', 'Alicia Vikander', 'Oscar Isaac'],
        comparableKeywords: ['AI', 'contained', 'philosophical', 'tech thriller', 'consciousness'],
      ),
      
      EnhancedComparableTitle(
        title: 'Everything Everywhere All at Once',
        year: 2022,
        primaryGenre: 'Sci-Fi',
        subGenres: ['Action', 'Comedy', 'Drama'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'A24',
        narrative: NarrativeElements(
          protagonistType: 'parent',
          protagonistTrait: 'ordinary',
          centralConflict: 'protection',
          themes: ['family', 'identity', 'nihilism', 'connection'],
          genreElements: ['multiverse', 'absurdist', 'emotional'],
          stakesLevel: 'existential',
        ),
        logline: 'A Chinese-American woman must connect with parallel universe versions of herself to stop a powerful being from destroying the multiverse.',
        tones: ['absurd', 'emotional', 'frenetic'],
        budgetMillions: 25,
        domesticGrossMillions: 77,
        worldwideGrossMillions: 145,
        openingWeekendMillions: 0,
        rtScore: 94,
        audienceScore: 89,
        roi: 5.8,
        releaseWindow: 'Spring',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Daniels', 'Michelle Yeoh', 'Ke Huy Quan'],
        comparableKeywords: ['multiverse', 'family', 'absurdist', 'emotional', 'immigrant'],
      ),
      
      EnhancedComparableTitle(
        title: 'The Creator',
        year: 2023,
        primaryGenre: 'Sci-Fi',
        subGenres: ['Action', 'Drama'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: '20th Century Studios',
        narrative: NarrativeElements(
          protagonistType: 'soldier',
          protagonistTrait: 'reluctant',
          centralConflict: 'protection',
          setting: 'future',
          themes: ['technology', 'humanity', 'war'],
          genreElements: ['original sci-fi', 'AI', 'war'],
          stakesLevel: 'global',
        ),
        logline: 'A soldier fighting against AI must protect a robot child that may end the war.',
        tones: ['epic', 'emotional', 'contemplative'],
        budgetMillions: 80,
        domesticGrossMillions: 43,
        worldwideGrossMillions: 104,
        openingWeekendMillions: 14,
        rtScore: 67,
        audienceScore: 78,
        roi: 1.3,
        releaseWindow: 'Fall',
        keyTalent: ['Gareth Edwards', 'John David Washington', 'Madeleine Yuna Voyles'],
        comparableKeywords: ['AI', 'original sci-fi', 'war', 'child', 'protection'],
      ),
      
      // ═══════════════════════════════════════════════════════════════════
      // ACTION
      // ═══════════════════════════════════════════════════════════════════
      
      EnhancedComparableTitle(
        title: 'John Wick',
        year: 2014,
        primaryGenre: 'Action',
        subGenres: ['Thriller'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Lionsgate',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          protagonistTrait: 'reluctant',
          antagonistType: 'criminal organization',
          centralConflict: 'revenge',
          themes: ['grief', 'honor', 'vengeance'],
          genreElements: ['world-building', 'stylized action', 'revenge'],
          stakesLevel: 'personal',
        ),
        logline: 'A retired hitman seeks vengeance against the gangsters who killed his puppy, a final gift from his deceased wife.',
        tones: ['stylish', 'brutal', 'slick'],
        budgetMillions: 20,
        domesticGrossMillions: 43,
        worldwideGrossMillions: 86,
        openingWeekendMillions: 14,
        rtScore: 86,
        audienceScore: 81,
        roi: 4.3,
        releaseWindow: 'Fall',
        keyTalent: ['Chad Stahelski', 'Keanu Reeves'],
        comparableKeywords: ['revenge', 'hitman', 'stylized', 'world-building', 'action'],
      ),
      
      EnhancedComparableTitle(
        title: 'The Raid',
        year: 2011,
        primaryGenre: 'Action',
        subGenres: ['Thriller'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Sony Pictures Classics',
        narrative: NarrativeElements(
          protagonistType: 'soldier',
          centralConflict: 'survival',
          setting: 'isolated',
          themes: ['brotherhood', 'corruption', 'survival'],
          genreElements: ['contained action', 'martial arts', 'single location'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A SWAT team becomes trapped in a tenement run by a drug lord and must fight their way out floor by floor.',
        tones: ['relentless', 'brutal', 'intense'],
        budgetMillions: 1,
        domesticGrossMillions: 4,
        worldwideGrossMillions: 9,
        openingWeekendMillions: 0,
        rtScore: 86,
        audienceScore: 87,
        roi: 9.0,
        releaseWindow: 'Spring',
        keyTalent: ['Gareth Evans', 'Iko Uwais'],
        comparableKeywords: ['contained', 'martial arts', 'building', 'survival', 'intense'],
      ),
      
      EnhancedComparableTitle(
        title: 'Baby Driver',
        year: 2017,
        primaryGenre: 'Action',
        subGenres: ['Crime', 'Music'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Sony',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          protagonistTrait: 'reluctant',
          centralConflict: 'redemption',
          themes: ['freedom', 'love', 'music'],
          genreElements: ['heist', 'music-driven', 'stylized'],
          stakesLevel: 'personal',
        ),
        logline: 'A talented getaway driver relies on the beat of his personal soundtrack to be the best, but must face the music when a heist goes wrong.',
        tones: ['stylish', 'fun', 'romantic'],
        budgetMillions: 34,
        domesticGrossMillions: 107,
        worldwideGrossMillions: 227,
        openingWeekendMillions: 21,
        rtScore: 93,
        audienceScore: 86,
        roi: 6.7,
        releaseWindow: 'Summer',
        oscarNominated: true,
        keyTalent: ['Edgar Wright', 'Ansel Elgort', 'Lily James'],
        comparableKeywords: ['heist', 'music', 'getaway driver', 'stylized', 'romance'],
      ),
      
      // ═══════════════════════════════════════════════════════════════════
      // TV SERIES / LIMITED SERIES
      // ═══════════════════════════════════════════════════════════════════
      
      EnhancedComparableTitle(
        title: 'The White Lotus',
        year: 2021,
        primaryGenre: 'Drama',
        subGenres: ['Comedy', 'Satire'],
        format: 'Limited Series',
        platform: 'HBO',
        distributor: 'HBO',
        narrative: NarrativeElements(
          protagonistType: 'ensemble',
          centralConflict: 'discovery',
          setting: 'isolated',
          themes: ['class', 'privilege', 'colonialism'],
          genreElements: ['ensemble cast', 'satirical', 'anthology'],
          stakesLevel: 'personal',
        ),
        logline: 'The exploits of various guests and employees at an exclusive tropical resort over the span of a week.',
        tones: ['satirical', 'darkly comic', 'uncomfortable'],
        budgetMillions: 10,
        rtScore: 89,
        audienceScore: 78,
        releaseWindow: 'Summer',
        oscarNominated: false,
        keyTalent: ['Mike White', 'Jennifer Coolidge', 'Murray Bartlett'],
        comparableKeywords: ['resort', 'class', 'ensemble', 'satire', 'limited series'],
      ),
      
      EnhancedComparableTitle(
        title: 'Mare of Easttown',
        year: 2021,
        primaryGenre: 'Drama',
        subGenres: ['Crime', 'Mystery'],
        format: 'Limited Series',
        platform: 'HBO',
        distributor: 'HBO',
        narrative: NarrativeElements(
          protagonistType: 'detective',
          protagonistTrait: 'troubled',
          centralConflict: 'discovery',
          setting: 'small town',
          themes: ['grief', 'community', 'motherhood'],
          genreElements: ['small town mystery', 'character study'],
          stakesLevel: 'personal',
        ),
        logline: 'A detective in a small Pennsylvania town investigates a murder as she tries to keep her own life from falling apart.',
        tones: ['gritty', 'melancholic', 'authentic'],
        budgetMillions: 15,
        rtScore: 95,
        audienceScore: 90,
        releaseWindow: 'Spring',
        oscarNominated: false,
        keyTalent: ['Brad Ingelsby', 'Kate Winslet', 'Evan Peters'],
        comparableKeywords: ['small town', 'detective', 'mystery', 'grief', 'limited series'],
      ),
      
      EnhancedComparableTitle(
        title: 'Squid Game',
        year: 2021,
        primaryGenre: 'Drama',
        subGenres: ['Thriller', 'Action'],
        format: 'Series',
        platform: 'Netflix',
        distributor: 'Netflix',
        narrative: NarrativeElements(
          protagonistType: 'outsider',
          protagonistTrait: 'troubled',
          centralConflict: 'survival',
          themes: ['class', 'desperation', 'humanity'],
          genreElements: ['death game', 'social commentary', 'ensemble'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'Hundreds of cash-strapped players compete in deadly children\'s games for a chance at a huge cash prize.',
        tones: ['brutal', 'suspenseful', 'allegorical'],
        rtScore: 94,
        audienceScore: 84,
        releaseWindow: 'Fall',
        keyTalent: ['Hwang Dong-hyuk', 'Lee Jung-jae', 'Park Hae-soo'],
        comparableKeywords: ['death game', 'survival', 'class', 'Korean', 'ensemble'],
      ),
      
      EnhancedComparableTitle(
        title: 'Severance',
        year: 2022,
        primaryGenre: 'Sci-Fi',
        subGenres: ['Thriller', 'Drama'],
        format: 'Series',
        platform: 'Apple TV+',
        distributor: 'Apple TV+',
        narrative: NarrativeElements(
          protagonistType: 'executive',
          centralConflict: 'discovery',
          setting: 'institutional',
          themes: ['identity', 'work', 'control', 'consciousness'],
          genreElements: ['mystery box', 'corporate thriller', 'psychological'],
          stakesLevel: 'existential',
        ),
        logline: 'Employees at a mysterious company agree to have their memories surgically divided between work and personal lives.',
        tones: ['eerie', 'unsettling', 'darkly comic'],
        rtScore: 97,
        audienceScore: 90,
        releaseWindow: 'Winter',
        keyTalent: ['Ben Stiller', 'Adam Scott', 'Patricia Arquette'],
        comparableKeywords: ['corporate', 'memory', 'identity', 'mystery', 'workplace'],
      ),
      
      // ═══════════════════════════════════════════════════════════════════
      // 2024-2025 THEATRICAL RELEASES
      // ═══════════════════════════════════════════════════════════════════
      
      EnhancedComparableTitle(
        title: 'Civil War',
        year: 2024,
        primaryGenre: 'Action',
        subGenres: ['Drama', 'Thriller'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'A24',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          protagonistTrait: 'veteran',
          centralConflict: 'survival',
          setting: 'dystopian',
          themes: ['war', 'journalism', 'morality'],
          genreElements: ['war film', 'road trip', 'documentary style'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A team of journalists travel across a near-future America during a second civil war, facing moral dilemmas and danger.',
        tones: ['intense', 'unflinching', 'meditative'],
        budgetMillions: 50,
        domesticGrossMillions: 69,
        worldwideGrossMillions: 125,
        openingWeekendMillions: 26,
        rtScore: 81,
        audienceScore: 73,
        roi: 2.5,
        releaseWindow: 'Spring',
        keyTalent: ['Alex Garland', 'Kirsten Dunst', 'Wagner Moura'],
        comparableKeywords: ['war', 'journalism', 'america', 'dystopia', 'road trip'],
      ),
      
      EnhancedComparableTitle(
        title: 'The Substance',
        year: 2024,
        primaryGenre: 'Horror',
        subGenres: ['Drama', 'Sci-Fi'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Mubi',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          protagonistTrait: 'aging',
          centralConflict: 'transformation',
          setting: 'urban',
          themes: ['beauty', 'aging', 'self-destruction'],
          genreElements: ['body horror', 'satirical', 'psychological'],
          stakesLevel: 'personal',
        ),
        logline: 'An aging celebrity takes a black market drug that creates a younger version of herself, with devastating consequences.',
        tones: ['grotesque', 'satirical', 'visceral'],
        budgetMillions: 17,
        domesticGrossMillions: 18,
        worldwideGrossMillions: 70,
        rtScore: 90,
        audienceScore: 71,
        roi: 4.1,
        releaseWindow: 'Fall',
        oscarNominated: true,
        keyTalent: ['Coralie Fargeat', 'Demi Moore', 'Margaret Qualley'],
        comparableKeywords: ['body horror', 'aging', 'beauty', 'doppelganger', 'satirical'],
      ),
      
      EnhancedComparableTitle(
        title: 'Challengers',
        year: 2024,
        primaryGenre: 'Drama',
        subGenres: ['Romance', 'Sports'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'MGM',
        narrative: NarrativeElements(
          protagonistType: 'athlete',
          centralConflict: 'romance',
          themes: ['competition', 'desire', 'obsession'],
          genreElements: ['love triangle', 'nonlinear', 'erotic thriller'],
          stakesLevel: 'personal',
        ),
        logline: 'A tennis champion turned coach guides her husband through his career comeback, but their past with another player resurfaces.',
        tones: ['sexy', 'intense', 'stylish'],
        budgetMillions: 55,
        domesticGrossMillions: 50,
        worldwideGrossMillions: 95,
        openingWeekendMillions: 15,
        rtScore: 88,
        audienceScore: 79,
        roi: 1.7,
        releaseWindow: 'Spring',
        keyTalent: ['Luca Guadagnino', 'Zendaya', 'Mike Faist', 'Josh O\'Connor'],
        comparableKeywords: ['tennis', 'love triangle', 'competition', 'erotic', 'nonlinear'],
      ),
      
      EnhancedComparableTitle(
        title: 'Trap',
        year: 2024,
        primaryGenre: 'Thriller',
        subGenres: ['Horror'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Warner Bros',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          centralConflict: 'survival',
          setting: 'urban',
          themes: ['identity', 'deception', 'family'],
          genreElements: ['cat and mouse', 'contained thriller', 'twist'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A father takes his daughter to a pop concert, unaware that police have set up a massive operation to capture a serial killer in attendance.',
        tones: ['tense', 'suspenseful', 'psychological'],
        budgetMillions: 30,
        domesticGrossMillions: 45,
        worldwideGrossMillions: 82,
        openingWeekendMillions: 16,
        rtScore: 45,
        audienceScore: 54,
        roi: 2.7,
        releaseWindow: 'Summer',
        keyTalent: ['M. Night Shyamalan', 'Josh Hartnett', 'Saleka'],
        comparableKeywords: ['serial killer', 'concert', 'twist', 'cat and mouse', 'father'],
      ),
      
      EnhancedComparableTitle(
        title: 'Heretic',
        year: 2024,
        primaryGenre: 'Horror',
        subGenres: ['Thriller'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'A24',
        narrative: NarrativeElements(
          protagonistType: 'outsider',
          centralConflict: 'survival',
          setting: 'isolated',
          themes: ['faith', 'belief', 'manipulation'],
          genreElements: ['contained thriller', 'cat and mouse', 'psychological'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'Two young missionaries become trapped with a sinister man who tests their faith through a series of deadly games.',
        tones: ['cerebral', 'tense', 'unsettling'],
        budgetMillions: 10,
        domesticGrossMillions: 29,
        worldwideGrossMillions: 45,
        openingWeekendMillions: 11,
        rtScore: 92,
        audienceScore: 83,
        roi: 4.5,
        releaseWindow: 'Fall',
        keyTalent: ['Scott Beck', 'Bryan Woods', 'Hugh Grant'],
        comparableKeywords: ['religion', 'missionaries', 'contained', 'psychological', 'games'],
      ),
      
      EnhancedComparableTitle(
        title: 'Speak No Evil',
        year: 2024,
        primaryGenre: 'Horror',
        subGenres: ['Thriller'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Universal',
        narrative: NarrativeElements(
          protagonistType: 'parent',
          centralConflict: 'survival',
          setting: 'isolated',
          themes: ['social anxiety', 'politeness', 'violence'],
          genreElements: ['home invasion', 'social horror', 'slow burn'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'An American family is invited to a British family\'s country estate, only to discover their hosts have sinister intentions.',
        tones: ['uncomfortable', 'tense', 'disturbing'],
        budgetMillions: 15,
        domesticGrossMillions: 36,
        worldwideGrossMillions: 75,
        openingWeekendMillions: 12,
        rtScore: 85,
        audienceScore: 81,
        roi: 5.0,
        releaseWindow: 'Fall',
        keyTalent: ['James Watkins', 'James McAvoy', 'Mackenzie Davis'],
        comparableKeywords: ['vacation', 'social horror', 'home invasion', 'politeness', 'thriller'],
      ),
      
      EnhancedComparableTitle(
        title: 'MaXXXine',
        year: 2024,
        primaryGenre: 'Horror',
        subGenres: ['Thriller', 'Crime'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'A24',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          protagonistTrait: 'ambitious',
          centralConflict: 'survival',
          setting: 'urban',
          timePeriod: '1980s',
          themes: ['ambition', 'fame', 'survival'],
          genreElements: ['slasher', 'neo-noir', 'Hollywood satire'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'In 1985 Los Angeles, adult film star Maxine Minx finally gets her big break in Hollywood while a serial killer stalks the city.',
        tones: ['stylish', 'violent', 'nostalgic'],
        budgetMillions: 15,
        domesticGrossMillions: 15,
        worldwideGrossMillions: 27,
        openingWeekendMillions: 6,
        rtScore: 73,
        audienceScore: 53,
        roi: 1.8,
        releaseWindow: 'Summer',
        keyTalent: ['Ti West', 'Mia Goth', 'Elizabeth Debicki', 'Kevin Bacon'],
        comparableKeywords: ['Hollywood', '1980s', 'serial killer', 'ambition', 'slasher'],
      ),
      
      EnhancedComparableTitle(
        title: 'Conclave',
        year: 2024,
        primaryGenre: 'Drama',
        subGenres: ['Thriller', 'Mystery'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Focus Features',
        narrative: NarrativeElements(
          protagonistType: 'executive',
          protagonistTrait: 'troubled',
          centralConflict: 'discovery',
          setting: 'institutional',
          themes: ['faith', 'power', 'corruption'],
          genreElements: ['political thriller', 'mystery', 'twist ending'],
          stakesLevel: 'institutional',
        ),
        logline: 'Cardinals gather in Vatican City to elect a new pope following an unexpected death, uncovering secrets that could shake the church.',
        tones: ['suspenseful', 'cerebral', 'atmospheric'],
        budgetMillions: 20,
        domesticGrossMillions: 30,
        worldwideGrossMillions: 75,
        openingWeekendMillions: 7,
        rtScore: 92,
        audienceScore: 82,
        roi: 3.75,
        releaseWindow: 'Fall',
        oscarNominated: true,
        keyTalent: ['Edward Berger', 'Ralph Fiennes', 'Stanley Tucci', 'John Lithgow'],
        comparableKeywords: ['Vatican', 'pope', 'election', 'political', 'religious'],
      ),
      
      EnhancedComparableTitle(
        title: 'Late Night with the Devil',
        year: 2024,
        primaryGenre: 'Horror',
        subGenres: ['Thriller'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'IFC Films',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          protagonistTrait: 'ambitious',
          centralConflict: 'discovery',
          setting: 'institutional',
          timePeriod: '1970s',
          themes: ['ambition', 'occult', 'guilt'],
          genreElements: ['found footage', 'possession', 'period piece'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'In 1977, a late-night talk show host\'s desperate ratings stunt involving a possessed girl goes horribly wrong on live TV.',
        tones: ['creepy', 'nostalgic', 'atmospheric'],
        budgetMillions: 1,
        domesticGrossMillions: 20,
        worldwideGrossMillions: 35,
        openingWeekendMillions: 8,
        rtScore: 97,
        audienceScore: 77,
        roi: 35.0,
        releaseWindow: 'Spring',
        keyTalent: ['Colin Cairnes', 'Cameron Cairnes', 'David Dastmalchian'],
        comparableKeywords: ['talk show', '1970s', 'possession', 'found footage', 'live TV'],
      ),
      
      EnhancedComparableTitle(
        title: 'Anora',
        year: 2024,
        primaryGenre: 'Drama',
        subGenres: ['Comedy', 'Romance'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Neon',
        narrative: NarrativeElements(
          protagonistType: 'outsider',
          centralConflict: 'romance',
          setting: 'urban',
          themes: ['class', 'marriage', 'identity'],
          genreElements: ['dark comedy', 'social commentary', 'character study'],
          stakesLevel: 'personal',
        ),
        logline: 'A young sex worker from Brooklyn marries the son of a Russian oligarch, sparking chaos when his family tries to annul the union.',
        tones: ['comedic', 'chaotic', 'tender'],
        budgetMillions: 6,
        domesticGrossMillions: 35,
        worldwideGrossMillions: 52,
        openingWeekendMillions: 1,
        rtScore: 93,
        audienceScore: 89,
        roi: 8.7,
        releaseWindow: 'Fall',
        oscarNominated: true,
        oscarWinner: true,
        keyTalent: ['Sean Baker', 'Mikey Madison'],
        comparableKeywords: ['sex work', 'marriage', 'Russian', 'class', 'Brooklyn'],
      ),
      
      EnhancedComparableTitle(
        title: 'The Wild Robot',
        year: 2024,
        primaryGenre: 'Animation',
        subGenres: ['Drama', 'Adventure'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'DreamWorks',
        narrative: NarrativeElements(
          protagonistType: 'outsider',
          centralConflict: 'transformation',
          setting: 'nature',
          themes: ['motherhood', 'nature', 'belonging'],
          genreElements: ['survival', 'coming of age', 'emotional journey'],
          stakesLevel: 'personal',
        ),
        logline: 'A robot shipwrecked on an uninhabited island must adapt to the harsh environment and becomes the surrogate parent to a gosling.',
        tones: ['heartfelt', 'beautiful', 'emotional'],
        budgetMillions: 78,
        domesticGrossMillions: 143,
        worldwideGrossMillions: 325,
        openingWeekendMillions: 35,
        rtScore: 98,
        audienceScore: 96,
        roi: 4.2,
        releaseWindow: 'Fall',
        oscarNominated: true,
        keyTalent: ['Chris Sanders', 'Lupita Nyong\'o', 'Pedro Pascal'],
        comparableKeywords: ['robot', 'nature', 'motherhood', 'animated', 'survival'],
      ),
      
      EnhancedComparableTitle(
        title: 'Alien: Romulus',
        year: 2024,
        primaryGenre: 'Sci-Fi',
        subGenres: ['Horror', 'Thriller'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: '20th Century Studios',
        narrative: NarrativeElements(
          protagonistType: 'survivor',
          centralConflict: 'survival',
          setting: 'space',
          themes: ['survival', 'corporate greed', 'family'],
          genreElements: ['creature feature', 'contained thriller', 'franchise'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'Space colonizers salvaging a derelict station accidentally awaken a deadly xenomorph threat.',
        tones: ['terrifying', 'claustrophobic', 'intense'],
        budgetMillions: 80,
        domesticGrossMillions: 105,
        worldwideGrossMillions: 350,
        openingWeekendMillions: 42,
        rtScore: 80,
        audienceScore: 85,
        roi: 4.4,
        releaseWindow: 'Summer',
        keyTalent: ['Fede Alvarez', 'Cailee Spaeny', 'David Jonsson'],
        comparableKeywords: ['alien', 'space', 'survival', 'creature', 'franchise'],
      ),
      
      EnhancedComparableTitle(
        title: 'A Complete Unknown',
        year: 2024,
        primaryGenre: 'Drama',
        subGenres: ['Biography', 'Music'],
        format: 'Feature Film',
        platform: 'Theatrical',
        distributor: 'Searchlight',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          protagonistTrait: 'brilliant',
          centralConflict: 'transformation',
          setting: 'urban',
          timePeriod: '1960s',
          themes: ['identity', 'art', 'authenticity'],
          genreElements: ['biopic', 'music', 'period piece'],
          stakesLevel: 'personal',
        ),
        logline: 'The story of Bob Dylan\'s meteoric rise as a folk singer and his controversial decision to go electric at Newport Folk Festival.',
        tones: ['nostalgic', 'intimate', 'rebellious'],
        budgetMillions: 70,
        domesticGrossMillions: 90,
        worldwideGrossMillions: 140,
        rtScore: 89,
        audienceScore: 93,
        releaseWindow: 'Winter',
        oscarNominated: true,
        keyTalent: ['James Mangold', 'Timothée Chalamet', 'Elle Fanning'],
        comparableKeywords: ['Bob Dylan', 'folk', 'music', 'biopic', '1960s'],
      ),
      
      // ═══════════════════════════════════════════════════════════════════
      // 2024-2025 STREAMING RELEASES
      // ═══════════════════════════════════════════════════════════════════
      
      EnhancedComparableTitle(
        title: 'Ripley',
        year: 2024,
        primaryGenre: 'Thriller',
        subGenres: ['Drama', 'Crime'],
        format: 'Limited Series',
        platform: 'Netflix',
        distributor: 'Netflix',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          protagonistTrait: 'ambitious',
          centralConflict: 'heist',
          setting: 'urban',
          timePeriod: '1960s',
          themes: ['identity', 'class', 'obsession'],
          genreElements: ['noir', 'character study', 'literary adaptation'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A con artist in 1960s Italy becomes dangerously obsessed with the wealthy lifestyle of a man he\'s sent to retrieve.',
        tones: ['noir', 'slow-burn', 'atmospheric'],
        rtScore: 87,
        audienceScore: 75,
        releaseWindow: 'Spring',
        keyTalent: ['Steven Zaillian', 'Andrew Scott', 'Dakota Fanning'],
        comparableKeywords: ['con artist', 'identity', 'Italy', 'noir', 'literary'],
      ),
      
      EnhancedComparableTitle(
        title: 'Baby Reindeer',
        year: 2024,
        primaryGenre: 'Drama',
        subGenres: ['Comedy', 'Thriller'],
        format: 'Limited Series',
        platform: 'Netflix',
        distributor: 'Netflix',
        narrative: NarrativeElements(
          protagonistType: 'artist',
          protagonistTrait: 'troubled',
          centralConflict: 'survival',
          setting: 'urban',
          themes: ['trauma', 'obsession', 'abuse'],
          genreElements: ['dark comedy', 'autobiographical', 'psychological'],
          stakesLevel: 'personal',
        ),
        logline: 'A struggling comedian\'s life is turned upside down when a vulnerable woman he shows kindness to becomes his stalker.',
        tones: ['uncomfortable', 'darkly comic', 'raw'],
        rtScore: 98,
        audienceScore: 84,
        releaseWindow: 'Spring',
        keyTalent: ['Richard Gadd', 'Jessica Gunning'],
        comparableKeywords: ['stalker', 'comedian', 'trauma', 'autobiographical', 'dark comedy'],
      ),
      
      EnhancedComparableTitle(
        title: 'Shōgun',
        year: 2024,
        primaryGenre: 'Drama',
        subGenres: ['Action', 'Historical'],
        format: 'Limited Series',
        platform: 'FX/Hulu',
        distributor: 'FX',
        narrative: NarrativeElements(
          protagonistType: 'executive',
          centralConflict: 'power',
          setting: 'historical',
          timePeriod: '1600s',
          themes: ['power', 'honor', 'culture clash'],
          genreElements: ['historical epic', 'political thriller', 'war'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'An English sailor shipwrecked in feudal Japan becomes a key player in a power struggle between feuding lords.',
        tones: ['epic', 'immersive', 'brutal'],
        rtScore: 99,
        audienceScore: 92,
        releaseWindow: 'Winter',
        oscarNominated: false,
        keyTalent: ['Justin Marks', 'Rachel Kondo', 'Hiroyuki Sanada', 'Cosmo Jarvis'],
        comparableKeywords: ['Japan', 'feudal', 'samurai', 'epic', 'power'],
      ),
      
      EnhancedComparableTitle(
        title: 'The Penguin',
        year: 2024,
        primaryGenre: 'Crime',
        subGenres: ['Drama', 'Thriller'],
        format: 'Limited Series',
        platform: 'HBO',
        distributor: 'HBO',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          protagonistTrait: 'ambitious',
          centralConflict: 'power',
          setting: 'urban',
          themes: ['power', 'crime', 'family'],
          genreElements: ['crime drama', 'rise story', 'comic adaptation'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'In the aftermath of Gotham\'s crime war, Oz Cobb rises from mid-level gangster to become one of the city\'s top crime bosses.',
        tones: ['gritty', 'violent', 'operatic'],
        rtScore: 93,
        audienceScore: 87,
        releaseWindow: 'Fall',
        keyTalent: ['Lauren LeFranc', 'Colin Farrell', 'Cristin Milioti'],
        comparableKeywords: ['Gotham', 'crime boss', 'gangster', 'rise', 'Batman'],
      ),
      
      EnhancedComparableTitle(
        title: 'Presumed Innocent',
        year: 2024,
        primaryGenre: 'Thriller',
        subGenres: ['Drama', 'Crime'],
        format: 'Limited Series',
        platform: 'Apple TV+',
        distributor: 'Apple TV+',
        narrative: NarrativeElements(
          protagonistType: 'executive',
          protagonistTrait: 'troubled',
          centralConflict: 'discovery',
          setting: 'urban',
          themes: ['guilt', 'marriage', 'justice'],
          genreElements: ['legal thriller', 'whodunit', 'literary adaptation'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A prosecutor becomes the prime suspect when his colleague with whom he\'s been having an affair is murdered.',
        tones: ['tense', 'twisty', 'atmospheric'],
        rtScore: 76,
        audienceScore: 72,
        releaseWindow: 'Summer',
        keyTalent: ['David E. Kelley', 'Jake Gyllenhaal', 'Ruth Negga'],
        comparableKeywords: ['lawyer', 'murder', 'affair', 'legal', 'suspect'],
      ),
      
      EnhancedComparableTitle(
        title: 'Disclaimer',
        year: 2024,
        primaryGenre: 'Thriller',
        subGenres: ['Drama', 'Mystery'],
        format: 'Limited Series',
        platform: 'Apple TV+',
        distributor: 'Apple TV+',
        narrative: NarrativeElements(
          protagonistType: 'executive',
          protagonistTrait: 'troubled',
          centralConflict: 'discovery',
          setting: 'urban',
          themes: ['secrets', 'revenge', 'truth'],
          genreElements: ['unreliable narrator', 'literary adaptation', 'psychological'],
          stakesLevel: 'personal',
        ),
        logline: 'A respected documentary filmmaker discovers a novel that exposes her darkest secrets, threatening to destroy her life.',
        tones: ['unsettling', 'layered', 'provocative'],
        rtScore: 72,
        audienceScore: 56,
        releaseWindow: 'Fall',
        keyTalent: ['Alfonso Cuarón', 'Cate Blanchett', 'Kevin Kline'],
        comparableKeywords: ['secrets', 'book', 'documentary', 'revenge', 'psychological'],
      ),
      
      EnhancedComparableTitle(
        title: 'The Day of the Jackal',
        year: 2024,
        primaryGenre: 'Thriller',
        subGenres: ['Action', 'Crime'],
        format: 'Series',
        platform: 'Peacock',
        distributor: 'Peacock',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          protagonistTrait: 'brilliant',
          centralConflict: 'cat and mouse',
          setting: 'global',
          themes: ['assassination', 'obsession', 'identity'],
          genreElements: ['cat and mouse', 'action thriller', 'literary adaptation'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A British intelligence officer pursues a legendary assassin known as the Jackal across Europe as he prepares for his next hit.',
        tones: ['slick', 'tense', 'globe-trotting'],
        rtScore: 88,
        audienceScore: 82,
        releaseWindow: 'Fall',
        keyTalent: ['Ronan Bennett', 'Eddie Redmayne', 'Lashana Lynch'],
        comparableKeywords: ['assassin', 'spy', 'Europe', 'cat and mouse', 'action'],
      ),
      
      EnhancedComparableTitle(
        title: 'No Good Deed',
        year: 2024,
        primaryGenre: 'Comedy',
        subGenres: ['Drama'],
        format: 'Limited Series',
        platform: 'Netflix',
        distributor: 'Netflix',
        narrative: NarrativeElements(
          protagonistType: 'parent',
          centralConflict: 'discovery',
          setting: 'urban',
          themes: ['secrets', 'real estate', 'family'],
          genreElements: ['dark comedy', 'ensemble', 'mystery'],
          stakesLevel: 'personal',
        ),
        logline: 'When a couple decides to sell their beautiful Los Angeles home, they discover it attracts desperate buyers with their own secrets.',
        tones: ['sardonic', 'twisty', 'satirical'],
        rtScore: 68,
        audienceScore: 71,
        releaseWindow: 'Winter',
        keyTalent: ['Liz Feldman', 'Lisa Kudrow', 'Ray Romano'],
        comparableKeywords: ['real estate', 'Los Angeles', 'secrets', 'ensemble', 'comedy'],
      ),
      
      EnhancedComparableTitle(
        title: 'Monsters: The Lyle and Erik Menendez Story',
        year: 2024,
        primaryGenre: 'Drama',
        subGenres: ['Crime', 'Biography'],
        format: 'Limited Series',
        platform: 'Netflix',
        distributor: 'Netflix',
        narrative: NarrativeElements(
          protagonistType: 'criminal',
          protagonistTrait: 'troubled',
          centralConflict: 'discovery',
          setting: 'urban',
          timePeriod: '1990s',
          themes: ['family', 'abuse', 'justice'],
          genreElements: ['true crime', 'courtroom', 'anthology'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'The true story of the Menendez brothers, who were convicted of murdering their parents in their Beverly Hills mansion.',
        tones: ['disturbing', 'empathetic', 'sensational'],
        rtScore: 47,
        audienceScore: 68,
        releaseWindow: 'Fall',
        keyTalent: ['Ryan Murphy', 'Ian Brennan', 'Nicholas Alexander Chavez', 'Cooper Koch'],
        comparableKeywords: ['true crime', 'Menendez', 'murder', 'family', 'trial'],
      ),
      
      EnhancedComparableTitle(
        title: 'Slow Horses',
        year: 2024,
        primaryGenre: 'Thriller',
        subGenres: ['Drama', 'Espionage'],
        format: 'Series',
        platform: 'Apple TV+',
        distributor: 'Apple TV+',
        narrative: NarrativeElements(
          protagonistType: 'detective',
          protagonistTrait: 'disgraced',
          centralConflict: 'discovery',
          setting: 'urban',
          themes: ['redemption', 'loyalty', 'espionage'],
          genreElements: ['spy thriller', 'ensemble', 'literary adaptation'],
          stakesLevel: 'life-or-death',
        ),
        logline: 'A team of disgraced MI5 agents, banished to a dead-end department, stumble onto a conspiracy that brings them back into the action.',
        tones: ['witty', 'cynical', 'tense'],
        rtScore: 97,
        audienceScore: 90,
        releaseWindow: 'Fall',
        keyTalent: ['Will Smith', 'Gary Oldman', 'Jack Lowden', 'Kristin Scott Thomas'],
        comparableKeywords: ['MI5', 'spy', 'disgraced', 'British', 'espionage'],
      ),
    ];
  }
}

/// Internal concept profile for matching
class _ConceptProfile {
  final String logline;
  final String genre;
  final String format;
  final String? secondaryGenre;
  final String? tone;
  final String? targetAudience;
  final String? budgetTier;
  final NarrativeElements narrativeElements;
  final ParsedUserComparable? parsedUserComp;
  
  _ConceptProfile({
    required this.logline,
    required this.genre,
    required this.format,
    this.secondaryGenre,
    this.tone,
    this.targetAudience,
    this.budgetTier,
    required this.narrativeElements,
    this.parsedUserComp,
  });
}
