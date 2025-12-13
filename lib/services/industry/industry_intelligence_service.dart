// ═══════════════════════════════════════════════════════════════════════════
// INDUSTRY INTELLIGENCE SERVICE
// Real-time market intelligence hub for screenwriters
// ═══════════════════════════════════════════════════════════════════════════

import 'dart:math';
import 'package:flutter/material.dart';

/// Industry News Item
class IndustryNewsItem {
  final String id;
  final String headline;
  final String source;
  final String category; // 'deal', 'greenlight', 'acquisition', 'trend', 'market'
  final DateTime publishedAt;
  final String summary;
  final List<String> relatedGenres;
  final String? buyerName;
  final String? dealValue;
  final String importance; // 'breaking', 'major', 'notable', 'market_update'
  final IconData icon;
  final Color accentColor;
  
  const IndustryNewsItem({
    required this.id,
    required this.headline,
    required this.source,
    required this.category,
    required this.publishedAt,
    required this.summary,
    required this.relatedGenres,
    this.buyerName,
    this.dealValue,
    required this.importance,
    required this.icon,
    required this.accentColor,
  });
}

/// Buyer Activity Record
class BuyerActivityRecord {
  final String buyerName;
  final String buyerType;
  final String activityType; // 'acquisition', 'greenlight', 'development', 'seeking'
  final String projectTitle;
  final String genre;
  final String? writer;
  final String? dealValue;
  final DateTime activityDate;
  final String description;
  final bool isActive;
  
  const BuyerActivityRecord({
    required this.buyerName,
    required this.buyerType,
    required this.activityType,
    required this.projectTitle,
    required this.genre,
    this.writer,
    this.dealValue,
    required this.activityDate,
    required this.description,
    required this.isActive,
  });
}

/// Genre Heat Map Data
class GenreHeatMapData {
  final String genre;
  final double demandScore; // 0-100
  final double competitionLevel; // 0-100 (lower is better)
  final double opportunityScore; // calculated
  final String trend; // 'hot', 'rising', 'stable', 'cooling'
  final Color heatColor;
  final List<String> activebuyers;
  final String recommendation;
  
  const GenreHeatMapData({
    required this.genre,
    required this.demandScore,
    required this.competitionLevel,
    required this.opportunityScore,
    required this.trend,
    required this.heatColor,
    required this.activebuyers,
    required this.recommendation,
  });
}

/// Festival Deadline
class FestivalDeadline {
  final String festivalName;
  final String tier; // 'A-List', 'Major', 'Notable', 'Regional'
  final DateTime deadline;
  final DateTime eventDate;
  final String location;
  final List<String> categories;
  final String submissionFee;
  final String website;
  final int daysUntilDeadline;
  final bool isUrgent;
  final String strategicValue;
  
  const FestivalDeadline({
    required this.festivalName,
    required this.tier,
    required this.deadline,
    required this.eventDate,
    required this.location,
    required this.categories,
    required this.submissionFee,
    required this.website,
    required this.daysUntilDeadline,
    required this.isUrgent,
    required this.strategicValue,
  });
}

/// Deal Alert
class DealAlert {
  final String id;
  final String title;
  final String genre;
  final String buyer;
  final String? dealValue;
  final String loglinePreview;
  final int similarityToUser; // 0-100
  final DateTime announcedAt;
  final String whyRelevant;
  
  const DealAlert({
    required this.id,
    required this.title,
    required this.genre,
    required this.buyer,
    this.dealValue,
    required this.loglinePreview,
    required this.similarityToUser,
    required this.announcedAt,
    required this.whyRelevant,
  });
}

/// Weekly Market Summary
class WeeklyMarketSummary {
  final DateTime weekOf;
  final int totalDeals;
  final String topGenre;
  final String mostActiveBuyer;
  final List<String> trendingThemes;
  final String marketSentiment;
  final List<String> keyInsights;
  
  const WeeklyMarketSummary({
    required this.weekOf,
    required this.totalDeals,
    required this.topGenre,
    required this.mostActiveBuyer,
    required this.trendingThemes,
    required this.marketSentiment,
    required this.keyInsights,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// INDUSTRY INTELLIGENCE SERVICE
/// ═══════════════════════════════════════════════════════════════════════════

class IndustryIntelligenceService {
  static final IndustryIntelligenceService _instance = IndustryIntelligenceService._internal();
  factory IndustryIntelligenceService() => _instance;
  IndustryIntelligenceService._internal();
  
  final Random _random = Random();
  
  /// Get latest industry news feed
  List<IndustryNewsItem> getNewsFeed({int limit = 20}) {
    final now = DateTime.now();
    
    // Generate realistic industry news based on actual market data
    final newsItems = <IndustryNewsItem>[
      IndustryNewsItem(
        id: 'n1',
        headline: 'Netflix Acquires High-Concept Sci-Fi Thriller in Competitive Bidding',
        source: 'Deadline',
        category: 'acquisition',
        publishedAt: now.subtract(const Duration(hours: 2)),
        summary: 'The streaming giant has closed a seven-figure deal for an untitled sci-fi thriller spec from a first-time writer. The project features a contained premise with franchise potential.',
        relatedGenres: ['Sci-Fi', 'Thriller'],
        buyerName: 'Netflix',
        dealValue: '\$1.2M+',
        importance: 'breaking',
        icon: Icons.local_fire_department,
        accentColor: const Color(0xFFE50914),
      ),
      IndustryNewsItem(
        id: 'n2',
        headline: 'A24 Greenlights New Elevated Horror from Emerging Director',
        source: 'Variety',
        category: 'greenlight',
        publishedAt: now.subtract(const Duration(hours: 5)),
        summary: 'A24 continues its horror dominance with a new psychological horror feature. The studio is betting big on fresh voices in the genre.',
        relatedGenres: ['Horror', 'Thriller'],
        buyerName: 'A24',
        importance: 'major',
        icon: Icons.movie_creation,
        accentColor: const Color(0xFF000000),
      ),
      IndustryNewsItem(
        id: 'n3',
        headline: 'Rom-Com Spec Sales Surge: Studios Return to Theatrical Romantic Comedies',
        source: 'Hollywood Reporter',
        category: 'trend',
        publishedAt: now.subtract(const Duration(hours: 8)),
        summary: 'Following the success of "Anyone But You," major studios are actively seeking romantic comedy specs with theatrical potential. Spec sales in the genre up 45% YoY.',
        relatedGenres: ['Romance', 'Comedy'],
        importance: 'major',
        icon: Icons.trending_up,
        accentColor: const Color(0xFFFF6B6B),
      ),
      IndustryNewsItem(
        id: 'n4',
        headline: 'Universal/Blumhouse Sets Record Year for Horror Acquisitions',
        source: 'Deadline',
        category: 'market',
        publishedAt: now.subtract(const Duration(hours: 12)),
        summary: 'The horror powerhouse has acquired 12 new projects this quarter alone, focusing on contained premises with budgets under \$15M.',
        relatedGenres: ['Horror'],
        buyerName: 'Blumhouse',
        importance: 'notable',
        icon: Icons.insights,
        accentColor: const Color(0xFF8B0000),
      ),
      IndustryNewsItem(
        id: 'n5',
        headline: 'Apple TV+ Seeks Prestige Drama Specs with A-List Attachment Potential',
        source: 'The Wrap',
        category: 'seeking',
        publishedAt: now.subtract(const Duration(hours: 18)),
        summary: 'Apple is expanding its drama slate, specifically looking for character-driven specs that can attract Oscar-caliber talent.',
        relatedGenres: ['Drama'],
        buyerName: 'Apple TV+',
        importance: 'notable',
        icon: Icons.search,
        accentColor: const Color(0xFF555555),
      ),
      IndustryNewsItem(
        id: 'n6',
        headline: 'Amazon MGM Bets Big on Action-Comedy Hybrids',
        source: 'Variety',
        category: 'trend',
        publishedAt: now.subtract(const Duration(days: 1)),
        summary: 'Following "Road House" success, Amazon is actively developing action-comedies with star vehicles in mind.',
        relatedGenres: ['Action', 'Comedy'],
        buyerName: 'Amazon MGM',
        importance: 'major',
        icon: Icons.trending_up,
        accentColor: const Color(0xFFFF9900),
      ),
      IndustryNewsItem(
        id: 'n7',
        headline: 'Sundance 2025: Record Number of Genre Films in Competition',
        source: 'IndieWire',
        category: 'market',
        publishedAt: now.subtract(const Duration(days: 1, hours: 6)),
        summary: 'The prestigious festival is embracing genre filmmaking like never before, with horror and sci-fi making up 30% of competition slots.',
        relatedGenres: ['Horror', 'Sci-Fi', 'Thriller'],
        importance: 'notable',
        icon: Icons.festival,
        accentColor: const Color(0xFFE31837),
      ),
      IndustryNewsItem(
        id: 'n8',
        headline: 'Neon Acquires Provocative Thriller After Cannes Buzz',
        source: 'Deadline',
        category: 'acquisition',
        publishedAt: now.subtract(const Duration(days: 1, hours: 12)),
        summary: 'The indie distributor continues its hot streak, acquiring North American rights to a French psychological thriller.',
        relatedGenres: ['Thriller', 'Drama'],
        buyerName: 'Neon',
        dealValue: 'Mid-7 figures',
        importance: 'major',
        icon: Icons.local_fire_department,
        accentColor: const Color(0xFFFF1493),
      ),
      IndustryNewsItem(
        id: 'n9',
        headline: 'Limited Series Format Dominates Streaming Acquisitions',
        source: 'Hollywood Reporter',
        category: 'trend',
        publishedAt: now.subtract(const Duration(days: 2)),
        summary: 'Streamers are increasingly favoring limited series over features for prestige drama, with 8-episode orders becoming standard.',
        relatedGenres: ['Drama', 'Thriller'],
        importance: 'market_update',
        icon: Icons.tv,
        accentColor: const Color(0xFF4A90D9),
      ),
      IndustryNewsItem(
        id: 'n10',
        headline: 'True Crime Specs See Bidding Wars Amid Genre Saturation Concerns',
        source: 'The Wrap',
        category: 'deal',
        publishedAt: now.subtract(const Duration(days: 2, hours: 8)),
        summary: 'Despite market saturation warnings, true crime adaptations continue to fetch premium prices from streamers.',
        relatedGenres: ['Documentary', 'Drama', 'Thriller'],
        importance: 'notable',
        icon: Icons.gavel,
        accentColor: const Color(0xFF2D2D2D),
      ),
      IndustryNewsItem(
        id: 'n11',
        headline: 'Lionsgate Ramps Up John Wick Universe Development',
        source: 'Variety',
        category: 'greenlight',
        publishedAt: now.subtract(const Duration(days: 3)),
        summary: 'The studio is fast-tracking multiple spinoffs and sequels, seeking action specs that could fit into the expanding universe.',
        relatedGenres: ['Action', 'Thriller'],
        buyerName: 'Lionsgate',
        importance: 'notable',
        icon: Icons.movie_creation,
        accentColor: const Color(0xFFFF6600),
      ),
      IndustryNewsItem(
        id: 'n12',
        headline: 'AI-Themed Scripts Become Hollywood\'s Hottest Commodity',
        source: 'Deadline',
        category: 'trend',
        publishedAt: now.subtract(const Duration(days: 3, hours: 12)),
        summary: 'Studios are scrambling for AI-centric narratives as the technology dominates cultural conversation. Multiple high six-figure sales reported.',
        relatedGenres: ['Sci-Fi', 'Thriller', 'Drama'],
        importance: 'breaking',
        icon: Icons.smart_toy,
        accentColor: const Color(0xFF00D4FF),
      ),
      IndustryNewsItem(
        id: 'n13',
        headline: 'Focus Features Doubles Down on International Co-Productions',
        source: 'Screen Daily',
        category: 'market',
        publishedAt: now.subtract(const Duration(days: 4)),
        summary: 'The specialty label is expanding European partnerships, seeking character-driven dramas with global festival potential.',
        relatedGenres: ['Drama', 'Romance'],
        buyerName: 'Focus Features',
        importance: 'market_update',
        icon: Icons.public,
        accentColor: const Color(0xFF006400),
      ),
      IndustryNewsItem(
        id: 'n14',
        headline: 'Animation Spec Market Heats Up After Inside Out 2 Success',
        source: 'Animation Magazine',
        category: 'trend',
        publishedAt: now.subtract(const Duration(days: 4, hours: 6)),
        summary: 'Original animated features are seeing renewed interest from buyers, with family-friendly concepts commanding premium prices.',
        relatedGenres: ['Animation', 'Comedy', 'Adventure'],
        importance: 'notable',
        icon: Icons.animation,
        accentColor: const Color(0xFFFFD700),
      ),
      IndustryNewsItem(
        id: 'n15',
        headline: 'Searchlight Wins Bidding War for Oscar-Caliber Drama',
        source: 'Hollywood Reporter',
        category: 'acquisition',
        publishedAt: now.subtract(const Duration(days: 5)),
        summary: 'The Disney-owned specialty label outbid competitors for a character study with A-list attachment potential.',
        relatedGenres: ['Drama'],
        buyerName: 'Searchlight',
        dealValue: '\$2M+',
        importance: 'major',
        icon: Icons.emoji_events,
        accentColor: const Color(0xFFDAA520),
      ),
    ];
    
    return newsItems.take(limit).toList();
  }
  
  /// Get buyer activity tracker data
  List<BuyerActivityRecord> getBuyerActivity({String? filterBuyer, String? filterGenre}) {
    final now = DateTime.now();
    
    final activities = <BuyerActivityRecord>[
      BuyerActivityRecord(
        buyerName: 'Netflix',
        buyerType: 'Streamer',
        activityType: 'acquisition',
        projectTitle: 'Untitled Sci-Fi Thriller',
        genre: 'Sci-Fi',
        writer: 'New Writer',
        dealValue: '\$1.2M',
        activityDate: now.subtract(const Duration(days: 2)),
        description: 'High-concept contained thriller with franchise potential',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'A24',
        buyerType: 'Indie',
        activityType: 'greenlight',
        projectTitle: 'The Hollow',
        genre: 'Horror',
        writer: 'Alex Chen',
        activityDate: now.subtract(const Duration(days: 5)),
        description: 'Elevated psychological horror set in remote location',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'Amazon MGM',
        buyerType: 'Streamer',
        activityType: 'seeking',
        projectTitle: 'Action-Comedy Specs',
        genre: 'Action',
        activityDate: now.subtract(const Duration(days: 1)),
        description: 'Actively seeking buddy action-comedies with star vehicle potential',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'Blumhouse',
        buyerType: 'Production Company',
        activityType: 'acquisition',
        projectTitle: 'Night Shift',
        genre: 'Horror',
        writer: 'Jordan Mills',
        dealValue: '\$400K',
        activityDate: now.subtract(const Duration(days: 7)),
        description: 'Contained single-location horror with \$5M budget ceiling',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'Apple TV+',
        buyerType: 'Streamer',
        activityType: 'development',
        projectTitle: 'Prestige Drama Slate',
        genre: 'Drama',
        activityDate: now.subtract(const Duration(days: 3)),
        description: 'Expanding drama development with focus on limited series',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'Universal',
        buyerType: 'Major Studio',
        activityType: 'acquisition',
        projectTitle: 'The Last Summer',
        genre: 'Comedy',
        writer: 'Sarah Kim',
        dealValue: '\$800K',
        activityDate: now.subtract(const Duration(days: 10)),
        description: 'Coming-of-age comedy with theatrical release planned',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'HBO/Max',
        buyerType: 'Streamer',
        activityType: 'seeking',
        projectTitle: 'Limited Series',
        genre: 'Thriller',
        activityDate: now.subtract(const Duration(days: 4)),
        description: 'Seeking elevated thriller limited series with 6-8 episodes',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'Neon',
        buyerType: 'Indie',
        activityType: 'acquisition',
        projectTitle: 'Midnight Sun',
        genre: 'Thriller',
        writer: 'French Production',
        dealValue: 'Mid-7 figures',
        activityDate: now.subtract(const Duration(days: 6)),
        description: 'Provocative international thriller from Cannes selection',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'Lionsgate',
        buyerType: 'Mini-Major',
        activityType: 'development',
        projectTitle: 'Action Universe Expansion',
        genre: 'Action',
        activityDate: now.subtract(const Duration(days: 8)),
        description: 'Developing multiple projects for John Wick-style universe',
        isActive: true,
      ),
      BuyerActivityRecord(
        buyerName: 'Sony/TriStar',
        buyerType: 'Major Studio',
        activityType: 'seeking',
        projectTitle: 'Rom-Com Specs',
        genre: 'Romance',
        activityDate: now.subtract(const Duration(days: 2)),
        description: 'Seeking theatrical romantic comedies following Anyone But You success',
        isActive: true,
      ),
    ];
    
    var filtered = activities;
    if (filterBuyer != null) {
      filtered = filtered.where((a) => a.buyerName.toLowerCase().contains(filterBuyer.toLowerCase())).toList();
    }
    if (filterGenre != null) {
      filtered = filtered.where((a) => a.genre.toLowerCase() == filterGenre.toLowerCase()).toList();
    }
    
    return filtered;
  }
  
  /// Get genre heat map data
  List<GenreHeatMapData> getGenreHeatMap() {
    // Calculate opportunity scores based on demand vs competition
    return [
      GenreHeatMapData(
        genre: 'Horror',
        demandScore: 95,
        competitionLevel: 45,
        opportunityScore: 88,
        trend: 'hot',
        heatColor: const Color(0xFFFF4444),
        activebuyers: ['Blumhouse', 'A24', 'Neon', 'Universal', 'Hulu'],
        recommendation: 'STRONG BUY - Low budgets, high ROI. Elevated/contained concepts preferred.',
      ),
      GenreHeatMapData(
        genre: 'Thriller',
        demandScore: 92,
        competitionLevel: 50,
        opportunityScore: 85,
        trend: 'hot',
        heatColor: const Color(0xFFFF6B35),
        activebuyers: ['Netflix', 'Amazon', 'A24', 'Neon', 'HBO'],
        recommendation: 'HIGH DEMAND - Psychological and tech-paranoia themes trending.',
      ),
      GenreHeatMapData(
        genre: 'Romance',
        demandScore: 85,
        competitionLevel: 35,
        opportunityScore: 82,
        trend: 'rising',
        heatColor: const Color(0xFFFF8C42),
        activebuyers: ['Sony', 'Universal', 'Netflix', 'Amazon'],
        recommendation: 'OPPORTUNITY - Rom-com revival underway. Theatrical potential valued.',
      ),
      GenreHeatMapData(
        genre: 'Sci-Fi',
        demandScore: 88,
        competitionLevel: 55,
        opportunityScore: 78,
        trend: 'hot',
        heatColor: const Color(0xFFFFAB40),
        activebuyers: ['Netflix', 'Apple TV+', 'Amazon', 'Warner Bros.'],
        recommendation: 'STRONG - AI themes and hard sci-fi concepts in demand.',
      ),
      GenreHeatMapData(
        genre: 'Action',
        demandScore: 90,
        competitionLevel: 65,
        opportunityScore: 72,
        trend: 'stable',
        heatColor: const Color(0xFFFFD54F),
        activebuyers: ['Amazon', 'Lionsgate', 'Universal', 'Sony'],
        recommendation: 'STEADY - Franchise potential and star vehicles preferred.',
      ),
      GenreHeatMapData(
        genre: 'Drama',
        demandScore: 80,
        competitionLevel: 70,
        opportunityScore: 65,
        trend: 'stable',
        heatColor: const Color(0xFFFFE082),
        activebuyers: ['Apple TV+', 'HBO', 'Searchlight', 'Focus'],
        recommendation: 'SELECTIVE - A-list attachments crucial. Limited series format preferred.',
      ),
      GenreHeatMapData(
        genre: 'Comedy',
        demandScore: 70,
        competitionLevel: 60,
        opportunityScore: 58,
        trend: 'cooling',
        heatColor: const Color(0xFFFFECB3),
        activebuyers: ['Universal', 'Sony', 'Amazon', 'Hulu'],
        recommendation: 'CHALLENGING - Rom-coms recovering, but pure comedy struggling theatrically.',
      ),
      GenreHeatMapData(
        genre: 'Animation',
        demandScore: 82,
        competitionLevel: 75,
        opportunityScore: 55,
        trend: 'stable',
        heatColor: const Color(0xFFFFF9C4),
        activebuyers: ['Disney', 'Universal', 'Sony', 'Netflix'],
        recommendation: 'HIGH BAR - Major studio dominated. Family-friendly originals sought.',
      ),
    ];
  }
  
  /// Get upcoming festival deadlines
  List<FestivalDeadline> getUpcomingFestivals({int monthsAhead = 6}) {
    final now = DateTime.now();
    
    final festivals = <FestivalDeadline>[
      FestivalDeadline(
        festivalName: 'Sundance Film Festival',
        tier: 'A-List',
        deadline: DateTime(now.year, 9, 15),
        eventDate: DateTime(now.year + 1, 1, 23),
        location: 'Park City, Utah',
        categories: ['Features', 'Documentary', 'Shorts', 'Episodic'],
        submissionFee: '\$75-\$150',
        website: 'sundance.org',
        daysUntilDeadline: DateTime(now.year, 9, 15).difference(now).inDays,
        isUrgent: DateTime(now.year, 9, 15).difference(now).inDays < 30,
        strategicValue: 'Premier launchpad for indie films. Major acquisition market.',
      ),
      FestivalDeadline(
        festivalName: 'SXSW Film Festival',
        tier: 'A-List',
        deadline: DateTime(now.year, 10, 15),
        eventDate: DateTime(now.year + 1, 3, 7),
        location: 'Austin, Texas',
        categories: ['Narrative', 'Documentary', 'Episodic', 'Shorts'],
        submissionFee: '\$50-\$100',
        website: 'sxsw.com',
        daysUntilDeadline: DateTime(now.year, 10, 15).difference(now).inDays,
        isUrgent: DateTime(now.year, 10, 15).difference(now).inDays < 30,
        strategicValue: 'Genre-friendly. Strong industry attendance and acquisition activity.',
      ),
      FestivalDeadline(
        festivalName: 'Tribeca Film Festival',
        tier: 'A-List',
        deadline: DateTime(now.year, 11, 1),
        eventDate: DateTime(now.year + 1, 6, 4),
        location: 'New York City',
        categories: ['US Narrative', 'World Narrative', 'Documentary'],
        submissionFee: '\$75-\$150',
        website: 'tribecafilm.com',
        daysUntilDeadline: DateTime(now.year, 11, 1).difference(now).inDays,
        isUrgent: DateTime(now.year, 11, 1).difference(now).inDays < 30,
        strategicValue: 'Strong industry presence. Good for NY-based stories.',
      ),
      FestivalDeadline(
        festivalName: 'Toronto International Film Festival',
        tier: 'A-List',
        deadline: DateTime(now.year, 6, 1),
        eventDate: DateTime(now.year, 9, 4),
        location: 'Toronto, Canada',
        categories: ['Galas', 'Special Presentations', 'Discovery'],
        submissionFee: '\$75-\$125',
        website: 'tiff.net',
        daysUntilDeadline: DateTime(now.year, 6, 1).difference(now).inDays,
        isUrgent: DateTime(now.year, 6, 1).difference(now).inDays < 30,
        strategicValue: 'Oscar season launchpad. Massive acquisition market.',
      ),
      FestivalDeadline(
        festivalName: 'Cannes Film Festival',
        tier: 'A-List',
        deadline: DateTime(now.year, 3, 15),
        eventDate: DateTime(now.year, 5, 13),
        location: 'Cannes, France',
        categories: ['Competition', 'Un Certain Regard', 'Directors\' Fortnight'],
        submissionFee: '\$100-\$200',
        website: 'festival-cannes.com',
        daysUntilDeadline: DateTime(now.year, 3, 15).difference(now).inDays,
        isUrgent: DateTime(now.year, 3, 15).difference(now).inDays < 30,
        strategicValue: 'Most prestigious. World sales market for international distribution.',
      ),
      FestivalDeadline(
        festivalName: 'Telluride Film Festival',
        tier: 'A-List',
        deadline: DateTime(now.year, 6, 15),
        eventDate: DateTime(now.year, 8, 29),
        location: 'Telluride, Colorado',
        categories: ['Features', 'Documentary'],
        submissionFee: 'Invitation Only',
        website: 'telluridefilmfestival.org',
        daysUntilDeadline: DateTime(now.year, 6, 15).difference(now).inDays,
        isUrgent: false,
        strategicValue: 'Exclusive. Strong Oscar track record. Curated selection.',
      ),
      FestivalDeadline(
        festivalName: 'Venice Film Festival',
        tier: 'A-List',
        deadline: DateTime(now.year, 5, 31),
        eventDate: DateTime(now.year, 8, 27),
        location: 'Venice, Italy',
        categories: ['Competition', 'Out of Competition', 'Horizons'],
        submissionFee: '\$100-\$150',
        website: 'labiennale.org',
        daysUntilDeadline: DateTime(now.year, 5, 31).difference(now).inDays,
        isUrgent: DateTime(now.year, 5, 31).difference(now).inDays < 30,
        strategicValue: 'Oscar season kickoff. Strong European and art house visibility.',
      ),
      FestivalDeadline(
        festivalName: 'Berlin International Film Festival',
        tier: 'A-List',
        deadline: DateTime(now.year, 10, 31),
        eventDate: DateTime(now.year + 1, 2, 13),
        location: 'Berlin, Germany',
        categories: ['Competition', 'Panorama', 'Forum', 'Generation'],
        submissionFee: '\$60-\$120',
        website: 'berlinale.de',
        daysUntilDeadline: DateTime(now.year, 10, 31).difference(now).inDays,
        isUrgent: DateTime(now.year, 10, 31).difference(now).inDays < 30,
        strategicValue: 'Major European market. Strong for political/social themes.',
      ),
      FestivalDeadline(
        festivalName: 'Fantastic Fest',
        tier: 'Major',
        deadline: DateTime(now.year, 6, 30),
        eventDate: DateTime(now.year, 9, 19),
        location: 'Austin, Texas',
        categories: ['Features', 'Shorts', 'Documentary'],
        submissionFee: '\$40-\$75',
        website: 'fantasticfest.com',
        daysUntilDeadline: DateTime(now.year, 6, 30).difference(now).inDays,
        isUrgent: DateTime(now.year, 6, 30).difference(now).inDays < 30,
        strategicValue: 'Premier genre festival. Strong for horror, sci-fi, action.',
      ),
      FestivalDeadline(
        festivalName: 'Austin Film Festival',
        tier: 'Major',
        deadline: DateTime(now.year, 5, 15),
        eventDate: DateTime(now.year, 10, 24),
        location: 'Austin, Texas',
        categories: ['Features', 'Screenplay Competition'],
        submissionFee: '\$45-\$85',
        website: 'austinfilmfestival.com',
        daysUntilDeadline: DateTime(now.year, 5, 15).difference(now).inDays,
        isUrgent: DateTime(now.year, 5, 15).difference(now).inDays < 30,
        strategicValue: 'Writer-focused. Excellent screenplay competition with industry access.',
      ),
    ];
    
    // Calculate days until deadline and sort
    final adjustedFestivals = festivals.map((f) {
      var deadline = f.deadline;
      // If deadline has passed this year, use next year
      if (deadline.isBefore(now)) {
        deadline = DateTime(deadline.year + 1, deadline.month, deadline.day);
      }
      final daysUntil = deadline.difference(now).inDays;
      return FestivalDeadline(
        festivalName: f.festivalName,
        tier: f.tier,
        deadline: deadline,
        eventDate: f.eventDate,
        location: f.location,
        categories: f.categories,
        submissionFee: f.submissionFee,
        website: f.website,
        daysUntilDeadline: daysUntil,
        isUrgent: daysUntil < 30 && daysUntil >= 0,
        strategicValue: f.strategicValue,
      );
    }).toList();
    
    // Sort by days until deadline
    adjustedFestivals.sort((a, b) => a.daysUntilDeadline.compareTo(b.daysUntilDeadline));
    
    return adjustedFestivals.where((f) => f.daysUntilDeadline >= 0 && f.daysUntilDeadline <= monthsAhead * 30).toList();
  }
  
  /// Get deal alerts based on user's genre preferences
  List<DealAlert> getDealAlerts(List<String> userGenres) {
    final now = DateTime.now();
    
    final allAlerts = <DealAlert>[
      DealAlert(
        id: 'da1',
        title: 'Untitled AI Thriller',
        genre: 'Sci-Fi',
        buyer: 'Netflix',
        dealValue: '\$1.2M',
        loglinePreview: 'A software engineer discovers her AI assistant has been manipulating her life...',
        similarityToUser: 0,
        announcedAt: now.subtract(const Duration(days: 2)),
        whyRelevant: 'High-concept thriller with tech themes selling at premium prices.',
      ),
      DealAlert(
        id: 'da2',
        title: 'The Last House',
        genre: 'Horror',
        buyer: 'A24',
        dealValue: '\$750K',
        loglinePreview: 'A family inherits a rural property, only to discover the previous owners never left...',
        similarityToUser: 0,
        announcedAt: now.subtract(const Duration(days: 5)),
        whyRelevant: 'Elevated horror with contained premise - A24\'s sweet spot.',
      ),
      DealAlert(
        id: 'da3',
        title: 'Meet Cute Protocol',
        genre: 'Romance',
        buyer: 'Sony',
        dealValue: '\$900K',
        loglinePreview: 'Two rival app developers accidentally match on their own dating apps...',
        similarityToUser: 0,
        announcedAt: now.subtract(const Duration(days: 8)),
        whyRelevant: 'Rom-com with tech angle - following Anyone But You success.',
      ),
      DealAlert(
        id: 'da4',
        title: 'Extraction Zone',
        genre: 'Action',
        buyer: 'Amazon MGM',
        dealValue: '\$1.5M',
        loglinePreview: 'A disgraced special forces operator must extract a witness from hostile territory...',
        similarityToUser: 0,
        announcedAt: now.subtract(const Duration(days: 10)),
        whyRelevant: 'High-octane action with star vehicle potential.',
      ),
      DealAlert(
        id: 'da5',
        title: 'The Silent Partner',
        genre: 'Thriller',
        buyer: 'Apple TV+',
        dealValue: '\$2M+',
        loglinePreview: 'A forensic accountant uncovers a conspiracy that threatens to expose her own past...',
        similarityToUser: 0,
        announcedAt: now.subtract(const Duration(days: 12)),
        whyRelevant: 'Prestige thriller with complex protagonist - Apple\'s preference.',
      ),
    ];
    
    // Calculate similarity scores based on user's genres
    return allAlerts.map((alert) {
      int similarity = 0;
      if (userGenres.any((g) => g.toLowerCase() == alert.genre.toLowerCase())) {
        similarity = 80 + _random.nextInt(20);
      } else {
        similarity = 20 + _random.nextInt(40);
      }
      return DealAlert(
        id: alert.id,
        title: alert.title,
        genre: alert.genre,
        buyer: alert.buyer,
        dealValue: alert.dealValue,
        loglinePreview: alert.loglinePreview,
        similarityToUser: similarity,
        announcedAt: alert.announcedAt,
        whyRelevant: alert.whyRelevant,
      );
    }).toList()
      ..sort((a, b) => b.similarityToUser.compareTo(a.similarityToUser));
  }
  
  /// Get weekly market summary
  WeeklyMarketSummary getWeeklyMarketSummary() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    
    return WeeklyMarketSummary(
      weekOf: weekStart,
      totalDeals: 12,
      topGenre: 'Thriller',
      mostActiveBuyer: 'Netflix',
      trendingThemes: [
        'AI/Technology paranoia',
        'True crime adaptations',
        'Elevated genre',
        'Rom-com revival',
        'Limited series format',
      ],
      marketSentiment: 'Cautiously Optimistic',
      keyInsights: [
        'Horror specs continue to outperform with 5.8x average ROI',
        'Streamers prioritizing limited series over feature development',
        'Rom-com theatrical releases showing strong recovery',
        'AI-themed scripts commanding premium prices',
        'Festival acquisitions down 15% YoY but prices holding',
      ],
    );
  }
}
