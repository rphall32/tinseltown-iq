/// ═══════════════════════════════════════════════════════════════════════════
/// CONCEPT DEVELOPMENT SERVICE - AI-Powered Concept Improvement Assistant
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Transforms Tinseltown IQ from a one-time analysis tool into an ongoing
/// development partner with:
/// - AI Rewrite Suggestions for loglines
/// - Weakness-to-Strength Converter with actionable fixes
/// - A/B Comparison Mode for side-by-side analysis
/// - Version History with score progression tracking
/// - "What If" Scenario Analysis for hypothetical changes

library concept_development_service;

import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'enhanced_analysis_engine.dart';
import 'industry_data.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// LOGLINE REWRITE SUGGESTION
/// ═══════════════════════════════════════════════════════════════════════════

class LoglineRewriteSuggestion {
  final String originalLogline;
  final String suggestedLogline;
  final String improvementReason;
  final List<String> changesHighlighted;
  final int estimatedScoreBoost;
  final String focusArea; // 'protagonist', 'conflict', 'stakes', 'hook', 'clarity'
  
  const LoglineRewriteSuggestion({
    required this.originalLogline,
    required this.suggestedLogline,
    required this.improvementReason,
    required this.changesHighlighted,
    required this.estimatedScoreBoost,
    required this.focusArea,
  });
  
  Map<String, dynamic> toJson() => {
    'originalLogline': originalLogline,
    'suggestedLogline': suggestedLogline,
    'improvementReason': improvementReason,
    'changesHighlighted': changesHighlighted,
    'estimatedScoreBoost': estimatedScoreBoost,
    'focusArea': focusArea,
  };
  
  factory LoglineRewriteSuggestion.fromJson(Map<String, dynamic> json) {
    return LoglineRewriteSuggestion(
      originalLogline: json['originalLogline'] as String,
      suggestedLogline: json['suggestedLogline'] as String,
      improvementReason: json['improvementReason'] as String,
      changesHighlighted: List<String>.from(json['changesHighlighted']),
      estimatedScoreBoost: json['estimatedScoreBoost'] as int,
      focusArea: json['focusArea'] as String,
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// WEAKNESS TO STRENGTH FIX
/// ═══════════════════════════════════════════════════════════════════════════

class WeaknessToStrengthFix {
  final String weaknessCategory;
  final String currentIssue;
  final String actionableFix;
  final String exampleBefore;
  final String exampleAfter;
  final List<String> stepByStepGuide;
  final int priorityLevel; // 1-5, 1 = highest priority
  final int potentialScoreIncrease;
  final IconData icon;
  final Color statusColor;
  
  const WeaknessToStrengthFix({
    required this.weaknessCategory,
    required this.currentIssue,
    required this.actionableFix,
    required this.exampleBefore,
    required this.exampleAfter,
    required this.stepByStepGuide,
    required this.priorityLevel,
    required this.potentialScoreIncrease,
    required this.icon,
    required this.statusColor,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// CONCEPT VERSION - For Version History Tracking
/// ═══════════════════════════════════════════════════════════════════════════

class ConceptVersion {
  final String versionId;
  final String projectId;
  final int versionNumber;
  final DateTime timestamp;
  final EnhancedConceptData conceptData;
  final int greenlightScore;
  final String verdict;
  final String changeDescription;
  final List<String> changesFromPrevious;
  final int? scoreDelta; // Change from previous version
  
  const ConceptVersion({
    required this.versionId,
    required this.projectId,
    required this.versionNumber,
    required this.timestamp,
    required this.conceptData,
    required this.greenlightScore,
    required this.verdict,
    required this.changeDescription,
    required this.changesFromPrevious,
    this.scoreDelta,
  });
  
  Map<String, dynamic> toJson() => {
    'versionId': versionId,
    'projectId': projectId,
    'versionNumber': versionNumber,
    'timestamp': timestamp.toIso8601String(),
    'logline': conceptData.logline,
    'synopsis': conceptData.synopsis,
    'genre': conceptData.genre,
    'format': conceptData.format,
    'secondaryGenre': conceptData.secondaryGenre,
    'tone': conceptData.tone,
    'targetAudience': conceptData.targetAudience,
    'budgetTier': conceptData.budgetTier,
    'comparable1': conceptData.comparableTitle1,
    'comparable2': conceptData.comparableTitle2,
    'comparable3': conceptData.comparableTitle3,
    'greenlightScore': greenlightScore,
    'verdict': verdict,
    'changeDescription': changeDescription,
    'changesFromPrevious': changesFromPrevious,
    'scoreDelta': scoreDelta,
  };
  
  factory ConceptVersion.fromJson(Map<String, dynamic> json) {
    return ConceptVersion(
      versionId: json['versionId'] as String,
      projectId: json['projectId'] as String,
      versionNumber: json['versionNumber'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
      conceptData: EnhancedConceptData(
        logline: json['logline'] as String,
        synopsis: json['synopsis'] as String,
        genre: json['genre'] as String,
        format: json['format'] as String,
        secondaryGenre: json['secondaryGenre'] as String?,
        tone: json['tone'] as String?,
        targetAudience: json['targetAudience'] as String?,
        budgetTier: json['budgetTier'] as String?,
        comparableTitle1: json['comparable1'] as String?,
        comparableTitle2: json['comparable2'] as String?,
        comparableTitle3: json['comparable3'] as String?,
      ),
      greenlightScore: json['greenlightScore'] as int,
      verdict: json['verdict'] as String,
      changeDescription: json['changeDescription'] as String,
      changesFromPrevious: List<String>.from(json['changesFromPrevious'] ?? []),
      scoreDelta: json['scoreDelta'] as int?,
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// A/B COMPARISON RESULT
/// ═══════════════════════════════════════════════════════════════════════════

class ABComparisonResult {
  final EnhancedAnalysisResult versionA;
  final EnhancedAnalysisResult versionB;
  final String winner; // 'A', 'B', or 'Tie'
  final int scoreDifference;
  final List<ComparisonPoint> comparisonPoints;
  final String recommendation;
  final List<String> versionAAdvantages;
  final List<String> versionBAdvantages;
  
  const ABComparisonResult({
    required this.versionA,
    required this.versionB,
    required this.winner,
    required this.scoreDifference,
    required this.comparisonPoints,
    required this.recommendation,
    required this.versionAAdvantages,
    required this.versionBAdvantages,
  });
}

class ComparisonPoint {
  final String category;
  final String versionAValue;
  final String versionBValue;
  final String winner; // 'A', 'B', or 'Tie'
  final String analysis;
  
  const ComparisonPoint({
    required this.category,
    required this.versionAValue,
    required this.versionBValue,
    required this.winner,
    required this.analysis,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// WHAT-IF SCENARIO
/// ═══════════════════════════════════════════════════════════════════════════

class WhatIfScenario {
  final String scenarioType; // 'genre', 'format', 'budget', 'audience', 'tone'
  final String currentValue;
  final String hypotheticalValue;
  final int currentScore;
  final int projectedScore;
  final int scoreDelta;
  final List<String> impactAnalysis;
  final List<String> pros;
  final List<String> cons;
  final String recommendation;
  
  const WhatIfScenario({
    required this.scenarioType,
    required this.currentValue,
    required this.hypotheticalValue,
    required this.currentScore,
    required this.projectedScore,
    required this.scoreDelta,
    required this.impactAnalysis,
    required this.pros,
    required this.cons,
    required this.recommendation,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// CONCEPT DEVELOPMENT SERVICE - Main Implementation
/// ═══════════════════════════════════════════════════════════════════════════

class ConceptDevelopmentService extends ChangeNotifier {
  static final ConceptDevelopmentService _instance = ConceptDevelopmentService._internal();
  factory ConceptDevelopmentService() => _instance;
  ConceptDevelopmentService._internal();
  
  static const String _versionHistoryKey = 'concept_version_history';
  
  final EnhancedAnalysisEngine _analysisEngine = EnhancedAnalysisEngine();
  final _random = math.Random();
  
  Map<String, List<ConceptVersion>> _versionHistory = {};
  bool _isLoaded = false;
  
  Map<String, List<ConceptVersion>> get versionHistory => _versionHistory;
  bool get isLoaded => _isLoaded;
  
  /// Load version history from storage
  Future<void> loadVersionHistory() async {
    if (_isLoaded) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_versionHistoryKey);
      
      if (historyJson != null && historyJson.isNotEmpty) {
        final Map<String, dynamic> decoded = json.decode(historyJson);
        _versionHistory = decoded.map((key, value) {
          final versions = (value as List)
              .map((v) => ConceptVersion.fromJson(v as Map<String, dynamic>))
              .toList();
          return MapEntry(key, versions);
        });
      }
      
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      _isLoaded = true;
    }
  }
  
  /// Save version history to storage
  Future<void> _saveVersionHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = json.encode(_versionHistory.map((key, value) {
        return MapEntry(key, value.map((v) => v.toJson()).toList());
      }));
      await prefs.setString(_versionHistoryKey, historyJson);
    } catch (e) {
      // Silently fail
    }
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // AI LOGLINE REWRITE SUGGESTIONS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Generate AI-powered logline rewrite suggestions
  List<LoglineRewriteSuggestion> generateLoglineRewrites(
    EnhancedConceptData concept,
    EnhancedAnalysisResult currentAnalysis,
  ) {
    final suggestions = <LoglineRewriteSuggestion>[];
    final logline = concept.logline;
    final loglineBreakdown = currentAnalysis.loglineBreakdown;
    
    // Analyze weak points and generate targeted rewrites
    
    // 1. Protagonist Enhancement
    if (loglineBreakdown.protagonistScore < 12) {
      suggestions.add(_generateProtagonistRewrite(logline, concept));
    }
    
    // 2. Conflict Strengthening
    if (loglineBreakdown.conflictScore < 15) {
      suggestions.add(_generateConflictRewrite(logline, concept));
    }
    
    // 3. Stakes Elevation
    if (loglineBreakdown.stakesScore < 12) {
      suggestions.add(_generateStakesRewrite(logline, concept));
    }
    
    // 4. Unique Hook Enhancement
    if (loglineBreakdown.uniqueHookScore < 15) {
      suggestions.add(_generateHookRewrite(logline, concept));
    }
    
    // 5. Concision Improvement
    if (loglineBreakdown.concisionScore < 8) {
      suggestions.add(_generateConcisionRewrite(logline, concept));
    }
    
    // Always add a "polished" version combining best practices
    suggestions.add(_generatePolishedRewrite(logline, concept, currentAnalysis));
    
    return suggestions;
  }
  
  LoglineRewriteSuggestion _generateProtagonistRewrite(String logline, EnhancedConceptData concept) {
    final protagonistEnhancements = _getProtagonistEnhancements(concept.genre);
    final enhanced = _enhanceLoglineProtagonist(logline, protagonistEnhancements);
    
    return LoglineRewriteSuggestion(
      originalLogline: logline,
      suggestedLogline: enhanced,
      improvementReason: 'Strengthened protagonist with clear flaw/motivation that creates empathy and drives the story forward.',
      changesHighlighted: ['Added character depth', 'Clarified protagonist\'s internal conflict', 'Made goal more specific'],
      estimatedScoreBoost: 8 + _random.nextInt(5),
      focusArea: 'protagonist',
    );
  }
  
  LoglineRewriteSuggestion _generateConflictRewrite(String logline, EnhancedConceptData concept) {
    final enhanced = _enhanceLoglineConflict(logline, concept);
    
    return LoglineRewriteSuggestion(
      originalLogline: logline,
      suggestedLogline: enhanced,
      improvementReason: 'Amplified central conflict with clearer antagonistic force and escalating tension.',
      changesHighlighted: ['Defined antagonist/obstacle', 'Raised conflict stakes', 'Added urgency'],
      estimatedScoreBoost: 10 + _random.nextInt(5),
      focusArea: 'conflict',
    );
  }
  
  LoglineRewriteSuggestion _generateStakesRewrite(String logline, EnhancedConceptData concept) {
    final enhanced = _enhanceLoglineStakes(logline, concept);
    
    return LoglineRewriteSuggestion(
      originalLogline: logline,
      suggestedLogline: enhanced,
      improvementReason: 'Elevated stakes to make the outcome matter more - clearer consequences of failure.',
      changesHighlighted: ['Added personal stakes', 'Clarified what\'s at risk', 'Connected to universal fears/desires'],
      estimatedScoreBoost: 7 + _random.nextInt(5),
      focusArea: 'stakes',
    );
  }
  
  LoglineRewriteSuggestion _generateHookRewrite(String logline, EnhancedConceptData concept) {
    final enhanced = _enhanceLoglineHook(logline, concept);
    
    return LoglineRewriteSuggestion(
      originalLogline: logline,
      suggestedLogline: enhanced,
      improvementReason: 'Added unique hook element that differentiates this from similar concepts in the market.',
      changesHighlighted: ['Added fresh twist', 'Unique world/premise element', 'Distinctive voice'],
      estimatedScoreBoost: 12 + _random.nextInt(6),
      focusArea: 'hook',
    );
  }
  
  LoglineRewriteSuggestion _generateConcisionRewrite(String logline, EnhancedConceptData concept) {
    final enhanced = _makeLoglineConcise(logline);
    
    return LoglineRewriteSuggestion(
      originalLogline: logline,
      suggestedLogline: enhanced,
      improvementReason: 'Tightened prose for maximum impact - every word earns its place.',
      changesHighlighted: ['Removed redundancy', 'Stronger verbs', 'Punchier phrasing'],
      estimatedScoreBoost: 5 + _random.nextInt(4),
      focusArea: 'clarity',
    );
  }
  
  LoglineRewriteSuggestion _generatePolishedRewrite(
    String logline, 
    EnhancedConceptData concept,
    EnhancedAnalysisResult analysis,
  ) {
    final enhanced = _generateFullyPolishedLogline(logline, concept, analysis);
    
    return LoglineRewriteSuggestion(
      originalLogline: logline,
      suggestedLogline: enhanced,
      improvementReason: 'Comprehensive rewrite incorporating all best practices for maximum market appeal.',
      changesHighlighted: [
        'Professional structure',
        'Clear protagonist + goal + obstacle + stakes',
        'Genre-appropriate tone',
        'Unique selling point emphasized'
      ],
      estimatedScoreBoost: 15 + _random.nextInt(8),
      focusArea: 'comprehensive',
    );
  }
  
  // Helper methods for logline enhancement
  String _enhanceLoglineProtagonist(String logline, Map<String, String> enhancements) {
    // Pattern: "A [flaw] [protagonist] must [goal] when [inciting incident]"
    final words = logline.split(' ');
    
    // Add character depth adjective
    final characterAdjectives = [
      'battle-scarred', 'ambitious', 'haunted', 'idealistic', 'cynical',
      'reluctant', 'determined', 'brilliant but flawed', 'recovering',
    ];
    
    // Find and enhance protagonist description
    String enhanced = logline;
    if (logline.toLowerCase().contains(' a ') || logline.toLowerCase().startsWith('a ')) {
      final adj = characterAdjectives[_random.nextInt(characterAdjectives.length)];
      enhanced = enhanced.replaceFirst(RegExp(r'\b[Aa]\s+(\w+)'), 'A $adj \$1');
    }
    
    // Add "must" if not present (clarifies goal)
    if (!enhanced.toLowerCase().contains(' must ')) {
      enhanced = enhanced.replaceFirst(' to ', ' must ');
    }
    
    return _cleanLogline(enhanced);
  }
  
  String _enhanceLoglineConflict(String logline, EnhancedConceptData concept) {
    final conflictPhrases = _getGenreConflictPhrases(concept.genre);
    String enhanced = logline;
    
    // Add "before" clause for urgency if not present
    if (!enhanced.toLowerCase().contains(' before ') && 
        !enhanced.toLowerCase().contains(' or else ')) {
      final urgencyClause = conflictPhrases[_random.nextInt(conflictPhrases.length)];
      enhanced = '$enhanced $urgencyClause';
    }
    
    // Strengthen verbs
    enhanced = enhanced
        .replaceAll(' tries to ', ' must ')
        .replaceAll(' wants to ', ' desperately needs to ')
        .replaceAll(' needs to ', ' is forced to ')
        .replaceAll(' has to ', ' must fight to ');
    
    return _cleanLogline(enhanced);
  }
  
  String _enhanceLoglineStakes(String logline, EnhancedConceptData concept) {
    final stakesElevations = _getGenreStakes(concept.genre);
    String enhanced = logline;
    
    // Add stakes clause if not present
    if (!enhanced.toLowerCase().contains(' or ') &&
        !enhanced.toLowerCase().contains(' risk ') &&
        !enhanced.toLowerCase().contains(' lose ')) {
      final stakes = stakesElevations[_random.nextInt(stakesElevations.length)];
      enhanced = '$enhanced—or $stakes';
    }
    
    return _cleanLogline(enhanced);
  }
  
  String _enhanceLoglineHook(String logline, EnhancedConceptData concept) {
    final hooks = _getGenreHooks(concept.genre);
    String enhanced = logline;
    
    // Add unique element
    final hook = hooks[_random.nextInt(hooks.length)];
    
    // Insert hook early in the logline
    if (enhanced.contains(',')) {
      final parts = enhanced.split(',');
      enhanced = '${parts[0]}, $hook,${parts.sublist(1).join(',')}';
    } else {
      enhanced = '$hook, ${enhanced.substring(0, 1).toLowerCase()}${enhanced.substring(1)}';
    }
    
    return _cleanLogline(enhanced);
  }
  
  String _makeLoglineConcise(String logline) {
    String enhanced = logline;
    
    // Remove common filler words
    final fillerPatterns = [
      RegExp(r'\s+that is\s+'), ' ',
      RegExp(r'\s+who is\s+'), ' ',
      RegExp(r'\s+in order to\s+'), ' to ',
      RegExp(r'\s+begins to\s+'), ' ',
      RegExp(r'\s+starts to\s+'), ' ',
      RegExp(r'\s+very\s+'), ' ',
      RegExp(r'\s+really\s+'), ' ',
      RegExp(r'\s+actually\s+'), ' ',
    ];
    
    for (int i = 0; i < fillerPatterns.length; i += 2) {
      enhanced = enhanced.replaceAll(
        fillerPatterns[i] as RegExp, 
        fillerPatterns[i + 1] as String
      );
    }
    
    // Replace weak verbs
    enhanced = enhanced
        .replaceAll(' is trying ', ' struggles ')
        .replaceAll(' is going ', ' races ')
        .replaceAll(' is looking ', ' hunts ')
        .replaceAll(' gets ', ' seizes ')
        .replaceAll(' goes ', ' plunges ');
    
    return _cleanLogline(enhanced);
  }
  
  String _generateFullyPolishedLogline(
    String logline,
    EnhancedConceptData concept,
    EnhancedAnalysisResult analysis,
  ) {
    // Build a professional logline from scratch using key elements
    final protagonist = _extractProtagonist(logline, concept);
    final goal = _extractGoal(logline);
    final obstacle = _extractObstacle(logline, concept);
    final stakes = _getGenreStakes(concept.genre)[0];
    
    // Professional template: "When [inciting incident], a [flaw] [protagonist] must [goal] 
    // before [antagonist/time pressure] [consequence]."
    
    final templates = [
      'When $obstacle, $protagonist must $goal—or $stakes.',
      '$protagonist, facing $obstacle, must $goal before $stakes.',
      'After $obstacle, $protagonist has one chance to $goal—or $stakes.',
      'To $goal, $protagonist must confront $obstacle before $stakes.',
    ];
    
    return _cleanLogline(templates[_random.nextInt(templates.length)]);
  }
  
  String _extractProtagonist(String logline, EnhancedConceptData concept) {
    // Extract or generate protagonist description
    final protagonistTypes = {
      'Action': ['a battle-hardened operative', 'a disgraced soldier', 'an unlikely hero'],
      'Horror': ['a skeptical investigator', 'a traumatized survivor', 'an isolated family'],
      'Drama': ['a conflicted professional', 'a grieving parent', 'an outsider'],
      'Comedy': ['an overconfident rookie', 'a lovable underdog', 'mismatched partners'],
      'Thriller': ['a paranoid witness', 'a desperate innocent', 'a reluctant detective'],
      'Sci-Fi': ['a visionary scientist', 'a rogue AI', 'the last human'],
      'Romance': ['a guarded heart', 'unlikely lovers', 'a second-chance seeker'],
    };
    
    final types = protagonistTypes[concept.genre] ?? ['a determined protagonist'];
    return types[_random.nextInt(types.length)];
  }
  
  String _extractGoal(String logline) {
    // Extract goal from logline or provide genre-appropriate default
    if (logline.contains(' must ')) {
      final parts = logline.split(' must ');
      if (parts.length > 1) {
        final goalPart = parts[1].split(RegExp(r'[,\.]|before|when|while'))[0];
        return goalPart.trim();
      }
    }
    return 'uncover the truth';
  }
  
  String _extractObstacle(String logline, EnhancedConceptData concept) {
    final obstacles = {
      'Action': ['a deadly conspiracy surfaces', 'an unstoppable enemy emerges', 'betrayal from within'],
      'Horror': ['an ancient evil awakens', 'the nightmare becomes real', 'the house reveals its secrets'],
      'Drama': ['a buried secret resurfaces', 'everything falls apart', 'the truth demands to be told'],
      'Comedy': ['everything goes hilariously wrong', 'an impossible deadline looms', 'chaos erupts'],
      'Thriller': ['a web of lies unravels', 'the hunter becomes the hunted', 'trust becomes impossible'],
      'Sci-Fi': ['reality begins to fracture', 'the technology turns hostile', 'time runs out'],
      'Romance': ['past mistakes resurface', 'fate intervenes', 'the truth threatens everything'],
    };
    
    final genreObstacles = obstacles[concept.genre] ?? ['everything changes'];
    return genreObstacles[_random.nextInt(genreObstacles.length)];
  }
  
  Map<String, String> _getProtagonistEnhancements(String genre) {
    return {
      'flaw': 'haunted by past failures',
      'motivation': 'desperate to prove themselves',
      'strength': 'uniquely qualified',
    };
  }
  
  List<String> _getGenreConflictPhrases(String genre) {
    final phrases = {
      'Action': ['before time runs out', 'while evading a relentless hunter', 'against impossible odds'],
      'Horror': ['before the next victim falls', 'while the darkness closes in', 'before it claims them all'],
      'Drama': ['before it\'s too late', 'while confronting painful truths', 'before the damage is irreversible'],
      'Comedy': ['before everything falls apart', 'while juggling escalating chaos', 'before the big event'],
      'Thriller': ['before the killer strikes again', 'while questioning everyone', 'before becoming the next target'],
      'Sci-Fi': ['before reality collapses', 'while questioning humanity', 'before the point of no return'],
      'Romance': ['before love slips away', 'while battling their own fears', 'before it\'s too late'],
    };
    return phrases[genre] ?? ['before everything changes'];
  }
  
  List<String> _getGenreStakes(String genre) {
    final stakes = {
      'Action': ['lose everything they\'ve fought for', 'watch the world burn', 'become what they despise'],
      'Horror': ['become the next victim', 'lose their soul', 'unleash something worse'],
      'Drama': ['lose the ones they love', 'sacrifice their integrity', 'live with eternal regret'],
      'Comedy': ['face total humiliation', 'lose their big chance', 'end up alone'],
      'Thriller': ['become the perfect scapegoat', 'lose their sanity', 'trust the wrong person'],
      'Sci-Fi': ['doom humanity', 'lose their humanity', 'erase their existence'],
      'Romance': ['lose their last chance at love', 'repeat past mistakes', 'settle for less'],
    };
    return stakes[genre] ?? ['face devastating consequences'];
  }
  
  List<String> _getGenreHooks(String genre) {
    final hooks = {
      'Action': ['armed only with wits and a stolen weapon', 'with 24 hours to live', 'with a price on their head'],
      'Horror': ['in a town that doesn\'t exist on any map', 'where the dead don\'t stay dead', 'where nightmares manifest'],
      'Drama': ['carrying a secret that could destroy them', 'bound by an impossible promise', 'facing their darkest truth'],
      'Comedy': ['with the world\'s worst timing', 'armed with zero practical skills', 'while pretending to be someone else'],
      'Thriller': ['unable to trust their own memory', 'framed for a crime they predicted', 'with everyone watching'],
      'Sci-Fi': ['in a simulation they can\'t escape', 'as the last of their kind', 'with technology that defies physics'],
      'Romance': ['pretending to be strangers', 'bound by an arrangement', 'across impossible circumstances'],
    };
    return hooks[genre] ?? ['with an unexpected twist'];
  }
  
  String _cleanLogline(String logline) {
    return logline
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(' ,', ',')
        .replaceAll(' .', '.')
        .replaceAll(',,', ',')
        .replaceAll('..', '.')
        .trim();
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // WEAKNESS TO STRENGTH CONVERTER
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Generate actionable fixes for each identified weakness
  List<WeaknessToStrengthFix> generateWeaknessToStrengthFixes(
    EnhancedAnalysisResult analysis,
  ) {
    final fixes = <WeaknessToStrengthFix>[];
    
    // Analyze each improvement area and generate specific fixes
    for (final area in analysis.improvementAreas) {
      final fix = _generateFixForWeakness(area, analysis);
      if (fix != null) {
        fixes.add(fix);
      }
    }
    
    // Add fixes based on logline breakdown scores
    final loglineBreakdown = analysis.loglineBreakdown;
    
    if (loglineBreakdown.protagonistScore < 12) {
      fixes.add(_generateProtagonistFix(analysis));
    }
    
    if (loglineBreakdown.conflictScore < 15) {
      fixes.add(_generateConflictFix(analysis));
    }
    
    if (loglineBreakdown.stakesScore < 12) {
      fixes.add(_generateStakesFix(analysis));
    }
    
    if (loglineBreakdown.uniqueHookScore < 15) {
      fixes.add(_generateHookFix(analysis));
    }
    
    // Sort by priority
    fixes.sort((a, b) => a.priorityLevel.compareTo(b.priorityLevel));
    
    return fixes.take(6).toList(); // Return top 6 most impactful
  }
  
  WeaknessToStrengthFix? _generateFixForWeakness(
    ImprovementArea area,
    EnhancedAnalysisResult analysis,
  ) {
    return WeaknessToStrengthFix(
      weaknessCategory: area.category,
      currentIssue: area.issue,
      actionableFix: area.suggestion,
      exampleBefore: _generateWeakExample(area.category),
      exampleAfter: _generateStrongExample(area.category),
      stepByStepGuide: _generateStepByStepGuide(area.category),
      priorityLevel: (10 - area.impactLevel).clamp(1, 5),
      potentialScoreIncrease: area.impactLevel,
      icon: _getIconForCategory(area.category),
      statusColor: _getColorForPriority((10 - area.impactLevel).clamp(1, 5)),
    );
  }
  
  WeaknessToStrengthFix _generateProtagonistFix(EnhancedAnalysisResult analysis) {
    return WeaknessToStrengthFix(
      weaknessCategory: 'Protagonist',
      currentIssue: 'Your protagonist lacks distinctiveness or a clear driving flaw.',
      actionableFix: 'Add a specific flaw or wound that directly connects to the story\'s conflict.',
      exampleBefore: 'A detective investigates a murder.',
      exampleAfter: 'A disgraced detective, fired for planting evidence, investigates the one murder that could prove his instincts were right all along.',
      stepByStepGuide: [
        '1. Identify your protagonist\'s core flaw (fear, obsession, trauma)',
        '2. Connect this flaw to WHY they care about solving this problem',
        '3. Show how the flaw creates internal conflict during the journey',
        '4. Ensure the resolution requires them to confront this flaw',
        '5. Add one distinctive trait that makes them memorable',
      ],
      priorityLevel: 1,
      potentialScoreIncrease: 12,
      icon: Icons.person_outline,
      statusColor: Colors.orange,
    );
  }
  
  WeaknessToStrengthFix _generateConflictFix(EnhancedAnalysisResult analysis) {
    return WeaknessToStrengthFix(
      weaknessCategory: 'Central Conflict',
      currentIssue: 'The central conflict is either unclear or not compelling enough.',
      actionableFix: 'Externalize the conflict with a clear antagonistic force and add escalating obstacles.',
      exampleBefore: 'A woman struggles to find herself after divorce.',
      exampleAfter: 'A woman rebuilding her life after divorce must fight her manipulative ex in a custody battle that forces her to expose secrets she\'s buried for years.',
      stepByStepGuide: [
        '1. Identify the EXTERNAL obstacle (person, institution, force)',
        '2. Make the antagonist\'s goals directly oppose your protagonist\'s',
        '3. Add a ticking clock or deadline for urgency',
        '4. Create escalating obstacles that test the protagonist',
        '5. Ensure the climax is a direct confrontation with this conflict',
      ],
      priorityLevel: 1,
      potentialScoreIncrease: 15,
      icon: Icons.flash_on,
      statusColor: Colors.red,
    );
  }
  
  WeaknessToStrengthFix _generateStakesFix(EnhancedAnalysisResult analysis) {
    return WeaknessToStrengthFix(
      weaknessCategory: 'Stakes',
      currentIssue: 'The consequences of failure aren\'t clear or compelling.',
      actionableFix: 'Add personal, professional, AND universal stakes that escalate throughout.',
      exampleBefore: 'He must stop the villain.',
      exampleAfter: 'He must stop the villain before the bomb destroys the hospital where his daughter is in surgery—knowing the only way in requires sacrificing the partner who saved his life.',
      stepByStepGuide: [
        '1. Define PERSONAL stakes (what does the protagonist lose?)',
        '2. Add PROFESSIONAL stakes (career, reputation, legacy)',
        '3. Include UNIVERSAL stakes (what does the world/community lose?)',
        '4. Make failure irreversible—no easy fixes',
        '5. Add a moral cost to success (what must they sacrifice?)',
      ],
      priorityLevel: 2,
      potentialScoreIncrease: 10,
      icon: Icons.warning_amber,
      statusColor: Colors.orange,
    );
  }
  
  WeaknessToStrengthFix _generateHookFix(EnhancedAnalysisResult analysis) {
    return WeaknessToStrengthFix(
      weaknessCategory: 'Unique Hook',
      currentIssue: 'The concept lacks a distinctive element that sets it apart.',
      actionableFix: 'Add a "what if" twist that makes this concept feel fresh and marketable.',
      exampleBefore: 'A cop hunts a serial killer.',
      exampleAfter: 'A cop hunts a serial killer who livestreams his crimes to millions of devoted followers—and the only way to catch him is to become his most famous fan.',
      stepByStepGuide: [
        '1. Ask "What if?" about one element (setting, premise, character)',
        '2. Research what\'s been done—then subvert expectations',
        '3. Combine two familiar elements in an unexpected way',
        '4. Add a contemporary/timely angle that feels relevant',
        '5. Ensure the hook is in your logline\'s first sentence',
      ],
      priorityLevel: 1,
      potentialScoreIncrease: 18,
      icon: Icons.lightbulb_outline,
      statusColor: Colors.amber,
    );
  }
  
  String _generateWeakExample(String category) {
    final examples = {
      'Protagonist': 'A man tries to save his family.',
      'Conflict': 'Things go wrong.',
      'Stakes': 'She might fail.',
      'Hook': 'A typical story in a familiar setting.',
      'Genre': 'It\'s kind of a drama-comedy-thriller.',
      'Market': 'It appeals to everyone.',
    };
    return examples[category] ?? 'Generic description without specifics.';
  }
  
  String _generateStrongExample(String category) {
    final examples = {
      'Protagonist': 'A disgraced surgeon with a god complex must save the child he failed to save years ago.',
      'Conflict': 'When a ruthless developer threatens to demolish the orphanage hiding her past, she must choose between exposing her true identity or losing everything she\'s built.',
      'Stakes': 'She has 48 hours to clear her name—or lose custody of her children forever.',
      'Hook': 'In a world where memories are currency, a memory-poor janitor discovers she\'s the only one who remembers the assassination of the president.',
      'Genre': 'A contained psychological thriller with elevated horror elements.',
      'Market': 'For fans of GONE GIRL who want the tension of PANIC ROOM.',
    };
    return examples[category] ?? 'Specific, compelling description with clear elements.';
  }
  
  List<String> _generateStepByStepGuide(String category) {
    final guides = {
      'Protagonist': [
        '1. Define their greatest fear',
        '2. Connect the fear to the plot',
        '3. Add a distinctive voice/trait',
        '4. Show their transformation arc',
      ],
      'Conflict': [
        '1. Identify the antagonistic force',
        '2. Create direct opposition to protagonist\'s goal',
        '3. Add escalating obstacles',
        '4. Build to a climactic confrontation',
      ],
      'Stakes': [
        '1. Define what\'s at risk personally',
        '2. Add professional/social consequences',
        '3. Include universal implications',
        '4. Make failure irreversible',
      ],
      'Hook': [
        '1. Ask "What if?" about your premise',
        '2. Combine unexpected elements',
        '3. Add contemporary relevance',
        '4. Lead with the hook in your pitch',
      ],
    };
    return guides[category] ?? ['1. Analyze the weakness', '2. Apply targeted improvement', '3. Test with feedback', '4. Iterate'];
  }
  
  IconData _getIconForCategory(String category) {
    final icons = {
      'Protagonist': Icons.person_outline,
      'Conflict': Icons.flash_on,
      'Stakes': Icons.warning_amber,
      'Hook': Icons.lightbulb_outline,
      'Genre': Icons.category,
      'Market': Icons.trending_up,
      'Logline': Icons.edit,
      'Synopsis': Icons.article,
    };
    return icons[category] ?? Icons.build;
  }
  
  Color _getColorForPriority(int priority) {
    if (priority <= 1) return Colors.red;
    if (priority <= 2) return Colors.orange;
    if (priority <= 3) return Colors.amber;
    return Colors.green;
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // A/B COMPARISON MODE
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Compare two concept versions side by side
  Future<ABComparisonResult> compareConceptsAB(
    EnhancedConceptData conceptA,
    EnhancedConceptData conceptB,
  ) async {
    // Analyze both versions
    final resultA = await _analysisEngine.analyzeConceptWithDelay(conceptA);
    final resultB = await _analysisEngine.analyzeConceptWithDelay(conceptB);
    
    // Determine winner
    final scoreDiff = resultA.greenlightScore - resultB.greenlightScore;
    String winner;
    if (scoreDiff.abs() <= 3) {
      winner = 'Tie';
    } else if (scoreDiff > 0) {
      winner = 'A';
    } else {
      winner = 'B';
    }
    
    // Generate comparison points
    final comparisonPoints = _generateComparisonPoints(resultA, resultB);
    
    // Identify advantages for each version
    final versionAAdvantages = _identifyAdvantages(resultA, resultB);
    final versionBAdvantages = _identifyAdvantages(resultB, resultA);
    
    // Generate recommendation
    final recommendation = _generateComparisonRecommendation(
      resultA, resultB, winner, versionAAdvantages, versionBAdvantages,
    );
    
    return ABComparisonResult(
      versionA: resultA,
      versionB: resultB,
      winner: winner,
      scoreDifference: scoreDiff.abs(),
      comparisonPoints: comparisonPoints,
      recommendation: recommendation,
      versionAAdvantages: versionAAdvantages,
      versionBAdvantages: versionBAdvantages,
    );
  }
  
  List<ComparisonPoint> _generateComparisonPoints(
    EnhancedAnalysisResult a,
    EnhancedAnalysisResult b,
  ) {
    return [
      ComparisonPoint(
        category: 'Overall Score',
        versionAValue: '${a.greenlightScore}/100',
        versionBValue: '${b.greenlightScore}/100',
        winner: a.greenlightScore > b.greenlightScore ? 'A' : (b.greenlightScore > a.greenlightScore ? 'B' : 'Tie'),
        analysis: 'Based on comprehensive analysis of all factors.',
      ),
      ComparisonPoint(
        category: 'Logline Strength',
        versionAValue: '${a.loglineBreakdown.totalLoglineScore}/100',
        versionBValue: '${b.loglineBreakdown.totalLoglineScore}/100',
        winner: a.loglineBreakdown.totalLoglineScore > b.loglineBreakdown.totalLoglineScore ? 'A' : 
                (b.loglineBreakdown.totalLoglineScore > a.loglineBreakdown.totalLoglineScore ? 'B' : 'Tie'),
        analysis: 'Evaluates protagonist, conflict, stakes, hook, and clarity.',
      ),
      ComparisonPoint(
        category: 'Market Fit',
        versionAValue: a.marketAnalysis.marketOutlook,
        versionBValue: b.marketAnalysis.marketOutlook,
        winner: a.marketAnalysis.genreBonus > b.marketAnalysis.genreBonus ? 'A' : 
                (b.marketAnalysis.genreBonus > a.marketAnalysis.genreBonus ? 'B' : 'Tie'),
        analysis: 'How well the concept aligns with current market trends.',
      ),
      ComparisonPoint(
        category: 'Buyer Interest',
        versionAValue: '${a.topBuyers.length} strong matches',
        versionBValue: '${b.topBuyers.length} strong matches',
        winner: a.topBuyers.length > b.topBuyers.length ? 'A' : 
                (b.topBuyers.length > a.topBuyers.length ? 'B' : 'Tie'),
        analysis: 'Number of studios/streamers likely to be interested.',
      ),
      ComparisonPoint(
        category: 'Similarity Risk',
        versionAValue: a.similarityRisk,
        versionBValue: b.similarityRisk,
        winner: _compareSimilarityRisk(a.similarityRisk, b.similarityRisk),
        analysis: 'Lower risk = more distinctive in the marketplace.',
      ),
      ComparisonPoint(
        category: 'Concept Strengths',
        versionAValue: '${a.conceptStrengths.length} identified',
        versionBValue: '${b.conceptStrengths.length} identified',
        winner: a.conceptStrengths.length > b.conceptStrengths.length ? 'A' : 
                (b.conceptStrengths.length > a.conceptStrengths.length ? 'B' : 'Tie'),
        analysis: 'Key selling points that make the concept appealing.',
      ),
    ];
  }
  
  String _compareSimilarityRisk(String riskA, String riskB) {
    final riskOrder = {'Low': 0, 'Medium': 1, 'High': 2};
    final a = riskOrder[riskA] ?? 1;
    final b = riskOrder[riskB] ?? 1;
    if (a < b) return 'A';
    if (b < a) return 'B';
    return 'Tie';
  }
  
  List<String> _identifyAdvantages(
    EnhancedAnalysisResult primary,
    EnhancedAnalysisResult secondary,
  ) {
    final advantages = <String>[];
    
    if (primary.greenlightScore > secondary.greenlightScore) {
      advantages.add('Higher overall GreenlightIQ™ score');
    }
    
    if (primary.loglineBreakdown.totalLoglineScore > secondary.loglineBreakdown.totalLoglineScore) {
      advantages.add('Stronger logline fundamentals');
    }
    
    if (primary.marketAnalysis.genreBonus > secondary.marketAnalysis.genreBonus) {
      advantages.add('Better market timing');
    }
    
    if (primary.topBuyers.length > secondary.topBuyers.length) {
      advantages.add('More potential buyers');
    }
    
    if (primary.conceptStrengths.length > secondary.conceptStrengths.length) {
      advantages.add('More identified strengths');
    }
    
    if (primary.improvementAreas.length < secondary.improvementAreas.length) {
      advantages.add('Fewer areas needing improvement');
    }
    
    return advantages;
  }
  
  String _generateComparisonRecommendation(
    EnhancedAnalysisResult a,
    EnhancedAnalysisResult b,
    String winner,
    List<String> aAdvantages,
    List<String> bAdvantages,
  ) {
    if (winner == 'Tie') {
      return 'Both versions are competitively strong. Consider combining the best elements: '
          'take the stronger protagonist/conflict from one and the unique hook from the other.';
    }
    
    final winningResult = winner == 'A' ? a : b;
    final losingResult = winner == 'A' ? b : a;
    final winningAdvantages = winner == 'A' ? aAdvantages : bAdvantages;
    
    return 'Version $winner scores higher due to: ${winningAdvantages.take(3).join(", ")}. '
        'However, Version ${winner == "A" ? "B" : "A"} has elements worth preserving, particularly '
        '${losingResult.conceptStrengths.isNotEmpty ? losingResult.conceptStrengths.first.description : "its unique angle"}.';
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // VERSION HISTORY TRACKING
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Save a new version to history
  Future<ConceptVersion> saveVersion({
    required String projectId,
    required EnhancedConceptData conceptData,
    required EnhancedAnalysisResult analysisResult,
    required String changeDescription,
  }) async {
    await loadVersionHistory();
    
    // Get existing versions for this project
    final existingVersions = _versionHistory[projectId] ?? [];
    final versionNumber = existingVersions.length + 1;
    
    // Calculate score delta if not first version
    int? scoreDelta;
    List<String> changesFromPrevious = [];
    
    if (existingVersions.isNotEmpty) {
      final previousVersion = existingVersions.last;
      scoreDelta = analysisResult.greenlightScore - previousVersion.greenlightScore;
      changesFromPrevious = _detectChanges(previousVersion.conceptData, conceptData);
    }
    
    final version = ConceptVersion(
      versionId: '${projectId}_v$versionNumber',
      projectId: projectId,
      versionNumber: versionNumber,
      timestamp: DateTime.now(),
      conceptData: conceptData,
      greenlightScore: analysisResult.greenlightScore,
      verdict: analysisResult.verdict,
      changeDescription: changeDescription,
      changesFromPrevious: changesFromPrevious,
      scoreDelta: scoreDelta,
    );
    
    // Add to history
    if (_versionHistory[projectId] == null) {
      _versionHistory[projectId] = [];
    }
    _versionHistory[projectId]!.add(version);
    
    await _saveVersionHistory();
    notifyListeners();
    
    return version;
  }
  
  /// Get version history for a project
  List<ConceptVersion> getVersionHistory(String projectId) {
    return _versionHistory[projectId] ?? [];
  }
  
  /// Get score progression data for charts
  List<Map<String, dynamic>> getScoreProgression(String projectId) {
    final versions = _versionHistory[projectId] ?? [];
    return versions.map((v) => {
      'version': v.versionNumber,
      'score': v.greenlightScore,
      'date': v.timestamp,
      'delta': v.scoreDelta,
    }).toList();
  }
  
  List<String> _detectChanges(EnhancedConceptData previous, EnhancedConceptData current) {
    final changes = <String>[];
    
    if (previous.logline != current.logline) {
      changes.add('Logline modified');
    }
    if (previous.synopsis != current.synopsis) {
      changes.add('Synopsis updated');
    }
    if (previous.genre != current.genre) {
      changes.add('Genre changed from ${previous.genre} to ${current.genre}');
    }
    if (previous.format != current.format) {
      changes.add('Format changed');
    }
    if (previous.tone != current.tone) {
      changes.add('Tone adjusted');
    }
    if (previous.targetAudience != current.targetAudience) {
      changes.add('Target audience refined');
    }
    if (previous.budgetTier != current.budgetTier) {
      changes.add('Budget tier changed');
    }
    
    return changes;
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // "WHAT IF" SCENARIO ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Generate "What If" scenario analysis
  Future<List<WhatIfScenario>> generateWhatIfScenarios(
    EnhancedConceptData currentConcept,
    EnhancedAnalysisResult currentAnalysis,
  ) async {
    final scenarios = <WhatIfScenario>[];
    
    // Genre change scenarios
    final alternativeGenres = _getAlternativeGenres(currentConcept.genre);
    for (final altGenre in alternativeGenres.take(2)) {
      final scenario = await _analyzeGenreChange(currentConcept, currentAnalysis, altGenre);
      scenarios.add(scenario);
    }
    
    // Format change scenario
    if (currentConcept.format.contains('Feature')) {
      scenarios.add(await _analyzeFormatChange(currentConcept, currentAnalysis, 'Limited Series (6-8 episodes)'));
    } else {
      scenarios.add(await _analyzeFormatChange(currentConcept, currentAnalysis, 'Feature Film'));
    }
    
    // Budget tier change scenario
    final altBudget = _getAlternativeBudget(currentConcept.budgetTier);
    if (altBudget != null) {
      scenarios.add(await _analyzeBudgetChange(currentConcept, currentAnalysis, altBudget));
    }
    
    // Audience change scenario
    final altAudience = _getAlternativeAudience(currentConcept.targetAudience);
    if (altAudience != null) {
      scenarios.add(await _analyzeAudienceChange(currentConcept, currentAnalysis, altAudience));
    }
    
    // Sort by score improvement potential
    scenarios.sort((a, b) => b.scoreDelta.compareTo(a.scoreDelta));
    
    return scenarios;
  }
  
  List<String> _getAlternativeGenres(String currentGenre) {
    final genreAlternatives = {
      'Action': ['Thriller', 'Sci-Fi', 'Adventure'],
      'Horror': ['Thriller', 'Mystery', 'Sci-Fi'],
      'Drama': ['Thriller', 'Romance', 'Biography'],
      'Comedy': ['Romance', 'Action', 'Drama'],
      'Thriller': ['Horror', 'Mystery', 'Drama'],
      'Sci-Fi': ['Action', 'Horror', 'Thriller'],
      'Romance': ['Drama', 'Comedy', 'Mystery'],
      'Mystery': ['Thriller', 'Horror', 'Drama'],
    };
    return genreAlternatives[currentGenre] ?? ['Drama', 'Thriller'];
  }
  
  String? _getAlternativeBudget(String? currentBudget) {
    final budgetAlternatives = {
      'Micro (<\$1M)': 'Low (\$1-10M)',
      'Low (\$1-10M)': 'Medium (\$10-50M)',
      'Medium (\$10-50M)': 'Low (\$1-10M)',
      'High (\$50-100M)': 'Medium (\$10-50M)',
      'Blockbuster (\$100M+)': 'High (\$50-100M)',
    };
    return budgetAlternatives[currentBudget];
  }
  
  String? _getAlternativeAudience(String? currentAudience) {
    final audienceAlternatives = {
      'General Audience': 'Young Adult (18-34)',
      'Young Adult (18-34)': 'Adult (35-54)',
      'Adult (35-54)': 'Young Adult (18-34)',
      'Family': 'General Audience',
      'Mature': 'Adult (35-54)',
    };
    return audienceAlternatives[currentAudience];
  }
  
  Future<WhatIfScenario> _analyzeGenreChange(
    EnhancedConceptData concept,
    EnhancedAnalysisResult currentAnalysis,
    String newGenre,
  ) async {
    // Create modified concept
    final modifiedConcept = EnhancedConceptData(
      logline: concept.logline,
      synopsis: concept.synopsis,
      genre: newGenre,
      format: concept.format,
      secondaryGenre: concept.secondaryGenre,
      tone: concept.tone,
      targetAudience: concept.targetAudience,
      budgetTier: concept.budgetTier,
      comparableTitle1: concept.comparableTitle1,
      comparableTitle2: concept.comparableTitle2,
      comparableTitle3: concept.comparableTitle3,
    );
    
    // Analyze modified version
    final modifiedResult = await _analysisEngine.analyzeConceptWithDelay(modifiedConcept);
    final scoreDelta = modifiedResult.greenlightScore - currentAnalysis.greenlightScore;
    
    return WhatIfScenario(
      scenarioType: 'genre',
      currentValue: concept.genre,
      hypotheticalValue: newGenre,
      currentScore: currentAnalysis.greenlightScore,
      projectedScore: modifiedResult.greenlightScore,
      scoreDelta: scoreDelta,
      impactAnalysis: [
        'Genre shift from ${concept.genre} to $newGenre',
        'Market position: ${modifiedResult.marketAnalysis.marketOutlook}',
        'Growth rate: ${modifiedResult.marketAnalysis.growthRate > 0 ? "+" : ""}${modifiedResult.marketAnalysis.growthRate}%',
      ],
      pros: _getGenreChangePros(concept.genre, newGenre, modifiedResult),
      cons: _getGenreChangeCons(concept.genre, newGenre),
      recommendation: scoreDelta > 5 
          ? 'This genre shift could significantly improve marketability. Consider if the story supports this change.'
          : scoreDelta < -5
              ? 'This genre shift would likely decrease appeal. The current genre is a better fit.'
              : 'Similar potential either way. Choose based on your creative vision.',
    );
  }
  
  Future<WhatIfScenario> _analyzeFormatChange(
    EnhancedConceptData concept,
    EnhancedAnalysisResult currentAnalysis,
    String newFormat,
  ) async {
    final modifiedConcept = EnhancedConceptData(
      logline: concept.logline,
      synopsis: concept.synopsis,
      genre: concept.genre,
      format: newFormat,
      secondaryGenre: concept.secondaryGenre,
      tone: concept.tone,
      targetAudience: concept.targetAudience,
      budgetTier: concept.budgetTier,
      comparableTitle1: concept.comparableTitle1,
      comparableTitle2: concept.comparableTitle2,
      comparableTitle3: concept.comparableTitle3,
    );
    
    final modifiedResult = await _analysisEngine.analyzeConceptWithDelay(modifiedConcept);
    final scoreDelta = modifiedResult.greenlightScore - currentAnalysis.greenlightScore;
    
    final isToSeries = newFormat.contains('Series');
    
    return WhatIfScenario(
      scenarioType: 'format',
      currentValue: concept.format,
      hypotheticalValue: newFormat,
      currentScore: currentAnalysis.greenlightScore,
      projectedScore: modifiedResult.greenlightScore,
      scoreDelta: scoreDelta,
      impactAnalysis: [
        'Format change from ${concept.format} to $newFormat',
        isToSeries 
            ? 'Series format allows deeper character development and world-building'
            : 'Feature format provides focused, contained storytelling',
      ],
      pros: isToSeries
          ? ['More time for character arcs', 'Streaming platforms hungry for content', 'Potential for seasons/franchise']
          : ['Single creative vision', 'Theatrical release potential', 'Prestige/awards consideration'],
      cons: isToSeries
          ? ['Requires more story material', 'Longer development cycle', 'Episode-by-episode hooks needed']
          : ['Limited runtime for complex stories', 'Theatrical market is challenging', 'Less character depth possible'],
      recommendation: _getFormatRecommendation(concept, isToSeries, scoreDelta),
    );
  }
  
  Future<WhatIfScenario> _analyzeBudgetChange(
    EnhancedConceptData concept,
    EnhancedAnalysisResult currentAnalysis,
    String newBudget,
  ) async {
    final modifiedConcept = EnhancedConceptData(
      logline: concept.logline,
      synopsis: concept.synopsis,
      genre: concept.genre,
      format: concept.format,
      secondaryGenre: concept.secondaryGenre,
      tone: concept.tone,
      targetAudience: concept.targetAudience,
      budgetTier: newBudget,
      comparableTitle1: concept.comparableTitle1,
      comparableTitle2: concept.comparableTitle2,
      comparableTitle3: concept.comparableTitle3,
    );
    
    final modifiedResult = await _analysisEngine.analyzeConceptWithDelay(modifiedConcept);
    final scoreDelta = modifiedResult.greenlightScore - currentAnalysis.greenlightScore;
    
    return WhatIfScenario(
      scenarioType: 'budget',
      currentValue: concept.budgetTier ?? 'Not specified',
      hypotheticalValue: newBudget,
      currentScore: currentAnalysis.greenlightScore,
      projectedScore: modifiedResult.greenlightScore,
      scoreDelta: scoreDelta,
      impactAnalysis: [
        'Budget adjustment affects buyer pool and ROI expectations',
        'Different budget tiers attract different buyers',
      ],
      pros: _getBudgetChangePros(newBudget),
      cons: _getBudgetChangeCons(newBudget),
      recommendation: 'Budget tier affects which buyers will consider the project. '
          'Lower budgets = easier greenlight, higher ROI potential. '
          'Higher budgets = bigger stars, wider release.',
    );
  }
  
  Future<WhatIfScenario> _analyzeAudienceChange(
    EnhancedConceptData concept,
    EnhancedAnalysisResult currentAnalysis,
    String newAudience,
  ) async {
    final modifiedConcept = EnhancedConceptData(
      logline: concept.logline,
      synopsis: concept.synopsis,
      genre: concept.genre,
      format: concept.format,
      secondaryGenre: concept.secondaryGenre,
      tone: concept.tone,
      targetAudience: newAudience,
      budgetTier: concept.budgetTier,
      comparableTitle1: concept.comparableTitle1,
      comparableTitle2: concept.comparableTitle2,
      comparableTitle3: concept.comparableTitle3,
    );
    
    final modifiedResult = await _analysisEngine.analyzeConceptWithDelay(modifiedConcept);
    final scoreDelta = modifiedResult.greenlightScore - currentAnalysis.greenlightScore;
    
    return WhatIfScenario(
      scenarioType: 'audience',
      currentValue: concept.targetAudience ?? 'General',
      hypotheticalValue: newAudience,
      currentScore: currentAnalysis.greenlightScore,
      projectedScore: modifiedResult.greenlightScore,
      scoreDelta: scoreDelta,
      impactAnalysis: [
        'Target audience affects marketing and distribution strategy',
        'Different demographics have different viewing habits',
      ],
      pros: ['Focused marketing', 'Clear audience expectations', 'Targeted platform fit'],
      cons: ['May limit crossover appeal', 'Demographic trends shift', 'Niche can mean smaller market'],
      recommendation: 'Consider where your target audience consumes content. '
          'Young adults = streaming-first. Families = theatrical + streaming. '
          'Mature audiences = prestige platforms.',
    );
  }
  
  List<String> _getGenreChangePros(String from, String to, EnhancedAnalysisResult result) {
    final pros = <String>[];
    if (result.marketAnalysis.growthRate > 0) {
      pros.add('$to is a growing market (+${result.marketAnalysis.growthRate}%)');
    }
    if (result.marketAnalysis.streamingDemand > 70) {
      pros.add('High streaming demand for $to content');
    }
    if (result.topBuyers.length >= 5) {
      pros.add('Multiple buyers actively seeking $to projects');
    }
    return pros.isEmpty ? ['Different buyer pool', 'Fresh angle on concept'] : pros;
  }
  
  List<String> _getGenreChangeCons(String from, String to) {
    return [
      'May require significant story adjustments',
      'Different genre conventions to master',
      'Existing comparable titles may not apply',
    ];
  }
  
  String _getFormatRecommendation(EnhancedConceptData concept, bool isToSeries, int scoreDelta) {
    if (isToSeries) {
      return concept.synopsis.length > 500 
          ? 'Your detailed story suggests strong series potential. The concept has enough depth for episodic exploration.'
          : 'Consider expanding the mythology/world to support a series format. Currently reads more as a contained story.';
    } else {
      return concept.synopsis.length < 300
          ? 'Your focused concept is well-suited for a feature film. The contained nature supports theatrical storytelling.'
          : 'You have rich material that could support a feature. Consider which elements are essential vs. which could be cut.';
    }
  }
  
  List<String> _getBudgetChangePros(String budget) {
    if (budget.contains('Micro') || budget.contains('Low')) {
      return ['Easier to greenlight', 'Higher ROI potential', 'More creative freedom', 'Faster production'];
    } else if (budget.contains('Medium')) {
      return ['Balanced risk/reward', 'Star attachment possible', 'Quality production values'];
    } else {
      return ['A-list talent attachment', 'Wide theatrical release', 'Major marketing support'];
    }
  }
  
  List<String> _getBudgetChangeCons(String budget) {
    if (budget.contains('Micro') || budget.contains('Low')) {
      return ['Limited production scope', 'Unknown cast likely', 'Platform release more likely'];
    } else if (budget.contains('Medium')) {
      return ['Competitive market segment', 'Need strong hook', 'Must prove commercial appeal'];
    } else {
      return ['High bar for greenlight', 'IP/franchise preference', 'Risk-averse buyers'];
    }
  }
}

/// Extension for string capitalization
extension StringCapitalize on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
