/// V4 TALENT PACKAGER
/// Suggests ideal talent based on comparable casts and project requirements

class TalentSuggestion {
  final String name;
  final String role; // "Lead Actor", "Director", "Supporting", "Writer"
  final int fitScore; // 0-100
  final String rationale;
  final List<String> relevantCredits;
  final String availability; // "Available", "In Production", "Unknown"
  final String quoteRange;
  final String agency;
  
  TalentSuggestion({
    required this.name,
    required this.role,
    required this.fitScore,
    required this.rationale,
    required this.relevantCredits,
    required this.availability,
    required this.quoteRange,
    required this.agency,
  });
}

class TalentPackage {
  final List<TalentSuggestion> directors;
  final List<TalentSuggestion> leadActors;
  final List<TalentSuggestion> supportingActors;
  final List<TalentSuggestion> writers;
  final String packageTier; // "A-List", "Rising Star", "Indie Darling", "Mixed"
  final String estimatedPackageCost;
  
  TalentPackage({
    required this.directors,
    required this.leadActors,
    required this.supportingActors,
    required this.writers,
    required this.packageTier,
    required this.estimatedPackageCost,
  });
}

class TalentPackager {
  
  TalentPackage suggest({
    required String genre,
    required String format,
    String? tone,
    String? budgetTier,
    String? protagonistType,
    List<String> themes = const [],
    List<String> comparableTitles = const [],
  }) {
    final directors = _suggestDirectors(genre, format, tone, budgetTier, comparableTitles);
    final leadActors = _suggestLeadActors(genre, format, tone, budgetTier, protagonistType, themes);
    final supportingActors = _suggestSupportingActors(genre, tone);
    final writers = _suggestWriters(genre, format, tone, themes);
    
    final packageTier = _determinePackageTier(directors, leadActors, budgetTier);
    final estimatedCost = _estimatePackageCost(packageTier, format);
    
    return TalentPackage(
      directors: directors.take(5).toList(),
      leadActors: leadActors.take(8).toList(),
      supportingActors: supportingActors.take(5).toList(),
      writers: writers.take(4).toList(),
      packageTier: packageTier,
      estimatedPackageCost: estimatedCost,
    );
  }
  
  List<TalentSuggestion> _suggestDirectors(
    String genre, 
    String format, 
    String? tone, 
    String? budgetTier,
    List<String> comparableTitles,
  ) {
    final allDirectors = _getDirectorDatabase();
    final suggestions = <TalentSuggestion>[];
    
    for (final director in allDirectors) {
      int score = 40; // Base score
      final reasons = <String>[];
      
      // Genre match
      if (director.genres.contains(genre)) {
        score += 25;
        reasons.add('Proven ${genre.toLowerCase()} filmmaker');
      }
      
      // Format match
      if (format.toLowerCase().contains('series') && director.doesTV) {
        score += 15;
        reasons.add('TV experience');
      } else if (format.toLowerCase().contains('film') && director.doesFilm) {
        score += 15;
      }
      
      // Tone match
      if (tone != null && director.tones.any((t) => t.toLowerCase() == tone.toLowerCase())) {
        score += 15;
        reasons.add('Matches ${tone.toLowerCase()} tone');
      }
      
      // Budget alignment
      if (_isBudgetAligned(director.budgetRange, budgetTier)) {
        score += 10;
      }
      
      // Comparable credits
      for (final comp in comparableTitles) {
        if (director.credits.any((c) => c.toLowerCase().contains(comp.toLowerCase()))) {
          score += 20;
          reasons.add('Directed similar project');
          break;
        }
      }
      
      if (score >= 50) {
        suggestions.add(TalentSuggestion(
          name: director.name,
          role: 'Director',
          fitScore: score.clamp(0, 100),
          rationale: reasons.isNotEmpty ? reasons.join('. ') : 'Strong genre fit',
          relevantCredits: director.credits.take(3).toList(),
          availability: director.availability,
          quoteRange: director.quote,
          agency: director.agency,
        ));
      }
    }
    
    suggestions.sort((a, b) => b.fitScore.compareTo(a.fitScore));
    return suggestions;
  }
  
  List<TalentSuggestion> _suggestLeadActors(
    String genre,
    String format,
    String? tone,
    String? budgetTier,
    String? protagonistType,
    List<String> themes,
  ) {
    final allActors = _getActorDatabase();
    final suggestions = <TalentSuggestion>[];
    
    for (final actor in allActors) {
      int score = 40;
      final reasons = <String>[];
      
      // Genre match
      if (actor.genres.contains(genre)) {
        score += 20;
        reasons.add('Genre experience');
      }
      
      // Protagonist type match
      if (protagonistType != null && actor.specialties.any((s) => 
        s.toLowerCase().contains(protagonistType.toLowerCase()))) {
        score += 20;
        reasons.add('Excels at ${protagonistType.toLowerCase()} roles');
      }
      
      // Theme alignment
      for (final theme in themes) {
        if (actor.themes.any((t) => t.toLowerCase() == theme.toLowerCase())) {
          score += 10;
          reasons.add('Strong in $theme narratives');
          break;
        }
      }
      
      // Tone match
      if (tone != null && actor.tones.any((t) => t.toLowerCase() == tone.toLowerCase())) {
        score += 10;
      }
      
      // Budget alignment
      if (_isBudgetAligned(actor.quote, budgetTier)) {
        score += 10;
      }
      
      // Recent momentum (awards, hits)
      if (actor.recentMomentum) {
        score += 10;
        reasons.add('Currently hot');
      }
      
      if (score >= 50) {
        suggestions.add(TalentSuggestion(
          name: actor.name,
          role: 'Lead Actor',
          fitScore: score.clamp(0, 100),
          rationale: reasons.isNotEmpty ? reasons.join('. ') : 'Strong fit for role',
          relevantCredits: actor.credits.take(3).toList(),
          availability: actor.availability,
          quoteRange: actor.quote,
          agency: actor.agency,
        ));
      }
    }
    
    suggestions.sort((a, b) => b.fitScore.compareTo(a.fitScore));
    return suggestions;
  }
  
  List<TalentSuggestion> _suggestSupportingActors(String genre, String? tone) {
    // Simplified supporting actor suggestions
    final supporting = <TalentSuggestion>[
      TalentSuggestion(
        name: 'Character Actor Pool',
        role: 'Supporting',
        fitScore: 75,
        rationale: 'Versatile supporting cast available',
        relevantCredits: ['Various $genre projects'],
        availability: 'Available',
        quoteRange: '\$50K - \$500K',
        agency: 'Various',
      ),
    ];
    return supporting;
  }
  
  List<TalentSuggestion> _suggestWriters(
    String genre, 
    String format, 
    String? tone,
    List<String> themes,
  ) {
    final allWriters = _getWriterDatabase();
    final suggestions = <TalentSuggestion>[];
    
    for (final writer in allWriters) {
      int score = 40;
      final reasons = <String>[];
      
      if (writer.genres.contains(genre)) {
        score += 25;
        reasons.add('${genre} specialist');
      }
      
      if (format.toLowerCase().contains('series') && writer.doesTV) {
        score += 15;
        reasons.add('TV writing experience');
      } else if (format.toLowerCase().contains('film') && writer.doesFilm) {
        score += 15;
      }
      
      for (final theme in themes) {
        if (writer.themes.any((t) => t.toLowerCase() == theme.toLowerCase())) {
          score += 15;
          reasons.add('Explores $theme themes');
          break;
        }
      }
      
      if (score >= 50) {
        suggestions.add(TalentSuggestion(
          name: writer.name,
          role: 'Writer',
          fitScore: score.clamp(0, 100),
          rationale: reasons.isNotEmpty ? reasons.join('. ') : 'Strong genre fit',
          relevantCredits: writer.credits.take(3).toList(),
          availability: writer.availability,
          quoteRange: writer.quote,
          agency: writer.agency,
        ));
      }
    }
    
    suggestions.sort((a, b) => b.fitScore.compareTo(a.fitScore));
    return suggestions;
  }
  
  bool _isBudgetAligned(String quote, String? budgetTier) {
    if (budgetTier == null) return true;
    final tier = budgetTier.toLowerCase();
    final q = quote.toLowerCase();
    
    if (tier == 'micro' || tier == 'low') {
      return q.contains('scale') || q.contains('100k') || q.contains('250k');
    }
    if (tier == 'medium') {
      return !q.contains('20m') && !q.contains('15m');
    }
    return true; // High/blockbuster can afford anyone
  }
  
  String _determinePackageTier(
    List<TalentSuggestion> directors,
    List<TalentSuggestion> actors,
    String? budgetTier,
  ) {
    if (budgetTier == 'blockbuster' || budgetTier == 'high') {
      return 'A-List';
    }
    if (budgetTier == 'micro' || budgetTier == 'low') {
      return 'Rising Star';
    }
    return 'Mixed';
  }
  
  String _estimatePackageCost(String tier, String format) {
    switch (tier) {
      case 'A-List':
        return format.contains('Series') ? '\$15M - \$40M' : '\$30M - \$80M';
      case 'Rising Star':
        return format.contains('Series') ? '\$1M - \$5M' : '\$3M - \$10M';
      case 'Indie Darling':
        return format.contains('Series') ? '\$2M - \$8M' : '\$5M - \$15M';
      default:
        return format.contains('Series') ? '\$5M - \$15M' : '\$10M - \$30M';
    }
  }
  
  List<_DirectorProfile> _getDirectorDatabase() {
    return [
      _DirectorProfile(
        name: 'Jordan Peele',
        genres: ['Horror', 'Thriller', 'Comedy'],
        tones: ['satirical', 'elevated', 'social'],
        credits: ['Get Out', 'Us', 'Nope'],
        doesFilm: true,
        doesTV: true,
        budgetRange: '\$20M - \$100M',
        quote: '\$10M - \$20M',
        agency: 'CAA',
        availability: 'Selective',
      ),
      _DirectorProfile(
        name: 'Ari Aster',
        genres: ['Horror', 'Drama'],
        tones: ['disturbing', 'atmospheric', 'elevated'],
        credits: ['Hereditary', 'Midsommar', 'Beau Is Afraid'],
        doesFilm: true,
        doesTV: false,
        budgetRange: '\$10M - \$50M',
        quote: '\$5M - \$10M',
        agency: 'WME',
        availability: 'Selective',
      ),
      _DirectorProfile(
        name: 'Emerald Fennell',
        genres: ['Thriller', 'Drama', 'Comedy'],
        tones: ['dark', 'provocative', 'stylish'],
        credits: ['Promising Young Woman', 'Saltburn'],
        doesFilm: true,
        doesTV: false,
        budgetRange: '\$10M - \$50M',
        quote: '\$3M - \$8M',
        agency: 'CAA',
        availability: 'Available',
      ),
      _DirectorProfile(
        name: 'Denis Villeneuve',
        genres: ['Sci-Fi', 'Thriller', 'Drama'],
        tones: ['epic', 'atmospheric', 'cerebral'],
        credits: ['Dune', 'Arrival', 'Blade Runner 2049'],
        doesFilm: true,
        doesTV: false,
        budgetRange: '\$80M - \$200M',
        quote: '\$15M - \$25M',
        agency: 'WME',
        availability: 'Committed through 2026',
      ),
      _DirectorProfile(
        name: 'Greta Gerwig',
        genres: ['Comedy', 'Drama', 'Romance'],
        tones: ['warm', 'witty', 'feminist'],
        credits: ['Barbie', 'Little Women', 'Lady Bird'],
        doesFilm: true,
        doesTV: false,
        budgetRange: '\$20M - \$150M',
        quote: '\$10M - \$20M',
        agency: 'UTA',
        availability: 'Working on Narnia',
      ),
      _DirectorProfile(
        name: 'Mike Flanagan',
        genres: ['Horror', 'Thriller', 'Drama'],
        tones: ['emotional', 'atmospheric', 'literary'],
        credits: ['The Haunting of Hill House', 'Midnight Mass', 'Doctor Sleep'],
        doesFilm: true,
        doesTV: true,
        budgetRange: '\$10M - \$50M',
        quote: '\$3M - \$8M',
        agency: 'UTA',
        availability: 'Available',
      ),
      _DirectorProfile(
        name: 'Luca Guadagnino',
        genres: ['Drama', 'Romance', 'Thriller'],
        tones: ['sensual', 'stylish', 'provocative'],
        credits: ['Challengers', 'Call Me By Your Name', 'Bones and All'],
        doesFilm: true,
        doesTV: true,
        budgetRange: '\$20M - \$80M',
        quote: '\$5M - \$12M',
        agency: 'CAA',
        availability: 'Available',
      ),
      _DirectorProfile(
        name: 'Chloe Zhao',
        genres: ['Drama', 'Sci-Fi', 'Western'],
        tones: ['naturalistic', 'poetic', 'humanist'],
        credits: ['Nomadland', 'Eternals', 'The Rider'],
        doesFilm: true,
        doesTV: false,
        budgetRange: '\$5M - \$200M',
        quote: '\$5M - \$15M',
        agency: 'WME',
        availability: 'Available',
      ),
      _DirectorProfile(
        name: 'Fede Alvarez',
        genres: ['Horror', 'Thriller', 'Sci-Fi'],
        tones: ['intense', 'visceral', 'commercial'],
        credits: ['Alien: Romulus', 'Don\'t Breathe', 'Evil Dead'],
        doesFilm: true,
        doesTV: false,
        budgetRange: '\$10M - \$100M',
        quote: '\$3M - \$8M',
        agency: 'CAA',
        availability: 'Available',
      ),
      _DirectorProfile(
        name: 'David Fincher',
        genres: ['Thriller', 'Drama', 'Crime'],
        tones: ['dark', 'meticulous', 'psychological'],
        credits: ['The Killer', 'Mank', 'Gone Girl'],
        doesFilm: true,
        doesTV: true,
        budgetRange: '\$50M - \$150M',
        quote: '\$15M - \$25M',
        agency: 'CAA',
        availability: 'Selective',
      ),
    ];
  }
  
  List<_ActorProfile> _getActorDatabase() {
    return [
      _ActorProfile(
        name: 'Zendaya',
        genres: ['Drama', 'Sci-Fi', 'Romance', 'Action'],
        specialties: ['young lead', 'dramatic'],
        tones: ['intense', 'emotional', 'stylish'],
        themes: ['identity', 'love', 'ambition'],
        credits: ['Dune', 'Challengers', 'Euphoria'],
        quote: '\$10M - \$15M',
        agency: 'CAA',
        availability: 'Limited',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Timothée Chalamet',
        genres: ['Drama', 'Sci-Fi', 'Romance', 'Biography'],
        specialties: ['young lead', 'artistic'],
        tones: ['prestige', 'emotional', 'intimate'],
        themes: ['identity', 'coming of age', 'artistry'],
        credits: ['Dune', 'A Complete Unknown', 'Wonka'],
        quote: '\$10M - \$20M',
        agency: 'UTA',
        availability: 'Limited',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Florence Pugh',
        genres: ['Drama', 'Horror', 'Action', 'Thriller'],
        specialties: ['fierce lead', 'complex'],
        tones: ['intense', 'emotional', 'raw'],
        themes: ['trauma', 'survival', 'power'],
        credits: ['Midsommar', 'Oppenheimer', 'Little Women'],
        quote: '\$5M - \$10M',
        agency: 'CAA',
        availability: 'Available',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Paul Mescal',
        genres: ['Drama', 'Romance', 'Action'],
        specialties: ['sensitive lead', 'physical'],
        tones: ['intimate', 'emotional', 'intense'],
        themes: ['masculinity', 'love', 'trauma'],
        credits: ['Gladiator II', 'Normal People', 'Aftersun'],
        quote: '\$3M - \$8M',
        agency: 'CAA',
        availability: 'Limited',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Mia Goth',
        genres: ['Horror', 'Drama', 'Thriller'],
        specialties: ['survivor', 'complex villain'],
        tones: ['disturbing', 'intense', 'provocative'],
        themes: ['ambition', 'survival', 'identity'],
        credits: ['Pearl', 'X', 'MaXXXine'],
        quote: '\$1M - \$3M',
        agency: 'WME',
        availability: 'Available',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Glen Powell',
        genres: ['Action', 'Comedy', 'Romance', 'Thriller'],
        specialties: ['charming lead', 'action hero'],
        tones: ['fun', 'commercial', 'charismatic'],
        themes: ['heroism', 'romance', 'adventure'],
        credits: ['Anyone But You', 'Top Gun: Maverick', 'Hit Man'],
        quote: '\$5M - \$12M',
        agency: 'WME',
        availability: 'In demand',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Sydney Sweeney',
        genres: ['Drama', 'Horror', 'Romance', 'Thriller'],
        specialties: ['dramatic lead', 'complex'],
        tones: ['dark', 'emotional', 'provocative'],
        themes: ['sexuality', 'identity', 'trauma'],
        credits: ['Anyone But You', 'Euphoria', 'Immaculate'],
        quote: '\$3M - \$8M',
        agency: 'UTA',
        availability: 'In demand',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Josh O\'Connor',
        genres: ['Drama', 'Romance', 'Period'],
        specialties: ['sensitive lead', 'complex'],
        tones: ['intimate', 'intense', 'prestige'],
        themes: ['class', 'love', 'identity'],
        credits: ['Challengers', 'The Crown', 'La Chimera'],
        quote: '\$2M - \$5M',
        agency: 'CAA',
        availability: 'Available',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Jenna Ortega',
        genres: ['Horror', 'Comedy', 'Thriller'],
        specialties: ['final girl', 'dark comedy'],
        tones: ['macabre', 'witty', 'edgy'],
        themes: ['survival', 'identity', 'family'],
        credits: ['Wednesday', 'Scream', 'Beetlejuice Beetlejuice'],
        quote: '\$5M - \$10M',
        agency: 'CAA',
        availability: 'Limited',
        recentMomentum: true,
      ),
      _ActorProfile(
        name: 'Austin Butler',
        genres: ['Drama', 'Biography', 'Action', 'Sci-Fi'],
        specialties: ['transformative lead', 'physical'],
        tones: ['intense', 'charismatic', 'prestige'],
        themes: ['fame', 'identity', 'survival'],
        credits: ['Elvis', 'Dune', 'The Bikeriders'],
        quote: '\$8M - \$15M',
        agency: 'WME',
        availability: 'Limited',
        recentMomentum: true,
      ),
    ];
  }
  
  List<_WriterProfile> _getWriterDatabase() {
    return [
      _WriterProfile(
        name: 'Tony Gilroy',
        genres: ['Thriller', 'Drama', 'Action'],
        themes: ['corruption', 'espionage', 'morality'],
        credits: ['Andor', 'Michael Clayton', 'Bourne series'],
        doesFilm: true,
        doesTV: true,
        quote: '\$2M - \$5M',
        agency: 'CAA',
        availability: 'Selective',
      ),
      _WriterProfile(
        name: 'Cord Jefferson',
        genres: ['Drama', 'Comedy', 'Satire'],
        themes: ['race', 'identity', 'media'],
        credits: ['American Fiction', 'Watchmen', 'The Good Place'],
        doesFilm: true,
        doesTV: true,
        quote: '\$500K - \$2M',
        agency: 'WME',
        availability: 'Available',
      ),
      _WriterProfile(
        name: 'Celine Song',
        genres: ['Drama', 'Romance'],
        themes: ['identity', 'fate', 'love'],
        credits: ['Past Lives'],
        doesFilm: true,
        doesTV: false,
        quote: '\$500K - \$1.5M',
        agency: 'UTA',
        availability: 'Available',
      ),
      _WriterProfile(
        name: 'Christopher McQuarrie',
        genres: ['Action', 'Thriller', 'Crime'],
        themes: ['heroism', 'redemption', 'loyalty'],
        credits: ['Mission: Impossible', 'The Usual Suspects', 'Top Gun: Maverick'],
        doesFilm: true,
        doesTV: false,
        quote: '\$5M - \$10M',
        agency: 'CAA',
        availability: 'Limited',
      ),
      _WriterProfile(
        name: 'Emerald Fennell',
        genres: ['Thriller', 'Drama', 'Dark Comedy'],
        themes: ['revenge', 'class', 'sexuality'],
        credits: ['Promising Young Woman', 'Saltburn', 'Killing Eve'],
        doesFilm: true,
        doesTV: true,
        quote: '\$2M - \$5M',
        agency: 'CAA',
        availability: 'Available',
      ),
    ];
  }
}

class _DirectorProfile {
  final String name;
  final List<String> genres;
  final List<String> tones;
  final List<String> credits;
  final bool doesFilm;
  final bool doesTV;
  final String budgetRange;
  final String quote;
  final String agency;
  final String availability;
  
  _DirectorProfile({
    required this.name,
    required this.genres,
    required this.tones,
    required this.credits,
    required this.doesFilm,
    required this.doesTV,
    required this.budgetRange,
    required this.quote,
    required this.agency,
    required this.availability,
  });
}

class _ActorProfile {
  final String name;
  final List<String> genres;
  final List<String> specialties;
  final List<String> tones;
  final List<String> themes;
  final List<String> credits;
  final String quote;
  final String agency;
  final String availability;
  final bool recentMomentum;
  
  _ActorProfile({
    required this.name,
    required this.genres,
    required this.specialties,
    required this.tones,
    required this.themes,
    required this.credits,
    required this.quote,
    required this.agency,
    required this.availability,
    required this.recentMomentum,
  });
}

class _WriterProfile {
  final String name;
  final List<String> genres;
  final List<String> themes;
  final List<String> credits;
  final bool doesFilm;
  final bool doesTV;
  final String quote;
  final String agency;
  final String availability;
  
  _WriterProfile({
    required this.name,
    required this.genres,
    required this.themes,
    required this.credits,
    required this.doesFilm,
    required this.doesTV,
    required this.quote,
    required this.agency,
    required this.availability,
  });
}
