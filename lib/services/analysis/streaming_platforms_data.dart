/// ═══════════════════════════════════════════════════════════════════════════
/// STREAMING PLATFORMS DATABASE - 2024-2025 Content Strategy & Acquisitions
/// Last Updated: July 2025 (Data from earnings calls, trade press, Nielsen)
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Sources:
/// - Company quarterly earnings reports
/// - Nielsen streaming data
/// - Variety/Deadline acquisition reports
/// - Antenna subscriber data

library;

/// ═══════════════════════════════════════════════════════════════════════════
/// STREAMING PLATFORM DATA MODELS
/// ═══════════════════════════════════════════════════════════════════════════

class StreamingPlatform {
  final String name;
  final String parentCompany;
  final int subscribersMillions;
  final double annualContentSpendBillions;
  final List<String> contentPillars;
  final String originalFilmStrategy;
  final String originalSeriesStrategy;
  final List<String> recentOriginalHits;
  final String acquisitionStrategy;
  final String budgetRange;
  final String currentPriorities;
  final bool acceptsSubmissions;
  final String submissionPath;
  final String competitiveAdvantage;
  final String marketPosition;
  
  const StreamingPlatform({
    required this.name,
    required this.parentCompany,
    required this.subscribersMillions,
    required this.annualContentSpendBillions,
    required this.contentPillars,
    required this.originalFilmStrategy,
    required this.originalSeriesStrategy,
    required this.recentOriginalHits,
    required this.acquisitionStrategy,
    required this.budgetRange,
    required this.currentPriorities,
    required this.acceptsSubmissions,
    required this.submissionPath,
    required this.competitiveAdvantage,
    required this.marketPosition,
  });
}

class ContentDeal {
  final String platform;
  final String title;
  final int year;
  final String dealType; // 'Acquisition', 'Output Deal', 'First-Look', 'Overall'
  final String reportedValue;
  final String notes;
  
  const ContentDeal({
    required this.platform,
    required this.title,
    required this.year,
    required this.dealType,
    required this.reportedValue,
    required this.notes,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// MAJOR STREAMING PLATFORMS - 2024-2025 DATA
/// ═══════════════════════════════════════════════════════════════════════════

const List<StreamingPlatform> streamingPlatformsDatabase = [
  StreamingPlatform(
    name: 'Netflix',
    parentCompany: 'Netflix, Inc.',
    subscribersMillions: 302,
    annualContentSpendBillions: 17.0,
    contentPillars: [
      'High-volume original content',
      'Global production (50% non-English)',
      'Four-quadrant entertainment',
      'Franchise building',
    ],
    originalFilmStrategy: 'Focus on star-driven packages, high-concept originals, and event films. Seeking theatrical-quality productions for streaming. 50+ original films annually.',
    originalSeriesStrategy: 'Limited series favored over long-running shows. Global content from 50+ countries. Strong K-drama, Spanish-language, and British content.',
    recentOriginalHits: [
      'Glass Onion', 'All Quiet on the Western Front', 'Rebel Ridge', 'Hit Man',
      'Squid Game', 'Wednesday', '3 Body Problem', 'Baby Reindeer', 'The Gentlemen'
    ],
    acquisitionStrategy: 'Festival acquisitions continue but reduced. Focus on originals. Theatrical windows for select prestige titles.',
    budgetRange: '\$5M - \$200M (films), \$8M - \$25M/episode (series)',
    currentPriorities: 'Reduce churn through event content, build gaming division, live events, ad-supported tier growth',
    acceptsSubmissions: false,
    submissionPath: 'Through agents/managers only. Strong preference for packaged projects.',
    competitiveAdvantage: 'Global reach (190+ countries), recommendation algorithm, brand recognition, ad tier for price-sensitive',
    marketPosition: 'Market leader in subscribers and original content volume. 28% operating margin target.',
  ),
  StreamingPlatform(
    name: 'Amazon Prime Video / MGM Studios',
    parentCompany: 'Amazon',
    subscribersMillions: 200,
    annualContentSpendBillions: 20.0,
    contentPillars: [
      'MGM library integration',
      'Franchise development (James Bond, Rocky, etc.)',
      'Theatrical-to-streaming pipeline',
      'Sports (Thursday Night Football)',
    ],
    originalFilmStrategy: 'Major theatrical releases through MGM + streaming originals. Road House model - theatrical-quality for streaming. Seeking franchise potential.',
    originalSeriesStrategy: 'Flagship series (Rings of Power, Jack Ryan, The Boys). Genre diversity. Expensive tentpole series.',
    recentOriginalHits: [
      'Saltburn', 'Road House', 'The Idea of You', 'Air', 'Challengers',
      'The Boys', 'Fallout', 'Citadel', 'Mr. & Mrs. Smith'
    ],
    acquisitionStrategy: 'Aggressive festival buyer. Sundance, TIFF major player. MGM theatrical distribution.',
    budgetRange: '\$10M - \$250M (films), \$10M - \$50M/episode (tentpole series)',
    currentPriorities: 'MGM integration, franchise building, sports expansion, international originals',
    acceptsSubmissions: false,
    submissionPath: 'Through agents/managers. Amazon Studios open to pitches through representation.',
    competitiveAdvantage: 'Prime bundle (shipping + streaming), MGM library, theatrical distribution capability',
    marketPosition: 'Second largest by content spend. Bundled with Prime shipping makes subscriber count complex.',
  ),
  StreamingPlatform(
    name: 'Apple TV+',
    parentCompany: 'Apple Inc.',
    subscribersMillions: 75,
    annualContentSpendBillions: 8.0,
    contentPillars: [
      'Prestige content only',
      'A-list talent deals',
      'Awards-focused slate',
      'Quality over quantity',
    ],
    originalFilmStrategy: 'Theatrical-first for prestige titles (Killers of the Flower Moon, Napoleon). Awards campaign investment. Select streaming premieres.',
    originalSeriesStrategy: 'Flagship prestige series. A-list showrunner deals. Limited quantity, maximum quality.',
    recentOriginalHits: [
      'Killers of the Flower Moon', 'Napoleon', 'Wolfs', 'Argylle',
      'Severance', 'The Morning Show', 'Slow Horses', 'Ted Lasso', 'Silo'
    ],
    acquisitionStrategy: 'Selective festival buyer for prestige. Willing to pay premium for awards-caliber material.',
    budgetRange: '\$50M - \$200M+ (films), \$15M - \$25M/episode (series)',
    currentPriorities: 'Scorsese relationship, Spielberg deal, awards recognition, subscriber growth through quality',
    acceptsSubmissions: false,
    submissionPath: 'A-list representation required. Package-dependent. First-look deals with major filmmakers.',
    competitiveAdvantage: 'Apple brand prestige, device integration, willingness to spend on quality, theatrical support',
    marketPosition: 'Smallest major by subscribers but highest per-subscriber content spend. Quality positioning.',
  ),
  StreamingPlatform(
    name: 'Max (HBO/Warner Bros Discovery)',
    parentCompany: 'Warner Bros. Discovery',
    subscribersMillions: 100,
    annualContentSpendBillions: 8.0,
    contentPillars: [
      'HBO prestige brand',
      'DC Universe content',
      'Warner Bros. theatrical',
      'Reality/unscripted',
    ],
    originalFilmStrategy: 'Warner theatrical window then Max. HBO Films prestige originals. DC animated and live-action.',
    originalSeriesStrategy: 'HBO flagship series (House of the Dragon, The Last of Us). Max originals for broader appeal. Reality content integration.',
    recentOriginalHits: [
      'House of the Dragon', 'The Last of Us', 'True Detective: Night Country', 'The White Lotus',
      'Hacks', 'And Just Like That', 'The Penguin'
    ],
    acquisitionStrategy: 'Warner Bros theatrical provides pipeline. Select independent acquisitions.',
    budgetRange: '\$5M - \$200M (films through WB), \$10M - \$20M/episode (HBO series)',
    currentPriorities: 'DC Universe reset (James Gunn), streaming profitability, international expansion',
    acceptsSubmissions: false,
    submissionPath: 'HBO: prestige through representation. Max: broader appeal projects.',
    competitiveAdvantage: 'HBO brand prestige, Warner Bros library, theatrical pipeline, DC IP',
    marketPosition: 'Merged HBO Max + Discovery. Profitability focus after debt concerns.',
  ),
  StreamingPlatform(
    name: 'Disney+',
    parentCompany: 'The Walt Disney Company',
    subscribersMillions: 126,
    annualContentSpendBillions: 6.0,
    contentPillars: [
      'Marvel Studios',
      'Star Wars (Lucasfilm)',
      'Pixar Animation',
      'Disney Animation',
      'National Geographic',
    ],
    originalFilmStrategy: 'Theatrical-first for tentpoles. Disney+ premieres for mid-budget. Pixar theatrical restored after streaming experiments.',
    originalSeriesStrategy: 'Marvel/Star Wars series content. Disney Channel programming. Nat Geo documentaries.',
    recentOriginalHits: [
      'The Mandalorian', 'Loki', 'Ahsoka', 'Percy Jackson',
      'Elemental', 'Inside Out 2', 'Moana 2'
    ],
    acquisitionStrategy: 'Limited acquisitions. Focus on franchise content. 20th Century Studios for mature content.',
    budgetRange: '\$100M - \$300M (theatrical), \$15M - \$25M/episode (series)',
    currentPriorities: 'Profitability, content quality over quantity, theatrical restoration, franchise fatigue management',
    acceptsSubmissions: false,
    submissionPath: 'Through representation for 20th Century Studios projects. Marvel/Lucasfilm internal.',
    competitiveAdvantage: 'Unmatched IP portfolio (Marvel, Star Wars, Pixar, Disney), family-friendly brand, parks synergy',
    marketPosition: 'Third largest global streaming. Family content leader. Facing franchise fatigue challenges.',
  ),
  StreamingPlatform(
    name: 'Hulu',
    parentCompany: 'The Walt Disney Company (100%)',
    subscribersMillions: 51,
    annualContentSpendBillions: 3.0,
    contentPillars: [
      'Next-day broadcast',
      'FX content',
      'Adult animation',
      'Original series',
    ],
    originalFilmStrategy: 'Genre films (horror, thriller). Lower-budget originals. Genre crossover with FX.',
    originalSeriesStrategy: 'FX series hub. Original comedies and dramas. The Bear model for prestige.',
    recentOriginalHits: [
      'The Bear', 'Shōgun', 'Only Murders in the Building', 'Palm Royale',
      'No One Will Save You', 'Prey'
    ],
    acquisitionStrategy: 'Genre acquisitions. Horror/thriller focus. Searchlight overflow.',
    budgetRange: '\$5M - \$50M (films), \$5M - \$20M/episode (series)',
    currentPriorities: 'FX integration, bundle with Disney+, original hit development',
    acceptsSubmissions: false,
    submissionPath: 'Through representation. FX brand for prestige. Hulu for broader appeal.',
    competitiveAdvantage: 'Next-day broadcast content, FX prestige brand, Disney+ bundle option, younger demo',
    marketPosition: 'US-focused (international via Disney+ Star). Disney bundle key driver.',
  ),
  StreamingPlatform(
    name: 'Paramount+',
    parentCompany: 'Paramount Global',
    subscribersMillions: 71,
    annualContentSpendBillions: 4.0,
    contentPillars: [
      'Paramount theatrical pipeline',
      'CBS content integration',
      'Star Trek franchise',
      'Yellowstone universe',
    ],
    originalFilmStrategy: 'Paramount theatrical to streaming. Original films in development. 45-day theatrical window.',
    originalSeriesStrategy: 'Taylor Sheridan universe (Yellowstone, 1883, etc.). Star Trek series. CBS procedurals.',
    recentOriginalHits: [
      'Yellowstone', '1883', 'Tulsa King', 'Special Ops: Lioness',
      'Star Trek: Strange New Worlds', 'A Quiet Place: Day One'
    ],
    acquisitionStrategy: 'Limited acquisitions. Focus on franchise content and Sheridan projects.',
    budgetRange: '\$20M - \$200M (films), \$8M - \$15M/episode (series)',
    currentPriorities: 'Potential sale/merger, streaming profitability, Taylor Sheridan relationship',
    acceptsSubmissions: false,
    submissionPath: 'Through representation. Taylor Sheridan connection valuable.',
    competitiveAdvantage: 'CBS content library, Star Trek IP, Yellowstone phenomenon, theatrical pipeline',
    marketPosition: 'Merger target (Skydance deal pending). Cost-cutting mode.',
  ),
  StreamingPlatform(
    name: 'Peacock',
    parentCompany: 'NBCUniversal (Comcast)',
    subscribersMillions: 34,
    annualContentSpendBillions: 2.5,
    contentPillars: [
      'NBC content library',
      'Universal theatrical',
      'Sports (Olympics, Premier League)',
      'Original series',
    ],
    originalFilmStrategy: 'Universal theatrical overflow. Original genre films. Direct-to-streaming mid-budget.',
    originalSeriesStrategy: 'Procedurals, true crime, limited series. Poker Face model for prestige.',
    recentOriginalHits: [
      'Poker Face', 'Based on a True Story', 'Apples Never Fall', 'Dr. Death',
      'Bel-Air', 'Girls5eva'
    ],
    acquisitionStrategy: 'Selective acquisitions. Genre content. True crime focus.',
    budgetRange: '\$5M - \$50M (films), \$4M - \$10M/episode (series)',
    currentPriorities: 'Subscriber growth through sports, original hit development, NBCU synergy',
    acceptsSubmissions: false,
    submissionPath: 'Through representation. NBC Universal relationships helpful.',
    competitiveAdvantage: 'Sports rights (Olympics, EPL), NBC library, Universal theatrical, broadcast synergy',
    marketPosition: 'Growth stage. Sports differentiation key strategy.',
  ),
  StreamingPlatform(
    name: 'Shudder',
    parentCompany: 'AMC Networks',
    subscribersMillions: 3,
    annualContentSpendBillions: 0.15,
    contentPillars: [
      'Horror originals',
      'Horror library curation',
      'Genre exclusive content',
      'Horror community',
    ],
    originalFilmStrategy: 'Low-budget horror originals. Festival acquisitions. Exclusive horror content.',
    originalSeriesStrategy: 'Horror series (Creepshow, Slasher). Documentary series.',
    recentOriginalHits: [
      'V/H/S franchise', 'Host', 'Skinamarink', 'Creepshow',
      'Deadstream', 'Glorious'
    ],
    acquisitionStrategy: 'Active horror festival buyer. Exclusive horror focus. Good for genre debuts.',
    budgetRange: '\$500K - \$5M (films), Low-budget originals',
    currentPriorities: 'Genre community building, exclusive horror content, cult film curation',
    acceptsSubmissions: true,
    submissionPath: 'Genre film submissions accepted. Horror festivals pathway effective.',
    competitiveAdvantage: 'Dedicated horror audience, community-focused, curator taste, affordable entry',
    marketPosition: 'Niche horror leader. Small but dedicated subscriber base. AMC ownership in flux.',
  ),
  StreamingPlatform(
    name: 'MUBI',
    parentCompany: 'MUBI, Inc.',
    subscribersMillions: 15,
    annualContentSpendBillions: 0.5,
    contentPillars: [
      'Curated arthouse',
      'Festival films',
      'International cinema',
      'Director retrospectives',
    ],
    originalFilmStrategy: 'Production arm (MUBI Films). Festival co-productions. Theatrical + streaming day-and-date.',
    originalSeriesStrategy: 'Limited series content. Focus on film over TV.',
    recentOriginalHits: [
      'Aftersun', 'Passages', 'The Substance', 'Saint Omer',
      'Memoria', 'In Front of Your Face'
    ],
    acquisitionStrategy: 'Festival buyer (Cannes, Venice, Berlin). International arthouse focus.',
    budgetRange: '\$1M - \$15M (typical acquisitions/productions)',
    currentPriorities: 'Global expansion, theatrical distribution (MUBI Go), original production growth',
    acceptsSubmissions: false,
    submissionPath: 'Festival pathway essential. Art house positioning required.',
    competitiveAdvantage: 'Curatorial brand, cinephile community, festival relationships, MUBI Go theatrical perk',
    marketPosition: 'Art house streaming leader. Growing theatrical presence. Global expansion.',
  ),
];

/// ═══════════════════════════════════════════════════════════════════════════
/// 2024-2025 STREAMING MARKET TRENDS
/// ═══════════════════════════════════════════════════════════════════════════

const streamingMarketTrends2025 = {
  'total_global_svod_revenue_2024': 101, // billions USD
  'projected_growth_2025': 8.5, // percentage
  'total_content_spend_major_platforms': 210, // billions USD
  'key_trends': [
    'Ad-supported tiers gaining momentum (Netflix, Disney+, Max ad tiers)',
    'Password sharing crackdown drove subscriber growth',
    'Consolidation continues (Paramount sale pending)',
    'Quality over quantity shift industry-wide',
    'Theatrical windows shortening to 45 days standard',
    'International/local content investment increasing',
    'Sports rights driving subscriber acquisition',
    'Gaming/interactive content expansion',
  ],
  'content_strategy_shifts': [
    'Fewer but bigger original films',
    'Limited series over multi-season commitments',
    'Cost-per-subscriber efficiency focus',
    'Franchise/IP development prioritized',
    'Live events and sports integration',
    'Theatrical releases for prestige/event titles',
  ],
  'acquisition_environment': {
    'festival_activity': 'Reduced but still significant at major festivals',
    'price_compression': 'Acquisition prices down 20-40% from 2021-2022 peak',
    'hot_genres': ['Horror', 'True Crime', 'Limited Series', 'International'],
    'cooling_genres': ['Expensive action', 'Multi-season drama commitments'],
  },
};

/// ═══════════════════════════════════════════════════════════════════════════
/// NOTABLE STREAMING DEALS 2023-2024
/// ═══════════════════════════════════════════════════════════════════════════

const List<ContentDeal> notableDealsDatabase = [
  ContentDeal(
    platform: 'Netflix',
    title: 'Rebel Ridge',
    year: 2024,
    dealType: 'Acquisition',
    reportedValue: '\$40M+',
    notes: 'Jeremy Saulnier thriller. Strong viewership performance.',
  ),
  ContentDeal(
    platform: 'Netflix',
    title: 'Hit Man',
    year: 2024,
    dealType: 'Acquisition',
    reportedValue: '\$20M',
    notes: 'Linklater comedy. Limited theatrical before streaming.',
  ),
  ContentDeal(
    platform: 'Amazon',
    title: 'Saltburn',
    year: 2023,
    dealType: 'Acquisition',
    reportedValue: '\$12M',
    notes: 'Emerald Fennell thriller. Viral social media success.',
  ),
  ContentDeal(
    platform: 'Amazon',
    title: 'Road House',
    year: 2024,
    dealType: 'Production',
    reportedValue: '\$85M budget',
    notes: 'Jake Gyllenhaal action remake. Streaming premiere.',
  ),
  ContentDeal(
    platform: 'Apple TV+',
    title: 'Killers of the Flower Moon',
    year: 2023,
    dealType: 'Co-production',
    reportedValue: '\$200M budget',
    notes: 'Scorsese epic. Theatrical release with Apple support.',
  ),
  ContentDeal(
    platform: 'Apple TV+',
    title: 'Napoleon',
    year: 2023,
    dealType: 'Production',
    reportedValue: '\$200M budget',
    notes: 'Ridley Scott epic. Theatrical-first strategy.',
  ),
  ContentDeal(
    platform: 'Neon',
    title: 'Anora',
    year: 2024,
    dealType: 'Acquisition',
    reportedValue: '\$8M',
    notes: 'Palme d\'Or winner. Sean Baker film.',
  ),
  ContentDeal(
    platform: 'Neon',
    title: 'Longlegs',
    year: 2024,
    dealType: 'Acquisition',
    reportedValue: '\$8M',
    notes: 'Horror breakout. \$100M+ theatrical.',
  ),
];

/// ═══════════════════════════════════════════════════════════════════════════
/// PLATFORM STRATEGY BY GENRE
/// ═══════════════════════════════════════════════════════════════════════════

const Map<String, List<String>> platformStrategyByGenre = {
  'Horror': [
    'Shudder - dedicated horror platform, accepts submissions',
    'Hulu - genre originals, Prey success model',
    'Netflix - high-concept horror with star potential',
    'Peacock - limited horror but genre-friendly',
  ],
  'Drama': [
    'Apple TV+ - prestige drama with A-list talent',
    'HBO/Max - HBO brand for prestige, Max for broader',
    'Netflix - global drama, limited series focus',
    'Amazon - MGM theatrical + streaming options',
  ],
  'Comedy': [
    'Hulu - FX comedies, The Bear model',
    'Netflix - broad appeal, star-driven',
    'Peacock - NBC legacy comedy',
    'Apple TV+ - prestige comedy (Ted Lasso model)',
  ],
  'Action/Thriller': [
    'Netflix - high-concept action packages',
    'Amazon - franchise potential, MGM action',
    'Paramount+ - Taylor Sheridan style',
    'Apple TV+ - prestige thriller',
  ],
  'Sci-Fi/Fantasy': [
    'Amazon - tentpole fantasy (Rings of Power)',
    'Netflix - genre diversity',
    'Disney+ - Marvel/Star Wars',
    'Apple TV+ - prestige sci-fi (Foundation, Silo)',
  ],
  'Documentary': [
    'Netflix - true crime, music docs',
    'HBO/Max - prestige documentary',
    'Hulu - FX documentary brand',
    'Disney+/Nat Geo - nature, science',
  ],
  'International/Art House': [
    'MUBI - art house curation',
    'Netflix - global content initiative',
    'Amazon - international acquisitions',
    'Apple TV+ - international prestige',
  ],
};

/// Helper function to get platforms by content spend
List<StreamingPlatform> get platformsByContentSpend {
  final sorted = List<StreamingPlatform>.from(streamingPlatformsDatabase)
    ..sort((a, b) => b.annualContentSpendBillions.compareTo(a.annualContentSpendBillions));
  return sorted;
}

/// Helper function to get platforms by subscriber count
List<StreamingPlatform> get platformsBySubscribers {
  final sorted = List<StreamingPlatform>.from(streamingPlatformsDatabase)
    ..sort((a, b) => b.subscribersMillions.compareTo(a.subscribersMillions));
  return sorted;
}

/// Helper function to get platforms that accept submissions
List<StreamingPlatform> get platformsAcceptingSubmissions {
  return streamingPlatformsDatabase.where((p) => p.acceptsSubmissions).toList();
}
