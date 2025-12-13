/// ═══════════════════════════════════════════════════════════════════════════
/// FILM FESTIVALS DATABASE - 2025 Submission Calendar & Buyer Events
/// Last Updated: July 2025 (Data from festival websites, FilmFreeway)
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Sources:
/// - Official festival websites
/// - FilmFreeway submission platform
/// - Variety/Deadline festival coverage
/// - Screen Daily festival calendar

library;

/// ═══════════════════════════════════════════════════════════════════════════
/// FILM FESTIVAL DATA MODELS
/// ═══════════════════════════════════════════════════════════════════════════

class FilmFestival {
  final String name;
  final String abbreviation;
  final String location;
  final String tier; // 'A-List', 'Major', 'Genre', 'Regional', 'Market'
  final String festivalDates2025;
  final String submissionDeadlineEarly;
  final String submissionDeadlineFinal;
  final String submissionFee;
  final List<String> categories;
  final String bestFor;
  final bool hasMarket;
  final String marketInfo;
  final List<String> recentBreakouts;
  final String submissionPlatform;
  final String acquisitionActivity;
  
  const FilmFestival({
    required this.name,
    required this.abbreviation,
    required this.location,
    required this.tier,
    required this.festivalDates2025,
    required this.submissionDeadlineEarly,
    required this.submissionDeadlineFinal,
    required this.submissionFee,
    required this.categories,
    required this.bestFor,
    required this.hasMarket,
    required this.marketInfo,
    required this.recentBreakouts,
    required this.submissionPlatform,
    required this.acquisitionActivity,
  });
}

class FilmMarket {
  final String name;
  final String location;
  final String dates2025;
  final String associatedFestival;
  final String buyerTypes;
  final List<String> majorBuyers;
  final String registrationInfo;
  final String bestFor;
  
  const FilmMarket({
    required this.name,
    required this.location,
    required this.dates2025,
    required this.associatedFestival,
    required this.buyerTypes,
    required this.majorBuyers,
    required this.registrationInfo,
    required this.bestFor,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// MAJOR FILM FESTIVALS - 2025 CALENDAR
/// ═══════════════════════════════════════════════════════════════════════════

const List<FilmFestival> festivalDatabase = [
  // A-LIST FESTIVALS (Oscar qualifying, major acquisitions)
  FilmFestival(
    name: 'Sundance Film Festival',
    abbreviation: 'Sundance',
    location: 'Park City, Utah, USA',
    tier: 'A-List',
    festivalDates2025: 'January 23 - February 2, 2025',
    submissionDeadlineEarly: 'August 2024',
    submissionDeadlineFinal: 'September 2024',
    submissionFee: '\$50-80 (features)',
    categories: ['US Dramatic Competition', 'US Documentary Competition', 'World Cinema', 'NEXT', 'Midnight', 'Shorts'],
    bestFor: 'US independent cinema launch pad, documentary premieres, diverse voices',
    hasMarket: true,
    marketInfo: 'Sundance Film Festival conducts major acquisition activity during festival.',
    recentBreakouts: ['Past Lives', 'CODA', 'The Birth of a Nation', 'Whiplash', 'Get Out'],
    submissionPlatform: 'sundance.org',
    acquisitionActivity: 'VERY HIGH - Major streaming/theatrical acquisitions. A24, Neon, Searchlight active buyers.',
  ),
  FilmFestival(
    name: 'Cannes Film Festival',
    abbreviation: 'Cannes',
    location: 'Cannes, France',
    tier: 'A-List',
    festivalDates2025: 'May 13-24, 2025',
    submissionDeadlineEarly: 'February 2025',
    submissionDeadlineFinal: 'March 2025',
    submissionFee: 'Free (by invitation)',
    categories: ['Competition', 'Un Certain Regard', 'Directors Fortnight', 'Critics Week', 'Out of Competition'],
    bestFor: 'International prestige launches, auteur cinema, major sales',
    hasMarket: true,
    marketInfo: 'Marché du Film - largest film market in the world, 12,000+ attendees',
    recentBreakouts: ['Parasite', 'The Square', 'Anora', 'Anatomy of a Fall', 'Triangle of Sadness'],
    submissionPlatform: 'festival-cannes.com',
    acquisitionActivity: 'EXTREMELY HIGH - All major buyers present. Record-breaking deals common.',
  ),
  FilmFestival(
    name: 'Venice Film Festival',
    abbreviation: 'Venice',
    location: 'Venice, Italy',
    tier: 'A-List',
    festivalDates2025: 'August 27 - September 6, 2025',
    submissionDeadlineEarly: 'May 2025',
    submissionDeadlineFinal: 'June 13, 2025 (features), May 31 (shorts)',
    submissionFee: 'Free',
    categories: ['Venezia 82 Competition', 'Out of Competition', 'Horizons', 'Venice Days'],
    bestFor: 'Oscar launch platform, prestige drama, European cinema',
    hasMarket: false,
    marketInfo: 'No formal market but significant industry attendance and deals.',
    recentBreakouts: ['Joker', 'Nomadland', 'Poor Things', 'The Whale', 'Tar'],
    submissionPlatform: 'labiennale.org',
    acquisitionActivity: 'VERY HIGH - Oscar campaign launches. Netflix, Apple, Amazon actively buying.',
  ),
  FilmFestival(
    name: 'Berlin International Film Festival',
    abbreviation: 'Berlinale',
    location: 'Berlin, Germany',
    tier: 'A-List',
    festivalDates2025: 'February 13-23, 2025',
    submissionDeadlineEarly: 'September 2024',
    submissionDeadlineFinal: 'October 2024',
    submissionFee: 'Free',
    categories: ['Competition', 'Encounters', 'Panorama', 'Forum', 'Generation', 'Perspectives'],
    bestFor: 'Political cinema, LGBTQ+ stories, European distribution',
    hasMarket: true,
    marketInfo: 'European Film Market (EFM) - major European sales market',
    recentBreakouts: ['Bad Luck Banging', 'Alcarràs', 'Synonyms', 'Touch Me Not'],
    submissionPlatform: 'berlinale.de',
    acquisitionActivity: 'HIGH - European buyers very active. Arthouse focus.',
  ),
  FilmFestival(
    name: 'Toronto International Film Festival',
    abbreviation: 'TIFF',
    location: 'Toronto, Canada',
    tier: 'A-List',
    festivalDates2025: 'September 4-14, 2025',
    submissionDeadlineEarly: 'May 2025',
    submissionDeadlineFinal: 'June 2025',
    submissionFee: '\$75 CAD (shorts), \$150 CAD (features)',
    categories: ['Galas', 'Special Presentations', 'Discovery', 'Midnight Madness', 'Platform', 'TIFF Docs'],
    bestFor: 'People\'s Choice Award = Oscar predictor, North American premieres, acquisitions',
    hasMarket: true,
    marketInfo: 'TIFF Industry Conference - major North American buying activity',
    recentBreakouts: ['Green Book', 'Jojo Rabbit', 'La La Land', 'The Imitation Game', 'American Beauty'],
    submissionPlatform: 'tiff.net',
    acquisitionActivity: 'EXTREMELY HIGH - All major studios/streamers present. Many record deals.',
  ),

  // MAJOR GENRE FESTIVALS
  FilmFestival(
    name: 'Fantastic Fest',
    abbreviation: 'FF',
    location: 'Austin, Texas, USA',
    tier: 'Genre',
    festivalDates2025: 'September 2025',
    submissionDeadlineEarly: 'May 2025',
    submissionDeadlineFinal: 'July 2025',
    submissionFee: '\$40-75',
    categories: ['Competition', 'Spotlight', 'Secret Screenings', 'Shorts'],
    bestFor: 'Horror, sci-fi, fantasy, action - genre premiere destination',
    hasMarket: true,
    marketInfo: 'Fantastic Market - genre-focused sales activity',
    recentBreakouts: ['Barbarian', 'Let the Right One In', 'The Raid', 'Green Room'],
    submissionPlatform: 'fantasticfest.com',
    acquisitionActivity: 'HIGH for genre - A24, Neon, RLJE, Shudder active.',
  ),
  FilmFestival(
    name: 'Sitges Film Festival',
    abbreviation: 'Sitges',
    location: 'Sitges, Spain',
    tier: 'Genre',
    festivalDates2025: 'October 2025',
    submissionDeadlineEarly: 'June 2025',
    submissionDeadlineFinal: 'July 2025',
    submissionFee: '\$30-50',
    categories: ['Official Fantàstic Competition', 'Midnight X-Treme', 'Blood Window', 'Anima\'t'],
    bestFor: 'European horror/genre launch, international sales',
    hasMarket: true,
    marketInfo: 'Blood Window - Latin American genre focus',
    recentBreakouts: ['REC', 'The Orphanage', 'Sleep Tight'],
    submissionPlatform: 'sitgesfilmfestival.com',
    acquisitionActivity: 'MODERATE-HIGH - European genre buyers.',
  ),
  FilmFestival(
    name: 'South by Southwest',
    abbreviation: 'SXSW',
    location: 'Austin, Texas, USA',
    tier: 'Major',
    festivalDates2025: 'March 7-15, 2025',
    submissionDeadlineEarly: 'September 2024',
    submissionDeadlineFinal: 'November 2024',
    submissionFee: '\$50-75',
    categories: ['Narrative Feature', 'Documentary Feature', 'Episodic', 'Shorts', 'Music Videos'],
    bestFor: 'Tech-adjacent films, genre crossover, music docs, comedy',
    hasMarket: true,
    marketInfo: 'SXSW Film Conference - significant industry presence',
    recentBreakouts: ['Everything Everywhere All at Once', 'The Disaster Artist', 'Bridesmaids', 'Us'],
    submissionPlatform: 'sxsw.com',
    acquisitionActivity: 'HIGH - Major buyers attend. Good for genre, comedy, tech themes.',
  ),
  FilmFestival(
    name: 'Tribeca Film Festival',
    abbreviation: 'Tribeca',
    location: 'New York City, USA',
    tier: 'Major',
    festivalDates2025: 'June 2025',
    submissionDeadlineEarly: 'December 2024',
    submissionDeadlineFinal: 'February 2025',
    submissionFee: '\$50-85',
    categories: ['US Narrative Competition', 'International Narrative', 'Documentary', 'Shorts', 'Immersive'],
    bestFor: 'New York premieres, diverse storytelling, immersive media',
    hasMarket: true,
    marketInfo: 'Tribeca Industry - focused industry program',
    recentBreakouts: ['Exit Through the Gift Shop', 'Time', 'Sleepwalk with Me'],
    submissionPlatform: 'tribecafilm.com',
    acquisitionActivity: 'MODERATE-HIGH - Strong documentary buying.',
  ),
  FilmFestival(
    name: 'Telluride Film Festival',
    abbreviation: 'Telluride',
    location: 'Telluride, Colorado, USA',
    tier: 'A-List',
    festivalDates2025: 'August 29 - September 1, 2025',
    submissionDeadlineEarly: 'By invitation only',
    submissionDeadlineFinal: 'By invitation only',
    submissionFee: 'N/A (invitation only)',
    categories: ['Main Slate', 'Tribute', 'Special Events'],
    bestFor: 'Oscar campaign launch, prestige world premieres',
    hasMarket: false,
    marketInfo: 'No formal market but intense industry attendance.',
    recentBreakouts: ['Moonlight', 'Brokeback Mountain', 'Juno', 'Argo'],
    submissionPlatform: 'telluridefilmfestival.org',
    acquisitionActivity: 'HIGH - Oscar campaign platform. Prestige buyers.',
  ),
  FilmFestival(
    name: 'Locarno Film Festival',
    abbreviation: 'Locarno',
    location: 'Locarno, Switzerland',
    tier: 'A-List',
    festivalDates2025: 'August 6-16, 2025',
    submissionDeadlineEarly: 'April 2025',
    submissionDeadlineFinal: 'May 2025',
    submissionFee: 'CHF 50-100',
    categories: ['Piazza Grande', 'Concorso internazionale', 'Cineasti del presente', 'Signs of Life'],
    bestFor: 'Auteur cinema, experimental work, European co-productions',
    hasMarket: true,
    marketInfo: 'Locarno Pro - industry program and market',
    recentBreakouts: ['Beau Travail', 'Force Majeure'],
    submissionPlatform: 'pardolive.ch',
    acquisitionActivity: 'MODERATE - European arthouse buyers.',
  ),

  // DOCUMENTARY FESTIVALS
  FilmFestival(
    name: 'IDFA (International Documentary Film Festival Amsterdam)',
    abbreviation: 'IDFA',
    location: 'Amsterdam, Netherlands',
    tier: 'A-List',
    festivalDates2025: 'November 2025',
    submissionDeadlineEarly: 'June 2025',
    submissionDeadlineFinal: 'August 2025',
    submissionFee: '€50-80',
    categories: ['Best Film', 'Best Director', 'First Appearance', 'IDFA DocLab'],
    bestFor: 'Documentary world premieres, European launch',
    hasMarket: true,
    marketInfo: 'IDFA Forum - documentary co-production market',
    recentBreakouts: ['The Act of Killing', 'Honeyland', 'Fire of Love'],
    submissionPlatform: 'idfa.nl',
    acquisitionActivity: 'HIGH for documentaries - Netflix, HBO, Nat Geo active.',
  ),
  FilmFestival(
    name: 'Hot Docs',
    abbreviation: 'Hot Docs',
    location: 'Toronto, Canada',
    tier: 'Major',
    festivalDates2025: 'April-May 2025',
    submissionDeadlineEarly: 'November 2024',
    submissionDeadlineFinal: 'January 2025',
    submissionFee: '\$50-80 CAD',
    categories: ['World Showcase', 'Canadian Spectrum', 'International Spectrum', 'Shorts'],
    bestFor: 'Documentary North American premieres, Canadian content',
    hasMarket: true,
    marketInfo: 'Hot Docs Forum - financing and co-production',
    recentBreakouts: ['RBG', 'Summer of Soul', 'Collective'],
    submissionPlatform: 'hotdocs.ca',
    acquisitionActivity: 'HIGH for docs - Major doc buyers attend.',
  ),
  FilmFestival(
    name: 'Sheffield DocFest',
    abbreviation: 'Sheffield',
    location: 'Sheffield, UK',
    tier: 'Major',
    festivalDates2025: 'June 2025',
    submissionDeadlineEarly: 'January 2025',
    submissionDeadlineFinal: 'February 2025',
    submissionFee: '£35-65',
    categories: ['Tim Hetherington Award', 'Art Doc Award', 'Short Doc Award'],
    bestFor: 'UK documentary launch, British broadcasters',
    hasMarket: true,
    marketInfo: 'MeetMarket - documentary pitching forum',
    recentBreakouts: ['Notes on Blindness', 'The Arbor'],
    submissionPlatform: 'sheffdocfest.com',
    acquisitionActivity: 'MODERATE - UK broadcasters, European buyers.',
  ),

  // SHORTS & EMERGING TALENT
  FilmFestival(
    name: 'Clermont-Ferrand Short Film Festival',
    abbreviation: 'Clermont',
    location: 'Clermont-Ferrand, France',
    tier: 'Major',
    festivalDates2025: 'January 31 - February 8, 2025',
    submissionDeadlineEarly: 'September 2024',
    submissionDeadlineFinal: 'October 2024',
    submissionFee: '€20-35',
    categories: ['International Competition', 'National Competition', 'Lab Competition'],
    bestFor: 'World\'s largest short film festival, career launcher',
    hasMarket: true,
    marketInfo: 'Short Film Market - extensive shorts market',
    recentBreakouts: ['Many Oscar-winning shorts premiered here'],
    submissionPlatform: 'clermont-filmfest.org',
    acquisitionActivity: 'HIGH for shorts - Distributors, broadcast buyers.',
  ),
  FilmFestival(
    name: 'Palm Springs International ShortFest',
    abbreviation: 'ShortFest',
    location: 'Palm Springs, California, USA',
    tier: 'Major',
    festivalDates2025: 'June 2025',
    submissionDeadlineEarly: 'February 2025',
    submissionDeadlineFinal: 'March 2025',
    submissionFee: '\$40-65',
    categories: ['Live Action', 'Animation', 'Documentary', 'Student'],
    bestFor: 'Oscar-qualifying shorts, industry connections',
    hasMarket: false,
    marketInfo: 'ShortFest Forum - industry panels and meetings',
    recentBreakouts: ['Multiple Oscar-nominated shorts'],
    submissionPlatform: 'psfilmfest.org',
    acquisitionActivity: 'MODERATE - Academy members attend.',
  ),

  // REGIONAL/SPECIALTY FESTIVALS
  FilmFestival(
    name: 'AFI Fest',
    abbreviation: 'AFI Fest',
    location: 'Los Angeles, California, USA',
    tier: 'Major',
    festivalDates2025: 'October-November 2025',
    submissionDeadlineEarly: 'July 2025',
    submissionDeadlineFinal: 'August 2025',
    submissionFee: '\$60-90',
    categories: ['World Cinema', 'New Auteurs', 'Documentary', 'Shorts'],
    bestFor: 'LA industry exposure, Oscar positioning, free public screenings',
    hasMarket: false,
    marketInfo: 'No formal market but strong industry attendance.',
    recentBreakouts: ['Precious', 'Beasts of the Southern Wild'],
    submissionPlatform: 'afi.com/afifest',
    acquisitionActivity: 'MODERATE - LA industry exposure.',
  ),
  FilmFestival(
    name: 'BFI London Film Festival',
    abbreviation: 'LFF',
    location: 'London, UK',
    tier: 'A-List',
    festivalDates2025: 'October 2025',
    submissionDeadlineEarly: 'May 2025',
    submissionDeadlineFinal: 'June 2025',
    submissionFee: '£25-65',
    categories: ['Best Film', 'Documentary', 'First Feature', 'Short Film'],
    bestFor: 'UK premieres, British distribution, European exposure',
    hasMarket: true,
    marketInfo: 'LFF Production Finance Market',
    recentBreakouts: ['The Favourite', 'American Honey', 'Moonlight'],
    submissionPlatform: 'bfi.org.uk/lff',
    acquisitionActivity: 'HIGH - UK distributors, European buyers.',
  ),
  FilmFestival(
    name: 'San Sebastián International Film Festival',
    abbreviation: 'SSIFF',
    location: 'San Sebastián, Spain',
    tier: 'A-List',
    festivalDates2025: 'September 2025',
    submissionDeadlineEarly: 'May 2025',
    submissionDeadlineFinal: 'June 2025',
    submissionFee: 'Free',
    categories: ['Official Selection', 'New Directors', 'Horizontes Latinos', 'Zabaltegi-Tabakalera'],
    bestFor: 'Spanish-language cinema, Latin American films, European distribution',
    hasMarket: true,
    marketInfo: 'Film Market and Industry Club',
    recentBreakouts: ['Amour', 'Smoke', 'Prisoners'],
    submissionPlatform: 'sansebastianfestival.com',
    acquisitionActivity: 'MODERATE-HIGH - Spanish/Latin American focus.',
  ),
];

/// ═══════════════════════════════════════════════════════════════════════════
/// FILM MARKETS DATABASE
/// ═══════════════════════════════════════════════════════════════════════════

const List<FilmMarket> marketsDatabase = [
  FilmMarket(
    name: 'Marché du Film',
    location: 'Cannes, France',
    dates2025: 'May 13-22, 2025',
    associatedFestival: 'Cannes Film Festival',
    buyerTypes: 'All - theatrical, streaming, TV, home video, international',
    majorBuyers: ['Netflix', 'Amazon', 'Apple', 'A24', 'Neon', 'Focus', 'Sony Classics', 'All major studios'],
    registrationInfo: 'marchedulfilm.com - badges from €600+',
    bestFor: 'All content types. World\'s largest film market.',
  ),
  FilmMarket(
    name: 'American Film Market',
    location: 'Santa Monica, California, USA',
    dates2025: 'November 2025',
    associatedFestival: 'None (standalone)',
    buyerTypes: 'International sales, pre-sales, genre content',
    majorBuyers: ['International distributors', 'Genre buyers', 'Sales agents'],
    registrationInfo: 'americanfilmmarket.com - badges from \$495',
    bestFor: 'Pre-sales, international sales, genre films, action.',
  ),
  FilmMarket(
    name: 'European Film Market (EFM)',
    location: 'Berlin, Germany',
    dates2025: 'February 13-20, 2025',
    associatedFestival: 'Berlinale',
    buyerTypes: 'European distributors, co-productions, art house',
    majorBuyers: ['European distributors', 'Arte', 'ZDF', 'BBC Film', 'Film4'],
    registrationInfo: 'efm-berlinale.de - badges from €395',
    bestFor: 'European co-productions, arthouse cinema, documentary.',
  ),
  FilmMarket(
    name: 'Toronto International Film Festival Industry',
    location: 'Toronto, Canada',
    dates2025: 'September 4-14, 2025',
    associatedFestival: 'TIFF',
    buyerTypes: 'North American theatrical, streaming, prestige',
    majorBuyers: ['All major studios', 'Netflix', 'Amazon', 'Apple', 'A24', 'Neon', 'Searchlight'],
    registrationInfo: 'tiff.net/industry',
    bestFor: 'North American premieres, Oscar contenders, prestige.',
  ),
  FilmMarket(
    name: 'Hong Kong FILMART',
    location: 'Hong Kong',
    dates2025: 'March 2025',
    associatedFestival: 'Hong Kong International Film Festival',
    buyerTypes: 'Asian buyers, international sales to Asia',
    majorBuyers: ['Asian theatrical distributors', 'Streaming platforms', 'TV buyers'],
    registrationInfo: 'filmart.hktdc.com',
    bestFor: 'Asian sales, co-productions with Asia, anime.',
  ),
  FilmMarket(
    name: 'Ventana Sur',
    location: 'Buenos Aires, Argentina',
    dates2025: 'December 2025',
    associatedFestival: 'None',
    buyerTypes: 'Latin American buyers, co-productions',
    majorBuyers: ['Latin American distributors', 'Spanish-language buyers'],
    registrationInfo: 'ventana-sur.com',
    bestFor: 'Latin American content, Spanish-language films.',
  ),
];

/// ═══════════════════════════════════════════════════════════════════════════
/// FESTIVAL STRATEGY RECOMMENDATIONS
/// ═══════════════════════════════════════════════════════════════════════════

const Map<String, List<String>> festivalStrategyByGoal = {
  'Oscar Campaign': [
    'Venice (August) → Telluride (August/September) → TIFF (September) pathway most successful',
    'Fall festival circuit: Venice, Telluride, TIFF creates momentum',
    'Sundance (January) for indie Oscar hopefuls',
    'AFI Fest for LA industry exposure pre-nominations',
  ],
  'Theatrical Acquisition': [
    'Sundance - highest acquisition activity for US indie',
    'TIFF - major North American buying',
    'Cannes - record-breaking deals, international reach',
    'SXSW - strong genre and comedy acquisitions',
  ],
  'Streaming Acquisition': [
    'Sundance - Netflix, Amazon, Apple all active',
    'TIFF - all major streamers present',
    'Berlin - European streaming platforms',
    'Tribeca - documentary streaming deals',
  ],
  'Horror/Genre': [
    'Fantastic Fest - premier genre destination',
    'SXSW Midnight - genre crossover',
    'Sitges - European genre launch',
    'FrightFest (London) - UK horror market',
  ],
  'Documentary': [
    'Sundance Documentary Competition - premier doc launch',
    'IDFA - world\'s largest documentary festival',
    'Hot Docs - North American documentary market',
    'Sheffield DocFest - UK/European broadcast sales',
  ],
  'International Sales': [
    'Cannes Marché du Film - largest film market globally',
    'Berlin EFM - European focus',
    'AFM - international pre-sales, genre content',
    'Hong Kong FILMART - Asian market access',
  ],
  'First Feature': [
    'Sundance NEXT section - experimental first features',
    'TIFF Discovery - emerging filmmakers',
    'Berlin Forum/Encounters - adventurous debuts',
    'Locarno - auteur-focused first features',
  ],
};

/// Helper function to get festivals by tier
List<FilmFestival> getFestivalsByTier(String tier) {
  return festivalDatabase.where((f) => f.tier == tier).toList();
}

/// Helper function to get festivals with markets
List<FilmFestival> get festivalsWithMarkets {
  return festivalDatabase.where((f) => f.hasMarket).toList();
}

/// Helper function to get festivals by genre suitability
List<FilmFestival> getFestivalsForGenre(String genre) {
  final genreFestivals = <FilmFestival>[];
  
  for (final fest in festivalDatabase) {
    final bestForLower = fest.bestFor.toLowerCase();
    if (genre == 'Horror' && (bestForLower.contains('horror') || bestForLower.contains('genre') || bestForLower.contains('midnight'))) {
      genreFestivals.add(fest);
    } else if (genre == 'Documentary' && bestForLower.contains('documentary')) {
      genreFestivals.add(fest);
    } else if ((genre == 'Drama' || genre == 'Comedy') && (fest.tier == 'A-List' || fest.tier == 'Major')) {
      genreFestivals.add(fest);
    }
  }
  
  return genreFestivals;
}
