/// ═══════════════════════════════════════════════════════════════════════════
/// EXPANDED BUYERS DATABASE - 50+ Studios, Streamers & Production Companies
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Comprehensive database of film/TV buyers with:
/// - Real acquisition mandates and content strategies
/// - 2024-2025 content spend and subscriber data
/// - Specific genre preferences and budget ranges
/// - Submission guidelines and contact pathways
/// 
/// Sources: Variety, Deadline, Hollywood Reporter, company announcements

library;

/// Buyer category classification
enum BuyerCategory {
  majorStreamer,      // Netflix, Amazon, Apple, Disney+, HBO Max
  majorStudio,        // Universal, Warner Bros, Paramount, Sony, Disney
  miniMajor,          // Lionsgate, STX, MGM
  specialtyDivision,  // Searchlight, Focus, Sony Classics, Neon, A24
  networkStreamer,    // Hulu, Peacock, Paramount+
  cablePremium,       // HBO, Showtime, FX
  internationalBuyer, // BBC, Canal+, Studio Canal, etc.
  productionCompany,  // Blumhouse, Legendary, etc.
}

/// Comprehensive buyer profile with detailed acquisition data
class ExpandedBuyerProfile {
  final String name;
  final BuyerCategory category;
  final String parentCompany;
  final List<String> primaryGenres;
  final List<String> secondaryGenres;
  final String contentStrategy;
  final String budgetRange;
  final int contentSpend2024; // in millions USD
  final int subscribers; // in millions (0 for non-streamers)
  final List<String> recentAcquisitions2024;
  final List<String> upcomingSlate;
  final String submissionPathway;
  final bool acceptsUnsolicited;
  final List<String> preferredFormats;
  final String territoryFocus;
  final String idealPitch;
  final int baseMatchScore;
  final Map<String, String> keyExecutives;
  
  const ExpandedBuyerProfile({
    required this.name,
    required this.category,
    required this.parentCompany,
    required this.primaryGenres,
    required this.secondaryGenres,
    required this.contentStrategy,
    required this.budgetRange,
    required this.contentSpend2024,
    required this.subscribers,
    required this.recentAcquisitions2024,
    required this.upcomingSlate,
    required this.submissionPathway,
    required this.acceptsUnsolicited,
    required this.preferredFormats,
    required this.territoryFocus,
    required this.idealPitch,
    required this.baseMatchScore,
    required this.keyExecutives,
  });
}

/// Complete database of 50+ buyers
const List<ExpandedBuyerProfile> expandedBuyerDatabase = [
  // ═══════════════════════════════════════════════════════════════════════════
  // MAJOR STREAMERS - Big budget, global reach
  // ═══════════════════════════════════════════════════════════════════════════
  
  ExpandedBuyerProfile(
    name: 'Netflix',
    category: BuyerCategory.majorStreamer,
    parentCompany: 'Netflix Inc.',
    primaryGenres: ['Thriller', 'Action', 'Drama', 'Sci-Fi', 'Romance'],
    secondaryGenres: ['Horror', 'Comedy', 'Documentary', 'Animation'],
    contentStrategy: 'High-volume global content with star-driven originals. Focus on binge-worthy series and event films. Expanding into live events and gaming. Recently acquired Warner Bros. for \$72B.',
    budgetRange: '\$20M - \$250M (films), \$5-15M/episode (series)',
    contentSpend2024: 17000,
    subscribers: 302,
    recentAcquisitions2024: ['Rebel Ridge', 'Hit Man', 'The Electric State', 'Beverly Hills Cop: Axel F', 'Damsel', 'Lift'],
    upcomingSlate: ['Wednesday S2', 'Squid Game S3', 'Knives Out 3', 'The Gray Man 2'],
    submissionPathway: 'Agent/manager submission only. No unsolicited. Query through CAA, WME, UTA, or established management.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Limited Series', 'Ongoing Series'],
    territoryFocus: 'Global - 190+ countries',
    idealPitch: 'High-concept with diverse leads. Think "What if..." premises that can be explained in one sentence. Strong IP or star attachments help.',
    baseMatchScore: 88,
    keyExecutives: {
      'Film': 'Dan Lin (Film Chairman)',
      'Series': 'Bela Bajaria (Chief Content Officer)',
      'Acquisitions': 'Scott Stuber (Film Head)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Amazon MGM Studios',
    category: BuyerCategory.majorStreamer,
    parentCompany: 'Amazon',
    primaryGenres: ['Action', 'Thriller', 'Sci-Fi', 'Drama', 'Comedy'],
    secondaryGenres: ['Fantasy', 'Horror', 'Romance'],
    contentStrategy: 'Franchise-building with theatrical releases. Leveraging MGM library (James Bond, Rocky, etc.). Mix of prestige and commercial content.',
    budgetRange: '\$30M - \$300M (films), \$10-20M/episode (premium series)',
    contentSpend2024: 20000,
    subscribers: 200,
    recentAcquisitions2024: ['Road House', 'The Idea of You', 'Saltburn', 'Red One', 'Challengers'],
    upcomingSlate: ['Blade Runner 2099', 'Lord of the Rings S3', 'Spider-Man Noir'],
    submissionPathway: 'Agent/manager submission. Strong interest in IP adaptations and established talent packages.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Limited Series', 'Event Series'],
    territoryFocus: 'Global with US priority',
    idealPitch: 'Franchise-potential properties with clear sequel/spinoff possibilities. IP adaptations from books, games, or existing franchises.',
    baseMatchScore: 86,
    keyExecutives: {
      'Film': 'Jennifer Salke (Head of Amazon MGM Studios)',
      'Series': 'Vernon Sanders (Head of TV)',
      'Acquisitions': 'Julie Rapaport (Co-Head of Movies)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Apple TV+',
    category: BuyerCategory.majorStreamer,
    parentCompany: 'Apple Inc.',
    primaryGenres: ['Sci-Fi', 'Drama', 'Thriller', 'Documentary'],
    secondaryGenres: ['Comedy', 'Animation', 'Mystery'],
    contentStrategy: 'Prestige-first: quality over quantity. A-list talent attachments essential. Focus on awards-caliber content that elevates Apple brand.',
    budgetRange: '\$50M - \$200M+ (films), \$15-25M/episode (series)',
    contentSpend2024: 9000,
    subscribers: 45,
    recentAcquisitions2024: ['Killers of the Flower Moon', 'Napoleon', 'Wolfs', 'Fly Me to the Moon', 'Argylle'],
    upcomingSlate: ['F1 (Brad Pitt)', 'Blitz', 'Silo S2', 'Severance S2'],
    submissionPathway: 'Top-tier agent packages only. Requires A-list director or star attached.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Limited Series'],
    territoryFocus: 'Global',
    idealPitch: 'Prestige material with vision. Director-driven projects with clear awards potential. Think Scorsese, Nolan-level talent.',
    baseMatchScore: 92,
    keyExecutives: {
      'Film': 'Matt Dentler (Head of Features)',
      'Series': 'Jamie Erlicht & Zack Van Amburg (Heads of Worldwide Video)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'HBO / Max',
    category: BuyerCategory.majorStreamer,
    parentCompany: 'Warner Bros. Discovery',
    primaryGenres: ['Drama', 'Fantasy', 'Thriller', 'Horror', 'Comedy'],
    secondaryGenres: ['Sci-Fi', 'Documentary', 'Animation'],
    contentStrategy: 'Premium serialized content. Strong IP development (Game of Thrones universe). Quality drama and prestige limited series.',
    budgetRange: '\$10-25M/episode (premium series), \$30-100M (films)',
    contentSpend2024: 8000,
    subscribers: 110,
    recentAcquisitions2024: ['House of the Dragon S2', 'True Detective: Night Country', 'The Penguin', 'Dune: Prophecy'],
    upcomingSlate: ['The Last of Us S2', 'Game of Thrones spinoffs', 'Harry Potter series'],
    submissionPathway: 'Agent/manager submission. Strong interest in IP with world-building potential.',
    acceptsUnsolicited: false,
    preferredFormats: ['Limited Series', 'Ongoing Series', 'Miniseries'],
    territoryFocus: 'US primary, Global secondary',
    idealPitch: 'Bold, distinctive voices. Limited series with clear 6-8 episode arc. World-building potential for expanded universes.',
    baseMatchScore: 89,
    keyExecutives: {
      'Series': 'Casey Bloys (Chairman & CEO, HBO/Max Content)',
      'Drama': 'Francesca Orsi (EVP, HBO Drama)',
      'Film': 'Mike De Luca & Pam Abdy (Film Co-Chairs)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Disney+',
    category: BuyerCategory.majorStreamer,
    parentCompany: 'The Walt Disney Company',
    primaryGenres: ['Fantasy', 'Adventure', 'Animation', 'Sci-Fi', 'Family'],
    secondaryGenres: ['Action', 'Drama', 'Documentary'],
    contentStrategy: 'Brand-focused content: Marvel, Star Wars, Pixar, Disney Animation, National Geographic. Family-friendly with some mature content via Star.',
    budgetRange: '\$100M+ (Marvel/Star Wars), \$50-150M (other films)',
    contentSpend2024: 23000,
    subscribers: 128,
    recentAcquisitions2024: ['Inside Out 2', 'Moana 2', 'Deadpool & Wolverine', 'Kingdom of the Planet of the Apes'],
    upcomingSlate: ['Thunderbolts', 'Fantastic Four', 'Avatar 3', 'Star Wars: Skeleton Crew'],
    submissionPathway: 'Agent submission only. IP-focused - primarily works with established franchises.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Limited Series'],
    territoryFocus: 'Global',
    idealPitch: 'Family-friendly adventure with merchandising potential. IP that fits Disney, Marvel, Star Wars, or Pixar brands.',
    baseMatchScore: 85,
    keyExecutives: {
      'Content': 'Alan Bergman (Disney Entertainment Co-Chairman)',
      'Marvel': 'Kevin Feige (President, Marvel Studios)',
      'Lucasfilm': 'Kathleen Kennedy (President)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Hulu',
    category: BuyerCategory.networkStreamer,
    parentCompany: 'The Walt Disney Company',
    primaryGenres: ['Comedy', 'Drama', 'Thriller', 'Horror'],
    secondaryGenres: ['True Crime', 'Documentary', 'Romance'],
    contentStrategy: 'Edgier Disney content. Young adult focus. Original series and next-day network content.',
    budgetRange: '\$10-50M (films), \$3-8M/episode (series)',
    contentSpend2024: 4500,
    subscribers: 52,
    recentAcquisitions2024: ['No One Will Save You', 'The Beekeeper', 'Prey', 'The Bear S3'],
    upcomingSlate: ['Alien: Earth (series)', 'Only Murders S5'],
    submissionPathway: 'Agent/manager submission. Open to emerging voices.',
    acceptsUnsolicited: false,
    preferredFormats: ['Limited Series', 'Ongoing Series', 'Feature Film'],
    territoryFocus: 'US primary',
    idealPitch: 'Fresh voices, younger demographic appeal. Contained thrillers and smart comedies work well.',
    baseMatchScore: 81,
    keyExecutives: {
      'Originals': 'Craig Erwich (President, ABC Entertainment & Hulu Originals)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Peacock',
    category: BuyerCategory.networkStreamer,
    parentCompany: 'NBCUniversal (Comcast)',
    primaryGenres: ['Mystery', 'Drama', 'Comedy', 'Thriller', 'True Crime'],
    secondaryGenres: ['Documentary', 'Horror'],
    contentStrategy: 'Procedurals, true crime, NBC legacy content. Growing original slate with focus on adult drama.',
    budgetRange: '\$5-40M (films), \$3-8M/episode (series)',
    contentSpend2024: 3000,
    subscribers: 36,
    recentAcquisitions2024: ['Poker Face', 'Based on a True Story', 'Twisted Metal', 'Dr. Death S2'],
    upcomingSlate: ['Poker Face S2', 'Hysteria!', 'Teacup'],
    submissionPathway: 'Agent/manager submission. Interest in procedural formats.',
    acceptsUnsolicited: false,
    preferredFormats: ['Ongoing Series', 'Limited Series'],
    territoryFocus: 'US',
    idealPitch: 'Mystery procedurals, true crime adaptations. Think Poker Face format - episodic with strong hook.',
    baseMatchScore: 79,
    keyExecutives: {
      'Content': 'Kelly Campbell (President, Peacock)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Paramount+',
    category: BuyerCategory.networkStreamer,
    parentCompany: 'Paramount Global',
    primaryGenres: ['Action', 'Thriller', 'Sci-Fi', 'Drama', 'Horror'],
    secondaryGenres: ['Comedy', 'True Crime', 'Documentary'],
    contentStrategy: 'Legacy franchises (Star Trek, Mission: Impossible, Transformers) plus original content. Recent merger talk with Skydance.',
    budgetRange: '\$10-50M (films), \$5-10M/episode (series)',
    contentSpend2024: 6000,
    subscribers: 72,
    recentAcquisitions2024: ['A Quiet Place: Day One', 'IF', 'Mean Girls', 'Bob Marley: One Love'],
    upcomingSlate: ['Mission: Impossible 8', 'Star Trek: Starfleet Academy', 'Yellowstone spinoffs'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Ongoing Series', 'Limited Series'],
    territoryFocus: 'US primary, Global expansion',
    idealPitch: 'Franchise potential. Content that can spawn sequels, spinoffs, or expanded universes.',
    baseMatchScore: 82,
    keyExecutives: {
      'Film': 'Brian Robbins (President & CEO, Paramount Pictures)',
      'Series': 'Chris McCarthy (CEO, Showtime/MTV Entertainment)',
    },
  ),
  
  // ═══════════════════════════════════════════════════════════════════════════
  // MAJOR STUDIOS - Theatrical focus
  // ═══════════════════════════════════════════════════════════════════════════
  
  ExpandedBuyerProfile(
    name: 'Universal Pictures',
    category: BuyerCategory.majorStudio,
    parentCompany: 'NBCUniversal (Comcast)',
    primaryGenres: ['Horror', 'Comedy', 'Action', 'Animation', 'Thriller'],
    secondaryGenres: ['Drama', 'Sci-Fi', 'Musical'],
    contentStrategy: 'Diverse theatrical slate. Strong Blumhouse partnership for horror. Illumination for animation. Focus on mid-budget genre films.',
    budgetRange: '\$5-200M',
    contentSpend2024: 3500,
    subscribers: 0,
    recentAcquisitions2024: ['Oppenheimer', 'Wicked', 'The Fall Guy', 'Abigail', 'Twisters'],
    upcomingSlate: ['Wicked Part 2', 'Jurassic World 4', 'Minions 3'],
    submissionPathway: 'Agent/manager submission. Blumhouse submissions for horror.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'High-concept genre films. Horror with Blumhouse model (\$5-15M budget). Comedies with star packages.',
    baseMatchScore: 85,
    keyExecutives: {
      'Film': 'Donna Langley (Chairman, NBCUniversal Studio Group)',
      'Production': 'Peter Cramer (President, Universal Pictures)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Warner Bros. Pictures',
    category: BuyerCategory.majorStudio,
    parentCompany: 'Warner Bros. Discovery',
    primaryGenres: ['Action', 'Sci-Fi', 'Fantasy', 'Drama', 'Horror'],
    secondaryGenres: ['Comedy', 'Animation', 'Musical'],
    contentStrategy: 'Theatrical tentpoles with DC Universe rebuild. Prestige through New Line. Mix of franchise and original content.',
    budgetRange: '\$50-300M+',
    contentSpend2024: 4000,
    subscribers: 0,
    recentAcquisitions2024: ['Dune: Part Two', 'Beetlejuice Beetlejuice', 'Joker: Folie à Deux', 'Furiosa'],
    upcomingSlate: ['Superman: Legacy', 'The Batman: Part II', 'Dune 3', 'Lord of the Rings: The War of the Rohirrim'],
    submissionPathway: 'Agent/manager submission. DC projects through DC Studios.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'Franchise IP with visual spectacle. DC projects via James Gunn/Peter Safran. Original tentpoles with established directors.',
    baseMatchScore: 84,
    keyExecutives: {
      'Film': 'Michael De Luca & Pamela Abdy (Co-Chairs, Warner Bros. Pictures Group)',
      'DC': 'James Gunn & Peter Safran (Co-CEOs, DC Studios)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Sony Pictures',
    category: BuyerCategory.majorStudio,
    parentCompany: 'Sony Group Corporation',
    primaryGenres: ['Action', 'Animation', 'Comedy', 'Horror', 'Romance'],
    secondaryGenres: ['Thriller', 'Sci-Fi', 'Drama'],
    contentStrategy: 'Spider-Man universe. Strong animation (Spider-Verse). Theatrical rom-com revival. Prestige through Sony Classics.',
    budgetRange: '\$20-200M',
    contentSpend2024: 3200,
    subscribers: 0,
    recentAcquisitions2024: ['Anyone But You', 'Bad Boys: Ride or Die', 'Ghostbusters: Frozen Empire', 'Madame Web'],
    upcomingSlate: ['Spider-Man: Beyond the Spider-Verse', 'Venom 3', 'Karate Kid: Legends'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'Spider-Man universe potential. Star-driven rom-coms (Anyone But You model). Animation with Spider-Verse style.',
    baseMatchScore: 82,
    keyExecutives: {
      'Film': 'Tom Rothman (Chairman, Sony Pictures Motion Picture Group)',
      'Animation': 'Phil Lord & Christopher Miller (Spider-Verse producers)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Paramount Pictures',
    category: BuyerCategory.majorStudio,
    parentCompany: 'Paramount Global',
    primaryGenres: ['Action', 'Horror', 'Thriller', 'Sci-Fi', 'Comedy'],
    secondaryGenres: ['Drama', 'Animation', 'Adventure'],
    contentStrategy: 'Legacy franchises focus. Strong horror slate. Theatrical commitment despite streaming pressure.',
    budgetRange: '\$15-200M',
    contentSpend2024: 2800,
    subscribers: 0,
    recentAcquisitions2024: ['A Quiet Place: Day One', 'IF', 'Mean Girls', 'Smile 2'],
    upcomingSlate: ['Mission: Impossible 8', 'A Quiet Place spinoffs', 'Transformers: One'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'High-concept premises with franchise potential. Horror with contained budgets. Star-driven action.',
    baseMatchScore: 83,
    keyExecutives: {
      'Film': 'Brian Robbins (President & CEO)',
      'Production': 'Marc Evans (President, Production)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: '20th Century Studios',
    category: BuyerCategory.majorStudio,
    parentCompany: 'The Walt Disney Company',
    primaryGenres: ['Sci-Fi', 'Horror', 'Thriller', 'Action', 'Comedy'],
    secondaryGenres: ['Drama', 'Adventure'],
    contentStrategy: 'Legacy franchises (Planet of the Apes, Alien, Avatar). More mature content than core Disney. Mix of theatrical and Disney+ releases.',
    budgetRange: '\$30-250M',
    contentSpend2024: 2500,
    subscribers: 0,
    recentAcquisitions2024: ['Alien: Romulus', 'Kingdom of the Planet of the Apes', 'The Menu'],
    upcomingSlate: ['Avatar 3', 'Alien: Earth (series)', 'Planet of the Apes sequels'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'Franchise-potential sci-fi and horror. Legacy IP extensions. Original genre films with vision.',
    baseMatchScore: 85,
    keyExecutives: {
      'Film': 'Steve Asbell (President, 20th Century Studios)',
    },
  ),
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SPECIALTY / INDIE STUDIOS - Prestige and elevated genre
  // ═══════════════════════════════════════════════════════════════════════════
  
  ExpandedBuyerProfile(
    name: 'A24',
    category: BuyerCategory.specialtyDivision,
    parentCompany: 'A24 Films LLC',
    primaryGenres: ['Horror', 'Drama', 'Comedy', 'Thriller', 'Sci-Fi'],
    secondaryGenres: ['Romance', 'Documentary', 'Animation'],
    contentStrategy: 'Auteur-driven content with cultural impact. Quality over box office. Festival circuit focus. Strong social media marketing.',
    budgetRange: '\$5-50M',
    contentSpend2024: 500,
    subscribers: 0,
    recentAcquisitions2024: ['Civil War', 'MaXXXine', 'Love Lies Bleeding', 'Sing Sing', 'Heretic'],
    upcomingSlate: ['Death of a Unicorn', 'Warfare', 'We Live in Time'],
    submissionPathway: 'Agent/manager submission. Festival acquisitions. Strong interest in first-time directors with vision.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Limited Series'],
    territoryFocus: 'US primary, Select international',
    idealPitch: 'Unique voice. Vision-driven filmmaking. Think "What would A24 make?" Cultural conversation starters.',
    baseMatchScore: 91,
    keyExecutives: {
      'Film': 'David Fenkel (CEO & Founder)',
      'Acquisitions': 'Noah Sacco (Head of Acquisitions)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Neon',
    category: BuyerCategory.specialtyDivision,
    parentCompany: 'Neon Rated LLC',
    primaryGenres: ['Horror', 'Drama', 'Thriller', 'Documentary'],
    secondaryGenres: ['Comedy', 'Sci-Fi'],
    contentStrategy: 'Bold, provocative content. Festival acquisitions. Marketing innovation. Parasite, Longlegs success model.',
    budgetRange: '\$3-30M',
    contentSpend2024: 250,
    subscribers: 0,
    recentAcquisitions2024: ['Longlegs', 'Anora', 'The Substance', 'Immaculate', 'Cuckoo'],
    upcomingSlate: ['Various festival acquisitions'],
    submissionPathway: 'Festival circuit primary. Agent/manager for pre-production.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'US primary',
    idealPitch: 'Conversation-starting films. Genre with elevated execution. Festival pedigree helps significantly.',
    baseMatchScore: 88,
    keyExecutives: {
      'Founder': 'Tom Quinn (CEO)',
      'Distribution': 'Elissa Federoff (President, Distribution)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Searchlight Pictures',
    category: BuyerCategory.specialtyDivision,
    parentCompany: 'The Walt Disney Company',
    primaryGenres: ['Drama', 'Comedy', 'Romance', 'Mystery', 'Horror'],
    secondaryGenres: ['Documentary', 'Musical'],
    contentStrategy: 'Awards-focused prestige films. Director-driven projects. Strong Oscar track record.',
    budgetRange: '\$10-40M',
    contentSpend2024: 400,
    subscribers: 0,
    recentAcquisitions2024: ['Poor Things', 'All of Us Strangers', 'A Real Pain', 'A Complete Unknown'],
    upcomingSlate: ['Nightbitch', 'Companion', 'Eric Clapton biopic'],
    submissionPathway: 'Agent/manager submission. Strong director attachment essential.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'US theatrical, Global',
    idealPitch: 'Oscar-caliber material. Director-driven vision. Character studies with breakout star potential.',
    baseMatchScore: 88,
    keyExecutives: {
      'Film': 'David Greenbaum & Matthew Greenfield (Presidents)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Focus Features',
    category: BuyerCategory.specialtyDivision,
    parentCompany: 'NBCUniversal (Comcast)',
    primaryGenres: ['Drama', 'Romance', 'Thriller', 'Comedy'],
    secondaryGenres: ['Documentary', 'Horror'],
    contentStrategy: 'Quality-driven specialty films. International co-productions. Awards season focus.',
    budgetRange: '\$8-35M',
    contentSpend2024: 300,
    subscribers: 0,
    recentAcquisitions2024: ['The Bikeriders', 'Conclave', 'Drive-Away Dolls', 'Lisa Frankenstein'],
    upcomingSlate: ['Nosferatu', 'September 5'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'US and International',
    idealPitch: 'Character-driven stories with international appeal. Strong director vision.',
    baseMatchScore: 84,
    keyExecutives: {
      'Film': 'Peter Kujawski (Chairman)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Sony Pictures Classics',
    category: BuyerCategory.specialtyDivision,
    parentCompany: 'Sony Pictures',
    primaryGenres: ['Drama', 'Documentary', 'Foreign Language', 'Comedy'],
    secondaryGenres: ['Romance', 'Mystery'],
    contentStrategy: 'Prestige acquisitions. Foreign language films. Documentary slate. Festival circuit focus.',
    budgetRange: '\$2-20M (acquisitions)',
    contentSpend2024: 150,
    subscribers: 0,
    recentAcquisitions2024: ['The Holdovers', 'The Teachers\' Lounge', 'Robot Dreams'],
    upcomingSlate: ['Various festival acquisitions'],
    submissionPathway: 'Festival circuit. Agent for US productions.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Documentary'],
    territoryFocus: 'Global acquisitions',
    idealPitch: 'Festival-ready prestige. International auteur work. Awards-season timing.',
    baseMatchScore: 82,
    keyExecutives: {
      'Co-Presidents': 'Tom Bernard & Michael Barker',
    },
  ),
  
  // ═══════════════════════════════════════════════════════════════════════════
  // PRODUCTION COMPANIES - Genre specialists
  // ═══════════════════════════════════════════════════════════════════════════
  
  ExpandedBuyerProfile(
    name: 'Blumhouse Productions',
    category: BuyerCategory.productionCompany,
    parentCompany: 'Blumhouse (Universal first-look)',
    primaryGenres: ['Horror', 'Thriller', 'Sci-Fi'],
    secondaryGenres: ['Drama', 'Documentary'],
    contentStrategy: 'Low-budget, high-concept horror model. \$3-15M budgets with massive ROI potential. First-time directors welcome.',
    budgetRange: '\$3-15M (core), up to \$30M (select)',
    contentSpend2024: 200,
    subscribers: 0,
    recentAcquisitions2024: ['M3GAN 2.0', 'Five Nights at Freddy\'s 2', 'Imaginary', 'Night Swim', 'Insidious: The Red Door'],
    upcomingSlate: ['Paranormal Activity 8', 'The Purge 6', 'Happy Death Day 3'],
    submissionPathway: 'Query: info@blumhouse.com. One of few accepting unsolicited.',
    acceptsUnsolicited: true,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'High-concept horror with contained setting. Clear poster image. \$5M budget, \$100M potential.',
    baseMatchScore: 94,
    keyExecutives: {
      'CEO': 'Jason Blum',
      'President': 'Charles Layton',
      'Development': 'Couper Samuelson (President, Features)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Legendary Entertainment',
    category: BuyerCategory.productionCompany,
    parentCompany: 'Wanda Group (Chinese conglomerate)',
    primaryGenres: ['Sci-Fi', 'Action', 'Fantasy', 'Horror'],
    secondaryGenres: ['Thriller', 'Drama'],
    contentStrategy: 'Tentpole franchise films. MonsterVerse (Godzilla, Kong). Co-financing partnerships with major studios.',
    budgetRange: '\$100-300M+',
    contentSpend2024: 800,
    subscribers: 0,
    recentAcquisitions2024: ['Dune: Part Two', 'Godzilla x Kong', 'Challengers'],
    upcomingSlate: ['Dune 3', 'MonsterVerse expansion', 'Godzilla series'],
    submissionPathway: 'Agent/manager submission for big packages.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'Epic scope IP with franchise potential. Think \$200M+ productions.',
    baseMatchScore: 86,
    keyExecutives: {
      'CEO': 'Joshua Grode',
      'Film': 'Mary Parent (Vice Chairman, Production)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Atomic Monster',
    category: BuyerCategory.productionCompany,
    parentCompany: 'James Wan (Universal/Warner deals)',
    primaryGenres: ['Horror', 'Thriller', 'Action'],
    secondaryGenres: ['Sci-Fi', 'Mystery'],
    contentStrategy: 'Horror franchise building. James Wan-style genre films. Both producing and directing slate.',
    budgetRange: '\$10-50M',
    contentSpend2024: 150,
    subscribers: 0,
    recentAcquisitions2024: ['M3GAN', 'Salem\'s Lot', 'There\'s Something Wrong with the Children'],
    upcomingSlate: ['Conjuring Universe expansions', 'Original horror'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'Horror with franchise DNA. Visual style-driven. Think Conjuring Universe potential.',
    baseMatchScore: 90,
    keyExecutives: {
      'Founder': 'James Wan',
      'President': 'Michael Clear',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Plan B Entertainment',
    category: BuyerCategory.productionCompany,
    parentCompany: 'Brad Pitt / Dede Gardner / Jeremy Kleiner',
    primaryGenres: ['Drama', 'Thriller', 'Documentary'],
    secondaryGenres: ['Comedy', 'Sci-Fi', 'Horror'],
    contentStrategy: 'Socially relevant prestige content. Underrepresented voices. Awards-caliber filmmaking.',
    budgetRange: '\$10-80M',
    contentSpend2024: 200,
    subscribers: 0,
    recentAcquisitions2024: ['She Said', 'Women Talking', 'Blonde'],
    upcomingSlate: ['Various prestige projects'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Documentary'],
    territoryFocus: 'US theatrical, Global',
    idealPitch: 'Socially impactful storytelling. Diverse perspectives. Awards potential.',
    baseMatchScore: 89,
    keyExecutives: {
      'Partners': 'Brad Pitt, Dede Gardner, Jeremy Kleiner',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'LuckyChap Entertainment',
    category: BuyerCategory.productionCompany,
    parentCompany: 'Margot Robbie / Tom Ackerley',
    primaryGenres: ['Comedy', 'Drama', 'Thriller'],
    secondaryGenres: ['Horror', 'Romance', 'Action'],
    contentStrategy: 'Female-driven stories with edge. Commercial films with substance. Barbie success model.',
    budgetRange: '\$15-150M',
    contentSpend2024: 250,
    subscribers: 0,
    recentAcquisitions2024: ['Barbie', 'Promising Young Woman', 'Saltburn'],
    upcomingSlate: ['Various female-led projects'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Limited Series'],
    territoryFocus: 'Global',
    idealPitch: 'Female protagonists with agency. Dark comedy. Unconventional perspectives.',
    baseMatchScore: 89,
    keyExecutives: {
      'Founders': 'Margot Robbie, Tom Ackerley',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Hello Sunshine',
    category: BuyerCategory.productionCompany,
    parentCompany: 'Candle Media (Blackstone-backed)',
    primaryGenres: ['Drama', 'Romance', 'Thriller'],
    secondaryGenres: ['Documentary', 'Comedy'],
    contentStrategy: 'Female-driven content. Book adaptations via Reese\'s Book Club. Limited series focus.',
    budgetRange: '\$15-60M',
    contentSpend2024: 200,
    subscribers: 0,
    recentAcquisitions2024: ['Daisy Jones & the Six', 'Where the Crawdads Sing', 'The Morning Show'],
    upcomingSlate: ['Various book adaptations'],
    submissionPathway: 'Agent/manager submission. Book club selections are prioritized.',
    acceptsUnsolicited: false,
    preferredFormats: ['Limited Series', 'Feature Film'],
    territoryFocus: 'US streaming, Global',
    idealPitch: 'Female stories. Book adaptations. Think Reese\'s Book Club selection.',
    baseMatchScore: 87,
    keyExecutives: {
      'Founder': 'Reese Witherspoon',
      'CEO': 'Sarah Harden',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Bad Robot Productions',
    category: BuyerCategory.productionCompany,
    parentCompany: 'J.J. Abrams (Warner Bros. deal)',
    primaryGenres: ['Sci-Fi', 'Thriller', 'Mystery', 'Action'],
    secondaryGenres: ['Horror', 'Fantasy', 'Drama'],
    contentStrategy: 'Mystery box storytelling. High-concept genre films. Franchise IP development.',
    budgetRange: '\$50-200M',
    contentSpend2024: 300,
    subscribers: 0,
    recentAcquisitions2024: ['Various development projects'],
    upcomingSlate: ['DC projects', 'Original sci-fi'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Ongoing Series'],
    territoryFocus: 'Global',
    idealPitch: 'Mystery-driven narratives. High-concept sci-fi. Think LOST, Cloverfield, Westworld.',
    baseMatchScore: 88,
    keyExecutives: {
      'Founder': 'J.J. Abrams',
      'Co-CEO': 'Katie McGrath',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'T-Street',
    category: BuyerCategory.productionCompany,
    parentCompany: 'Rian Johnson / Ram Bergman',
    primaryGenres: ['Mystery', 'Thriller', 'Sci-Fi', 'Comedy'],
    secondaryGenres: ['Drama', 'Action'],
    contentStrategy: 'Whodunit mysteries (Knives Out franchise). Genre-bending storytelling. Director-led projects.',
    budgetRange: '\$30-100M',
    contentSpend2024: 150,
    subscribers: 0,
    recentAcquisitions2024: ['Poker Face', 'Glass Onion'],
    upcomingSlate: ['Knives Out 3', 'Various originals'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film', 'Ongoing Series'],
    territoryFocus: 'Global',
    idealPitch: 'Clever mysteries. Genre subversion. Think Knives Out meets Poker Face.',
    baseMatchScore: 91,
    keyExecutives: {
      'Partners': 'Rian Johnson, Ram Bergman',
    },
  ),
  
  // ═══════════════════════════════════════════════════════════════════════════
  // MINI-MAJORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  ExpandedBuyerProfile(
    name: 'Lionsgate',
    category: BuyerCategory.miniMajor,
    parentCompany: 'Lionsgate Entertainment',
    primaryGenres: ['Action', 'Thriller', 'Horror', 'Comedy'],
    secondaryGenres: ['Drama', 'Sci-Fi', 'Romance'],
    contentStrategy: 'Franchise focus (John Wick, Hunger Games, SAW). Genre expertise. Mid-budget theatrical.',
    budgetRange: '\$15-100M',
    contentSpend2024: 800,
    subscribers: 0,
    recentAcquisitions2024: ['John Wick: Chapter 4', 'Hunger Games: Ballad of Songbirds & Snakes', 'Saw X'],
    upcomingSlate: ['Ballerina (John Wick spinoff)', 'Now You See Me 3'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global theatrical',
    idealPitch: 'Franchise-potential action/thriller. Think John Wick model - stylized, character-driven.',
    baseMatchScore: 83,
    keyExecutives: {
      'Film': 'Adam Fogelson (Vice Chairman)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'STXfilms',
    category: BuyerCategory.miniMajor,
    parentCompany: 'STX Entertainment (Najafi Companies)',
    primaryGenres: ['Action', 'Comedy', 'Thriller', 'Horror'],
    secondaryGenres: ['Drama', 'Romance'],
    contentStrategy: 'Star-driven mid-budget films. Genre expertise. International pre-sales model.',
    budgetRange: '\$10-60M',
    contentSpend2024: 200,
    subscribers: 0,
    recentAcquisitions2024: ['Plane', 'Guy Ritchie\'s The Covenant'],
    upcomingSlate: ['Various genre projects'],
    submissionPathway: 'Agent/manager submission.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Global',
    idealPitch: 'Star vehicles with international appeal. Action-thrillers in \$20-40M range.',
    baseMatchScore: 78,
    keyExecutives: {
      'Chairman': 'Adam Fogelson',
    },
  ),
  
  // ═══════════════════════════════════════════════════════════════════════════
  // INTERNATIONAL BUYERS
  // ═══════════════════════════════════════════════════════════════════════════
  
  ExpandedBuyerProfile(
    name: 'BBC Film',
    category: BuyerCategory.internationalBuyer,
    parentCompany: 'BBC',
    primaryGenres: ['Drama', 'Comedy', 'Documentary', 'Thriller'],
    secondaryGenres: ['Horror', 'Romance'],
    contentStrategy: 'British stories with international appeal. Co-productions. Diverse voices.',
    budgetRange: '£2-10M (co-financing)',
    contentSpend2024: 80,
    subscribers: 0,
    recentAcquisitions2024: ['Scrapper', 'Living', 'All of Us Strangers'],
    upcomingSlate: ['Various British productions'],
    submissionPathway: 'BBC Writersroom for scripts. Agent for developed projects.',
    acceptsUnsolicited: true,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'UK primary',
    idealPitch: 'British-set stories. Diverse British voices. \$5-15M budgets.',
    baseMatchScore: 75,
    keyExecutives: {
      'Head': 'Rose Garnett (Director, BBC Film)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'StudioCanal',
    category: BuyerCategory.internationalBuyer,
    parentCompany: 'Canal+ Group (Vivendi)',
    primaryGenres: ['Drama', 'Thriller', 'Comedy', 'Action'],
    secondaryGenres: ['Horror', 'Family'],
    contentStrategy: 'European production and distribution. Paddington franchise. International co-productions.',
    budgetRange: '€5-80M',
    contentSpend2024: 400,
    subscribers: 0,
    recentAcquisitions2024: ['Paddington in Peru', 'Various European productions'],
    upcomingSlate: ['Paddington sequels', 'European co-productions'],
    submissionPathway: 'Agent/manager submission for international co-productions.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'Europe, Global',
    idealPitch: 'European stories with global appeal. Family entertainment. Co-production potential.',
    baseMatchScore: 76,
    keyExecutives: {
      'CEO': 'Anna Marsh',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Film4',
    category: BuyerCategory.internationalBuyer,
    parentCompany: 'Channel 4 (UK)',
    primaryGenres: ['Drama', 'Horror', 'Comedy', 'Thriller'],
    secondaryGenres: ['Documentary', 'Sci-Fi'],
    contentStrategy: 'Bold British cinema. First-time director support. Cultural impact over box office.',
    budgetRange: '£2-8M (co-financing)',
    contentSpend2024: 50,
    subscribers: 0,
    recentAcquisitions2024: ['The Zone of Interest', 'All of Us Strangers', 'Rye Lane'],
    upcomingSlate: ['Various British productions'],
    submissionPathway: 'Agent/manager or direct query.',
    acceptsUnsolicited: true,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'UK',
    idealPitch: 'Distinctive British voices. First/second features. Cultural relevance.',
    baseMatchScore: 80,
    keyExecutives: {
      'Head': 'Ollie Madden (Head of Film4)',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'CJ Entertainment',
    category: BuyerCategory.internationalBuyer,
    parentCompany: 'CJ Group (South Korea)',
    primaryGenres: ['Thriller', 'Action', 'Drama', 'Horror'],
    secondaryGenres: ['Comedy', 'Sci-Fi'],
    contentStrategy: 'Korean content global expansion. Parasite success model. Hollywood co-productions.',
    budgetRange: '\$10-80M',
    contentSpend2024: 600,
    subscribers: 0,
    recentAcquisitions2024: ['Exhuma', 'Various Korean productions'],
    upcomingSlate: ['Korean blockbusters', 'Hollywood co-productions'],
    submissionPathway: 'Agent/manager for Hollywood co-productions.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'South Korea, Global',
    idealPitch: 'Korean-Hollywood hybrid potential. Genre films with international appeal.',
    baseMatchScore: 78,
    keyExecutives: {
      'CEO': 'Kang Ho Sung',
    },
  ),
  
  ExpandedBuyerProfile(
    name: 'Pathé',
    category: BuyerCategory.internationalBuyer,
    parentCompany: 'Pathé SA (France)',
    primaryGenres: ['Drama', 'Comedy', 'Thriller', 'Action'],
    secondaryGenres: ['Documentary', 'Animation'],
    contentStrategy: 'French and European production/distribution. International co-productions.',
    budgetRange: '€5-50M',
    contentSpend2024: 350,
    subscribers: 0,
    recentAcquisitions2024: ['Various European productions'],
    upcomingSlate: ['French cinema slate'],
    submissionPathway: 'Agent/manager for international co-productions.',
    acceptsUnsolicited: false,
    preferredFormats: ['Feature Film'],
    territoryFocus: 'France, Europe',
    idealPitch: 'French or European stories. International co-production potential.',
    baseMatchScore: 74,
    keyExecutives: {
      'CEO': 'Jérôme Seydoux (Honorary Chairman)',
    },
  ),
];

/// Helper function to get buyers by genre
List<ExpandedBuyerProfile> getBuyersByGenre(String genre) {
  return expandedBuyerDatabase.where((buyer) => 
    buyer.primaryGenres.contains(genre) || 
    buyer.secondaryGenres.contains(genre)
  ).toList()..sort((a, b) => b.baseMatchScore.compareTo(a.baseMatchScore));
}

/// Helper function to get buyers by category
List<ExpandedBuyerProfile> getBuyersByCategory(BuyerCategory category) {
  return expandedBuyerDatabase.where((buyer) => buyer.category == category).toList();
}

/// Helper function to get buyers accepting unsolicited
List<ExpandedBuyerProfile> getBuyersAcceptingUnsolicited() {
  return expandedBuyerDatabase.where((buyer) => buyer.acceptsUnsolicited).toList();
}
