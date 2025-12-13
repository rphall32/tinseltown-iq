/// V4 BUYER AFFINITY ANALYZER
/// Matches concepts to ideal buyers based on acquisition history and preferences

class BuyerAffinityResult {
  final String buyerName;
  final String buyerType; // "Streamer", "Major Studio", "Mini-Major", "Indie"
  final int affinityScore; // 0-100
  final String whyTheyWantIt;
  final List<String> recentSimilarAcquisitions;
  final String budgetRange;
  final String decisionMaker;
  final List<String> currentNeeds;
  
  BuyerAffinityResult({
    required this.buyerName,
    required this.buyerType,
    required this.affinityScore,
    required this.whyTheyWantIt,
    required this.recentSimilarAcquisitions,
    required this.budgetRange,
    required this.decisionMaker,
    required this.currentNeeds,
  });
}

class BuyerAffinityAnalyzer {
  
  List<BuyerAffinityResult> analyze({
    required String genre,
    required String format,
    String? secondaryGenre,
    String? tone,
    String? budgetTier,
    List<String> themes = const [],
    List<String> comparableTitles = const [],
  }) {
    final results = <BuyerAffinityResult>[];
    
    // Get all potential buyers
    final allBuyers = _getBuyerDatabase();
    
    // Score each buyer
    for (final buyer in allBuyers) {
      final score = _calculateAffinity(
        buyer: buyer,
        genre: genre,
        format: format,
        secondaryGenre: secondaryGenre,
        tone: tone,
        budgetTier: budgetTier,
        themes: themes,
        comparableTitles: comparableTitles,
      );
      
      if (score >= 50) { // Only include if decent match
        results.add(BuyerAffinityResult(
          buyerName: buyer.name,
          buyerType: buyer.type,
          affinityScore: score,
          whyTheyWantIt: _generateWhyStatement(buyer, genre, format, themes),
          recentSimilarAcquisitions: _getRelevantAcquisitions(buyer, genre),
          budgetRange: buyer.budgetRange,
          decisionMaker: buyer.decisionMaker,
          currentNeeds: buyer.currentNeeds,
        ));
      }
    }
    
    // Sort by affinity score
    results.sort((a, b) => b.affinityScore.compareTo(a.affinityScore));
    
    return results.take(8).toList();
  }
  
  int _calculateAffinity({
    required _BuyerProfile buyer,
    required String genre,
    required String format,
    String? secondaryGenre,
    String? tone,
    String? budgetTier,
    List<String> themes = const [],
    List<String> comparableTitles = const [],
  }) {
    int score = 50; // Base score
    
    // Genre match (up to +30)
    if (buyer.preferredGenres.contains(genre)) {
      score += 25;
    }
    if (secondaryGenre != null && buyer.preferredGenres.contains(secondaryGenre)) {
      score += 10;
    }
    
    // Format match (up to +15)
    if (buyer.preferredFormats.contains(format)) {
      score += 15;
    } else if (_isFormatCompatible(buyer.preferredFormats, format)) {
      score += 8;
    }
    
    // Tone alignment (up to +10)
    if (tone != null && buyer.preferredTones.contains(tone.toLowerCase())) {
      score += 10;
    }
    
    // Budget alignment (up to +10)
    if (budgetTier != null && _isBudgetAligned(buyer.budgetRange, budgetTier)) {
      score += 10;
    }
    
    // Theme overlap (up to +15)
    final themeOverlap = themes.where((t) => buyer.preferredThemes.contains(t.toLowerCase())).length;
    score += (themeOverlap * 5).clamp(0, 15);
    
    // Comparable title match (up to +20)
    for (final comp in comparableTitles) {
      if (buyer.acquisitionHistory.any((a) => a.toLowerCase().contains(comp.toLowerCase()))) {
        score += 20;
        break;
      }
    }
    
    // Current needs alignment (up to +10)
    final needsMatch = buyer.currentNeeds.any((need) => 
      genre.toLowerCase().contains(need.toLowerCase()) ||
      themes.any((t) => need.toLowerCase().contains(t.toLowerCase()))
    );
    if (needsMatch) {
      score += 10;
    }
    
    return score.clamp(0, 100);
  }
  
  bool _isFormatCompatible(List<String> buyerFormats, String projectFormat) {
    final pf = projectFormat.toLowerCase();
    for (final bf in buyerFormats) {
      final bfl = bf.toLowerCase();
      if (pf.contains('film') && bfl.contains('film')) return true;
      if (pf.contains('series') && bfl.contains('series')) return true;
      if (pf.contains('limited') && bfl.contains('limited')) return true;
    }
    return false;
  }
  
  bool _isBudgetAligned(String buyerRange, String projectTier) {
    final tier = projectTier.toLowerCase();
    final range = buyerRange.toLowerCase();
    
    if (tier == 'micro' && range.contains('under')) return true;
    if (tier == 'low' && (range.contains('5') || range.contains('10') || range.contains('15'))) return true;
    if (tier == 'medium' && (range.contains('20') || range.contains('40') || range.contains('50'))) return true;
    if (tier == 'high' && (range.contains('50') || range.contains('100'))) return true;
    if (tier == 'blockbuster' && (range.contains('100') || range.contains('200'))) return true;
    
    return false;
  }
  
  String _generateWhyStatement(_BuyerProfile buyer, String genre, String format, List<String> themes) {
    final statements = <String>[];
    
    if (buyer.preferredGenres.contains(genre)) {
      statements.add('${buyer.name} has been actively acquiring $genre content');
    }
    
    if (buyer.currentNeeds.isNotEmpty) {
      statements.add('Currently seeking ${buyer.currentNeeds.first.toLowerCase()}');
    }
    
    if (themes.isNotEmpty && buyer.preferredThemes.any((t) => themes.contains(t))) {
      statements.add('Aligns with their focus on ${themes.first} themes');
    }
    
    if (statements.isEmpty) {
      statements.add('Format and genre align with their content strategy');
    }
    
    return statements.join('. ');
  }
  
  List<String> _getRelevantAcquisitions(_BuyerProfile buyer, String genre) {
    // Return up to 3 relevant acquisitions
    return buyer.acquisitionHistory.take(3).toList();
  }
  
  List<_BuyerProfile> _getBuyerDatabase() {
    return [
      // STREAMERS
      _BuyerProfile(
        name: 'Netflix Film',
        type: 'Streamer',
        preferredGenres: ['Action', 'Thriller', 'Horror', 'Comedy', 'Romance', 'Sci-Fi'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['high-concept', 'commercial', 'diverse'],
        preferredThemes: ['family', 'survival', 'identity', 'love'],
        budgetRange: '\$20M - \$200M',
        decisionMaker: 'Scott Stuber (Film Chair)',
        currentNeeds: ['High-concept action', 'Romantic comedies', 'Event thrillers'],
        acquisitionHistory: ['Rebel Ridge', 'Hit Man', 'Glass Onion', 'Don\'t Look Up', 'The Adam Project'],
      ),
      _BuyerProfile(
        name: 'Netflix Series',
        type: 'Streamer',
        preferredGenres: ['Drama', 'Thriller', 'Crime', 'Sci-Fi', 'Horror'],
        preferredFormats: ['Series', 'Limited Series'],
        preferredTones: ['bingeable', 'twisty', 'diverse'],
        preferredThemes: ['mystery', 'crime', 'supernatural', 'family'],
        budgetRange: '\$5M - \$20M per episode',
        decisionMaker: 'Bela Bajaria (Chief Content Officer)',
        currentNeeds: ['Limited series events', 'International co-productions', 'True crime'],
        acquisitionHistory: ['Squid Game', 'Wednesday', 'Ripley', 'Baby Reindeer', '3 Body Problem'],
      ),
      _BuyerProfile(
        name: 'Amazon MGM Studios',
        type: 'Streamer',
        preferredGenres: ['Action', 'Thriller', 'Drama', 'Sci-Fi'],
        preferredFormats: ['Feature Film', 'Series'],
        preferredTones: ['prestige', 'commercial', 'elevated'],
        preferredThemes: ['heroism', 'survival', 'redemption'],
        budgetRange: '\$30M - \$200M',
        decisionMaker: 'Jennifer Salke (Head of Studios)',
        currentNeeds: ['Franchise potential', 'A-list packages', 'Theatrical events'],
        acquisitionHistory: ['Road House', 'The Idea of You', 'Air', 'Saltburn', 'Citadel'],
      ),
      _BuyerProfile(
        name: 'Apple TV+',
        type: 'Streamer',
        preferredGenres: ['Drama', 'Thriller', 'Sci-Fi', 'Comedy'],
        preferredFormats: ['Feature Film', 'Series', 'Limited Series'],
        preferredTones: ['prestige', 'auteur', 'elevated'],
        preferredThemes: ['humanity', 'technology', 'family', 'identity'],
        budgetRange: '\$50M - \$200M',
        decisionMaker: 'Jamie Erlicht & Zack Van Amburg (Heads of Video)',
        currentNeeds: ['A-list talent', 'Award contenders', 'Prestige limited series'],
        acquisitionHistory: ['Killers of the Flower Moon', 'Napoleon', 'Severance', 'Slow Horses', 'The Morning Show'],
      ),
      _BuyerProfile(
        name: 'HBO/Max',
        type: 'Streamer',
        preferredGenres: ['Drama', 'Thriller', 'Crime', 'Comedy', 'Horror'],
        preferredFormats: ['Series', 'Limited Series', 'Feature Film'],
        preferredTones: ['prestige', 'edgy', 'character-driven'],
        preferredThemes: ['power', 'corruption', 'family', 'identity'],
        budgetRange: '\$10M - \$25M per episode',
        decisionMaker: 'Casey Bloys (Chairman & CEO)',
        currentNeeds: ['Successor to Succession', 'Prestige limited', 'IP adaptations'],
        acquisitionHistory: ['The White Lotus', 'The Penguin', 'True Detective', 'The Last of Us', 'House of the Dragon'],
      ),
      _BuyerProfile(
        name: 'Hulu/FX',
        type: 'Streamer',
        preferredGenres: ['Drama', 'Thriller', 'Horror', 'Comedy', 'Crime'],
        preferredFormats: ['Series', 'Limited Series'],
        preferredTones: ['edgy', 'provocative', 'auteur'],
        preferredThemes: ['violence', 'sexuality', 'social issues', 'crime'],
        budgetRange: '\$5M - \$15M per episode',
        decisionMaker: 'John Landgraf (Chairman, FX)',
        currentNeeds: ['Shōgun follow-ups', 'Limited series events', 'Ryan Murphy projects'],
        acquisitionHistory: ['Shōgun', 'The Bear', 'Fargo', 'American Horror Story', 'Under the Banner of Heaven'],
      ),
      _BuyerProfile(
        name: 'Peacock',
        type: 'Streamer',
        preferredGenres: ['Thriller', 'Crime', 'Comedy', 'Drama'],
        preferredFormats: ['Series', 'Limited Series', 'Feature Film'],
        preferredTones: ['commercial', 'accessible', 'IP-driven'],
        preferredThemes: ['mystery', 'crime', 'family'],
        budgetRange: '\$3M - \$10M per episode',
        decisionMaker: 'Kelly Campbell (President)',
        currentNeeds: ['IP extensions', 'True crime', 'Procedurals'],
        acquisitionHistory: ['The Day of the Jackal', 'Poker Face', 'Bel-Air', 'Dr. Death'],
      ),
      _BuyerProfile(
        name: 'Paramount+',
        type: 'Streamer',
        preferredGenres: ['Action', 'Drama', 'Thriller', 'Sci-Fi'],
        preferredFormats: ['Series', 'Feature Film'],
        preferredTones: ['commercial', 'franchise', 'accessible'],
        preferredThemes: ['heroism', 'adventure', 'family'],
        budgetRange: '\$5M - \$15M per episode',
        decisionMaker: 'George Cheeks (President & CEO)',
        currentNeeds: ['Franchise content', 'Star Trek universe', 'Taylor Sheridan projects'],
        acquisitionHistory: ['Yellowstone', '1923', 'Tulsa King', 'Star Trek: Discovery', 'Halo'],
      ),
      
      // MAJOR STUDIOS
      _BuyerProfile(
        name: 'Universal Pictures',
        type: 'Major Studio',
        preferredGenres: ['Horror', 'Comedy', 'Action', 'Drama'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['commercial', 'high-concept', 'franchise'],
        preferredThemes: ['family', 'survival', 'heroism'],
        budgetRange: '\$20M - \$200M',
        decisionMaker: 'Donna Langley (Chairman)',
        currentNeeds: ['Original horror', 'Comedy stars', 'Franchise potential'],
        acquisitionHistory: ['Oppenheimer', 'M3GAN', 'Cocaine Bear', 'Nope', 'The Black Phone'],
      ),
      _BuyerProfile(
        name: 'Warner Bros.',
        type: 'Major Studio',
        preferredGenres: ['Action', 'Horror', 'Drama', 'Sci-Fi'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['commercial', 'franchise', 'elevated'],
        preferredThemes: ['heroism', 'justice', 'identity'],
        budgetRange: '\$30M - \$250M',
        decisionMaker: 'Michael De Luca & Pam Abdy (Co-Chairs)',
        currentNeeds: ['DC Universe content', 'Original tentpoles', 'Prestige drama'],
        acquisitionHistory: ['Barbie', 'Dune', 'Elvis', 'The Batman', 'A Star Is Born'],
      ),
      _BuyerProfile(
        name: 'Sony Pictures',
        type: 'Major Studio',
        preferredGenres: ['Action', 'Comedy', 'Horror', 'Animation'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['commercial', 'crowd-pleasing', 'franchise'],
        preferredThemes: ['heroism', 'adventure', 'family'],
        budgetRange: '\$30M - \$200M',
        decisionMaker: 'Tom Rothman (Chairman)',
        currentNeeds: ['Spider-Verse expansion', 'Star vehicles', 'Original IP'],
        acquisitionHistory: ['Spider-Verse', 'Anyone But You', 'Bad Boys 4', 'Ghostbusters', 'Bullet Train'],
      ),
      _BuyerProfile(
        name: 'Paramount Pictures',
        type: 'Major Studio',
        preferredGenres: ['Action', 'Horror', 'Comedy', 'Sci-Fi'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['commercial', 'franchise', 'accessible'],
        preferredThemes: ['adventure', 'heroism', 'survival'],
        budgetRange: '\$20M - \$200M',
        decisionMaker: 'Brian Robbins (President & CEO)',
        currentNeeds: ['A Quiet Place expansion', 'Star vehicles', 'Franchise tentpoles'],
        acquisitionHistory: ['A Quiet Place', 'Top Gun: Maverick', 'Scream', 'Smile', 'IF'],
      ),
      _BuyerProfile(
        name: '20th Century Studios',
        type: 'Major Studio',
        preferredGenres: ['Horror', 'Sci-Fi', 'Action', 'Comedy'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['elevated', 'franchise', 'auteur'],
        preferredThemes: ['survival', 'humanity', 'identity'],
        budgetRange: '\$30M - \$150M',
        decisionMaker: 'Steve Asbell (President)',
        currentNeeds: ['Alien/Predator universe', 'Original genre', 'Prestige'],
        acquisitionHistory: ['Alien: Romulus', 'Avatar', 'Kingdom of the Planet of the Apes', 'The Menu'],
      ),
      
      // MINI-MAJORS & INDIE
      _BuyerProfile(
        name: 'A24',
        type: 'Mini-Major',
        preferredGenres: ['Horror', 'Drama', 'Comedy', 'Sci-Fi'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['elevated', 'auteur', 'distinctive'],
        preferredThemes: ['identity', 'trauma', 'family', 'existential'],
        budgetRange: '\$5M - \$50M',
        decisionMaker: 'Daniel Katz & David Fenkel (Founders)',
        currentNeeds: ['Elevated horror', 'Distinctive voice', 'Award potential'],
        acquisitionHistory: ['Everything Everywhere', 'Hereditary', 'Midsommar', 'Civil War', 'The Whale'],
      ),
      _BuyerProfile(
        name: 'Neon',
        type: 'Indie',
        preferredGenres: ['Horror', 'Drama', 'Thriller'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['arthouse', 'provocative', 'auteur'],
        preferredThemes: ['identity', 'class', 'transgression'],
        budgetRange: '\$5M - \$30M',
        decisionMaker: 'Tom Quinn (CEO)',
        currentNeeds: ['Festival acquisitions', 'International auteurs', 'Genre-bending'],
        acquisitionHistory: ['Parasite', 'Longlegs', 'Anora', 'Triangle of Sadness', 'I, Tonya'],
      ),
      _BuyerProfile(
        name: 'Searchlight Pictures',
        type: 'Mini-Major',
        preferredGenres: ['Drama', 'Comedy', 'Thriller'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['prestige', 'character-driven', 'elevated'],
        preferredThemes: ['identity', 'redemption', 'social issues'],
        budgetRange: '\$10M - \$50M',
        decisionMaker: 'David Greenbaum & Matthew Greenfield (Presidents)',
        currentNeeds: ['Oscar contenders', 'Character studies', 'Diverse voices'],
        acquisitionHistory: ['The Holdovers', 'Poor Things', 'The Banshees of Inisherin', 'Nomadland'],
      ),
      _BuyerProfile(
        name: 'Focus Features',
        type: 'Mini-Major',
        preferredGenres: ['Drama', 'Thriller', 'Romance'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['prestige', 'elevated', 'literary'],
        preferredThemes: ['relationships', 'history', 'identity'],
        budgetRange: '\$10M - \$40M',
        decisionMaker: 'Peter Kujawski (Chairman)',
        currentNeeds: ['Award contenders', 'Literary adaptations', 'Prestige horror'],
        acquisitionHistory: ['Conclave', 'Tár', 'Belfast', 'Promising Young Woman'],
      ),
      _BuyerProfile(
        name: 'Blumhouse',
        type: 'Indie',
        preferredGenres: ['Horror', 'Thriller'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['commercial', 'high-concept', 'efficient'],
        preferredThemes: ['survival', 'supernatural', 'trauma'],
        budgetRange: '\$3M - \$15M',
        decisionMaker: 'Jason Blum (CEO)',
        currentNeeds: ['Original horror concepts', 'Contained thrillers', 'Franchise starters'],
        acquisitionHistory: ['Get Out', 'The Invisible Man', 'M3GAN', 'Five Nights at Freddy\'s', 'The Black Phone'],
      ),
      _BuyerProfile(
        name: 'Lionsgate',
        type: 'Mini-Major',
        preferredGenres: ['Action', 'Horror', 'Thriller', 'Comedy'],
        preferredFormats: ['Feature Film'],
        preferredTones: ['commercial', 'franchise', 'accessible'],
        preferredThemes: ['survival', 'revenge', 'heroism'],
        budgetRange: '\$15M - \$80M',
        decisionMaker: 'Adam Fogelson (Vice Chair)',
        currentNeeds: ['John Wick universe', 'YA adaptations', 'Action franchises'],
        acquisitionHistory: ['John Wick', 'Hunger Games', 'Saw', 'Borderlands', 'The Expendables'],
      ),
    ];
  }
}

class _BuyerProfile {
  final String name;
  final String type;
  final List<String> preferredGenres;
  final List<String> preferredFormats;
  final List<String> preferredTones;
  final List<String> preferredThemes;
  final String budgetRange;
  final String decisionMaker;
  final List<String> currentNeeds;
  final List<String> acquisitionHistory;
  
  _BuyerProfile({
    required this.name,
    required this.type,
    required this.preferredGenres,
    required this.preferredFormats,
    required this.preferredTones,
    required this.preferredThemes,
    required this.budgetRange,
    required this.decisionMaker,
    required this.currentNeeds,
    required this.acquisitionHistory,
  });
}
