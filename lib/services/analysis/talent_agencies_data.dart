/// ═══════════════════════════════════════════════════════════════════════════
/// TALENT AGENCIES DATABASE - Big Four & Key Literary Agencies
/// Last Updated: July 2025 (Data from Variety, Hollywood Reporter, Agency websites)
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// Sources:
/// - Variety/Hollywood Reporter agency rankings
/// - Agency press releases and client announcements
/// - IMDbPro representation data

library;

/// ═══════════════════════════════════════════════════════════════════════════
/// TALENT AGENCY DATA MODELS
/// ═══════════════════════════════════════════════════════════════════════════

class TalentAgency {
  final String name;
  final String abbreviation;
  final String headquarters;
  final String type; // 'Big Four', 'Major', 'Boutique', 'Literary'
  final List<String> divisions;
  final List<String> notableClients;
  final List<String> notableLiteraryAgents;
  final String submissionPolicy;
  final String bestFor;
  final int estimatedClients;
  final String recentAchievements;
  
  const TalentAgency({
    required this.name,
    required this.abbreviation,
    required this.headquarters,
    required this.type,
    required this.divisions,
    required this.notableClients,
    required this.notableLiteraryAgents,
    required this.submissionPolicy,
    required this.bestFor,
    required this.estimatedClients,
    required this.recentAchievements,
  });
}

class LiteraryAgent {
  final String name;
  final String agency;
  final List<String> specialties;
  final List<String> notableClients;
  final String submissionStatus;
  final String lookingFor;
  final List<String> recentSales;
  
  const LiteraryAgent({
    required this.name,
    required this.agency,
    required this.specialties,
    required this.notableClients,
    required this.submissionStatus,
    required this.lookingFor,
    required this.recentSales,
  });
}

class LiteraryManager {
  final String name;
  final String company;
  final List<String> specialties;
  final List<String> notableClients;
  final bool acceptsUnsolicited;
  final String submissionInfo;
  final String lookingFor;
  
  const LiteraryManager({
    required this.name,
    required this.company,
    required this.specialties,
    required this.notableClients,
    required this.acceptsUnsolicited,
    required this.submissionInfo,
    required this.lookingFor,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// THE BIG FOUR + MAJOR AGENCIES
/// ═══════════════════════════════════════════════════════════════════════════

const List<TalentAgency> talentAgenciesDatabase = [
  // THE BIG FOUR
  TalentAgency(
    name: 'Creative Artists Agency',
    abbreviation: 'CAA',
    headquarters: 'Los Angeles, CA',
    type: 'Big Four',
    divisions: ['Motion Pictures', 'Television', 'Digital Media', 'Sports', 'Music', 'Theater', 'Books'],
    notableClients: [
      'Tom Cruise', 'George Clooney', 'Reese Witherspoon', 'Oprah Winfrey', 'Steven Spielberg',
      'Jennifer Aniston', 'Dwayne Johnson', 'Meryl Streep', 'Brad Pitt', 'Julia Roberts',
      'LeBron James', 'Beyoncé', 'Scarlett Johansson', 'Chris Pratt', 'Ryan Reynolds'
    ],
    notableLiteraryAgents: [
      'Bryan Lourd (Co-Chairman)', 'Kevin Huvane (Co-Chairman)', 'Richard Lovett (Co-Chairman)',
      'Michelle Kydd Lee (Head of TV Literary)', 'Joel Lubin (Motion Picture Literary)',
      'Maha Dakhil (Motion Picture Literary)'
    ],
    submissionPolicy: 'Referral only. Query letters not accepted. Industry connections required.',
    bestFor: 'A-list packages, major studio deals, franchise talent, high-budget productions',
    estimatedClients: 3000,
    recentAchievements: 'Acquired ICM Partners (2023). Represents talent behind Oppenheimer, Barbie, multiple Oscar winners.',
  ),
  TalentAgency(
    name: 'William Morris Endeavor',
    abbreviation: 'WME',
    headquarters: 'Beverly Hills, CA',
    type: 'Big Four',
    divisions: ['Motion Pictures', 'Television', 'Digital Media', 'Music', 'Sports', 'Theater', 'Books', 'Podcasts'],
    notableClients: [
      'Denzel Washington', 'Matt Damon', 'Christian Bale', 'Ben Affleck', 'Charlize Theron',
      'Hugh Jackman', 'Emily Blunt', 'Gal Gadot', 'Timothée Chalamet', 'Zendaya',
      'Dua Lipa', 'Lizzo', 'UFC fighters', 'Serena Williams'
    ],
    notableLiteraryAgents: [
      'Ari Emanuel (CEO Endeavor)', 'Graham Taylor (TV Literary)', 'Cliff Roberts (Motion Picture Literary)',
      'Craig Kestel (TV Literary)', 'Jennifer Rudolph Walsh (Books)'
    ],
    submissionPolicy: 'Referral only. No unsolicited material accepted.',
    bestFor: 'Cross-platform packages, sports entertainment crossover, international talent',
    estimatedClients: 2500,
    recentAchievements: 'Parent company Endeavor went private (2024). Strong in UFC, fashion, and live events integration.',
  ),
  TalentAgency(
    name: 'United Talent Agency',
    abbreviation: 'UTA',
    headquarters: 'Beverly Hills, CA',
    type: 'Big Four',
    divisions: ['Motion Pictures', 'Television', 'Digital Media', 'Music', 'Esports', 'Podcasts', 'Books', 'Fine Arts'],
    notableClients: [
      'Kevin Hart', 'Harrison Ford', 'Channing Tatum', 'Gwyneth Paltrow', 'Johnny Depp',
      'Andrew Garfield', 'Jessica Chastain', 'Pedro Pascal', 'Kieran Culkin', 'Sydney Sweeney',
      'Bad Bunny', 'Post Malone', 'Joe Rogan'
    ],
    notableLiteraryAgents: [
      'Jeremy Zimmer (CEO)', 'Marty Bowen (TV)', 'Tracey Jacobs (Motion Pictures)',
      'Jason Heyman (Motion Pictures)', 'Rena Ronson (Independent Film)'
    ],
    submissionPolicy: 'Referral preferred. Selective query consideration through digital portal.',
    bestFor: 'Independent film, diverse talent, digital creators, podcast personalities',
    estimatedClients: 2000,
    recentAchievements: 'Strong in independent film space. Podcast and digital media expansion. Diverse talent emphasis.',
  ),
  TalentAgency(
    name: 'ICM Partners (Now CAA)',
    abbreviation: 'ICM',
    headquarters: 'Los Angeles, CA (Merged with CAA 2023)',
    type: 'Legacy Major',
    divisions: ['Motion Pictures', 'Television', 'Books', 'Theater', 'Broadcasting'],
    notableClients: [
      'Samuel L. Jackson', 'Uma Thurman', 'Chris Rock', 'Rashida Jones', 'Spike Lee',
      'Jordan Peele', 'Lena Dunham', 'Issa Rae'
    ],
    notableLiteraryAgents: [
      'Former literary agents now integrated into CAA literary department'
    ],
    submissionPolicy: 'Now part of CAA. Follow CAA submission guidelines.',
    bestFor: 'Literary talent (now through CAA), diverse voices',
    estimatedClients: 0, // Merged
    recentAchievements: 'Acquired by CAA in 2023. Rich literary heritage now part of CAA.',
  ),
  TalentAgency(
    name: 'Paradigm Talent Agency',
    abbreviation: 'Paradigm',
    headquarters: 'Beverly Hills, CA (Scaled down 2020)',
    type: 'Major',
    divisions: ['Music', 'Comedy', 'Literary'],
    notableClients: [
      'Stephen King (literary)', 'Laurie Anderson', 'Various music acts'
    ],
    notableLiteraryAgents: [
      'Focus shifted to music and comedy touring post-2020'
    ],
    submissionPolicy: 'Limited operations. Music touring focus.',
    bestFor: 'Music touring, comedy, select literary',
    estimatedClients: 800,
    recentAchievements: 'Reorganized after pandemic. Focus on music touring.',
  ),

  // MAJOR AGENCIES
  TalentAgency(
    name: 'APA (Agency for the Performing Arts)',
    abbreviation: 'APA',
    headquarters: 'Beverly Hills, CA',
    type: 'Major',
    divisions: ['Motion Pictures', 'Television', 'Comedy', 'Music', 'Books', 'Digital'],
    notableClients: [
      'Ricky Gervais', 'Trevor Noah', 'Hannah Gadsby', 'Jerry Seinfeld (past)',
      'Various TV writers and showrunners'
    ],
    notableLiteraryAgents: [
      'Steve Fisher (Literary)', 'Sheryl Petersen (TV Literary)'
    ],
    submissionPolicy: 'Query letters accepted for literary department.',
    bestFor: 'Comedy writers, TV staff writers, emerging talent',
    estimatedClients: 1000,
    recentAchievements: 'Strong comedy department. Good entry point for emerging writers.',
  ),
  TalentAgency(
    name: 'Gersh Agency',
    abbreviation: 'Gersh',
    headquarters: 'Beverly Hills, CA',
    type: 'Major',
    divisions: ['Motion Pictures', 'Television', 'Books', 'Theater', 'Digital'],
    notableClients: [
      'Kristen Stewart', 'Adam Driver', 'Michael Shannon', 'Toni Collette',
      'Various indie filmmakers'
    ],
    notableLiteraryAgents: [
      'Bob Gersh (Chairman)', 'Lynn Pleshette (TV Literary)'
    ],
    submissionPolicy: 'Query letters with industry credits considered.',
    bestFor: 'Character actors, indie filmmakers, TV writers',
    estimatedClients: 600,
    recentAchievements: 'Strong indie film relationships. Good A24, Searchlight connections.',
  ),
  TalentAgency(
    name: 'Verve Talent & Literary',
    abbreviation: 'Verve',
    headquarters: 'Beverly Hills, CA',
    type: 'Boutique',
    divisions: ['Motion Pictures', 'Television', 'Books', 'Digital'],
    notableClients: [
      'Emerging writers and directors', 'Independent filmmakers'
    ],
    notableLiteraryAgents: [
      'Bryan Besser (Literary Partner)', 'Adam Levine (TV Literary)'
    ],
    submissionPolicy: 'More accessible than Big Four. Query letters considered.',
    bestFor: 'Emerging writers, spec scripts, indie projects',
    estimatedClients: 400,
    recentAchievements: 'Known for developing emerging talent. Good spec market track record.',
  ),
  TalentAgency(
    name: 'Buchwald Agency',
    abbreviation: 'Buchwald',
    headquarters: 'Los Angeles, CA',
    type: 'Boutique',
    divisions: ['Motion Pictures', 'Television', 'Theater'],
    notableClients: [
      'TV writers', 'Theater talent', 'Emerging directors'
    ],
    notableLiteraryAgents: [
      'Various literary agents'
    ],
    submissionPolicy: 'Query letters accepted.',
    bestFor: 'TV writers, theater crossover',
    estimatedClients: 300,
    recentAchievements: 'Strong theater connections.',
  ),
  TalentAgency(
    name: 'Innovative Artists',
    abbreviation: 'IA',
    headquarters: 'Los Angeles, CA',
    type: 'Major',
    divisions: ['Motion Pictures', 'Television', 'Voiceover', 'Commercial'],
    notableClients: [
      'Character actors', 'Voice talent', 'Commercial talent'
    ],
    notableLiteraryAgents: [
      'Scott Henderson (Literary)'
    ],
    submissionPolicy: 'Query letters considered for literary.',
    bestFor: 'Character actors, voice work, commercial talent',
    estimatedClients: 500,
    recentAchievements: 'Strong voiceover and commercial department.',
  ),

  // LITERARY-FOCUSED AGENCIES
  TalentAgency(
    name: 'Anonymous Content',
    abbreviation: 'AC',
    headquarters: 'Los Angeles, CA',
    type: 'Literary',
    divisions: ['Management', 'Production', 'Literary Representation'],
    notableClients: [
      'Charlie Kaufman', 'Nic Pizzolatto', 'Various showrunners'
    ],
    notableLiteraryAgents: [
      'Steve Golin (Founder)', 'David Kanter', 'Michael Sugar'
    ],
    submissionPolicy: 'Referral preferred. Management company with production arm.',
    bestFor: 'Auteur writers, showrunners, literary-forward projects',
    estimatedClients: 150,
    recentAchievements: 'True Detective, Spotlight, The Revenant. Strong Oscar track record.',
  ),
  TalentAgency(
    name: '3 Arts Entertainment',
    abbreviation: '3 Arts',
    headquarters: 'Beverly Hills, CA',
    type: 'Literary',
    divisions: ['Management', 'Production', 'Television', 'Film'],
    notableClients: [
      'Tina Fey', 'Amy Poehler', 'Mindy Kaling', 'Various comedy writers'
    ],
    notableLiteraryAgents: [
      'Erwin Stoff', 'Michael Rotenberg', 'Dave Becky'
    ],
    submissionPolicy: 'Referral only. Management company.',
    bestFor: 'Comedy writers, TV showrunners, production deals',
    estimatedClients: 200,
    recentAchievements: 'Strong comedy pedigree. Producing arm active.',
  ),
];

/// ═══════════════════════════════════════════════════════════════════════════
/// LITERARY MANAGERS DATABASE
/// ═══════════════════════════════════════════════════════════════════════════

const List<LiteraryManager> literaryManagersDatabase = [
  LiteraryManager(
    name: 'Michael Sugar',
    company: 'Sugar23',
    specialties: ['Drama', 'Thriller', 'Prestige'],
    notableClients: ['Nic Pizzolatto (True Detective)', 'Derek Cianfrance'],
    acceptsUnsolicited: false,
    submissionInfo: 'Referral only. Highly selective.',
    lookingFor: 'Auteur voices, prestige drama, limited series',
  ),
  LiteraryManager(
    name: 'Jewerl Ross',
    company: 'Anonymous Content',
    specialties: ['Drama', 'Genre', 'Diverse Voices'],
    notableClients: ['Various emerging writers'],
    acceptsUnsolicited: false,
    submissionInfo: 'Festival connections, referrals.',
    lookingFor: 'Fresh perspectives, diverse storytelling',
  ),
  LiteraryManager(
    name: 'Peter Principato',
    company: 'Artists First',
    specialties: ['Comedy', 'Drama', 'Television'],
    notableClients: ['Various comedy writers'],
    acceptsUnsolicited: false,
    submissionInfo: 'Industry referrals.',
    lookingFor: 'Comedy writers with distinct voice',
  ),
  LiteraryManager(
    name: 'Jon Rubinstein',
    company: 'Brillstein Entertainment',
    specialties: ['Comedy', 'Drama', 'Television'],
    notableClients: ['Various TV writers and showrunners'],
    acceptsUnsolicited: false,
    submissionInfo: 'Referral from existing clients.',
    lookingFor: 'TV writers with showrunning potential',
  ),
  LiteraryManager(
    name: 'Dan Aloni',
    company: 'Fourward',
    specialties: ['Action', 'Thriller', 'Sci-Fi'],
    notableClients: ['Action/genre writers'],
    acceptsUnsolicited: true,
    submissionInfo: 'Query accepted via website.',
    lookingFor: 'High-concept genre scripts',
  ),
  LiteraryManager(
    name: 'Tariq Merhab',
    company: 'Circle of Confusion',
    specialties: ['Sci-Fi', 'Fantasy', 'Horror', 'Graphic Novels'],
    notableClients: ['The Walking Dead creators', 'Genre writers'],
    acceptsUnsolicited: true,
    submissionInfo: 'Query via website. Genre focus.',
    lookingFor: 'Graphic novel adaptations, genre material, IP',
  ),
  LiteraryManager(
    name: 'Adam Kolbrenner',
    company: 'Madhouse Entertainment',
    specialties: ['Horror', 'Thriller', 'Action'],
    notableClients: ['Genre writers'],
    acceptsUnsolicited: true,
    submissionInfo: 'Query via website.',
    lookingFor: 'Horror, thriller, contained concepts',
  ),
  LiteraryManager(
    name: 'Brooklyn Weaver',
    company: 'Energy Entertainment',
    specialties: ['Drama', 'Thriller', 'Diverse Stories'],
    notableClients: ['Emerging diverse writers'],
    acceptsUnsolicited: true,
    submissionInfo: 'Query via website. Diversity focused.',
    lookingFor: 'Underrepresented voices, fresh perspectives',
  ),
  LiteraryManager(
    name: 'Jake Wagner',
    company: 'Good Fear Content Management',
    specialties: ['Horror', 'Thriller', 'Genre'],
    notableClients: ['Horror writers'],
    acceptsUnsolicited: true,
    submissionInfo: 'Query via website. Horror specialty.',
    lookingFor: 'Elevated horror, smart genre',
  ),
  LiteraryManager(
    name: 'Ryan Cunningham',
    company: 'Grandview',
    specialties: ['Drama', 'Comedy', 'Television'],
    notableClients: ['TV writers'],
    acceptsUnsolicited: false,
    submissionInfo: 'Referral preferred.',
    lookingFor: 'TV writers, comedy, drama',
  ),
];

/// ═══════════════════════════════════════════════════════════════════════════
/// SUBMISSION PATHWAY RECOMMENDATIONS
/// ═══════════════════════════════════════════════════════════════════════════

const Map<String, List<String>> submissionPathwaysByGenre = {
  'Horror': [
    'Circle of Confusion - genre specialty, accepts queries',
    'Good Fear Management - horror focus, accepts queries',
    'Madhouse Entertainment - thriller/horror, accepts queries',
    'Energy Entertainment - genre with diverse voices',
    'Blumhouse open submissions program',
  ],
  'Thriller': [
    'Madhouse Entertainment - thriller specialty',
    'Fourward - action/thriller focus',
    'Circle of Confusion - genre material',
    'Verve - emerging talent friendly',
    'APA Literary - accessible big agency',
  ],
  'Comedy': [
    '3 Arts Entertainment (referral) - comedy powerhouse',
    'APA - comedy specialty department',
    'Verve - accessible for emerging talent',
    'Grandview - TV comedy focus',
  ],
  'Drama': [
    'Anonymous Content (referral) - prestige drama',
    'Sugar23 (referral) - auteur voices',
    'Energy Entertainment - diverse dramas',
    'Gersh Agency - indie drama connections',
  ],
  'Sci-Fi': [
    'Circle of Confusion - sci-fi/fantasy specialty',
    'Fourward - high-concept genre',
    'UTA Independent Film - sci-fi indie',
  ],
  'Action': [
    'Fourward - action specialty',
    'Madhouse Entertainment - action/thriller',
    'WME/CAA (with package) - studio action',
  ],
};

/// Helper function to get managers accepting unsolicited
List<LiteraryManager> get managersAcceptingUnsolicited {
  return literaryManagersDatabase.where((m) => m.acceptsUnsolicited).toList();
}

/// Helper function to get agencies by type
List<TalentAgency> getAgenciesByType(String type) {
  return talentAgenciesDatabase.where((a) => a.type == type).toList();
}
