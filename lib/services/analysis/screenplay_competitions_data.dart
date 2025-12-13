/// ═══════════════════════════════════════════════════════════════════════════
/// SCREENPLAY COMPETITIONS DATABASE - 2025 Contest Calendar & Success Stories
/// Last Updated: July 2025 (Data from competition websites, tracking boards)
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Sources:
/// - Official competition websites
/// - The Black List annual reports
/// - Tracking boards (Tracking Board, Done Deal Pro)
/// - Writer success stories

library;

/// ═══════════════════════════════════════════════════════════════════════════
/// SCREENPLAY COMPETITION DATA MODELS
/// ═══════════════════════════════════════════════════════════════════════════

class ScreenplayCompetition {
  final String name;
  final String tier; // 'Elite', 'Major', 'Notable', 'Genre-Specific'
  final String deadline2025;
  final String entryFee;
  final List<String> categories;
  final String grandPrize;
  final List<String> otherPrizes;
  final int estimatedSubmissions;
  final String industryConnections;
  final List<String> successStories;
  final String website;
  final String bestFor;
  
  const ScreenplayCompetition({
    required this.name,
    required this.tier,
    required this.deadline2025,
    required this.entryFee,
    required this.categories,
    required this.grandPrize,
    required this.otherPrizes,
    required this.estimatedSubmissions,
    required this.industryConnections,
    required this.successStories,
    required this.website,
    required this.bestFor,
  });
}

class BlackListInfo {
  final String name;
  final String description;
  final String cost;
  final String evaluationService;
  final List<String> successStories;
  final String industryReach;
  final String website;
  final String bestPractices;
  
  const BlackListInfo({
    required this.name,
    required this.description,
    required this.cost,
    required this.evaluationService,
    required this.successStories,
    required this.industryReach,
    required this.website,
    required this.bestPractices,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// MAJOR SCREENPLAY COMPETITIONS - 2025
/// ═══════════════════════════════════════════════════════════════════════════

const List<ScreenplayCompetition> competitionsDatabase = [
  // ELITE TIER (Industry-recognized, career-changing)
  ScreenplayCompetition(
    name: 'Academy Nicholl Fellowships in Screenwriting',
    tier: 'Elite',
    deadline2025: 'May 2025',
    entryFee: '\$85',
    categories: ['Feature Screenplay'],
    grandPrize: '\$35,000 fellowship (up to 5 awarded)',
    otherPrizes: ['Finalist status highly recognized', 'Industry meetings', 'Academy member access'],
    estimatedSubmissions: 7000,
    industryConnections: 'VERY HIGH - Academy members, studios actively monitor. Finalist status opens doors.',
    successStories: [
      'Susannah Grant (Erin Brockovich) - Finalist',
      'Ehren Kruger (The Ring, Transformers) - Winner',
      'Allison Schroeder (Hidden Figures) - Winner',
      'Destin Daniel Cretton (Short Term 12, Shang-Chi) - Finalist',
    ],
    website: 'oscars.org/nicholl',
    bestFor: 'Prestige recognition. Best for character-driven dramas and elevated genre.',
  ),
  ScreenplayCompetition(
    name: 'Austin Film Festival Screenplay Competition',
    tier: 'Elite',
    deadline2025: 'June 2025',
    entryFee: '\$50-70',
    categories: ['Drama', 'Comedy', 'Sci-Fi', 'Horror', 'Action/Thriller', 'TV Pilot'],
    grandPrize: '\$5,000 + badge + industry meetings',
    otherPrizes: ['Second Rounder badges', 'Industry panels', 'Pitch opportunities'],
    estimatedSubmissions: 10000,
    industryConnections: 'VERY HIGH - Major managers/agents attend. Second Round status meaningful.',
    successStories: [
      'Jez Butterworth (Ford v Ferrari) - Winner',
      'Aaron Sorkin keynote speaker',
      'Numerous TV staffings from winners',
    ],
    website: 'austinfilmfestival.com',
    bestFor: 'All genres. TV pilots particularly strong. Great networking conference.',
  ),
  ScreenplayCompetition(
    name: 'PAGE International Screenwriting Awards',
    tier: 'Elite',
    deadline2025: 'April 2025 (early) - June 2025 (final)',
    entryFee: '\$55-75',
    categories: ['Drama', 'Comedy', 'Family', 'Action/Adventure', 'Thriller/Horror', 'Sci-Fi', 'Historical', 'TV Drama', 'TV Comedy'],
    grandPrize: '\$25,000 + meetings',
    otherPrizes: ['\$10,000 per category winner', 'Finalists receive industry exposure'],
    estimatedSubmissions: 8000,
    industryConnections: 'VERY HIGH - Direct management and agent attention. Multiple genre categories.',
    successStories: [
      'Multiple winners signed by CAA, WME, UTA',
      'Sold specs to major studios',
    ],
    website: 'pageawards.com',
    bestFor: 'Genre-specific recognition. Good for commercial scripts.',
  ),
  ScreenplayCompetition(
    name: 'Sundance Screenwriters Lab',
    tier: 'Elite',
    deadline2025: 'August 2025',
    entryFee: '\$100',
    categories: ['Feature Screenplay'],
    grandPrize: 'Intensive mentorship lab + fellowship support',
    otherPrizes: ['Advisor network', 'Sundance alumni community', 'Potential Catalyst funding'],
    estimatedSubmissions: 5000,
    industryConnections: 'EXTREMELY HIGH - Sundance brand. Lab advisors are A-list filmmakers.',
    successStories: [
      'Quentin Tarantino (Reservoir Dogs)',
      'Beasts of the Southern Wild',
      'Mudbound',
      'The Birth of a Nation',
    ],
    website: 'sundance.org/programs/screenwriters-lab',
    bestFor: 'Director-writers with personal stories. Independent cinema.',
  ),

  // MAJOR TIER (Industry-respected, significant exposure)
  ScreenplayCompetition(
    name: 'Final Draft Big Break',
    tier: 'Major',
    deadline2025: 'June 2025',
    entryFee: '\$60-75',
    categories: ['Feature', 'TV Pilot'],
    grandPrize: '\$15,000 + Final Draft software',
    otherPrizes: ['Manager meetings', 'Industry coverage'],
    estimatedSubmissions: 6000,
    industryConnections: 'HIGH - Sponsored by industry software leader. Manager partnerships.',
    successStories: [
      'Multiple winners signed and staffed',
      'Specs optioned from winner pool',
    ],
    website: 'finaldraft.com/big-break',
    bestFor: 'Commercial scripts. Good manager exposure.',
  ),
  ScreenplayCompetition(
    name: 'Script Pipeline',
    tier: 'Major',
    deadline2025: 'May 2025',
    entryFee: '\$55-65',
    categories: ['Feature', 'TV Pilot', 'First Look'],
    grandPrize: '\$25,000 + representation',
    otherPrizes: ['Direct producer introductions', 'Coverage feedback'],
    estimatedSubmissions: 8000,
    industryConnections: 'HIGH - Active producer relationships. Scripts shopped directly.',
    successStories: [
      'Kumail Nanjiani (The Big Sick connection)',
      'Multiple options and sales',
    ],
    website: 'scriptpipeline.com',
    bestFor: 'Market-ready scripts. Strong producer connections.',
  ),
  ScreenplayCompetition(
    name: 'ScreenCraft',
    tier: 'Major',
    deadline2025: 'Various (multiple competitions)',
    entryFee: '\$45-85',
    categories: ['Drama', 'Horror', 'Sci-Fi', 'Comedy', 'Action', 'TV', 'Animation', 'Shorts'],
    grandPrize: '\$2,500-10,000 depending on competition',
    otherPrizes: ['Manager meetings', 'Coverage', 'Industry exposure'],
    estimatedSubmissions: 15000,
    industryConnections: 'HIGH - Multiple genre-specific competitions. Active industry partnerships.',
    successStories: [
      'Multiple sales from genre competitions',
      'TV staffings',
    ],
    website: 'screencraft.org',
    bestFor: 'Genre-specific scripts. Multiple opportunities per year.',
  ),
  ScreenplayCompetition(
    name: 'BlueCat Screenplay Competition',
    tier: 'Major',
    deadline2025: 'April 2025',
    entryFee: '\$50-70',
    categories: ['Feature', 'Short', 'TV Pilot'],
    grandPrize: '\$10,000 + written analysis',
    otherPrizes: ['All entrants receive analysis', 'Finalist recognition'],
    estimatedSubmissions: 5000,
    industryConnections: 'MODERATE-HIGH - Known for quality feedback.',
    successStories: [
      'Valued for development feedback',
      'Winners have gone on to representation',
    ],
    website: 'bluecatscreenplay.com',
    bestFor: 'Writers seeking development feedback. Good analysis included.',
  ),
  ScreenplayCompetition(
    name: 'WeScreenplay',
    tier: 'Major',
    deadline2025: 'Various (multiple deadlines)',
    entryFee: '\$35-55',
    categories: ['Feature', 'TV', 'Diverse Voices', 'Horror', 'International'],
    grandPrize: '\$2,500-5,000 + representation meetings',
    otherPrizes: ['Finalist recognition', 'Coverage services'],
    estimatedSubmissions: 7000,
    industryConnections: 'HIGH - Active management partnerships. Multiple specialty competitions.',
    successStories: [
      'Multiple writers signed from competitions',
      'Diverse Voices initiative highlighted',
    ],
    website: 'wescreenplay.com',
    bestFor: 'Affordable entry. Diverse voices focus.',
  ),
  ScreenplayCompetition(
    name: 'Slamdance Screenplay Competition',
    tier: 'Major',
    deadline2025: 'September 2025',
    entryFee: '\$55-75',
    categories: ['Feature', 'Short', 'Horror', 'TV'],
    grandPrize: '\$5,000 + Slamdance Festival access',
    otherPrizes: ['Festival badge', 'Industry screenings'],
    estimatedSubmissions: 4000,
    industryConnections: 'MODERATE-HIGH - Connected to Slamdance Film Festival. Indie focus.',
    successStories: [
      'Festival connection valuable',
      'Independent filmmakers supported',
    ],
    website: 'slamdance.com',
    bestFor: 'Independent/alternative voices. Festival connection.',
  ),

  // NOTABLE TIER (Good exposure, emerging writer focused)
  ScreenplayCompetition(
    name: 'Scriptapalooza',
    tier: 'Notable',
    deadline2025: 'March 2025',
    entryFee: '\$55-75',
    categories: ['Feature', 'TV', 'Shorts'],
    grandPrize: '\$10,000 + producer introductions',
    otherPrizes: ['Coverage', 'Development meetings'],
    estimatedSubmissions: 4000,
    industryConnections: 'MODERATE - Established competition with producer network.',
    successStories: ['Multiple options from winner pool'],
    website: 'scriptapalooza.com',
    bestFor: 'Commercial scripts. Strong coverage options.',
  ),
  ScreenplayCompetition(
    name: 'Roadmap Writers',
    tier: 'Notable',
    deadline2025: 'Rolling (mentorship program)',
    entryFee: 'Program fees vary',
    categories: ['Feature', 'TV', 'Genre'],
    grandPrize: 'Mentorship with working writers',
    otherPrizes: ['Direct manager/agent connections', 'Career coaching'],
    estimatedSubmissions: 2000,
    industryConnections: 'HIGH - Mentorship model with direct connections.',
    successStories: [
      'Multiple TV staffings',
      'Representation from mentorship',
    ],
    website: 'roadmapwriters.com',
    bestFor: 'Writers seeking mentorship and career development.',
  ),
  ScreenplayCompetition(
    name: 'Tracking Board Launch Pad',
    tier: 'Notable',
    deadline2025: 'February 2025',
    entryFee: '\$65-85',
    categories: ['Feature', 'TV Pilot'],
    grandPrize: '\$15,000 + industry meetings',
    otherPrizes: ['Tracking Board exposure', 'Manager attention'],
    estimatedSubmissions: 5000,
    industryConnections: 'HIGH - Tracking Board industry newsletter reach.',
    successStories: [
      'Multiple finalists signed',
      'Scripts optioned from competition',
    ],
    website: 'tblaunchpad.com',
    bestFor: 'Commercial scripts with high-concept hooks.',
  ),
  ScreenplayCompetition(
    name: 'Humanitas Prize',
    tier: 'Notable',
    deadline2025: 'December 2025',
    entryFee: 'Free (nomination-based for produced work), \$75 for New Voices',
    categories: ['Drama', 'Comedy', 'Documentary', 'Children\'s'],
    grandPrize: '\$10,000-25,000',
    otherPrizes: ['Prestige recognition', 'Ceremony attendance'],
    estimatedSubmissions: 1500,
    industryConnections: 'HIGH - Prestige award. Industry recognition.',
    successStories: [
      'Major writers honored',
      'New Voices winners gain attention',
    ],
    website: 'humanitasprize.org',
    bestFor: 'Scripts with humanistic themes. Prestige recognition.',
  ),

  // GENRE-SPECIFIC
  ScreenplayCompetition(
    name: 'Shriekfest Horror Film Festival & Screenplay Competition',
    tier: 'Genre-Specific',
    deadline2025: 'July 2025',
    entryFee: '\$40-60',
    categories: ['Horror Feature', 'Horror Short', 'Thriller', 'Sci-Fi'],
    grandPrize: '\$500 + festival exposure',
    otherPrizes: ['Genre industry connections', 'Festival screenings'],
    estimatedSubmissions: 2000,
    industryConnections: 'MODERATE - Genre community focused. Horror specialist.',
    successStories: ['Genre writers connected to horror producers'],
    website: 'shriekfest.com',
    bestFor: 'Horror specialists. Genre community networking.',
  ),
  ScreenplayCompetition(
    name: 'Fresh Voices Screenplay Competition',
    tier: 'Notable',
    deadline2025: 'April 2025',
    entryFee: '\$40-60',
    categories: ['Feature', 'TV'],
    grandPrize: '\$3,000 + representation meetings',
    otherPrizes: ['Industry coverage', 'Finalist recognition'],
    estimatedSubmissions: 3000,
    industryConnections: 'MODERATE - Focus on emerging writers.',
    successStories: ['New writers discovered'],
    website: 'freshvoices.net',
    bestFor: 'First-time competition entrants. Emerging writers.',
  ),
  ScreenplayCompetition(
    name: 'CineStory Feature Fellowship',
    tier: 'Notable',
    deadline2025: 'June 2025',
    entryFee: '\$50-75',
    categories: ['Feature'],
    grandPrize: '\$3,000 + retreat attendance',
    otherPrizes: ['Mentorship retreat', 'Industry meetings'],
    estimatedSubmissions: 2500,
    industryConnections: 'MODERATE - Retreat model with direct mentorship.',
    successStories: ['Fellowship retreat valued by participants'],
    website: 'cinestory.org',
    bestFor: 'Writers seeking development and community.',
  ),
];

/// ═══════════════════════════════════════════════════════════════════════════
/// THE BLACK LIST
/// ═══════════════════════════════════════════════════════════════════════════

const BlackListInfo blackListInfo = BlackListInfo(
  name: 'The Black List',
  description: 'Annual survey of Hollywood executives\' favorite unproduced screenplays AND online hosting/evaluation platform.',
  cost: '\$30/month hosting + \$100 per professional evaluation',
  evaluationService: 'Reader evaluations (1-10 score). Scripts scoring 8+ get industry attention.',
  successStories: [
    'Juno - Black List 2007, Academy Award winner',
    'The King\'s Speech - Black List 2009, Academy Award winner',
    'Argo - Black List 2007, Academy Award winner',
    'Slumdog Millionaire - Black List 2007, Academy Award winner',
    'Get Out - Black List 2016, Academy Award winner',
    'Spotlight - Black List 2013, Academy Award winner',
    'The Imitation Game - Black List 2011, Academy Award nominee',
    'Whiplash - Black List 2012, Academy Award winner',
    'The Revenant - Black List 2007, Academy Award winner',
    'American Hustle - Black List 2010, Academy Award nominee',
  ],
  industryReach: '4,000+ industry professionals receive annual list. Online platform connects directly with managers/agents.',
  website: 'blcklst.com',
  bestPractices: '''
BEST PRACTICES FOR BLACK LIST HOSTING:
1. Have a polished, proofread script before hosting
2. Write a compelling logline (crucial for discovery)
3. High-concept scripts perform better for initial reads
4. If you receive 7 or below, revise before re-hosting
5. Aim for multiple 8+ evaluations for maximum exposure
6. Industry professionals monitor 8+ scripts regularly
7. Consider seasonal timing (avoid major holidays)
8. Update script if you receive consistent feedback on issues
9. Engage with the community for query advice
10. Be prepared for representation outreach if you score well

TYPICAL BLACK LIST SCRIPT JOURNEY:
- Host script (\$30/month)
- Request evaluation (\$100)
- If 8+: Increased visibility, potential industry downloads
- Multiple 8+ scores: Manager/agent attention
- Industry professional downloads visible to writer
- Success stories: Scripts sold directly from platform
''',
);

/// ═══════════════════════════════════════════════════════════════════════════
/// COMPETITION STRATEGY BY CAREER STAGE
/// ═══════════════════════════════════════════════════════════════════════════

const Map<String, List<String>> competitionStrategyByStage = {
  'First Script': [
    'BlueCat - valuable feedback included with entry',
    'Fresh Voices - focused on emerging writers',
    'WeScreenplay - affordable entry fees',
    'Use competitions for development feedback first',
  ],
  'Polished Portfolio (2-3 scripts)': [
    'Nicholl Fellowships - prestige recognition',
    'Austin Film Festival - conference networking',
    'PAGE Awards - multiple genre categories',
    'Black List hosting - industry exposure',
  ],
  'Seeking Representation': [
    'Script Pipeline - active producer connections',
    'Tracking Board Launch Pad - newsletter exposure',
    'ScreenCraft - manager partnerships',
    'Roadmap Writers - mentorship pathway',
  ],
  'Genre Specialists': [
    'ScreenCraft genre-specific competitions',
    'Shriekfest (horror)',
    'Austin Film Festival (all genres recognized)',
    'Slamdance (indie/alternative)',
  ],
  'TV Writers': [
    'Austin Film Festival TV Pilot',
    'Final Draft Big Break TV',
    'WeScreenplay TV Pilot',
    'Script Pipeline TV',
  ],
};

/// ═══════════════════════════════════════════════════════════════════════════
/// ANNUAL COMPETITION CALENDAR
/// ═══════════════════════════════════════════════════════════════════════════

const Map<String, List<String>> competitionCalendar = {
  'January': ['Slamdance final deadline'],
  'February': ['Tracking Board Launch Pad deadline'],
  'March': ['Scriptapalooza deadline'],
  'April': ['PAGE Awards early deadline', 'BlueCat deadline', 'Fresh Voices deadline'],
  'May': ['Nicholl Fellowships deadline', 'Script Pipeline deadline'],
  'June': ['Austin Film Festival deadline', 'PAGE Awards final deadline', 'Final Draft Big Break deadline', 'CineStory deadline'],
  'July': ['Shriekfest deadline'],
  'August': ['Sundance Labs deadline'],
  'September': ['Slamdance early deadline'],
  'October': ['Austin Film Festival Conference'],
  'November': ['Industry slowdown - holiday period'],
  'December': ['Humanitas Prize deadline', 'Black List annual survey released'],
};

/// Helper function to get competitions by tier
List<ScreenplayCompetition> getCompetitionsByTier(String tier) {
  return competitionsDatabase.where((c) => c.tier == tier).toList();
}

/// Helper function to get competitions by category
List<ScreenplayCompetition> getCompetitionsForCategory(String category) {
  return competitionsDatabase.where((c) => c.categories.any((cat) => cat.toLowerCase().contains(category.toLowerCase()))).toList();
}
