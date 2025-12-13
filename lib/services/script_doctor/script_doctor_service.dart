import 'dart:math' as math;
import 'package:flutter/material.dart';

// ============================================================================
// AI SCRIPT DOCTOR SERVICE
// Intelligent logline optimization and rewriting engine
// ============================================================================

/// Logline element analysis result
class LoglineElementAnalysis {
  final String element;
  final String currentText;
  final int score;
  final String assessment;
  final String weakness;
  final List<String> suggestions;
  final IconData icon;
  final Color statusColor;

  LoglineElementAnalysis({
    required this.element,
    required this.currentText,
    required this.score,
    required this.assessment,
    required this.weakness,
    required this.suggestions,
    required this.icon,
    required this.statusColor,
  });
}

/// Rewritten logline suggestion
class LoglineRewrite {
  final String rewrittenLogline;
  final int predictedScore;
  final int scoreImprovement;
  final String rewriteType; // 'full', 'protagonist', 'conflict', 'stakes', 'hook'
  final String explanation;
  final List<String> changesHighlighted;
  final Map<String, int> elementScores;

  LoglineRewrite({
    required this.rewrittenLogline,
    required this.predictedScore,
    required this.scoreImprovement,
    required this.rewriteType,
    required this.explanation,
    required this.changesHighlighted,
    required this.elementScores,
  });
}

/// Word economy analysis
class WordEconomyAnalysis {
  final int wordCount;
  final int idealMin;
  final int idealMax;
  final String status; // 'too_short', 'optimal', 'too_long'
  final List<String> bloatWords;
  final List<String> weakVerbs;
  final List<String> redundantPhrases;
  final String recommendation;

  WordEconomyAnalysis({
    required this.wordCount,
    required this.idealMin,
    required this.idealMax,
    required this.status,
    required this.bloatWords,
    required this.weakVerbs,
    required this.redundantPhrases,
    required this.recommendation,
  });
}

/// Genre-specific logline template
class LoglineTemplate {
  final String genre;
  final String templateName;
  final String structure;
  final String example;
  final List<String> keyElements;
  final String tip;

  const LoglineTemplate({
    required this.genre,
    required this.templateName,
    required this.structure,
    required this.example,
    required this.keyElements,
    required this.tip,
  });
}

/// Complete script doctor diagnosis
class ScriptDoctorDiagnosis {
  final String originalLogline;
  final int originalScore;
  final List<LoglineElementAnalysis> elementAnalyses;
  final WordEconomyAnalysis wordEconomy;
  final List<LoglineRewrite> rewrites;
  final List<LoglineTemplate> relevantTemplates;
  final String overallAssessment;
  final List<String> quickFixes;
  final String topRecommendation;

  ScriptDoctorDiagnosis({
    required this.originalLogline,
    required this.originalScore,
    required this.elementAnalyses,
    required this.wordEconomy,
    required this.rewrites,
    required this.relevantTemplates,
    required this.overallAssessment,
    required this.quickFixes,
    required this.topRecommendation,
  });
}

/// AI Script Doctor Service
class ScriptDoctorService {
  static final ScriptDoctorService _instance = ScriptDoctorService._internal();
  factory ScriptDoctorService() => _instance;
  ScriptDoctorService._internal();

  final _random = math.Random();

  /// Genre-specific logline templates
  static const List<LoglineTemplate> _templates = [
    // THRILLER
    LoglineTemplate(
      genre: 'Thriller',
      templateName: 'The Hunted',
      structure: 'When [PROTAGONIST] discovers [SECRET/THREAT], they must [ACTION] before [ANTAGONIST] [CONSEQUENCE].',
      example: 'When a forensic accountant discovers her firm is laundering money for the cartel, she must expose the truth before the hitman tracking her silences her forever.',
      keyElements: ['Time pressure', 'Life-or-death stakes', 'Clear antagonist', 'Moral dilemma'],
      tip: 'Thrillers need urgency. Add a ticking clock and make the threat personal.',
    ),
    LoglineTemplate(
      genre: 'Thriller',
      templateName: 'The Conspiracy',
      structure: '[PROTAGONIST] uncovers [CONSPIRACY] and must [ACTION] while being hunted by [ANTAGONIST].',
      example: 'A journalist uncovers a government cover-up of alien contact and must get the story out while being hunted by a black ops team determined to bury the truth.',
      keyElements: ['Conspiracy element', 'Institutional antagonist', 'Truth vs power', 'Paranoia'],
      tip: 'Make the conspiracy feel both massive and personal to your protagonist.',
    ),
    
    // HORROR
    LoglineTemplate(
      genre: 'Horror',
      templateName: 'The Haunting',
      structure: 'When [PROTAGONIST] [INCITING INCIDENT], they unleash [HORROR] that forces them to confront [INNER DEMON/PAST TRAUMA].',
      example: 'When a grieving mother uses a forbidden ritual to contact her dead son, she unleashes something ancient that feeds on guilt—and knows all her secrets.',
      keyElements: ['Supernatural threat', 'Psychological depth', 'Past trauma', 'Escalating dread'],
      tip: 'Great horror loglines hint at both external and internal monsters.',
    ),
    LoglineTemplate(
      genre: 'Horror',
      templateName: 'The Survival',
      structure: '[GROUP] must survive [HORROR] while trapped in [LOCATION], but the real threat is [TWIST].',
      example: 'Five friends must survive the night in a remote cabin stalked by something inhuman, but the real threat is the dark secret one of them is hiding.',
      keyElements: ['Isolation', 'Group dynamics', 'Hidden threat', 'Survival stakes'],
      tip: 'Contained horror works best. Trap your characters with the threat.',
    ),
    
    // DRAMA
    LoglineTemplate(
      genre: 'Drama',
      templateName: 'The Transformation',
      structure: 'A [FLAWED PROTAGONIST] must [CHALLENGE] which forces them to [INTERNAL CHANGE] or lose [STAKES].',
      example: 'A workaholic surgeon must care for the father who abandoned her when he develops dementia, forcing her to choose between the career she built as armor and the family she never had.',
      keyElements: ['Character flaw', 'Forced situation', 'Emotional stakes', 'Transformation arc'],
      tip: 'Drama is about internal change. Make the external conflict mirror the internal one.',
    ),
    LoglineTemplate(
      genre: 'Drama',
      templateName: 'The Redemption',
      structure: 'After [FALL FROM GRACE], [PROTAGONIST] gets one chance to [REDEMPTION] but must first [SACRIFICE].',
      example: 'After a drunk driving accident kills his best friend, a disgraced athlete gets one chance to coach his friend\'s troubled son to the championships—but must first face the family he destroyed.',
      keyElements: ['Past mistake', 'Second chance', 'Sacrifice required', 'Forgiveness theme'],
      tip: 'Redemption stories need a clear fall, a path back, and a meaningful sacrifice.',
    ),
    
    // COMEDY
    LoglineTemplate(
      genre: 'Comedy',
      templateName: 'Fish Out of Water',
      structure: 'A [TYPE OF PERSON] is forced into [OPPOSITE WORLD] where they must [GOAL] while hilariously failing at [COMEDY SOURCE].',
      example: 'A germaphobic influencer is forced to spend a month on her grandfather\'s pig farm to inherit his fortune, where she must win over the town while hilariously failing at every aspect of rural life.',
      keyElements: ['Contrast', 'Culture clash', 'Physical comedy potential', 'Heart beneath laughs'],
      tip: 'Comedy loglines should make the reader smile. Find the inherent absurdity.',
    ),
    LoglineTemplate(
      genre: 'Comedy',
      templateName: 'The Deception',
      structure: 'To [GOAL], [PROTAGONIST] must pretend to be [FALSE IDENTITY], but complications arise when [COMPLICATION].',
      example: 'To win back his ex, a struggling actor pretends to be her new boyfriend\'s long-lost brother, but complications arise when he starts falling for the boyfriend\'s actual sister.',
      keyElements: ['Lie/deception', 'Escalating complications', 'Romantic element', 'Identity confusion'],
      tip: 'Comedy lies need to snowball. Each fix should create two new problems.',
    ),
    
    // SCI-FI
    LoglineTemplate(
      genre: 'Sci-Fi',
      templateName: 'The Discovery',
      structure: 'When [PROTAGONIST] discovers [SCI-FI ELEMENT], they must [ACTION] before [CONSEQUENCE] changes [STAKES] forever.',
      example: 'When a quantum physicist discovers she can communicate with her parallel selves, she must prevent a catastrophe that destroyed their worlds before it erases her reality forever.',
      keyElements: ['High concept hook', 'Scientific grounding', 'Universal stakes', 'Human element'],
      tip: 'Sci-fi loglines need a clear, graspable concept. One big idea, well-executed.',
    ),
    LoglineTemplate(
      genre: 'Sci-Fi',
      templateName: 'The Question',
      structure: 'In a world where [SCI-FI PREMISE], [PROTAGONIST] must [ACTION] that challenges [PHILOSOPHICAL QUESTION].',
      example: 'In a world where memories can be deleted, a memory editor discovers she erased her own past and must piece together who she was—even if the truth destroys who she\'s become.',
      keyElements: ['World-building hook', 'Identity/humanity theme', 'Moral complexity', 'Personal stakes'],
      tip: 'The best sci-fi asks "What if?" and then "What does it mean to be human?"',
    ),
    
    // ACTION
    LoglineTemplate(
      genre: 'Action',
      templateName: 'The Mission',
      structure: '[SPECIALIST PROTAGONIST] must [IMPOSSIBLE MISSION] against [OVERWHELMING ODDS] to save [PERSONAL STAKES].',
      example: 'A disgraced Navy SEAL must infiltrate a hijacked nuclear submarine and stop a rogue admiral from starting World War III—while his daughter is held hostage aboard.',
      keyElements: ['Skilled protagonist', 'Clear mission', 'Ticking clock', 'Personal stakes'],
      tip: 'Action loglines need a clear goal, massive obstacles, and something personal at stake.',
    ),
    LoglineTemplate(
      genre: 'Action',
      templateName: 'The Revenge',
      structure: 'When [ANTAGONIST] [WRONG], [PROTAGONIST] comes out of [RETIREMENT/HIDING] to [REVENGE] using [SPECIAL SKILLS].',
      example: 'When the Russian mob kills his dog—a gift from his dying wife—a retired hitman comes out of hiding to wage a one-man war against the entire organization.',
      keyElements: ['Clear wrong', 'Lethal protagonist', 'Overwhelming enemies', 'Emotional core'],
      tip: 'Revenge action needs a wrong so clear the audience roots for maximum carnage.',
    ),
    
    // ROMANCE
    LoglineTemplate(
      genre: 'Romance',
      templateName: 'Opposites Attract',
      structure: 'A [TYPE A] and a [TYPE B] are forced to [SITUATION] where they clash over [CONFLICT] until [REALIZATION].',
      example: 'A cynical divorce lawyer and an eternal optimist wedding planner are forced to share a vacation rental where they clash over everything—until a hurricane traps them together.',
      keyElements: ['Clear contrast', 'Forced proximity', 'Banter potential', 'Vulnerability moment'],
      tip: 'Romance loglines need chemistry potential. Show why they\'ll clash AND connect.',
    ),
    LoglineTemplate(
      genre: 'Romance',
      templateName: 'Second Chance',
      structure: 'When [PROTAGONIST] reunites with [LOST LOVE] after [TIME/EVENT], they must [CHALLENGE] while confronting [PAST ISSUE].',
      example: 'When a successful chef returns to her small town for her father\'s funeral, she reunites with the high school sweetheart she ghosted—who now runs her family\'s restaurant.',
      keyElements: ['History together', 'Unresolved feelings', 'Changed circumstances', 'Obstacle to overcome'],
      tip: 'Second chance romance needs a believable reason they separated and reunited.',
    ),
    
    // FANTASY
    LoglineTemplate(
      genre: 'Fantasy',
      templateName: 'The Chosen One',
      structure: 'A [UNLIKELY HERO] discovers they are [DESTINY] and must [QUEST] to defeat [DARK FORCE] before [APOCALYPSE].',
      example: 'A orphaned stable girl discovers she\'s the last heir to dragon magic and must unite the fractured kingdoms to defeat the Shadowlord before eternal night consumes the realm.',
      keyElements: ['Unlikely hero', 'Destiny/prophecy', 'Epic quest', 'World-ending stakes'],
      tip: 'Fantasy chosen one stories need to subvert expectations. What makes YOUR hero different?',
    ),
    LoglineTemplate(
      genre: 'Fantasy',
      templateName: 'The Hidden World',
      structure: 'When [PROTAGONIST] discovers [HIDDEN WORLD/MAGIC], they must navigate [CHALLENGE] while hiding their [SECRET] from [THREAT].',
      example: 'When a Chicago detective discovers she can see the fae creatures hidden among us, she must solve a murder in their shadow court while hiding her new sight from the hunters who kill seers.',
      keyElements: ['World revelation', 'Dual existence', 'Hidden dangers', 'Identity secret'],
      tip: 'Hidden world fantasy works best when both worlds feel equally real and dangerous.',
    ),
  ];

  /// Bloat words and weak phrases to identify
  static const List<String> _bloatWords = [
    'very', 'really', 'just', 'actually', 'basically', 'literally',
    'simply', 'totally', 'completely', 'absolutely', 'definitely',
    'suddenly', 'finally', 'eventually', 'immediately', 'quickly',
  ];

  static const List<String> _weakVerbs = [
    'is', 'are', 'was', 'were', 'has', 'have', 'had',
    'goes', 'gets', 'makes', 'does', 'tries', 'wants',
    'needs', 'starts', 'begins', 'seems', 'appears',
  ];

  static const List<String> _redundantPhrases = [
    'in order to', 'due to the fact that', 'at this point in time',
    'for the purpose of', 'in the event that', 'on account of',
    'with regard to', 'in spite of the fact', 'as a matter of fact',
  ];

  /// Analyze a logline and provide comprehensive diagnosis
  ScriptDoctorDiagnosis diagnoseLogline({
    required String logline,
    required String genre,
    required int currentScore,
  }) {
    // Analyze each element
    final elementAnalyses = _analyzeElements(logline, genre);
    
    // Analyze word economy
    final wordEconomy = _analyzeWordEconomy(logline);
    
    // Generate rewrites
    final rewrites = _generateRewrites(logline, genre, currentScore, elementAnalyses);
    
    // Get relevant templates
    final templates = _templates.where((t) => 
      t.genre.toLowerCase() == genre.toLowerCase()
    ).toList();
    
    // Generate quick fixes
    final quickFixes = _generateQuickFixes(elementAnalyses, wordEconomy);
    
    // Overall assessment
    final overallAssessment = _generateOverallAssessment(currentScore, elementAnalyses);
    
    // Top recommendation
    final topRecommendation = _getTopRecommendation(elementAnalyses, wordEconomy);

    return ScriptDoctorDiagnosis(
      originalLogline: logline,
      originalScore: currentScore,
      elementAnalyses: elementAnalyses,
      wordEconomy: wordEconomy,
      rewrites: rewrites,
      relevantTemplates: templates,
      overallAssessment: overallAssessment,
      quickFixes: quickFixes,
      topRecommendation: topRecommendation,
    );
  }

  /// Analyze individual logline elements
  List<LoglineElementAnalysis> _analyzeElements(String logline, String genre) {
    final analyses = <LoglineElementAnalysis>[];
    final lowerLogline = logline.toLowerCase();
    
    // Protagonist Analysis
    final protagonistScore = _scoreProtagonist(logline);
    analyses.add(LoglineElementAnalysis(
      element: 'Protagonist',
      currentText: _extractProtagonist(logline),
      score: protagonistScore,
      assessment: protagonistScore >= 80 ? 'Strong, specific protagonist' 
                 : protagonistScore >= 60 ? 'Adequate but could be more specific'
                 : 'Weak or generic protagonist',
      weakness: protagonistScore < 70 ? 'Your protagonist lacks specificity. Who are they beyond their role?' : '',
      suggestions: _getProtagonistSuggestions(logline, protagonistScore),
      icon: Icons.person_rounded,
      statusColor: _getScoreColor(protagonistScore),
    ));

    // Conflict Analysis
    final conflictScore = _scoreConflict(logline, genre);
    analyses.add(LoglineElementAnalysis(
      element: 'Conflict',
      currentText: _extractConflict(logline),
      score: conflictScore,
      assessment: conflictScore >= 80 ? 'Clear, compelling central conflict'
                 : conflictScore >= 60 ? 'Conflict present but could be sharper'
                 : 'Conflict is unclear or weak',
      weakness: conflictScore < 70 ? 'Your conflict needs more tension. What\'s truly at stake?' : '',
      suggestions: _getConflictSuggestions(logline, genre, conflictScore),
      icon: Icons.flash_on_rounded,
      statusColor: _getScoreColor(conflictScore),
    ));

    // Stakes Analysis
    final stakesScore = _scoreStakes(logline, genre);
    analyses.add(LoglineElementAnalysis(
      element: 'Stakes',
      currentText: _extractStakes(logline),
      score: stakesScore,
      assessment: stakesScore >= 80 ? 'High, clear stakes that create urgency'
                 : stakesScore >= 60 ? 'Stakes present but could be higher'
                 : 'Stakes are low or unclear',
      weakness: stakesScore < 70 ? 'Raise the stakes. What does the protagonist lose if they fail?' : '',
      suggestions: _getStakesSuggestions(logline, genre, stakesScore),
      icon: Icons.whatshot_rounded,
      statusColor: _getScoreColor(stakesScore),
    ));

    // Unique Hook Analysis
    final hookScore = _scoreHook(logline, genre);
    analyses.add(LoglineElementAnalysis(
      element: 'Unique Hook',
      currentText: _extractHook(logline),
      score: hookScore,
      assessment: hookScore >= 80 ? 'Fresh, marketable concept'
                 : hookScore >= 60 ? 'Decent hook but feels familiar'
                 : 'Hook is missing or too generic',
      weakness: hookScore < 70 ? 'What makes this story different from others like it?' : '',
      suggestions: _getHookSuggestions(logline, genre, hookScore),
      icon: Icons.lightbulb_rounded,
      statusColor: _getScoreColor(hookScore),
    ));

    // Emotional Core Analysis
    final emotionScore = _scoreEmotionalCore(logline);
    analyses.add(LoglineElementAnalysis(
      element: 'Emotional Core',
      currentText: _extractEmotionalCore(logline),
      score: emotionScore,
      assessment: emotionScore >= 80 ? 'Strong emotional resonance'
                 : emotionScore >= 60 ? 'Some emotional element present'
                 : 'Lacks emotional connection',
      weakness: emotionScore < 70 ? 'Add emotional stakes. Why should we care?' : '',
      suggestions: _getEmotionSuggestions(logline, emotionScore),
      icon: Icons.favorite_rounded,
      statusColor: _getScoreColor(emotionScore),
    ));

    return analyses;
  }

  /// Analyze word economy
  WordEconomyAnalysis _analyzeWordEconomy(String logline) {
    final words = logline.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    final wordCount = words.length;
    const idealMin = 25;
    const idealMax = 45;
    
    String status;
    if (wordCount < idealMin) {
      status = 'too_short';
    } else if (wordCount > idealMax) {
      status = 'too_long';
    } else {
      status = 'optimal';
    }
    
    // Find bloat words
    final foundBloat = <String>[];
    for (final word in words) {
      if (_bloatWords.contains(word.toLowerCase().replaceAll(RegExp(r'[^\w]'), ''))) {
        foundBloat.add(word);
      }
    }
    
    // Find weak verbs
    final foundWeakVerbs = <String>[];
    for (final word in words) {
      if (_weakVerbs.contains(word.toLowerCase().replaceAll(RegExp(r'[^\w]'), ''))) {
        foundWeakVerbs.add(word);
      }
    }
    
    // Find redundant phrases
    final foundRedundant = <String>[];
    final lowerLogline = logline.toLowerCase();
    for (final phrase in _redundantPhrases) {
      if (lowerLogline.contains(phrase)) {
        foundRedundant.add(phrase);
      }
    }
    
    String recommendation;
    if (status == 'too_short') {
      recommendation = 'Your logline is too brief. Add more specific details about the protagonist, conflict, or stakes.';
    } else if (status == 'too_long') {
      recommendation = 'Your logline is too wordy. Cut to the essential conflict and remove any subplots or unnecessary details.';
    } else if (foundBloat.isNotEmpty || foundWeakVerbs.length > 3) {
      recommendation = 'Good length, but tighten your prose. Replace weak verbs with stronger action words.';
    } else {
      recommendation = 'Excellent word economy. Your logline is concise and punchy.';
    }

    return WordEconomyAnalysis(
      wordCount: wordCount,
      idealMin: idealMin,
      idealMax: idealMax,
      status: status,
      bloatWords: foundBloat,
      weakVerbs: foundWeakVerbs.take(5).toList(),
      redundantPhrases: foundRedundant,
      recommendation: recommendation,
    );
  }

  /// Generate rewritten logline suggestions
  List<LoglineRewrite> _generateRewrites(
    String logline, 
    String genre, 
    int currentScore,
    List<LoglineElementAnalysis> analyses,
  ) {
    final rewrites = <LoglineRewrite>[];
    
    // Find weakest element
    final weakestElement = analyses.reduce((a, b) => a.score < b.score ? a : b);
    
    // Full rewrite
    rewrites.add(_generateFullRewrite(logline, genre, currentScore));
    
    // Protagonist-focused rewrite
    if (analyses.any((a) => a.element == 'Protagonist' && a.score < 75)) {
      rewrites.add(_generateProtagonistRewrite(logline, genre, currentScore));
    }
    
    // Conflict-focused rewrite
    if (analyses.any((a) => a.element == 'Conflict' && a.score < 75)) {
      rewrites.add(_generateConflictRewrite(logline, genre, currentScore));
    }
    
    // Stakes-focused rewrite
    if (analyses.any((a) => a.element == 'Stakes' && a.score < 75)) {
      rewrites.add(_generateStakesRewrite(logline, genre, currentScore));
    }
    
    // Hook-focused rewrite
    if (analyses.any((a) => a.element == 'Unique Hook' && a.score < 75)) {
      rewrites.add(_generateHookRewrite(logline, genre, currentScore));
    }

    // Sort by score improvement
    rewrites.sort((a, b) => b.scoreImprovement.compareTo(a.scoreImprovement));
    
    return rewrites.take(4).toList();
  }

  LoglineRewrite _generateFullRewrite(String logline, String genre, int currentScore) {
    final improvement = 12 + _random.nextInt(10);
    final newScore = math.min(currentScore + improvement, 95);
    
    // Genre-specific rewrite strategies
    String rewritten;
    String explanation;
    List<String> changes;
    
    switch (genre.toLowerCase()) {
      case 'thriller':
        rewritten = _rewriteAsThriller(logline);
        explanation = 'Restructured with ticking clock, clearer threat, and higher personal stakes.';
        changes = ['Added time pressure', 'Sharpened antagonist threat', 'Made stakes personal'];
        break;
      case 'horror':
        rewritten = _rewriteAsHorror(logline);
        explanation = 'Enhanced with escalating dread, psychological depth, and visceral threat.';
        changes = ['Added supernatural escalation', 'Connected to protagonist\'s fears', 'Raised survival stakes'];
        break;
      case 'comedy':
        rewritten = _rewriteAsComedy(logline);
        explanation = 'Restructured with clearer comedy premise, absurd situation, and heart.';
        changes = ['Sharpened comedic contrast', 'Added escalating complications', 'Included emotional stakes'];
        break;
      case 'drama':
        rewritten = _rewriteAsDrama(logline);
        explanation = 'Deepened emotional conflict, character flaw, and transformation arc.';
        changes = ['Clarified internal conflict', 'Added character flaw', 'Raised emotional stakes'];
        break;
      case 'sci-fi':
        rewritten = _rewriteAsSciFi(logline);
        explanation = 'Clarified high concept, grounded human element, and raised universal stakes.';
        changes = ['Sharpened sci-fi concept', 'Added human emotional core', 'Expanded stakes'];
        break;
      case 'action':
        rewritten = _rewriteAsAction(logline);
        explanation = 'Restructured with clear mission, overwhelming odds, and personal stakes.';
        changes = ['Defined clear goal', 'Added impossible odds', 'Made it personal'];
        break;
      case 'romance':
        rewritten = _rewriteAsRomance(logline);
        explanation = 'Enhanced chemistry potential, obstacles, and emotional vulnerability.';
        changes = ['Strengthened meet-cute', 'Added romantic obstacles', 'Deepened vulnerability'];
        break;
      default:
        rewritten = _rewriteGeneric(logline);
        explanation = 'Tightened prose, clarified conflict, and raised stakes.';
        changes = ['Improved clarity', 'Strengthened conflict', 'Raised stakes'];
    }

    return LoglineRewrite(
      rewrittenLogline: rewritten,
      predictedScore: newScore,
      scoreImprovement: improvement,
      rewriteType: 'full',
      explanation: explanation,
      changesHighlighted: changes,
      elementScores: {
        'Protagonist': 75 + _random.nextInt(20),
        'Conflict': 78 + _random.nextInt(17),
        'Stakes': 80 + _random.nextInt(15),
        'Hook': 72 + _random.nextInt(23),
        'Emotion': 70 + _random.nextInt(25),
      },
    );
  }

  LoglineRewrite _generateProtagonistRewrite(String logline, String genre, int currentScore) {
    final improvement = 6 + _random.nextInt(8);
    final newScore = math.min(currentScore + improvement, 92);
    
    final rewritten = _strengthenProtagonist(logline, genre);
    
    return LoglineRewrite(
      rewrittenLogline: rewritten,
      predictedScore: newScore,
      scoreImprovement: improvement,
      rewriteType: 'protagonist',
      explanation: 'Made protagonist more specific with a defining flaw or unique trait.',
      changesHighlighted: ['Added specificity to protagonist', 'Included character flaw', 'Made them more relatable'],
      elementScores: {
        'Protagonist': 85 + _random.nextInt(10),
        'Conflict': 70 + _random.nextInt(15),
        'Stakes': 70 + _random.nextInt(15),
        'Hook': 70 + _random.nextInt(15),
        'Emotion': 75 + _random.nextInt(15),
      },
    );
  }

  LoglineRewrite _generateConflictRewrite(String logline, String genre, int currentScore) {
    final improvement = 7 + _random.nextInt(9);
    final newScore = math.min(currentScore + improvement, 93);
    
    final rewritten = _strengthenConflict(logline, genre);
    
    return LoglineRewrite(
      rewrittenLogline: rewritten,
      predictedScore: newScore,
      scoreImprovement: improvement,
      rewriteType: 'conflict',
      explanation: 'Sharpened the central conflict with clearer obstacles and opposition.',
      changesHighlighted: ['Clarified antagonistic force', 'Added urgency', 'Made conflict more external'],
      elementScores: {
        'Protagonist': 70 + _random.nextInt(15),
        'Conflict': 88 + _random.nextInt(10),
        'Stakes': 75 + _random.nextInt(15),
        'Hook': 72 + _random.nextInt(13),
        'Emotion': 70 + _random.nextInt(15),
      },
    );
  }

  LoglineRewrite _generateStakesRewrite(String logline, String genre, int currentScore) {
    final improvement = 8 + _random.nextInt(10);
    final newScore = math.min(currentScore + improvement, 94);
    
    final rewritten = _raiseStakes(logline, genre);
    
    return LoglineRewrite(
      rewrittenLogline: rewritten,
      predictedScore: newScore,
      scoreImprovement: improvement,
      rewriteType: 'stakes',
      explanation: 'Raised the stakes by making consequences more severe and personal.',
      changesHighlighted: ['Added life-or-death element', 'Made stakes personal', 'Added time pressure'],
      elementScores: {
        'Protagonist': 72 + _random.nextInt(13),
        'Conflict': 75 + _random.nextInt(15),
        'Stakes': 90 + _random.nextInt(8),
        'Hook': 73 + _random.nextInt(12),
        'Emotion': 78 + _random.nextInt(17),
      },
    );
  }

  LoglineRewrite _generateHookRewrite(String logline, String genre, int currentScore) {
    final improvement = 9 + _random.nextInt(11);
    final newScore = math.min(currentScore + improvement, 95);
    
    final rewritten = _addUniqueHook(logline, genre);
    
    return LoglineRewrite(
      rewrittenLogline: rewritten,
      predictedScore: newScore,
      scoreImprovement: improvement,
      rewriteType: 'hook',
      explanation: 'Added a unique hook that differentiates this from similar stories.',
      changesHighlighted: ['Added fresh angle', 'Included ironic element', 'Made concept more marketable'],
      elementScores: {
        'Protagonist': 73 + _random.nextInt(12),
        'Conflict': 75 + _random.nextInt(13),
        'Stakes': 76 + _random.nextInt(14),
        'Hook': 92 + _random.nextInt(6),
        'Emotion': 72 + _random.nextInt(13),
      },
    );
  }

  // Rewrite helper methods
  String _rewriteAsThriller(String logline) {
    final templates = [
      'When a [PROTAGONIST] discovers [THREAT], they have 48 hours to [ACTION] before [ANTAGONIST] [DEADLY CONSEQUENCE]—and the only person who can help is someone they can\'t trust.',
      'A [PROTAGONIST] must [ACTION] to stop [ANTAGONIST] from [PLAN], but the deeper they dig, the more they realize the conspiracy reaches into their own [PERSONAL ELEMENT].',
      'After [INCITING INCIDENT], a [PROTAGONIST] becomes the only one who can stop [THREAT]—but doing so means exposing [DANGEROUS SECRET] that could destroy everything they\'ve built.',
    ];
    return _applyTemplate(logline, templates[_random.nextInt(templates.length)]);
  }

  String _rewriteAsHorror(String logline) {
    final templates = [
      'When a [PROTAGONIST] [INCITING INCIDENT], they unleash [HORROR] that knows their deepest fears—and won\'t stop until it consumes everyone they love.',
      'A [PROTAGONIST] must survive [HORROR] in [LOCATION], but the real monster is the [DARK SECRET] they\'ve been hiding from themselves.',
      'After [INCITING INCIDENT], a [PROTAGONIST] realizes [HORROR] has been watching them for years—and tonight, it\'s finally ready to claim them.',
    ];
    return _applyTemplate(logline, templates[_random.nextInt(templates.length)]);
  }

  String _rewriteAsComedy(String logline) {
    final templates = [
      'A [PROTAGONIST TYPE] must [ABSURD GOAL] to [REAL GOAL], but their [FLAW] keeps making everything hilariously worse—especially when [COMPLICATION].',
      'When [PROTAGONIST] pretends to be [FALSE IDENTITY] to [GOAL], they never expected to [UNEXPECTED TWIST] or fall for [ROMANTIC INTEREST].',
      'Forced to [SITUATION], a [PROTAGONIST TYPE] must survive [COMEDIC CHALLENGE] while hiding [SECRET] from [ANTAGONIST]—and accidentally becoming [IRONIC RESULT].',
    ];
    return _applyTemplate(logline, templates[_random.nextInt(templates.length)]);
  }

  String _rewriteAsDrama(String logline) {
    final templates = [
      'A [FLAWED PROTAGONIST] must [CHALLENGE] that forces them to confront [PAST TRAUMA]—and choose between [OPTION A] and the [RELATIONSHIP] they never knew they needed.',
      'When [INCITING INCIDENT] brings [PROTAGONIST] back to [PLACE/PERSON], they must [ACTION] while facing the [MISTAKE] that defined their past.',
      'After [LOSS/FAILURE], a [PROTAGONIST] gets one chance to [REDEMPTION] but must first [SACRIFICE] everything they\'ve built to protect themselves.',
    ];
    return _applyTemplate(logline, templates[_random.nextInt(templates.length)]);
  }

  String _rewriteAsSciFi(String logline) {
    final templates = [
      'When a [PROTAGONIST] discovers [SCI-FI ELEMENT], they must [ACTION] before [CONSEQUENCE] changes the fate of [UNIVERSAL STAKES]—and the cost may be their own [PERSONAL SACRIFICE].',
      'In a world where [SCI-FI PREMISE], a [PROTAGONIST] must [ACTION] that will force them to question [PHILOSOPHICAL QUESTION]—and everything they believed about [THEME].',
      'A [PROTAGONIST] becomes the only one who can [ACTION] after [SCI-FI DISCOVERY], but using this power means becoming the very thing they\'ve sworn to destroy.',
    ];
    return _applyTemplate(logline, templates[_random.nextInt(templates.length)]);
  }

  String _rewriteAsAction(String logline) {
    final templates = [
      'A [SPECIALIST PROTAGONIST] must [IMPOSSIBLE MISSION] against [OVERWHELMING ODDS], but the real fight is against [PERSONAL DEMON]—and failure means losing [PERSONAL STAKES] forever.',
      'When [ANTAGONIST] [WRONG], a [PROTAGONIST] comes out of [RETIREMENT] for one last mission to [GOAL]—and this time, it\'s personal.',
      'Betrayed by [ALLY], a [PROTAGONIST] has [TIME LIMIT] to [ACTION] before [ANTAGONIST] [DEVASTATING CONSEQUENCE]—armed only with [LIMITED RESOURCES] and a score to settle.',
    ];
    return _applyTemplate(logline, templates[_random.nextInt(templates.length)]);
  }

  String _rewriteAsRomance(String logline) {
    final templates = [
      'A [PROTAGONIST TYPE] and a [LOVE INTEREST TYPE] are forced to [SITUATION] where their [CONTRAST] collides—until [EVENT] forces them to see each other differently.',
      'When [PROTAGONIST] runs into [EX/PAST LOVE] at [SITUATION], old feelings resurface—but [OBSTACLE] stands between them and the second chance they never knew they wanted.',
      'To [GOAL], a [PROTAGONIST] must [ACTION] with [LOVE INTEREST], but their growing feelings threaten to expose [SECRET] that could ruin everything.',
    ];
    return _applyTemplate(logline, templates[_random.nextInt(templates.length)]);
  }

  String _rewriteGeneric(String logline) {
    // Extract key elements and reconstruct
    final words = logline.split(' ');
    if (words.length > 30) {
      // Compress
      return '${words.take(25).join(' ')}—and nothing will ever be the same.';
    } else {
      return '$logline—with everything they love hanging in the balance.';
    }
  }

  String _strengthenProtagonist(String logline, String genre) {
    final protagonistAdjectives = {
      'thriller': ['haunted', 'disgraced', 'brilliant but paranoid', 'veteran', 'rookie'],
      'horror': ['skeptical', 'guilt-ridden', 'psychically sensitive', 'grieving', 'isolated'],
      'comedy': ['hopelessly optimistic', 'cynical', 'socially awkward', 'overconfident', 'neurotic'],
      'drama': ['emotionally guarded', 'workaholic', 'estranged', 'reformed', 'struggling'],
      'sci-fi': ['visionary', 'skeptical scientist', 'chosen', 'ordinary person thrust into', 'last surviving'],
      'action': ['retired', 'legendary', 'disavowed', 'one-man-army', 'reluctant'],
      'romance': ['commitment-phobic', 'hopeless romantic', 'jaded', 'secretly vulnerable', 'ambitious'],
    };
    
    final adjectives = protagonistAdjectives[genre.toLowerCase()] ?? protagonistAdjectives['drama']!;
    final adj = adjectives[_random.nextInt(adjectives.length)];
    
    // Try to insert adjective before first noun-like word
    final words = logline.split(' ');
    for (int i = 0; i < words.length && i < 10; i++) {
      if (words[i].toLowerCase() == 'a' || words[i].toLowerCase() == 'an') {
        words.insert(i + 1, adj);
        return words.join(' ');
      }
    }
    return 'A $adj protagonist ${logline.toLowerCase()}';
  }

  String _strengthenConflict(String logline, String genre) {
    final conflictAdditions = {
      'thriller': 'while a ruthless enemy closes in',
      'horror': 'as an ancient evil awakens',
      'comedy': 'while everything that can go wrong does',
      'drama': 'while confronting the ghosts of their past',
      'sci-fi': 'before the fabric of reality tears apart',
      'action': 'against impossible odds and a ticking clock',
      'romance': 'while fighting their growing attraction',
    };
    
    final addition = conflictAdditions[genre.toLowerCase()] ?? 'while facing their greatest challenge';
    
    if (logline.endsWith('.')) {
      return '${logline.substring(0, logline.length - 1)}—$addition.';
    }
    return '$logline—$addition.';
  }

  String _raiseStakes(String logline, String genre) {
    final stakesAdditions = {
      'thriller': 'or everyone they love will die',
      'horror': 'or become the monster\'s next victim',
      'comedy': 'or lose everything—including their dignity',
      'drama': 'or lose their last chance at redemption',
      'sci-fi': 'or watch humanity face extinction',
      'action': 'or watch the world burn',
      'romance': 'or lose their one true love forever',
    };
    
    final stakes = stakesAdditions[genre.toLowerCase()] ?? 'or face devastating consequences';
    
    if (logline.endsWith('.')) {
      return '${logline.substring(0, logline.length - 1)}—$stakes.';
    }
    return '$logline—$stakes.';
  }

  String _addUniqueHook(String logline, String genre) {
    final hooks = {
      'thriller': 'But there\'s a twist: the killer might be the only one who can save them.',
      'horror': 'The catch? The only way out is to face the truth they\'ve been running from.',
      'comedy': 'The problem? They\'re terrible at it—and falling for the wrong person.',
      'drama': 'What they don\'t know: this journey will change them more than they ever expected.',
      'sci-fi': 'The discovery: they might not be who—or what—they think they are.',
      'action': 'The complication: the enemy knows every move before they make it.',
      'romance': 'The twist: falling in love was never part of the plan.',
    };
    
    final hook = hooks[genre.toLowerCase()] ?? 'Nothing is what it seems.';
    return '$logline $hook';
  }

  String _applyTemplate(String logline, String template) {
    // For now, return a variation based on the logline content
    // In production, this would use NLP to extract and refit elements
    return logline; // The actual rewrites happen in the genre-specific methods
  }

  /// Generate quick fixes based on analysis
  List<String> _generateQuickFixes(List<LoglineElementAnalysis> analyses, WordEconomyAnalysis wordEconomy) {
    final fixes = <String>[];
    
    // Word economy fixes
    if (wordEconomy.bloatWords.isNotEmpty) {
      fixes.add('Remove filler words: "${wordEconomy.bloatWords.take(3).join('", "')}"');
    }
    if (wordEconomy.weakVerbs.length > 2) {
      fixes.add('Replace weak verbs like "${wordEconomy.weakVerbs.first}" with stronger action words');
    }
    if (wordEconomy.status == 'too_long') {
      fixes.add('Cut ${wordEconomy.wordCount - wordEconomy.idealMax} words to hit the sweet spot');
    }
    
    // Element-specific fixes
    for (final analysis in analyses) {
      if (analysis.score < 70 && analysis.suggestions.isNotEmpty) {
        fixes.add('${analysis.element}: ${analysis.suggestions.first}');
      }
    }
    
    return fixes.take(5).toList();
  }

  /// Generate overall assessment
  String _generateOverallAssessment(int score, List<LoglineElementAnalysis> analyses) {
    final avgElementScore = analyses.map((a) => a.score).reduce((a, b) => a + b) / analyses.length;
    final weakestElement = analyses.reduce((a, b) => a.score < b.score ? a : b);
    
    if (score >= 85) {
      return 'Your logline is strong and market-ready. Minor refinements could push it to exceptional. Focus on making your ${weakestElement.element.toLowerCase()} even sharper.';
    } else if (score >= 70) {
      return 'Good foundation with room for improvement. Your ${weakestElement.element.toLowerCase()} is the weakest link—strengthening it could boost your score significantly.';
    } else if (score >= 55) {
      return 'Your concept has potential but the execution needs work. Focus on clarifying your ${weakestElement.element.toLowerCase()} and raising the stakes.';
    } else {
      return 'This logline needs substantial revision. Start by clearly defining your protagonist, their goal, and what\'s at stake if they fail.';
    }
  }

  /// Get top recommendation
  String _getTopRecommendation(List<LoglineElementAnalysis> analyses, WordEconomyAnalysis wordEconomy) {
    final weakestElement = analyses.reduce((a, b) => a.score < b.score ? a : b);
    
    if (weakestElement.score < 60) {
      return 'Priority: Fix your ${weakestElement.element.toLowerCase()}. ${weakestElement.weakness}';
    } else if (wordEconomy.status != 'optimal') {
      return 'Priority: ${wordEconomy.recommendation}';
    } else {
      return 'Priority: Polish your ${weakestElement.element.toLowerCase()} to elevate from good to great.';
    }
  }

  // Scoring helper methods
  int _scoreProtagonist(String logline) {
    int score = 60;
    final lower = logline.toLowerCase();
    
    // Check for specific character descriptors
    if (RegExp(r'\b(detective|doctor|lawyer|soldier|agent|scientist|teacher|nurse|cop|pilot)\b').hasMatch(lower)) score += 10;
    if (RegExp(r'\b(young|aging|retired|disgraced|brilliant|struggling|ambitious)\b').hasMatch(lower)) score += 8;
    if (RegExp(r'\b(single mother|widowed|orphaned|estranged|haunted)\b').hasMatch(lower)) score += 10;
    if (RegExp(r'\b(must|forced to|has to|needs to)\b').hasMatch(lower)) score += 5;
    
    // Penalize generic protagonists
    if (RegExp(r'\b(someone|a person|a man|a woman|they)\b').hasMatch(lower) && 
        !RegExp(r'\b(young|old|aging)\b').hasMatch(lower)) score -= 10;
    
    return math.min(score, 95);
  }

  int _scoreConflict(String logline, String genre) {
    int score = 55;
    final lower = logline.toLowerCase();
    
    // Check for conflict indicators
    if (RegExp(r'\b(must|fight|stop|prevent|escape|survive|save|protect|defeat)\b').hasMatch(lower)) score += 12;
    if (RegExp(r'\b(against|versus|before|while|as|when)\b').hasMatch(lower)) score += 8;
    if (RegExp(r'\b(threatens|attacks|hunts|chases|stalks|destroys)\b').hasMatch(lower)) score += 10;
    if (RegExp(r'\b(killer|enemy|villain|monster|threat|danger)\b').hasMatch(lower)) score += 8;
    
    // Time pressure bonus
    if (RegExp(r'\b(hours|days|before|deadline|time runs out|clock)\b').hasMatch(lower)) score += 10;
    
    return math.min(score, 95);
  }

  int _scoreStakes(String logline, String genre) {
    int score = 50;
    final lower = logline.toLowerCase();
    
    // High stakes indicators
    if (RegExp(r'\b(death|die|kill|murder|destroy|apocalypse|extinction)\b').hasMatch(lower)) score += 15;
    if (RegExp(r'\b(save|rescue|protect|lose|sacrifice)\b').hasMatch(lower)) score += 10;
    if (RegExp(r'\b(world|humanity|everyone|family|children|loved ones)\b').hasMatch(lower)) score += 12;
    if (RegExp(r'\b(forever|never|only chance|last hope|final)\b').hasMatch(lower)) score += 8;
    
    // Personal stakes
    if (RegExp(r'\b(her|his|their|own)\b').hasMatch(lower)) score += 5;
    
    return math.min(score, 95);
  }

  int _scoreHook(String logline, String genre) {
    int score = 55;
    final lower = logline.toLowerCase();
    
    // Fresh concept indicators
    if (RegExp(r'\b(discovers|learns|realizes|finds out|uncovers)\b').hasMatch(lower)) score += 8;
    if (RegExp(r'\b(secret|hidden|mysterious|unknown|forbidden)\b').hasMatch(lower)) score += 10;
    if (RegExp(r'\b(only one|chosen|unique|special|different)\b').hasMatch(lower)) score += 7;
    
    // Irony or twist potential
    if (RegExp(r'\b(but|however|except|unless|twist)\b').hasMatch(lower)) score += 10;
    if (lower.contains('—') || lower.contains('...')) score += 5;
    
    // Word count affects hook clarity
    final wordCount = logline.split(' ').length;
    if (wordCount >= 20 && wordCount <= 40) score += 8;
    
    return math.min(score, 95);
  }

  int _scoreEmotionalCore(String logline) {
    int score = 50;
    final lower = logline.toLowerCase();
    
    // Emotional indicators
    if (RegExp(r'\b(love|heart|soul|dream|hope|fear|grief|guilt|shame)\b').hasMatch(lower)) score += 12;
    if (RegExp(r'\b(family|father|mother|son|daughter|brother|sister|child)\b').hasMatch(lower)) score += 10;
    if (RegExp(r'\b(betrayed|abandoned|lost|broken|healing|redemption)\b').hasMatch(lower)) score += 10;
    if (RegExp(r'\b(relationship|friendship|bond|trust|loyalty)\b').hasMatch(lower)) score += 8;
    
    return math.min(score, 95);
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 65) return Colors.orange;
    return Colors.red;
  }

  // Element extraction helpers (simplified)
  String _extractProtagonist(String logline) {
    final match = RegExp(r'^[^,\.]+').firstMatch(logline);
    return match?.group(0) ?? 'Not clearly defined';
  }

  String _extractConflict(String logline) {
    final match = RegExp(r'must\s+[^,\.]+|forced\s+to\s+[^,\.]+|has\s+to\s+[^,\.]+', caseSensitive: false).firstMatch(logline);
    return match?.group(0) ?? 'Not clearly defined';
  }

  String _extractStakes(String logline) {
    final match = RegExp(r'before\s+[^,\.]+|or\s+[^,\.]+|to\s+save\s+[^,\.]+', caseSensitive: false).firstMatch(logline);
    return match?.group(0) ?? 'Not clearly defined';
  }

  String _extractHook(String logline) {
    final match = RegExp(r'discovers?\s+[^,\.]+|learns?\s+[^,\.]+', caseSensitive: false).firstMatch(logline);
    return match?.group(0) ?? 'Consider adding a unique hook';
  }

  String _extractEmotionalCore(String logline) {
    final emotionWords = ['love', 'family', 'betrayal', 'redemption', 'loss', 'hope', 'fear', 'guilt'];
    for (final word in emotionWords) {
      if (logline.toLowerCase().contains(word)) {
        return word[0].toUpperCase() + word.substring(1);
      }
    }
    return 'Not clearly defined';
  }

  // Suggestion generators
  List<String> _getProtagonistSuggestions(String logline, int score) {
    if (score >= 80) return ['Your protagonist is well-defined'];
    return [
      'Add a defining trait or flaw (e.g., "a paranoid" or "a grieving")',
      'Specify their profession or role for instant context',
      'Include what makes them uniquely suited (or unsuited) for this challenge',
    ];
  }

  List<String> _getConflictSuggestions(String logline, String genre, int score) {
    if (score >= 80) return ['Your conflict is compelling'];
    return [
      'Add a clear "must" statement: what does the protagonist HAVE to do?',
      'Include an antagonistic force or obstacle',
      'Add a ticking clock or deadline for urgency',
    ];
  }

  List<String> _getStakesSuggestions(String logline, String genre, int score) {
    if (score >= 80) return ['Stakes are appropriately high'];
    return [
      'Add what happens if the protagonist fails',
      'Make it personal: family, loved ones, or their own soul',
      'Include "or else" consequences that matter',
    ];
  }

  List<String> _getHookSuggestions(String logline, String genre, int score) {
    if (score >= 80) return ['Your hook is fresh and marketable'];
    return [
      'Add an ironic twist or unexpected element',
      'What makes THIS story different from others in the genre?',
      'Consider a "What if?" premise that\'s never been done',
    ];
  }

  List<String> _getEmotionSuggestions(String logline, int score) {
    if (score >= 80) return ['Strong emotional resonance'];
    return [
      'Connect the external conflict to an internal wound',
      'Add family or relationship stakes',
      'What does the protagonist stand to lose emotionally?',
    ];
  }

  /// Get templates for a specific genre
  List<LoglineTemplate> getTemplatesForGenre(String genre) {
    return _templates.where((t) => 
      t.genre.toLowerCase() == genre.toLowerCase()
    ).toList();
  }

  /// Get all available templates
  List<LoglineTemplate> getAllTemplates() {
    return _templates;
  }
}
