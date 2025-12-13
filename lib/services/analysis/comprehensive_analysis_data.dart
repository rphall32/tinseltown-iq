/// ═══════════════════════════════════════════════════════════════════════════
/// COMPREHENSIVE ANALYSIS DATA - Unified Export of All Industry Intelligence
/// Last Updated: July 2025
/// ═══════════════════════════════════════════════════════════════════════════
/// 
/// This file provides a unified interface to all expanded industry data:
/// - 100+ Buyers (studios, streamers, indie distributors)
/// - 100+ Producers (working industry professionals)
/// - 200+ Comparable Titles (2020-2025 successes)
/// - 15+ Talent Agencies (Big Four + majors)
/// - 20+ Film Festivals (2025 submission calendar)
/// - 15+ International Markets (global box office data)
/// - 20+ Screenplay Competitions (with success stories)
/// - 10+ Streaming Platforms (content strategies)

library;

// Export all data modules
export 'industry_data.dart';
export 'expanded_buyers_data.dart';
export 'expanded_producers_data.dart';
export 'expanded_titles_data.dart';
export 'talent_agencies_data.dart';
export 'film_festivals_data.dart';
export 'international_markets_data.dart';
export 'screenplay_competitions_data.dart';
export 'streaming_platforms_data.dart';

// Import for unified access
import 'industry_data.dart';
import 'expanded_buyers_data.dart';
import 'expanded_producers_data.dart';
import 'expanded_titles_data.dart';
import 'talent_agencies_data.dart';
import 'film_festivals_data.dart';
import 'international_markets_data.dart';
import 'screenplay_competitions_data.dart';
import 'streaming_platforms_data.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// COMPREHENSIVE DATA ACCESS CLASS
/// ═══════════════════════════════════════════════════════════════════════════

class ComprehensiveIndustryData {
  // Singleton pattern
  static final ComprehensiveIndustryData _instance = ComprehensiveIndustryData._internal();
  factory ComprehensiveIndustryData() => _instance;
  ComprehensiveIndustryData._internal();
  
  // ═══════════════════════════════════════════════════════════════════════════
  // DATA COUNTS (for UI display)
  // ═══════════════════════════════════════════════════════════════════════════
  
  int get buyerCount => expandedBuyerDatabase.length;
  int get producerCount => expandedProducerDatabase.length;
  int get titleCount => expandedTitlesDatabase.length;
  int get agencyCount => talentAgenciesDatabase.length;
  int get festivalCount => festivalDatabase.length;
  int get marketCount => internationalMarketsDatabase.length;
  int get competitionCount => competitionsDatabase.length;
  int get platformCount => streamingPlatformsDatabase.length;
  int get managerCount => literaryManagersDatabase.length;
  
  String get dataSummary => '''
GREENLIGHTIQ™ INDUSTRY DATABASE - July 2025

📊 DATA COVERAGE:
• $buyerCount Industry Buyers (studios, streamers, distributors)
• $producerCount Working Producers (with real track records)
• $titleCount Comparable Titles (2020-2025 successes)
• $agencyCount Talent Agencies (Big Four + major agencies)
• $festivalCount Film Festivals (with 2025 submission deadlines)
• $marketCount International Markets (global box office data)
• $competitionCount Screenplay Competitions (with success stories)
• $platformCount Streaming Platforms (content strategies)
• $managerCount Literary Managers (with submission info)

📈 TOTAL DATA POINTS: ${buyerCount + producerCount + titleCount + agencyCount + festivalCount + marketCount + competitionCount + platformCount + managerCount}+

🔄 SOURCES: Box Office Mojo, The Numbers, Variety, Hollywood Reporter, 
   Deadline, Screen Daily, Company Earnings, Festival Websites, 
   IMDbPro, WGA, Nielsen, Comscore, PwC Entertainment Outlook
''';

  // ═══════════════════════════════════════════════════════════════════════════
  // BUYER DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  List<BuyerProfile> get allBuyers => expandedBuyerDatabase;
  
  List<BuyerProfile> getBuyersByGenre(String genre) {
    return expandedBuyerDatabase.where((b) => b.preferredGenres.contains(genre)).toList();
  }
  
  List<BuyerProfile> getBuyersByType(String type) {
    return expandedBuyerDatabase.where((b) => b.type == type).toList();
  }
  
  List<BuyerProfile> get buyersAcceptingSubmissions {
    return expandedBuyerDatabase.where((b) => b.acceptsUnsolicited).toList();
  }
  
  List<BuyerProfile> get majorStreamers {
    return expandedBuyerDatabase.where((b) => b.type == 'Streamer').toList();
  }
  
  List<BuyerProfile> get majorStudios {
    return expandedBuyerDatabase.where((b) => b.type == 'Major Studio').toList();
  }
  
  List<BuyerProfile> get indieDistributors {
    return expandedBuyerDatabase.where((b) => b.type == 'Indie' || b.type == 'Mini-Major').toList();
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // PRODUCER DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  List<ProducerProfile> get allProducers => expandedProducerDatabase;
  
  List<ProducerProfile> getProducersByGenre(String genre) {
    return expandedProducerDatabase.where((p) => p.specialties.contains(genre)).toList();
  }
  
  List<ProducerProfile> get producersAcceptingSubmissions {
    return expandedProducerDatabase.where((p) => p.acceptsSubmissions).toList();
  }
  
  List<ProducerProfile> getTopProducersForGenre(String genre, {int limit = 10}) {
    final filtered = getProducersByGenre(genre);
    filtered.sort((a, b) => b.baseMatchScore.compareTo(a.baseMatchScore));
    return filtered.take(limit).toList();
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // TITLE DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  List<RecentTitle> get allTitles => expandedTitlesDatabase;
  
  List<RecentTitle> getTitlesByGenre(String genre) {
    return expandedTitlesDatabase.where((t) => t.genre == genre).toList();
  }
  
  List<RecentTitle> getTitlesByYear(int year) {
    return expandedTitlesDatabase.where((t) => t.year == year).toList();
  }
  
  List<RecentTitle> get topBoxOfficeHits {
    final sorted = List<RecentTitle>.from(expandedTitlesDatabase)
      ..sort((a, b) => b.boxOfficeMillions.compareTo(a.boxOfficeMillions));
    return sorted.take(20).toList();
  }
  
  List<RecentTitle> get criticallyAcclaimed {
    return expandedTitlesDatabase.where((t) => t.rtScore >= 90).toList();
  }
  
  List<RecentTitle> get streamingSuccesses {
    return expandedTitlesDatabase.where((t) => t.boxOfficeMillions == 0 && t.rtScore >= 80).toList();
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // AGENCY & MANAGER DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  List<TalentAgency> get allAgencies => talentAgenciesDatabase;
  
  List<TalentAgency> get bigFourAgencies {
    return talentAgenciesDatabase.where((a) => a.type == 'Big Four').toList();
  }
  
  List<LiteraryManager> get allManagers => literaryManagersDatabase;
  
  List<LiteraryManager> get managersAcceptingUnsolicited {
    return literaryManagersDatabase.where((m) => m.acceptsUnsolicited).toList();
  }
  
  List<String> getSubmissionPathwaysForGenre(String genre) {
    return submissionPathwaysByGenre[genre] ?? ['Research managers specializing in your genre'];
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // FESTIVAL DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  List<FilmFestival> get allFestivals => festivalDatabase;
  
  List<FilmFestival> get aListFestivals {
    return festivalDatabase.where((f) => f.tier == 'A-List').toList();
  }
  
  List<FilmFestival> get genreFestivals {
    return festivalDatabase.where((f) => f.tier == 'Genre').toList();
  }
  
  List<FilmFestival> get festivalsWithMarkets {
    return festivalDatabase.where((f) => f.hasMarket).toList();
  }
  
  List<FilmMarket> get allMarkets => marketsDatabase;
  
  List<String> getFestivalStrategyForGoal(String goal) {
    return festivalStrategyByGoal[goal] ?? ['Research festivals aligned with your goals'];
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // INTERNATIONAL MARKET DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  List<InternationalMarket> get allInternationalMarkets => internationalMarketsDatabase;
  
  List<InternationalMarket> getMarketsByRegion(String region) {
    return internationalMarketsDatabase.where((m) => m.region == region).toList();
  }
  
  List<InternationalMarket> get topMarketsBySize {
    final sorted = List<InternationalMarket>.from(internationalMarketsDatabase)
      ..sort((a, b) => b.boxOffice2024Billions.compareTo(a.boxOffice2024Billions));
    return sorted.take(10).toList();
  }
  
  List<InternationalMarket> get fastestGrowingMarkets {
    final sorted = List<InternationalMarket>.from(internationalMarketsDatabase)
      ..sort((a, b) => b.growthRate2024.compareTo(a.growthRate2024));
    return sorted.take(10).toList();
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // COMPETITION DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  List<ScreenplayCompetition> get allCompetitions => competitionsDatabase;
  
  List<ScreenplayCompetition> get eliteCompetitions {
    return competitionsDatabase.where((c) => c.tier == 'Elite').toList();
  }
  
  List<ScreenplayCompetition> get majorCompetitions {
    return competitionsDatabase.where((c) => c.tier == 'Major').toList();
  }
  
  BlackListInfo get blackList => blackListInfo;
  
  List<String> getCompetitionStrategyForStage(String stage) {
    return competitionStrategyByStage[stage] ?? ['Research competitions appropriate for your experience level'];
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // STREAMING PLATFORM DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  List<StreamingPlatform> get allPlatforms => streamingPlatformsDatabase;
  
  List<StreamingPlatform> get platformsBySubscribers {
    final sorted = List<StreamingPlatform>.from(streamingPlatformsDatabase)
      ..sort((a, b) => b.subscribersMillions.compareTo(a.subscribersMillions));
    return sorted;
  }
  
  List<StreamingPlatform> get platformsByContentSpend {
    final sorted = List<StreamingPlatform>.from(streamingPlatformsDatabase)
      ..sort((a, b) => b.annualContentSpendBillions.compareTo(a.annualContentSpendBillions));
    return sorted;
  }
  
  List<String> getPlatformStrategyForGenre(String genre) {
    return platformStrategyByGenre[genre] ?? ['Research platforms that acquire your genre'];
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // GENRE MARKET DATA ACCESS
  // ═══════════════════════════════════════════════════════════════════════════
  
  GenreMarketData? getGenreMarketData(String genre) {
    return genreMarketDatabase[genre];
  }
  
  List<String> get allGenres => genreMarketDatabase.keys.toList();
  
  List<String> get growingGenres {
    return genreMarketDatabase.entries
        .where((e) => e.value.isGrowing)
        .map((e) => e.key)
        .toList();
  }
  
  List<String> get highROIGenres {
    final sorted = genreMarketDatabase.entries.toList()
      ..sort((a, b) => b.value.avgROI.compareTo(a.value.avgROI));
    return sorted.take(5).map((e) => e.key).toList();
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // COMPREHENSIVE ANALYSIS HELPERS
  // ═══════════════════════════════════════════════════════════════════════════
  
  /// Get all relevant industry contacts for a concept
  Map<String, dynamic> getIndustryContactsForConcept({
    required String genre,
    String? secondaryGenre,
    required String format,
    String? budgetTier,
  }) {
    final buyers = getBuyersByGenre(genre);
    final producers = getProducersByGenre(genre);
    final comparables = getTitlesByGenre(genre);
    final agencies = allAgencies;
    final managers = managersAcceptingUnsolicited;
    
    // Filter by format
    List<BuyerProfile> formatBuyers;
    if (format.contains('Series')) {
      formatBuyers = buyers.where((b) => b.type == 'Streamer').toList();
    } else {
      formatBuyers = buyers;
    }
    
    return {
      'buyers': formatBuyers,
      'producers': producers,
      'comparables': comparables,
      'agencies': agencies,
      'managers': managers,
      'festivals': getFestivalStrategyForGoal('Theatrical Acquisition'),
      'competitions': eliteCompetitions,
      'platforms': getPlatformStrategyForGenre(genre),
    };
  }
  
  /// Get submission pathways for unsolicited material
  Map<String, dynamic> getSubmissionPathways(String genre) {
    return {
      'managers_accepting': managersAcceptingUnsolicited.where((m) => m.specialties.contains(genre)).toList(),
      'buyers_accepting': buyersAcceptingSubmissions,
      'producers_accepting': producersAcceptingSubmissions.where((p) => p.specialties.contains(genre)).toList(),
      'competitions': eliteCompetitions + majorCompetitions,
      'black_list': blackListInfo,
      'pathways': getSubmissionPathwaysForGenre(genre),
    };
  }
  
  /// Get market analysis for a concept
  Map<String, dynamic> getMarketAnalysisForGenre(String genre) {
    final genreData = getGenreMarketData(genre);
    final titles = getTitlesByGenre(genre);
    
    return {
      'genre_data': genreData,
      'recent_titles': titles,
      'top_performers': titles.where((t) => t.boxOfficeMillions > 100).toList(),
      'streaming_hits': titles.where((t) => t.boxOfficeMillions == 0 && t.rtScore >= 85).toList(),
      'market_timing': marketTimingAdvice[genre],
      'international_opportunities': topMarketsBySize,
    };
  }
}

/// Global instance for easy access
final industryData = ComprehensiveIndustryData();
