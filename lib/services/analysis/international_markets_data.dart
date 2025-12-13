/// ═══════════════════════════════════════════════════════════════════════════
/// INTERNATIONAL MARKETS DATABASE - Global Box Office & Streaming Intelligence
/// Last Updated: July 2025 (Data from Comscore, The Numbers, Variety, Screen Daily)
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Sources:
/// - Comscore box office data
/// - The Numbers industry analytics
/// - PwC Global Entertainment & Media Outlook 2025
/// - Variety/Screen Daily international reports
/// - National cinema associations

library;

/// ═══════════════════════════════════════════════════════════════════════════
/// INTERNATIONAL MARKET DATA MODELS
/// ═══════════════════════════════════════════════════════════════════════════

class InternationalMarket {
  final String country;
  final String region;
  final double boxOffice2024Billions; // in USD
  final double growthRate2024; // year-over-year percentage
  final int screenCount;
  final double averageTicketPrice; // in USD
  final double streamingPenetration; // percentage of households
  final List<String> majorLocalStudios;
  final List<String> dominantStreamers;
  final String contentPreferences;
  final String localContentQuota;
  final String coProductionTreaties;
  final List<String> topGenres;
  final String marketOutlook;
  final String buyerTips;
  
  const InternationalMarket({
    required this.country,
    required this.region,
    required this.boxOffice2024Billions,
    required this.growthRate2024,
    required this.screenCount,
    required this.averageTicketPrice,
    required this.streamingPenetration,
    required this.majorLocalStudios,
    required this.dominantStreamers,
    required this.contentPreferences,
    required this.localContentQuota,
    required this.coProductionTreaties,
    required this.topGenres,
    required this.marketOutlook,
    required this.buyerTips,
  });
}

class CoProductionTreaty {
  final String country1;
  final String country2;
  final String treatyName;
  final int yearSigned;
  final List<String> benefits;
  final String applicationProcess;
  final List<String> successfulProductions;
  
  const CoProductionTreaty({
    required this.country1,
    required this.country2,
    required this.treatyName,
    required this.yearSigned,
    required this.benefits,
    required this.applicationProcess,
    required this.successfulProductions,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// MAJOR INTERNATIONAL MARKETS - 2024-2025 DATA
/// ═══════════════════════════════════════════════════════════════════════════

const List<InternationalMarket> internationalMarketsDatabase = [
  // NORTH AMERICA
  InternationalMarket(
    country: 'United States',
    region: 'North America',
    boxOffice2024Billions: 8.5,
    growthRate2024: 4.2,
    screenCount: 40000,
    averageTicketPrice: 11.75,
    streamingPenetration: 85,
    majorLocalStudios: ['Disney', 'Warner Bros', 'Universal', 'Paramount', 'Sony', 'Lionsgate'],
    dominantStreamers: ['Netflix', 'Disney+', 'Amazon Prime', 'HBO Max', 'Hulu', 'Peacock', 'Apple TV+'],
    contentPreferences: 'Franchise films, superhero content, horror, family animation. Strong theatrical culture for event films.',
    localContentQuota: 'None',
    coProductionTreaties: 'Treaties with UK, Canada, Australia, France, Germany, Italy, and others',
    topGenres: ['Action', 'Animation', 'Horror', 'Sci-Fi', 'Comedy'],
    marketOutlook: 'STABLE - Theatrical recovering post-pandemic. Streaming consolidation. Premium large format growth.',
    buyerTips: 'Package with recognizable talent. High-concept hooks essential. Four-quadrant appeal maximizes value.',
  ),
  InternationalMarket(
    country: 'Canada',
    region: 'North America',
    boxOffice2024Billions: 0.75,
    growthRate2024: 3.8,
    screenCount: 3400,
    averageTicketPrice: 12.50,
    streamingPenetration: 78,
    majorLocalStudios: ['Entertainment One', 'Lionsgate (partial)', 'Various regional producers'],
    dominantStreamers: ['Netflix', 'Disney+', 'Crave (Bell Media)', 'Amazon Prime'],
    contentPreferences: 'Hollywood imports dominate theatrical. Strong local documentary and arthouse scene.',
    localContentQuota: 'Canadian content requirements for broadcasters',
    coProductionTreaties: 'Extensive treaties with 50+ countries. Strong UK, France, Germany relationships.',
    topGenres: ['Action', 'Comedy', 'Documentary', 'Drama'],
    marketOutlook: 'STABLE - Strong production hub due to tax incentives. Hollywood shoots extensively in Canada.',
    buyerTips: 'Canadian co-productions offer tax benefits. Telefilm Canada funding available. English/French markets.',
  ),

  // EUROPE
  InternationalMarket(
    country: 'United Kingdom',
    region: 'Europe',
    boxOffice2024Billions: 1.35,
    growthRate2024: 2.1,
    screenCount: 4500,
    averageTicketPrice: 10.50,
    streamingPenetration: 82,
    majorLocalStudios: ['Working Title', 'Film4', 'BBC Film', 'Vertigo Films', 'Heyday Films'],
    dominantStreamers: ['Netflix', 'Amazon Prime', 'Disney+', 'Sky/Now TV', 'BBC iPlayer', 'ITVX'],
    contentPreferences: 'British comedy, period drama, James Bond franchise, prestige films. Strong arthouse appreciation.',
    localContentQuota: 'SVOD 30% European content rule',
    coProductionTreaties: 'EU treaties, US, Canada, Australia, New Zealand, India, China',
    topGenres: ['Drama', 'Comedy', 'Period', 'Action', 'Horror'],
    marketOutlook: 'BULLISH - Major production hub. Pinewood, Shepperton expansion. Tax incentives attractive.',
    buyerTips: 'British Film Institute (BFI) funding available. Strong theatrical and streaming buyers. BBC, Channel 4, Sky active.',
  ),
  InternationalMarket(
    country: 'France',
    region: 'Europe',
    boxOffice2024Billions: 1.15,
    growthRate2024: -2.3,
    screenCount: 6100,
    averageTicketPrice: 8.50,
    streamingPenetration: 72,
    majorLocalStudios: ['Gaumont', 'Pathé', 'StudioCanal', 'EuropaCorp', 'UGC'],
    dominantStreamers: ['Netflix', 'Disney+', 'Amazon Prime', 'Canal+', 'France.tv'],
    contentPreferences: 'Strong local film culture. French comedy dominant locally. Auteur cinema celebrated.',
    localContentQuota: 'Strict quotas - 40% French content on TV, streaming must invest in local production',
    coProductionTreaties: 'Extensive - Belgium, Germany, Italy, Spain, UK, US, Canada',
    topGenres: ['Comedy', 'Drama', 'Thriller', 'Romance', 'Animation'],
    marketOutlook: 'STABLE - Theatrical culture resilient. Streaming adapting to local content rules.',
    buyerTips: 'CNC (Centre national du cinéma) funding key. French language versions expected. Canal+ major buyer.',
  ),
  InternationalMarket(
    country: 'Germany',
    region: 'Europe',
    boxOffice2024Billions: 0.85,
    growthRate2024: 1.5,
    screenCount: 4800,
    averageTicketPrice: 11.00,
    streamingPenetration: 65,
    majorLocalStudios: ['Constantin Film', 'UFA', 'Studio Babelsberg', 'X Filme'],
    dominantStreamers: ['Netflix', 'Amazon Prime', 'Disney+', 'RTL+', 'Joyn', 'WOW (Sky)'],
    contentPreferences: 'Local comedy, thrillers, period pieces. Hollywood imports for theatrical.',
    localContentQuota: 'German regional film funds require local spend/content',
    coProductionTreaties: 'France, UK, Italy, Spain, US, Canada, China',
    topGenres: ['Comedy', 'Thriller', 'Drama', 'Action', 'Documentary'],
    marketOutlook: 'STABLE - Strong production incentives. Berlin as film hub. Netflix investing heavily in local.',
    buyerTips: 'Regional film funds (FFA, DFFF) offer significant incentives. German dubbing culture strong.',
  ),
  InternationalMarket(
    country: 'Italy',
    region: 'Europe',
    boxOffice2024Billions: 0.52,
    growthRate2024: -1.2,
    screenCount: 3800,
    averageTicketPrice: 8.00,
    streamingPenetration: 58,
    majorLocalStudios: ['Medusa', 'RAI Cinema', '01 Distribution', 'Cattleya'],
    dominantStreamers: ['Netflix', 'Amazon Prime', 'Disney+', 'Sky Italia', 'TimVision'],
    contentPreferences: 'Local comedies hugely popular. Crime dramas (Gomorra style). International arthouse.',
    localContentQuota: 'RAI has local content requirements. EU 30% rule applies.',
    coProductionTreaties: 'France, UK, Germany, Spain, US, Canada',
    topGenres: ['Comedy', 'Crime/Drama', 'Romance', 'Historical'],
    marketOutlook: 'STABLE - Strong local production. Venice Film Festival prestige. Tax incentives improved.',
    buyerTips: 'Medusa and RAI Cinema key theatrical buyers. Italian co-productions offer tax benefits.',
  ),
  InternationalMarket(
    country: 'Spain',
    region: 'Europe',
    boxOffice2024Billions: 0.58,
    growthRate2024: 3.2,
    screenCount: 3600,
    averageTicketPrice: 8.50,
    streamingPenetration: 68,
    majorLocalStudios: ['Atresmedia', 'Mediaset España', 'Telecinco Cinema', 'Filmax'],
    dominantStreamers: ['Netflix', 'Amazon Prime', 'Disney+', 'HBO Max', 'Movistar+'],
    contentPreferences: 'Spanish-language content strong. Horror (REC, Orphanage legacy). Crime thrillers.',
    localContentQuota: 'SVOD 30% European, portion must be Spanish-language',
    coProductionTreaties: 'Latin America (extensive), France, UK, US, Germany',
    topGenres: ['Horror', 'Thriller', 'Comedy', 'Drama'],
    marketOutlook: 'BULLISH - Netflix La Casa de Papel effect. Strong genre production. Spain as Latin gateway.',
    buyerTips: 'Spanish co-production opens Latin American markets. Sitges festival for genre.',
  ),

  // ASIA-PACIFIC
  InternationalMarket(
    country: 'China',
    region: 'Asia-Pacific',
    boxOffice2024Billions: 7.2,
    growthRate2024: -8.5,
    screenCount: 84000,
    averageTicketPrice: 5.50,
    streamingPenetration: 72,
    majorLocalStudios: ['China Film Group', 'Huayi Brothers', 'Bona Film', 'Wanda Film', 'Alibaba Pictures'],
    dominantStreamers: ['iQiyi', 'Tencent Video', 'Youku', 'Bilibili'],
    contentPreferences: 'Patriotic films, local comedies, action. Hollywood imports restricted to ~34/year.',
    localContentQuota: 'Foreign film quota: 34 revenue-sharing imports/year. Heavy censorship.',
    coProductionTreaties: 'Official co-productions can bypass quota - strict requirements',
    topGenres: ['Action', 'Comedy', 'Drama', 'Fantasy', 'Animation'],
    marketOutlook: 'CHALLENGING - Quota restrictions, censorship issues, geopolitical tensions limiting Hollywood access.',
    buyerTips: 'Co-production very difficult. Requires Chinese elements, censorship compliance. Focus on other Asian markets.',
  ),
  InternationalMarket(
    country: 'Japan',
    region: 'Asia-Pacific',
    boxOffice2024Billions: 1.95,
    growthRate2024: 5.8,
    screenCount: 3500,
    averageTicketPrice: 12.00,
    streamingPenetration: 55,
    majorLocalStudios: ['Toho', 'Toei', 'Shochiku', 'Kadokawa'],
    dominantStreamers: ['Netflix', 'Amazon Prime', 'Disney+', 'U-NEXT', 'Hulu Japan'],
    contentPreferences: 'Anime dominates. Local live-action strong. Hollywood releases popular but not dominant.',
    localContentQuota: 'None officially, but cultural preference for local content',
    coProductionTreaties: 'Limited - case by case',
    topGenres: ['Animation', 'Action', 'Sci-Fi', 'Horror', 'Drama'],
    marketOutlook: 'BULLISH - Anime global explosion. Godzilla Minus One success. Streaming growth.',
    buyerTips: 'Anime rights extremely valuable. Toho partnership for Japanese market. Strong theatrical culture.',
  ),
  InternationalMarket(
    country: 'South Korea',
    region: 'Asia-Pacific',
    boxOffice2024Billions: 1.25,
    growthRate2024: 4.2,
    screenCount: 3100,
    averageTicketPrice: 9.50,
    streamingPenetration: 78,
    majorLocalStudios: ['CJ Entertainment', 'Lotte Entertainment', 'NEW', 'Showbox'],
    dominantStreamers: ['Netflix', 'Disney+', 'Wavve', 'Tving', 'Watcha'],
    contentPreferences: 'Korean content hugely popular locally and globally. Genre-bending films celebrated.',
    localContentQuota: 'Screen quota: Korean films must play 73+ days/year per screen',
    coProductionTreaties: 'US, France, UK, China (limited)',
    topGenres: ['Thriller', 'Drama', 'Horror', 'Action', 'Romance'],
    marketOutlook: 'VERY BULLISH - K-content global phenomenon. Parasite, Squid Game effect. Investment surge.',
    buyerTips: 'CJ Entertainment major player. Korean talent/IP highly valuable. Netflix investing heavily.',
  ),
  InternationalMarket(
    country: 'India',
    region: 'Asia-Pacific',
    boxOffice2024Billions: 2.65,
    growthRate2024: 12.5,
    screenCount: 9500,
    averageTicketPrice: 3.00,
    streamingPenetration: 42,
    majorLocalStudios: ['Yash Raj Films', 'Dharma Productions', 'Red Chillies', 'Eros', 'T-Series'],
    dominantStreamers: ['JioCinema', 'Disney+ Hotstar', 'Amazon Prime', 'Netflix', 'Zee5', 'SonyLIV'],
    contentPreferences: 'Bollywood dominates Hindi market. Regional cinema (Tamil, Telugu) massive. Musicals essential.',
    localContentQuota: 'None - local content naturally dominant',
    coProductionTreaties: 'UK, France, Germany, Italy, Spain, Brazil, Canada, Australia',
    topGenres: ['Action', 'Drama', 'Romance', 'Musical', 'Comedy'],
    marketOutlook: 'VERY BULLISH - Fastest growing major market. RRR global success. Premium screens expanding.',
    buyerTips: 'Indian co-productions offer massive audience. Music/dance elements valued. Regional markets matter.',
  ),
  InternationalMarket(
    country: 'Australia',
    region: 'Asia-Pacific',
    boxOffice2024Billions: 0.78,
    growthRate2024: 2.8,
    screenCount: 2100,
    averageTicketPrice: 14.00,
    streamingPenetration: 80,
    majorLocalStudios: ['Village Roadshow', 'Screen Australia', 'Various independent'],
    dominantStreamers: ['Netflix', 'Disney+', 'Stan', 'Binge', 'Amazon Prime', 'Paramount+'],
    contentPreferences: 'Hollywood imports dominate theatrical. Strong local TV/streaming. Action and horror produced.',
    localContentQuota: 'Streaming local content obligations (new)',
    coProductionTreaties: 'UK, US, Canada, France, Germany, Italy, China, Singapore, South Africa',
    topGenres: ['Action', 'Horror', 'Comedy', 'Drama'],
    marketOutlook: 'STABLE - Major production hub for Hollywood. Tax incentives strong. Streaming competition intense.',
    buyerTips: 'Producer Offset (40%) attractive. Australian talent sought globally. Stan/Binge for local content.',
  ),

  // LATIN AMERICA
  InternationalMarket(
    country: 'Mexico',
    region: 'Latin America',
    boxOffice2024Billions: 0.88,
    growthRate2024: 6.5,
    screenCount: 7200,
    averageTicketPrice: 4.50,
    streamingPenetration: 52,
    majorLocalStudios: ['Videocine', 'Corazón Films', 'Cinépolis Distribución'],
    dominantStreamers: ['Netflix', 'Disney+', 'Amazon Prime', 'HBO Max', 'ViX (TelevisaUnivision)'],
    contentPreferences: 'Mexican comedies huge locally. Hollywood imports strong. Horror growing.',
    localContentQuota: 'Screen quota for Mexican films (limited enforcement)',
    coProductionTreaties: 'Spain (major), US, Argentina, Colombia, Brazil',
    topGenres: ['Comedy', 'Horror', 'Drama', 'Action'],
    marketOutlook: 'BULLISH - Strong theatrical growth. Netflix Spanish-language investment. Production hub.',
    buyerTips: 'Spanish-language content spans Latin America. Cinépolis major exhibitor/buyer. FIDECINE support.',
  ),
  InternationalMarket(
    country: 'Brazil',
    region: 'Latin America',
    boxOffice2024Billions: 0.65,
    growthRate2024: 4.2,
    screenCount: 3400,
    averageTicketPrice: 5.00,
    streamingPenetration: 48,
    majorLocalStudios: ['Globo Filmes', 'Paris Filmes', 'Downtown Filmes'],
    dominantStreamers: ['Netflix', 'Globoplay', 'Amazon Prime', 'Disney+', 'HBO Max'],
    contentPreferences: 'Brazilian comedies, Globo-produced content, action. Portuguese-language market.',
    localContentQuota: 'Tax incentives favor local production (Lei do Audiovisual)',
    coProductionTreaties: 'Portugal, Spain, Argentina, France, Germany, Italy',
    topGenres: ['Comedy', 'Action', 'Drama', 'Documentary'],
    marketOutlook: 'STABLE - Globo media powerhouse. Unique Portuguese-language market. Netflix investing.',
    buyerTips: 'Globo Films partnership key. Portuguese language limits region crossover. ANCINE incentives.',
  ),

  // MIDDLE EAST
  InternationalMarket(
    country: 'Saudi Arabia',
    region: 'Middle East',
    boxOffice2024Billions: 0.55,
    growthRate2024: 35.0,
    screenCount: 800,
    averageTicketPrice: 15.00,
    streamingPenetration: 65,
    majorLocalStudios: ['Saudi Film Council', 'MBC Studios', 'Myrkott'],
    dominantStreamers: ['Netflix', 'Shahid (MBC)', 'Disney+', 'Amazon Prime'],
    contentPreferences: 'Hollywood imports, Arabic content growing. Vision 2030 entertainment push.',
    localContentQuota: 'None - actively seeking international content',
    coProductionTreaties: 'Developing relationships, Film Commission active',
    topGenres: ['Action', 'Animation', 'Comedy', 'Drama'],
    marketOutlook: 'VERY BULLISH - Cinemas only reopened 2018. Massive expansion. Investment surge.',
    buyerTips: 'Red Sea Film Festival growing. Saudi Film Commission incentives. Content restrictions apply.',
  ),
  InternationalMarket(
    country: 'UAE',
    region: 'Middle East',
    boxOffice2024Billions: 0.35,
    growthRate2024: 8.5,
    screenCount: 600,
    averageTicketPrice: 12.00,
    streamingPenetration: 72,
    majorLocalStudios: ['Image Nation', 'twofour54'],
    dominantStreamers: ['Netflix', 'OSN', 'Disney+', 'Amazon Prime', 'Shahid'],
    contentPreferences: 'Hollywood imports, Bollywood significant (expat population), Arabic content.',
    localContentQuota: 'None - free market',
    coProductionTreaties: 'Various - Dubai Film Commission active',
    topGenres: ['Action', 'Animation', 'Comedy', 'Drama'],
    marketOutlook: 'BULLISH - Dubai as regional hub. Production incentives. MENA gateway.',
    buyerTips: 'Dubai Film Commission rebates. Regional Arabic market access. Image Nation partnerships.',
  ),
];

/// ═══════════════════════════════════════════════════════════════════════════
/// GLOBAL BOX OFFICE SUMMARY 2024
/// ═══════════════════════════════════════════════════════════════════════════

const globalBoxOfficeSummary = {
  'total_global_2024': 33.5, // billions USD
  'north_america': 9.25,
  'international_ex_china': 17.05,
  'china': 7.2,
  'growth_vs_2023': -2.5, // percentage
  'top_10_markets': [
    'USA (\$8.5B)',
    'China (\$7.2B)',
    'India (\$2.65B)',
    'Japan (\$1.95B)',
    'UK (\$1.35B)',
    'South Korea (\$1.25B)',
    'France (\$1.15B)',
    'Mexico (\$0.88B)',
    'Germany (\$0.85B)',
    'Australia (\$0.78B)',
  ],
  'streaming_revenue_global': 101, // billions USD
  'theatrical_vs_streaming_split': '25% theatrical / 50% streaming / 25% other',
};

/// ═══════════════════════════════════════════════════════════════════════════
/// CO-PRODUCTION TREATIES DATABASE
/// ═══════════════════════════════════════════════════════════════════════════

const List<CoProductionTreaty> coProductionTreatiesDatabase = [
  CoProductionTreaty(
    country1: 'USA',
    country2: 'UK',
    treatyName: 'US-UK Film Treaty',
    yearSigned: 1968,
    benefits: ['Access to UK tax reliefs', 'British qualification for content', 'European distribution advantages'],
    applicationProcess: 'BFI certification required. Cultural test applies.',
    successfulProductions: ['Harry Potter series', 'James Bond films', 'Gravity', 'The Dark Knight'],
  ),
  CoProductionTreaty(
    country1: 'UK',
    country2: 'France',
    treatyName: 'UK-France Film Co-production Agreement',
    yearSigned: 1994,
    benefits: ['Both countries\' tax incentives', 'European co-production status', 'Broadcast sales advantages'],
    applicationProcess: 'BFI and CNC joint approval.',
    successfulProductions: ['Portrait of a Lady on Fire', 'Dunkirk'],
  ),
  CoProductionTreaty(
    country1: 'USA',
    country2: 'Canada',
    treatyName: 'US-Canada Film/TV Treaty',
    yearSigned: 1988,
    benefits: ['Canadian tax credits', 'North American content status', 'Labor flexibility'],
    applicationProcess: 'CAVCO certification. CRTC for broadcast.',
    successfulProductions: ['X-Men', 'Suits', 'Arrival'],
  ),
  CoProductionTreaty(
    country1: 'UK',
    country2: 'Australia',
    treatyName: 'UK-Australia Co-production Treaty',
    yearSigned: 1990,
    benefits: ['Both countries\' incentives', 'Commonwealth market access'],
    applicationProcess: 'Screen Australia and BFI approval.',
    successfulProductions: ['Animal Kingdom', 'The Great Gatsby'],
  ),
];

/// Helper function to get markets by region
List<InternationalMarket> getMarketsByRegion(String region) {
  return internationalMarketsDatabase.where((m) => m.region == region).toList();
}

/// Helper function to get top growing markets
List<InternationalMarket> get topGrowingMarkets {
  final sorted = List<InternationalMarket>.from(internationalMarketsDatabase)
    ..sort((a, b) => b.growthRate2024.compareTo(a.growthRate2024));
  return sorted.take(10).toList();
}

/// Helper function to get markets by box office size
List<InternationalMarket> get topMarketsBySize {
  final sorted = List<InternationalMarket>.from(internationalMarketsDatabase)
    ..sort((a, b) => b.boxOffice2024Billions.compareTo(a.boxOffice2024Billions));
  return sorted.take(10).toList();
}
