/// V4 FRANCHISE/IP POTENTIAL ANALYZER
/// Evaluates sequel, spinoff, and extended universe potential

class FranchisePotential {
  final int overallScore; // 0-100
  final String tier; // "High Franchise Potential", "Sequel Viable", "Standalone", "Limited"
  final SequelPotential sequelPotential;
  final SpinoffPotential spinoffPotential;
  final UniversePotential universePotential;
  final List<String> ipStrengths;
  final List<String> ipWeaknesses;
  final String recommendation;
  final List<FranchiseComparable> comparableSuccesses;
  
  FranchisePotential({
    required this.overallScore,
    required this.tier,
    required this.sequelPotential,
    required this.spinoffPotential,
    required this.universePotential,
    required this.ipStrengths,
    required this.ipWeaknesses,
    required this.recommendation,
    required this.comparableSuccesses,
  });
}

class SequelPotential {
  final int score; // 0-100
  final bool viableSequel;
  final String reasoning;
  final List<String> sequelHooks;
  
  SequelPotential({
    required this.score,
    required this.viableSequel,
    required this.reasoning,
    required this.sequelHooks,
  });
}

class SpinoffPotential {
  final int score; // 0-100
  final List<String> possibleSpinoffs;
  final String reasoning;
  
  SpinoffPotential({
    required this.score,
    required this.possibleSpinoffs,
    required this.reasoning,
  });
}

class UniversePotential {
  final int score; // 0-100
  final bool worldBuildable;
  final String reasoning;
  final List<String> expansionIdeas;
  
  UniversePotential({
    required this.score,
    required this.worldBuildable,
    required this.reasoning,
    required this.expansionIdeas,
  });
}

class FranchiseComparable {
  final String title;
  final String outcome;
  final int sequelCount;
  final String totalRevenue;
  
  FranchiseComparable({
    required this.title,
    required this.outcome,
    required this.sequelCount,
    required this.totalRevenue,
  });
}

class FranchiseAnalyzer {
  
  FranchisePotential analyze({
    required String logline,
    required String genre,
    required String format,
    String? setting,
    String? protagonistType,
    List<String> themes = const [],
    List<String> genreElements = const [],
  }) {
    // Analyze each dimension
    final sequelPotential = _analyzeSequelPotential(logline, genre, protagonistType, genreElements);
    final spinoffPotential = _analyzeSpinoffPotential(logline, genre, setting, themes);
    final universePotential = _analyzeUniversePotential(logline, genre, setting, genreElements);
    
    // Calculate overall score (weighted average)
    final overallScore = (
      (sequelPotential.score * 0.4) +
      (spinoffPotential.score * 0.3) +
      (universePotential.score * 0.3)
    ).round();
    
    // Determine tier
    final tier = _determineTier(overallScore, sequelPotential, universePotential);
    
    // Identify strengths and weaknesses
    final strengths = _identifyStrengths(logline, genre, setting, protagonistType, genreElements);
    final weaknesses = _identifyWeaknesses(logline, genre, setting, genreElements);
    
    // Generate recommendation
    final recommendation = _generateRecommendation(tier, sequelPotential, spinoffPotential, universePotential);
    
    // Find comparable successes
    final comparables = _findComparableSuccesses(genre, tier);
    
    return FranchisePotential(
      overallScore: overallScore,
      tier: tier,
      sequelPotential: sequelPotential,
      spinoffPotential: spinoffPotential,
      universePotential: universePotential,
      ipStrengths: strengths,
      ipWeaknesses: weaknesses,
      recommendation: recommendation,
      comparableSuccesses: comparables,
    );
  }
  
  SequelPotential _analyzeSequelPotential(
    String logline,
    String genre,
    String? protagonistType,
    List<String> genreElements,
  ) {
    int score = 40; // Base score
    final hooks = <String>[];
    final lowerLogline = logline.toLowerCase();
    
    // Recurring protagonist potential
    final recurringProtagonists = ['detective', 'agent', 'soldier', 'survivor', 'hero'];
    if (protagonistType != null && recurringProtagonists.contains(protagonistType.toLowerCase())) {
      score += 20;
      hooks.add('Protagonist can return for new adventures');
    }
    
    // Genre sequel viability
    final highSequelGenres = ['Action', 'Horror', 'Thriller', 'Sci-Fi'];
    if (highSequelGenres.contains(genre)) {
      score += 15;
      hooks.add('Genre has strong sequel tradition');
    }
    
    // Ongoing threat/mystery potential
    final ongoingElements = ['conspiracy', 'organization', 'war', 'invasion', 'outbreak', 'serial'];
    if (ongoingElements.any((e) => lowerLogline.contains(e))) {
      score += 15;
      hooks.add('Larger threat can continue');
    }
    
    // Character growth potential
    if (lowerLogline.contains('young') || lowerLogline.contains('learn') || 
        lowerLogline.contains('discover') || lowerLogline.contains('become')) {
      score += 10;
      hooks.add('Character evolution arc');
    }
    
    // Check for sequel-unfriendly elements
    if (lowerLogline.contains('final') || lowerLogline.contains('last') ||
        lowerLogline.contains('death') || lowerLogline.contains('end of')) {
      score -= 15;
    }
    
    final viable = score >= 60;
    final reasoning = viable
        ? 'Strong sequel potential based on protagonist continuity and expandable narrative'
        : 'Concept is more suited to standalone execution';
    
    return SequelPotential(
      score: score.clamp(0, 100),
      viableSequel: viable,
      reasoning: reasoning,
      sequelHooks: hooks,
    );
  }
  
  SpinoffPotential _analyzeSpinoffPotential(
    String logline,
    String genre,
    String? setting,
    List<String> themes,
  ) {
    int score = 30; // Base score
    final possibleSpinoffs = <String>[];
    final lowerLogline = logline.toLowerCase();
    
    // Ensemble cast potential
    if (lowerLogline.contains('group') || lowerLogline.contains('team') ||
        lowerLogline.contains('family') || lowerLogline.contains('crew')) {
      score += 25;
      possibleSpinoffs.add('Individual character origin stories');
    }
    
    // Rich setting
    if (setting != null && ['urban', 'institutional', 'historical', 'space', 'future'].contains(setting)) {
      score += 20;
      possibleSpinoffs.add('Explore other corners of the world');
    }
    
    // Multiple factions/groups
    if (lowerLogline.contains('against') || lowerLogline.contains('between') ||
        lowerLogline.contains('rival') || lowerLogline.contains('two')) {
      score += 15;
      possibleSpinoffs.add('Tell the story from antagonist perspective');
    }
    
    // Time flexibility
    if (lowerLogline.contains('history') || lowerLogline.contains('past') ||
        lowerLogline.contains('generation') || lowerLogline.contains('legacy')) {
      score += 15;
      possibleSpinoffs.add('Prequel exploring origins');
    }
    
    String reasoning;
    if (score >= 60) {
      reasoning = 'Multiple spinoff opportunities available through characters or world';
    } else if (score >= 40) {
      reasoning = 'Some spinoff potential exists but requires development';
    } else {
      reasoning = 'Limited spinoff potential - story is character-focused';
    }
    
    return SpinoffPotential(
      score: score.clamp(0, 100),
      possibleSpinoffs: possibleSpinoffs,
      reasoning: reasoning,
    );
  }
  
  UniversePotential _analyzeUniversePotential(
    String logline,
    String genre,
    String? setting,
    List<String> genreElements,
  ) {
    int score = 25; // Base score
    final expansionIdeas = <String>[];
    final lowerLogline = logline.toLowerCase();
    
    // World-building elements
    final worldBuildingKeywords = ['world', 'kingdom', 'empire', 'organization', 'system', 
                                    'society', 'universe', 'realm', 'dimension'];
    if (worldBuildingKeywords.any((w) => lowerLogline.contains(w))) {
      score += 30;
      expansionIdeas.add('Expand the world\'s geography and factions');
    }
    
    // Genre with universe tradition
    final universeGenres = ['Sci-Fi', 'Fantasy', 'Superhero', 'Horror'];
    if (universeGenres.contains(genre)) {
      score += 20;
      expansionIdeas.add('Genre supports extended universe storytelling');
    }
    
    // Rules/mythology potential
    if (lowerLogline.contains('power') || lowerLogline.contains('magic') ||
        lowerLogline.contains('technology') || lowerLogline.contains('ancient') ||
        lowerLogline.contains('secret')) {
      score += 15;
      expansionIdeas.add('Develop lore and mythology');
    }
    
    // Multiple story types possible
    if (setting != null && setting != 'small town' && setting != 'isolated') {
      score += 10;
      expansionIdeas.add('Setting supports diverse narrative types');
    }
    
    final worldBuildable = score >= 55;
    String reasoning;
    if (worldBuildable) {
      reasoning = 'Strong potential for extended universe development';
    } else if (score >= 35) {
      reasoning = 'Universe expansion possible with intentional world-building';
    } else {
      reasoning = 'Concept is intimate in scope - universe expansion not recommended';
    }
    
    return UniversePotential(
      score: score.clamp(0, 100),
      worldBuildable: worldBuildable,
      reasoning: reasoning,
      expansionIdeas: expansionIdeas,
    );
  }
  
  String _determineTier(int overallScore, SequelPotential sequel, UniversePotential universe) {
    if (overallScore >= 75 && universe.worldBuildable) {
      return 'High Franchise Potential';
    } else if (overallScore >= 55 && sequel.viableSequel) {
      return 'Sequel Viable';
    } else if (overallScore >= 40) {
      return 'Standalone';
    } else {
      return 'Limited';
    }
  }
  
  List<String> _identifyStrengths(
    String logline,
    String genre,
    String? setting,
    String? protagonistType,
    List<String> genreElements,
  ) {
    final strengths = <String>[];
    final lowerLogline = logline.toLowerCase();
    
    // Strong protagonist
    if (protagonistType != null) {
      final iconicProtagonists = ['detective', 'agent', 'survivor', 'hero', 'scientist'];
      if (iconicProtagonists.contains(protagonistType.toLowerCase())) {
        strengths.add('Iconic protagonist type with franchise history');
      }
    }
    
    // High-concept premise
    if (lowerLogline.contains('must') || lowerLogline.contains('only') ||
        lowerLogline.contains('before') || lowerLogline.contains('discovers')) {
      strengths.add('High-concept hook drives audience interest');
    }
    
    // Merchandising potential
    if (genre == 'Sci-Fi' || genre == 'Fantasy' || genre == 'Action' ||
        genre == 'Animation' || genre == 'Superhero') {
      strengths.add('Genre supports merchandise and licensing');
    }
    
    // World-building
    if (setting == 'space' || setting == 'future' || setting == 'historical') {
      strengths.add('Rich setting for world expansion');
    }
    
    return strengths;
  }
  
  List<String> _identifyWeaknesses(
    String logline,
    String genre,
    String? setting,
    List<String> genreElements,
  ) {
    final weaknesses = <String>[];
    final lowerLogline = logline.toLowerCase();
    
    // Finite story
    if (lowerLogline.contains('final') || lowerLogline.contains('last') ||
        lowerLogline.contains('once') || lowerLogline.contains('only chance')) {
      weaknesses.add('Story implies finite resolution');
    }
    
    // Personal/intimate scope
    if (lowerLogline.contains('personal') || lowerLogline.contains('between two') ||
        lowerLogline.contains('relationship') || lowerLogline.contains('marriage')) {
      weaknesses.add('Intimate scope limits expansion');
    }
    
    // Genre limitations
    if (genre == 'Romance' || genre == 'Biography') {
      weaknesses.add('Genre typically not franchise-oriented');
    }
    
    // Limited setting
    if (setting == 'small town' || setting == 'isolated') {
      weaknesses.add('Contained setting limits world-building');
    }
    
    return weaknesses;
  }
  
  String _generateRecommendation(
    String tier,
    SequelPotential sequel,
    SpinoffPotential spinoff,
    UniversePotential universe,
  ) {
    switch (tier) {
      case 'High Franchise Potential':
        return 'STRONG BUY. Pitch with 3-film arc or series bible. Emphasize world-building and character expandability. Target major studios/streamers seeking franchise IP.';
      case 'Sequel Viable':
        return 'DEVELOP WITH SEQUEL HOOKS. Plant seeds for continuation while delivering satisfying standalone. Pitch sequel potential to buyers without overselling.';
      case 'Standalone':
        return 'EXECUTE AS PREMIUM STANDALONE. Focus on craft and execution over franchise potential. Target prestige buyers and awards-oriented distributors.';
      default:
        return 'SINGLE-VISION PROJECT. Best suited for auteur-driven development. Not recommended for franchise-seeking buyers.';
    }
  }
  
  List<FranchiseComparable> _findComparableSuccesses(String genre, String tier) {
    final allComparables = _getFranchiseDatabase();
    
    return allComparables
        .where((c) => c.genres.contains(genre) || c.tiers.contains(tier))
        .map((c) => FranchiseComparable(
          title: c.title,
          outcome: c.outcome,
          sequelCount: c.sequelCount,
          totalRevenue: c.totalRevenue,
        ))
        .take(4)
        .toList();
  }
  
  List<_FranchiseExample> _getFranchiseDatabase() {
    return [
      _FranchiseExample(
        title: 'John Wick',
        genres: ['Action', 'Thriller'],
        tiers: ['High Franchise Potential', 'Sequel Viable'],
        outcome: 'Low-budget original became \$1B+ franchise',
        sequelCount: 4,
        totalRevenue: '\$1B+',
      ),
      _FranchiseExample(
        title: 'A Quiet Place',
        genres: ['Horror', 'Thriller', 'Sci-Fi'],
        tiers: ['Sequel Viable'],
        outcome: 'Original horror concept expanded to trilogy + spinoff',
        sequelCount: 3,
        totalRevenue: '\$700M+',
      ),
      _FranchiseExample(
        title: 'Get Out',
        genres: ['Horror', 'Thriller'],
        tiers: ['Standalone'],
        outcome: 'Standalone success launched director\'s brand',
        sequelCount: 0,
        totalRevenue: '\$255M',
      ),
      _FranchiseExample(
        title: 'The Conjuring',
        genres: ['Horror'],
        tiers: ['High Franchise Potential'],
        outcome: 'Spawned largest horror universe',
        sequelCount: 8,
        totalRevenue: '\$2B+',
      ),
      _FranchiseExample(
        title: 'Knives Out',
        genres: ['Mystery', 'Comedy', 'Thriller'],
        tiers: ['Sequel Viable'],
        outcome: 'Anthology sequel model with returning detective',
        sequelCount: 2,
        totalRevenue: '\$600M+',
      ),
      _FranchiseExample(
        title: 'Dune',
        genres: ['Sci-Fi', 'Drama'],
        tiers: ['High Franchise Potential'],
        outcome: 'Literary adaptation became theatrical franchise',
        sequelCount: 2,
        totalRevenue: '\$1.1B+',
      ),
      _FranchiseExample(
        title: 'Parasite',
        genres: ['Drama', 'Thriller', 'Comedy'],
        tiers: ['Standalone'],
        outcome: 'Best Picture winner as pure standalone',
        sequelCount: 0,
        totalRevenue: '\$263M',
      ),
      _FranchiseExample(
        title: 'Yellowstone',
        genres: ['Drama', 'Western'],
        tiers: ['High Franchise Potential'],
        outcome: 'TV series spawned multiple spinoffs',
        sequelCount: 4,
        totalRevenue: 'N/A (TV)',
      ),
    ];
  }
}

class _FranchiseExample {
  final String title;
  final List<String> genres;
  final List<String> tiers;
  final String outcome;
  final int sequelCount;
  final String totalRevenue;
  
  _FranchiseExample({
    required this.title,
    required this.genres,
    required this.tiers,
    required this.outcome,
    required this.sequelCount,
    required this.totalRevenue,
  });
}
