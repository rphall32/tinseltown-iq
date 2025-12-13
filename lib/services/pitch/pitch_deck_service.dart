/// ═══════════════════════════════════════════════════════════════════════════
/// PITCH DECK GENERATOR SERVICE
/// Generate professional pitch materials from concept analysis
/// ═══════════════════════════════════════════════════════════════════════════

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// One-Page Pitch Document
class OnePagerPitch {
  final String title;
  final String logline;
  final String genre;
  final String format;
  final String tone;
  final String targetAudience;
  final String synopsis;
  final List<String> comparableWorks;
  final int greenlightScore;
  final String marketPosition;
  final List<String> uniqueSellingPoints;
  final String writerBio;
  final String contactInfo;
  final DateTime generatedAt;
  
  const OnePagerPitch({
    required this.title,
    required this.logline,
    required this.genre,
    required this.format,
    required this.tone,
    required this.targetAudience,
    required this.synopsis,
    required this.comparableWorks,
    required this.greenlightScore,
    required this.marketPosition,
    required this.uniqueSellingPoints,
    required this.writerBio,
    required this.contactInfo,
    required this.generatedAt,
  });
}

/// Query Letter
class QueryLetter {
  final String recipientName;
  final String recipientCompany;
  final String recipientTitle;
  final String subject;
  final String opening;
  final String loglineParagraph;
  final String synopsisParagraph;
  final String marketParagraph;
  final String credentialsParagraph;
  final String closing;
  final String signature;
  final QueryLetterTemplate template;
  final DateTime generatedAt;
  
  const QueryLetter({
    required this.recipientName,
    required this.recipientCompany,
    required this.recipientTitle,
    required this.subject,
    required this.opening,
    required this.loglineParagraph,
    required this.synopsisParagraph,
    required this.marketParagraph,
    required this.credentialsParagraph,
    required this.closing,
    required this.signature,
    required this.template,
    required this.generatedAt,
  });
  
  /// Generate full letter text
  String toPlainText() {
    final buffer = StringBuffer();
    buffer.writeln('To: $recipientName');
    buffer.writeln('$recipientTitle, $recipientCompany');
    buffer.writeln();
    buffer.writeln('Subject: $subject');
    buffer.writeln();
    buffer.writeln(opening);
    buffer.writeln();
    buffer.writeln(loglineParagraph);
    buffer.writeln();
    buffer.writeln(synopsisParagraph);
    buffer.writeln();
    buffer.writeln(marketParagraph);
    buffer.writeln();
    buffer.writeln(credentialsParagraph);
    buffer.writeln();
    buffer.writeln(closing);
    buffer.writeln();
    buffer.writeln(signature);
    return buffer.toString();
  }
}

/// Query Letter Templates
enum QueryLetterTemplate {
  professional,
  conversational,
  genre,
  festival,
  referral,
}

/// Buyer-Specific Pitch
class BuyerSpecificPitch {
  final String buyerName;
  final String buyerType;
  final String customizedLogline;
  final String whyThisBuyer;
  final List<String> alignmentPoints;
  final List<String> recentSuccesses;
  final String submissionStrategy;
  final String pitchAngle;
  final int matchScore;
  final DateTime generatedAt;
  
  const BuyerSpecificPitch({
    required this.buyerName,
    required this.buyerType,
    required this.customizedLogline,
    required this.whyThisBuyer,
    required this.alignmentPoints,
    required this.recentSuccesses,
    required this.submissionStrategy,
    required this.pitchAngle,
    required this.matchScore,
    required this.generatedAt,
  });
}

/// Comparable Works Lookbook Entry
class ComparableLookbookEntry {
  final String title;
  final int year;
  final String platform;
  final double boxOfficeMillions;
  final int rtScore;
  final String relevance;
  final String posterDescription;
  
  const ComparableLookbookEntry({
    required this.title,
    required this.year,
    required this.platform,
    required this.boxOfficeMillions,
    required this.rtScore,
    required this.relevance,
    required this.posterDescription,
  });
}

/// Full Pitch Package
class PitchPackage {
  final OnePagerPitch onePager;
  final QueryLetter queryLetter;
  final List<BuyerSpecificPitch> buyerPitches;
  final List<ComparableLookbookEntry> lookbook;
  final String elevatorPitch;
  final String twitterPitch;
  final DateTime generatedAt;
  
  const PitchPackage({
    required this.onePager,
    required this.queryLetter,
    required this.buyerPitches,
    required this.lookbook,
    required this.elevatorPitch,
    required this.twitterPitch,
    required this.generatedAt,
  });
}

/// ═══════════════════════════════════════════════════════════════════════════
/// PITCH DECK GENERATOR SERVICE
/// ═══════════════════════════════════════════════════════════════════════════

class PitchDeckService {
  static final PitchDeckService _instance = PitchDeckService._internal();
  factory PitchDeckService() => _instance;
  PitchDeckService._internal();
  
  /// Generate a One-Page Pitch document
  OnePagerPitch generateOnePager({
    required String title,
    required String logline,
    required String genre,
    required String format,
    required String? tone,
    required String? targetAudience,
    required String synopsis,
    required List<String> comparables,
    required int greenlightScore,
    required List<Map<String, dynamic>> marketInsights,
    required List<String> strengths,
    String? writerBio,
    String? contactInfo,
  }) {
    // Generate market position statement
    String marketPosition = _generateMarketPosition(genre, greenlightScore, marketInsights);
    
    // Generate unique selling points from analysis strengths
    List<String> usps = _generateUSPs(strengths, logline, genre);
    
    return OnePagerPitch(
      title: title.isNotEmpty ? title : 'Untitled Project',
      logline: logline,
      genre: genre,
      format: format,
      tone: tone ?? _inferTone(genre, logline),
      targetAudience: targetAudience ?? _inferAudience(genre, format),
      synopsis: synopsis,
      comparableWorks: comparables,
      greenlightScore: greenlightScore,
      marketPosition: marketPosition,
      uniqueSellingPoints: usps,
      writerBio: writerBio ?? '',
      contactInfo: contactInfo ?? '',
      generatedAt: DateTime.now(),
    );
  }
  
  /// Generate a Query Letter
  QueryLetter generateQueryLetter({
    required String projectTitle,
    required String logline,
    required String synopsis,
    required String genre,
    required String format,
    required int greenlightScore,
    required List<String> comparables,
    required String recipientName,
    required String recipientCompany,
    required String recipientTitle,
    String? writerBio,
    String? writerCredentials,
    QueryLetterTemplate template = QueryLetterTemplate.professional,
  }) {
    final opening = _generateOpening(template, recipientName, recipientCompany, genre);
    final loglinePara = _generateLoglineParagraph(projectTitle, logline, format, genre);
    final synopsisPara = _generateSynopsisParagraph(synopsis);
    final marketPara = _generateMarketParagraph(genre, comparables, greenlightScore);
    final credentialsPara = _generateCredentialsParagraph(writerBio, writerCredentials);
    final closing = _generateClosing(template, projectTitle);
    final signature = writerBio?.split(' ').take(2).join(' ') ?? 'Writer';
    
    return QueryLetter(
      recipientName: recipientName,
      recipientCompany: recipientCompany,
      recipientTitle: recipientTitle,
      subject: '$format Query: $projectTitle - $genre',
      opening: opening,
      loglineParagraph: loglinePara,
      synopsisParagraph: synopsisPara,
      marketParagraph: marketPara,
      credentialsParagraph: credentialsPara,
      closing: closing,
      signature: signature,
      template: template,
      generatedAt: DateTime.now(),
    );
  }
  
  /// Generate Buyer-Specific Pitch
  BuyerSpecificPitch generateBuyerPitch({
    required String buyerName,
    required String buyerType,
    required String logline,
    required String genre,
    required String format,
    required int matchScore,
    required List<String> buyerPreferences,
    required List<String> recentAcquisitions,
    required String contentStrategy,
  }) {
    // Customize logline for specific buyer
    String customizedLogline = _customizeLoglineForBuyer(logline, buyerName, buyerType, buyerPreferences);
    
    // Generate why this buyer
    String whyThisBuyer = _generateWhyThisBuyer(buyerName, buyerType, genre, contentStrategy);
    
    // Generate alignment points
    List<String> alignmentPoints = _generateAlignmentPoints(genre, buyerPreferences, contentStrategy);
    
    // Generate submission strategy
    String submissionStrategy = _generateSubmissionStrategy(buyerName, buyerType);
    
    // Generate pitch angle
    String pitchAngle = _generatePitchAngle(buyerName, buyerType, genre, format);
    
    return BuyerSpecificPitch(
      buyerName: buyerName,
      buyerType: buyerType,
      customizedLogline: customizedLogline,
      whyThisBuyer: whyThisBuyer,
      alignmentPoints: alignmentPoints,
      recentSuccesses: recentAcquisitions.take(3).toList(),
      submissionStrategy: submissionStrategy,
      pitchAngle: pitchAngle,
      matchScore: matchScore,
      generatedAt: DateTime.now(),
    );
  }
  
  /// Generate Elevator Pitch (30 seconds)
  String generateElevatorPitch({
    required String title,
    required String logline,
    required String genre,
    required List<String> comparables,
    required int greenlightScore,
  }) {
    final compString = comparables.take(2).join(' meets ');
    
    return '''
It's $compString. 

$logline

This $genre project has been analyzed and scored $greenlightScore/100 on market viability. It's designed for the current market appetite for elevated $genre content.
'''.trim();
  }
  
  /// Generate Twitter/X Pitch (280 characters)
  String generateTwitterPitch({
    required String title,
    required String logline,
    required String genre,
  }) {
    // Condense logline to fit Twitter limit
    String shortLogline = logline;
    if (logline.length > 200) {
      shortLogline = '${logline.substring(0, 197)}...';
    }
    
    final hashtags = '#${genre.replaceAll(' ', '')} #Screenplay';
    final available = 280 - hashtags.length - title.length - 10;
    
    if (shortLogline.length > available) {
      shortLogline = '${shortLogline.substring(0, available - 3)}...';
    }
    
    return '$title: $shortLogline $hashtags';
  }
  
  /// Generate Complete Pitch Package
  PitchPackage generateFullPackage({
    required String title,
    required String logline,
    required String synopsis,
    required String genre,
    required String format,
    required String? tone,
    required String? targetAudience,
    required int greenlightScore,
    required List<String> comparables,
    required List<Map<String, dynamic>> marketInsights,
    required List<String> strengths,
    required List<Map<String, dynamic>> topBuyers,
    String? writerBio,
    String? contactInfo,
  }) {
    // Generate one-pager
    final onePager = generateOnePager(
      title: title,
      logline: logline,
      genre: genre,
      format: format,
      tone: tone,
      targetAudience: targetAudience,
      synopsis: synopsis,
      comparables: comparables,
      greenlightScore: greenlightScore,
      marketInsights: marketInsights,
      strengths: strengths,
      writerBio: writerBio,
      contactInfo: contactInfo,
    );
    
    // Generate query letter
    final queryLetter = generateQueryLetter(
      projectTitle: title,
      logline: logline,
      synopsis: synopsis,
      genre: genre,
      format: format,
      greenlightScore: greenlightScore,
      comparables: comparables,
      recipientName: '[Recipient Name]',
      recipientCompany: '[Company]',
      recipientTitle: 'Development Executive',
      writerBio: writerBio,
    );
    
    // Generate buyer-specific pitches
    final buyerPitches = topBuyers.take(5).map((buyer) {
      return generateBuyerPitch(
        buyerName: buyer['name'] as String? ?? 'Unknown',
        buyerType: buyer['type'] as String? ?? 'Studio',
        logline: logline,
        genre: genre,
        format: format,
        matchScore: buyer['matchPercent'] as int? ?? 75,
        buyerPreferences: (buyer['preferredGenres'] as List<dynamic>?)?.cast<String>() ?? [genre],
        recentAcquisitions: (buyer['recentAcquisitions'] as List<dynamic>?)?.cast<String>() ?? [],
        contentStrategy: buyer['contentStrategy'] as String? ?? '',
      );
    }).toList();
    
    // Generate lookbook
    final lookbook = comparables.map((comp) {
      return ComparableLookbookEntry(
        title: comp,
        year: 2023,
        platform: 'Theatrical',
        boxOfficeMillions: 150.0,
        rtScore: 85,
        relevance: 'Similar tone and genre approach',
        posterDescription: 'Visual style reference',
      );
    }).toList();
    
    // Generate short pitches
    final elevatorPitch = generateElevatorPitch(
      title: title,
      logline: logline,
      genre: genre,
      comparables: comparables,
      greenlightScore: greenlightScore,
    );
    
    final twitterPitch = generateTwitterPitch(
      title: title,
      logline: logline,
      genre: genre,
    );
    
    return PitchPackage(
      onePager: onePager,
      queryLetter: queryLetter,
      buyerPitches: buyerPitches,
      lookbook: lookbook,
      elevatorPitch: elevatorPitch,
      twitterPitch: twitterPitch,
      generatedAt: DateTime.now(),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════════════════════════════════════
  
  String _generateMarketPosition(String genre, int score, List<Map<String, dynamic>> insights) {
    String position = '';
    
    if (score >= 80) {
      position = 'This project is positioned in the top tier of marketable $genre concepts. ';
    } else if (score >= 65) {
      position = 'This project shows strong market potential within the $genre space. ';
    } else {
      position = 'This project offers a unique entry point into the $genre market. ';
    }
    
    // Add market trend context
    final genreTrends = {
      'Horror': 'Horror continues to dominate ROI metrics with 5.8x average returns.',
      'Thriller': 'Psychological thrillers are experiencing peak demand from streamers.',
      'Sci-Fi': 'AI and technology-themed sci-fi is the hottest commodity in the market.',
      'Romance': 'Rom-coms are making a theatrical comeback with strong box office.',
      'Action': 'Franchise-potential action specs remain highly sought after.',
      'Drama': 'Prestige dramas with A-list attachment potential command premiums.',
      'Comedy': 'Female-led and Gen Z comedy voices are breaking through.',
    };
    
    position += genreTrends[genre] ?? 'The market shows healthy appetite for quality content in this space.';
    
    return position;
  }
  
  List<String> _generateUSPs(List<String> strengths, String logline, String genre) {
    List<String> usps = [];
    
    // Add from strengths
    usps.addAll(strengths.take(3));
    
    // Add genre-specific USPs if needed
    if (usps.length < 3) {
      final genreUSPs = {
        'Horror': 'Contained premise ideal for micro-budget production model',
        'Thriller': 'High-concept hook with broad audience appeal',
        'Sci-Fi': 'Original IP with franchise expansion potential',
        'Romance': 'Fresh voice in the theatrical rom-com revival',
        'Action': 'Set-piece driven narrative with global appeal',
      };
      
      if (genreUSPs.containsKey(genre)) {
        usps.add(genreUSPs[genre]!);
      }
    }
    
    return usps.take(5).toList();
  }
  
  String _inferTone(String genre, String logline) {
    final lowercaseLogline = logline.toLowerCase();
    
    if (lowercaseLogline.contains('dark') || lowercaseLogline.contains('gritty')) {
      return 'Dark/Gritty';
    } else if (lowercaseLogline.contains('fun') || lowercaseLogline.contains('adventure')) {
      return 'Fun/Adventurous';
    } else if (genre == 'Horror') {
      return 'Suspenseful/Atmospheric';
    } else if (genre == 'Comedy' || genre == 'Romance') {
      return 'Light/Uplifting';
    } else if (genre == 'Drama') {
      return 'Emotional/Character-driven';
    }
    
    return 'Engaging/Compelling';
  }
  
  String _inferAudience(String genre, String format) {
    final audiences = {
      'Horror': 'Ages 18-34, genre enthusiasts',
      'Thriller': 'Ages 25-54, adult audiences',
      'Sci-Fi': 'Ages 18-44, genre and mainstream crossover',
      'Romance': 'Ages 18-49, female-skewing with crossover appeal',
      'Action': 'Ages 18-49, broad quadrant',
      'Drama': 'Ages 35-65, prestige audience',
      'Comedy': 'Ages 18-44, broad appeal',
      'Animation': 'Family audiences, all ages',
    };
    
    return audiences[genre] ?? 'Broad mainstream audience';
  }
  
  String _generateOpening(QueryLetterTemplate template, String recipientName, String company, String genre) {
    switch (template) {
      case QueryLetterTemplate.professional:
        return 'Dear $recipientName,\n\nI am seeking representation/development interest for my $genre screenplay, which I believe aligns well with $company\'s recent acquisitions in this space.';
      case QueryLetterTemplate.conversational:
        return 'Dear $recipientName,\n\nI hope this finds you well. After following $company\'s impressive slate of $genre projects, I wanted to share my latest screenplay which I believe fits your taste profile.';
      case QueryLetterTemplate.genre:
        return 'Dear $recipientName,\n\nAs a fellow $genre enthusiast, I\'m excited to submit my screenplay for your consideration. $company\'s commitment to quality genre content made you my first choice.';
      case QueryLetterTemplate.festival:
        return 'Dear $recipientName,\n\nFollowing positive reception at [Festival Name], I\'m reaching out to gauge $company\'s interest in my $genre screenplay.';
      case QueryLetterTemplate.referral:
        return 'Dear $recipientName,\n\n[Referrer Name] suggested I reach out to you regarding my $genre screenplay, believing it would be a strong fit for $company\'s development slate.';
    }
  }
  
  String _generateLoglineParagraph(String title, String logline, String format, String genre) {
    return '"$title" is a $format $genre that follows: $logline';
  }
  
  String _generateSynopsisParagraph(String synopsis) {
    // Condense synopsis to 2-3 sentences for query letter
    if (synopsis.length > 500) {
      final sentences = synopsis.split(RegExp(r'[.!?]')).where((s) => s.trim().isNotEmpty).toList();
      if (sentences.length > 3) {
        return '${sentences.take(3).join('. ')}.';
      }
    }
    return synopsis;
  }
  
  String _generateMarketParagraph(String genre, List<String> comparables, int score) {
    final compString = comparables.take(2).join(' and ');
    
    return 'In the vein of $compString, this project targets the proven $genre audience while offering a fresh perspective. Market analysis indicates strong commercial viability with a GreenlightIQ™ score of $score/100.';
  }
  
  String _generateCredentialsParagraph(String? bio, String? credentials) {
    if (credentials != null && credentials.isNotEmpty) {
      return credentials;
    } else if (bio != null && bio.isNotEmpty) {
      return 'About the writer: $bio';
    }
    return 'I am a dedicated screenwriter committed to bringing fresh, marketable stories to the screen. I would welcome the opportunity to discuss this project further.';
  }
  
  String _generateClosing(QueryLetterTemplate template, String title) {
    switch (template) {
      case QueryLetterTemplate.professional:
        return 'The complete screenplay for "$title" is available upon request. Thank you for your time and consideration.\n\nRespectfully,';
      case QueryLetterTemplate.conversational:
        return 'I\'d love to send over the full script whenever works for you. Thanks so much for taking the time to read this!\n\nBest,';
      case QueryLetterTemplate.genre:
        return 'The script is ready and waiting. I\'m confident it\'ll resonate with audiences who loved your recent work.\n\nCheers,';
      case QueryLetterTemplate.festival:
        return 'Following festival interest, the project is ready for the next stage. I would be honored to discuss further.\n\nWarm regards,';
      case QueryLetterTemplate.referral:
        return 'Per [Referrer Name]\'s suggestion, I\'ve attached a treatment. The full screenplay is available at your convenience.\n\nBest regards,';
    }
  }
  
  String _customizeLoglineForBuyer(String logline, String buyerName, String buyerType, List<String> preferences) {
    // Customize emphasis based on buyer type
    String customized = logline;
    
    if (buyerType == 'Streamer') {
      // Emphasize binge-worthy elements
      if (!customized.contains('episode') && !customized.contains('series')) {
        customized = '$customized Perfect for limited series adaptation.';
      }
    } else if (buyerType == 'Major Studio') {
      // Emphasize theatrical/franchise potential
      if (!customized.contains('franchise') && !customized.contains('universe')) {
        customized = '$customized Designed with franchise potential in mind.';
      }
    } else if (buyerType == 'Indie') {
      // Emphasize unique voice and contained scope
      customized = '$customized A distinctive voice in the genre.';
    }
    
    return customized;
  }
  
  String _generateWhyThisBuyer(String buyerName, String buyerType, String genre, String contentStrategy) {
    return '$buyerName has demonstrated a clear appetite for $genre content. Their strategy of "$contentStrategy" aligns perfectly with this project\'s positioning.';
  }
  
  List<String> _generateAlignmentPoints(String genre, List<String> preferences, String strategy) {
    List<String> points = [];
    
    if (preferences.contains(genre)) {
      points.add('$genre is a core genre focus');
    }
    
    points.add('Project scope aligns with typical acquisition range');
    points.add('Tone matches successful recent acquisitions');
    
    if (strategy.toLowerCase().contains('franchise')) {
      points.add('Franchise/expansion potential built into concept');
    }
    
    if (strategy.toLowerCase().contains('diverse') || strategy.toLowerCase().contains('fresh')) {
      points.add('Fresh voice and perspective in established genre');
    }
    
    return points.take(4).toList();
  }
  
  String _generateSubmissionStrategy(String buyerName, String buyerType) {
    if (buyerType == 'Production Company') {
      return 'Submit through official submission portal or manager/agent connection.';
    } else if (buyerType == 'Streamer') {
      return 'Requires agent or manager submission. Consider packaging with talent attachments.';
    } else if (buyerType == 'Major Studio') {
      return 'Studio submissions require established representation. Consider development executives through industry connections.';
    } else if (buyerType == 'Indie') {
      return 'Indie distributors often accept queries. Consider festival premiere strategy for leverage.';
    }
    return 'Standard query submission through proper channels.';
  }
  
  String _generatePitchAngle(String buyerName, String buyerType, String genre, String format) {
    final angles = {
      'Netflix': 'Emphasize global appeal and binge-worthy hook',
      'Amazon MGM': 'Highlight franchise potential and theatrical viability',
      'Apple TV+': 'Focus on prestige elements and A-list attachment potential',
      'A24': 'Lead with auteur vision and cultural relevance',
      'Blumhouse': 'Emphasize contained premise and high-concept hook',
      'HBO/Max': 'Pitch limited series potential and premium quality',
      'Neon': 'Highlight festival potential and conversation-starting elements',
    };
    
    return angles[buyerName] ?? 'Focus on unique hook and market positioning';
  }
  
  /// Generate PDF document from One-Pager
  Future<pw.Document> generateOnePagerPDF(OnePagerPitch pitch) async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Text(
                  pitch.title.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Center(
                child: pw.Text(
                  '${pitch.format} • ${pitch.genre} • ${pitch.tone}',
                  style: const pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                  ),
                ),
              ),
              pw.Divider(thickness: 2, color: PdfColors.amber),
              pw.SizedBox(height: 16),
              
              // Logline
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'LOGLINE',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey600,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      pitch.logline,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),
              
              // Two column layout
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Left column - Synopsis
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'SYNOPSIS',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          pitch.synopsis,
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 16),
                  // Right column - Stats
                  pw.Expanded(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Greenlight Score
                        pw.Container(
                          padding: const pw.EdgeInsets.all(8),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.amber50,
                            borderRadius: pw.BorderRadius.circular(8),
                            border: pw.Border.all(color: PdfColors.amber),
                          ),
                          child: pw.Column(
                            children: [
                              pw.Text(
                                'GREENLIGHT SCORE',
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                '${pitch.greenlightScore}/100',
                                style: pw.TextStyle(
                                  fontSize: 24,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.amber800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 12),
                        
                        // Target Audience
                        pw.Text(
                          'TARGET AUDIENCE',
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.Text(
                          pitch.targetAudience,
                          style: const pw.TextStyle(fontSize: 9),
                        ),
                        pw.SizedBox(height: 12),
                        
                        // Comparables
                        pw.Text(
                          'COMPARABLE WORKS',
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        ...pitch.comparableWorks.map((c) => pw.Padding(
                          padding: const pw.EdgeInsets.only(top: 2),
                          child: pw.Text('• $c', style: const pw.TextStyle(fontSize: 9)),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 16),
              
              // Market Position
              pw.Text(
                'MARKET POSITION',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                pitch.marketPosition,
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 16),
              
              // Unique Selling Points
              pw.Text(
                'UNIQUE SELLING POINTS',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(height: 4),
              ...pitch.uniqueSellingPoints.map((usp) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('✓ ', style: pw.TextStyle(color: PdfColors.green700, fontWeight: pw.FontWeight.bold)),
                    pw.Expanded(child: pw.Text(usp, style: const pw.TextStyle(fontSize: 10))),
                  ],
                ),
              )),
              
              // Footer
              pw.Spacer(),
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    pitch.contactInfo.isNotEmpty ? pitch.contactInfo : 'Contact information',
                    style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
                  ),
                  pw.Text(
                    'Generated by Tinseltown IQ™',
                    style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey400),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    
    return pdf;
  }
}
