import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// PDF Report Types
enum PDFReportType {
  executiveSummary,
  fullReport,
  buyerPackage,
  pitchDeck,
}

extension PDFReportTypeExtension on PDFReportType {
  String get displayName {
    switch (this) {
      case PDFReportType.executiveSummary:
        return 'Executive Summary';
      case PDFReportType.fullReport:
        return 'Full Report';
      case PDFReportType.buyerPackage:
        return 'Buyer Package';
      case PDFReportType.pitchDeck:
        return 'Pitch Deck';
    }
  }
}

/// PDF Report Data - A simple data transfer object for PDF generation
/// This avoids model class conflicts between files
class PDFReportData {
  final String projectTitle;
  final String logline;
  final String synopsis;
  final String format;
  final String genre;
  final String? secondaryGenre;
  final String? tone;
  final String? targetAudience;
  final int greenlightScore;
  final String verdict;
  final String verdictDescription;
  final String similarityRisk;
  final String similarityDescription;
  final List<PDFBuyerData> topBuyers;
  final List<PDFProducerData> topProducers;
  final List<PDFSimilarTitleData> similarTitles;
  final PDFMarketInsightsData marketInsights;

  PDFReportData({
    required this.projectTitle,
    required this.logline,
    required this.synopsis,
    required this.format,
    required this.genre,
    this.secondaryGenre,
    this.tone,
    this.targetAudience,
    required this.greenlightScore,
    required this.verdict,
    required this.verdictDescription,
    required this.similarityRisk,
    required this.similarityDescription,
    required this.topBuyers,
    required this.topProducers,
    required this.similarTitles,
    required this.marketInsights,
  });

  String get fullGenre => secondaryGenre != null ? '$genre / $secondaryGenre' : genre;
}

class PDFBuyerData {
  final String name;
  final String type;
  final int matchPercent;
  final String reason;
  final String lookingFor;

  PDFBuyerData({
    required this.name,
    required this.type,
    required this.matchPercent,
    required this.reason,
    required this.lookingFor,
  });
}

class PDFProducerData {
  final String name;
  final String company;
  final int matchPercent;
  final String specialty;
  final String budgetRange;

  PDFProducerData({
    required this.name,
    required this.company,
    required this.matchPercent,
    required this.specialty,
    required this.budgetRange,
  });
}

class PDFSimilarTitleData {
  final String title;
  final int year;
  final int similarityPercent;
  final String platform;
  final String differentiator;

  PDFSimilarTitleData({
    required this.title,
    required this.year,
    required this.similarityPercent,
    required this.platform,
    required this.differentiator,
  });
}

class PDFMarketInsightsData {
  final String genreTrend;
  final int genreTrendPercent;
  final bool genreTrendUp;
  final String platformFit;
  final String budgetRecommendation;
  final String targetAudience;
  final String timingAdvice;

  PDFMarketInsightsData({
    required this.genreTrend,
    required this.genreTrendPercent,
    required this.genreTrendUp,
    required this.platformFit,
    required this.budgetRecommendation,
    required this.targetAudience,
    required this.timingAdvice,
  });
}

/// PDF Export Service for GreenlightIQ Reports
/// 
/// Generates professional PDF reports from concept analyses
/// with comprehensive industry insights and recommendations.
class PDFExportService {
  static final PDFExportService _instance = PDFExportService._internal();
  factory PDFExportService() => _instance;
  PDFExportService._internal();

  // Brand colors
  static const PdfColor _goldColor = PdfColor.fromInt(0xFFD4AF37);
  static const PdfColor _darkBlue = PdfColor.fromInt(0xFF0D1B2A);
  static const PdfColor _mediumBlue = PdfColor.fromInt(0xFF1B263B);
  static const PdfColor _lightGray = PdfColor.fromInt(0xFFF5F5F5);
  static const PdfColor _white = PdfColor.fromInt(0xFFFFFFFF);
  static const PdfColor _green = PdfColor.fromInt(0xFF4CAF50);
  static const PdfColor _red = PdfColor.fromInt(0xFFE53935);
  static const PdfColor _orange = PdfColor.fromInt(0xFFFF9800);

  /// Generate PDF report from PDFReportData
  Future<Uint8List> generateReport({
    required PDFReportData data,
    required PDFReportType reportType,
  }) async {
    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(
        base: await PdfGoogleFonts.interRegular(),
        bold: await PdfGoogleFonts.interBold(),
        italic: await PdfGoogleFonts.interItalic(),
      ),
    );

    switch (reportType) {
      case PDFReportType.executiveSummary:
        _buildExecutiveSummary(pdf, data);
        break;
      case PDFReportType.fullReport:
        _buildFullReport(pdf, data);
        break;
      case PDFReportType.buyerPackage:
        _buildBuyerPackage(pdf, data);
        break;
      case PDFReportType.pitchDeck:
        _buildPitchDeck(pdf, data);
        break;
    }

    return pdf.save();
  }

  void _buildExecutiveSummary(pw.Document pdf, PDFReportData data) {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(data),
            pw.SizedBox(height: 30),
            _buildScoreSection(data),
            pw.SizedBox(height: 30),
            _buildConceptOverview(data),
            pw.SizedBox(height: 30),
            _buildTopBuyers(data, maxBuyers: 3),
            pw.SizedBox(height: 30),
            _buildMarketSnapshot(data),
            pw.Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  void _buildFullReport(pw.Document pdf, PDFReportData data) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(data),
        footer: (context) => _buildPageFooter(context),
        build: (context) => [
          _buildScoreSection(data),
          pw.SizedBox(height: 20),
          _buildConceptSection(data),
          pw.SizedBox(height: 20),
          _buildMarketInsightsSection(data),
          pw.SizedBox(height: 20),
          _buildBuyerMatchesSection(data),
          pw.SizedBox(height: 20),
          _buildProducerMatchesSection(data),
          pw.SizedBox(height: 20),
          _buildSimilarTitlesSection(data),
          pw.SizedBox(height: 20),
          _buildRecommendationsSection(data),
        ],
      ),
    );
  }

  void _buildBuyerPackage(pw.Document pdf, PDFReportData data) {
    // Cover Page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                'SUBMISSION PACKAGE',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: _goldColor,
                  letterSpacing: 4,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                data.projectTitle,
                style: pw.TextStyle(
                  fontSize: 32,
                  fontWeight: pw.FontWeight.bold,
                  color: _darkBlue,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                '${data.format} | ${data.fullGenre}',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.grey700,
                ),
              ),
              pw.SizedBox(height: 40),
              _buildScoreBadge(data.greenlightScore, data.verdict),
              pw.SizedBox(height: 40),
              pw.Text(
                'GreenlightIQ Analysis Report',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.grey600,
                ),
              ),
              pw.Text(
                DateTime.now().toString().split(' ')[0],
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColors.grey500,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Content Pages
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(data),
        footer: (context) => _buildPageFooter(context),
        build: (context) => [
          _buildConceptSection(data),
          pw.SizedBox(height: 20),
          _buildMarketInsightsSection(data),
          pw.SizedBox(height: 20),
          _buildBuyerMatchesSection(data),
          pw.SizedBox(height: 20),
          _buildSimilarTitlesSection(data),
        ],
      ),
    );
  }

  void _buildPitchDeck(pw.Document pdf, PDFReportData data) {
    // Title Slide
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter.landscape,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                data.projectTitle,
                style: pw.TextStyle(
                  fontSize: 48,
                  fontWeight: pw.FontWeight.bold,
                  color: _darkBlue,
                ),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: pw.BoxDecoration(
                  color: _goldColor,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                ),
                child: pw.Text(
                  '${data.format} | ${data.fullGenre}',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: _white,
                  ),
                ),
              ),
              pw.SizedBox(height: 40),
              _buildScoreBadge(data.greenlightScore, data.verdict),
            ],
          ),
        ),
      ),
    );

    // Logline Slide
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter.landscape,
        margin: const pw.EdgeInsets.all(60),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'THE CONCEPT',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: _goldColor,
                letterSpacing: 2,
              ),
            ),
            pw.SizedBox(height: 30),
            pw.Text(
              data.logline,
              style: pw.TextStyle(
                fontSize: 24,
                color: _darkBlue,
                lineSpacing: 8,
              ),
            ),
            pw.Spacer(),
            pw.Divider(color: _goldColor, thickness: 2),
          ],
        ),
      ),
    );

    // Market Fit Slide
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter.landscape,
        margin: const pw.EdgeInsets.all(60),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'MARKET FIT',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: _goldColor,
                letterSpacing: 2,
              ),
            ),
            pw.SizedBox(height: 30),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: _buildPitchMetric(
                    'Genre Trend',
                    data.marketInsights.genreTrend,
                    '${data.marketInsights.genreTrendUp ? '+' : ''}${data.marketInsights.genreTrendPercent}%',
                    data.marketInsights.genreTrendUp ? _green : _red,
                  ),
                ),
                pw.SizedBox(width: 40),
                pw.Expanded(
                  child: _buildPitchMetric(
                    'Platform Fit',
                    data.marketInsights.platformFit,
                    'Optimal',
                    _green,
                  ),
                ),
                pw.SizedBox(width: 40),
                pw.Expanded(
                  child: _buildPitchMetric(
                    'Target Audience',
                    data.marketInsights.targetAudience,
                    'Identified',
                    _goldColor,
                  ),
                ),
              ],
            ),
            pw.Spacer(),
            pw.Divider(color: _goldColor, thickness: 2),
          ],
        ),
      ),
    );

    // Buyer Matches Slide
    if (data.topBuyers.isNotEmpty) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.letter.landscape,
          margin: const pw.EdgeInsets.all(60),
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'POTENTIAL BUYERS',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: _goldColor,
                  letterSpacing: 2,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: data.topBuyers.take(3).map((buyer) => 
                  pw.Expanded(
                    child: pw.Container(
                      margin: const pw.EdgeInsets.only(right: 20),
                      padding: const pw.EdgeInsets.all(20),
                      decoration: pw.BoxDecoration(
                        color: _lightGray,
                        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            buyer.name,
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              color: _darkBlue,
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Text(
                            buyer.type,
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.grey600,
                            ),
                          ),
                          pw.SizedBox(height: 15),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: pw.BoxDecoration(
                              color: _goldColor,
                              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(20)),
                            ),
                            child: pw.Text(
                              '${buyer.matchPercent}% Match',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: _white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).toList(),
              ),
              pw.Spacer(),
              pw.Divider(color: _goldColor, thickness: 2),
            ],
          ),
        ),
      );
    }
  }

  // Helper widgets

  pw.Widget _buildHeader(PDFReportData data) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'TINSELTOWN IQ',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
                color: _goldColor,
                letterSpacing: 2,
              ),
            ),
            pw.Text(
              'GreenlightIQ Analysis Report',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey600,
              ),
            ),
          ],
        ),
        pw.Text(
          data.projectTitle,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: _darkBlue,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildFooter() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'Generated by Tinseltown IQ',
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey500,
          ),
        ),
        pw.Text(
          DateTime.now().toString().split(' ')[0],
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey500,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPageFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'Generated by Tinseltown IQ',
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey500,
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber} of ${context.pagesCount}',
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey500,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildScoreSection(PDFReportData data) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(24),
      decoration: pw.BoxDecoration(
        color: _lightGray,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
      ),
      child: pw.Row(
        children: [
          _buildScoreBadge(data.greenlightScore, data.verdict),
          pw.SizedBox(width: 24),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  data.verdict,
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  data.verdictDescription,
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                    lineSpacing: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildScoreBadge(int score, String verdict) {
    PdfColor badgeColor;
    if (score >= 80) {
      badgeColor = _green;
    } else if (score >= 60) {
      badgeColor = _goldColor;
    } else if (score >= 40) {
      badgeColor = _orange;
    } else {
      badgeColor = _red;
    }

    return pw.Container(
      width: 80,
      height: 80,
      decoration: pw.BoxDecoration(
        color: badgeColor,
        shape: pw.BoxShape.circle,
      ),
      child: pw.Center(
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              '$score',
              style: pw.TextStyle(
                fontSize: 28,
                fontWeight: pw.FontWeight.bold,
                color: _white,
              ),
            ),
            pw.Text(
              '/100',
              style: pw.TextStyle(
                fontSize: 12,
                color: _white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildConceptOverview(PDFReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'CONCEPT OVERVIEW',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: _goldColor,
            letterSpacing: 2,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Text(
          data.logline,
          style: pw.TextStyle(
            fontSize: 12,
            color: _darkBlue,
            lineSpacing: 4,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          '${data.format} | ${data.fullGenre}',
          style: pw.TextStyle(
            fontSize: 11,
            color: PdfColors.grey600,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildTopBuyers(PDFReportData data, {int maxBuyers = 5}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'TOP BUYER MATCHES',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: _goldColor,
            letterSpacing: 2,
          ),
        ),
        pw.SizedBox(height: 12),
        ...data.topBuyers.take(maxBuyers).map((buyer) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8),
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: _lightGray,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      buyer.name,
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: _darkBlue,
                      ),
                    ),
                    pw.Text(
                      buyer.type,
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: pw.BoxDecoration(
                  color: _goldColor,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
                ),
                child: pw.Text(
                  '${buyer.matchPercent}%',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: _white,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  pw.Widget _buildMarketSnapshot(PDFReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'MARKET SNAPSHOT',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: _goldColor,
            letterSpacing: 2,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Row(
          children: [
            pw.Expanded(
              child: _buildMetricBox(
                'Genre Trend',
                data.marketInsights.genreTrend,
                data.marketInsights.genreTrendUp ? _green : _red,
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _buildMetricBox(
                'Platform Fit',
                data.marketInsights.platformFit,
                _goldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildMetricBox(String label, String value, PdfColor accentColor) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: _lightGray,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        border: pw.Border(left: pw.BorderSide(color: accentColor, width: 3)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey600,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: _darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPitchMetric(String label, String value, String badge, PdfColor badgeColor) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey600,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 18,
            color: _darkBlue,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: pw.BoxDecoration(
            color: badgeColor,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Text(
            badge,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: _white,
            ),
          ),
        ),
      ],
    );
  }

  // Full Report Sections

  pw.Widget _buildConceptSection(PDFReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Project Overview'),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: _lightGray,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Logline',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: _goldColor,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                data.logline,
                style: pw.TextStyle(
                  fontSize: 12,
                  color: _darkBlue,
                  lineSpacing: 4,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: _buildInfoItem('Format', data.format),
                  ),
                  pw.Expanded(
                    child: _buildInfoItem('Genre', data.fullGenre),
                  ),
                ],
              ),
              if (data.tone != null) ...[
                pw.SizedBox(height: 12),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: _buildInfoItem('Tone', data.tone!),
                    ),
                    pw.Expanded(
                      child: _buildInfoItem('Target Audience', data.targetAudience ?? 'General'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildMarketInsightsSection(PDFReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Market Insights'),
        pw.SizedBox(height: 12),
        pw.Row(
          children: [
            pw.Expanded(
              child: _buildInsightCard(
                'Genre Trend',
                data.marketInsights.genreTrend,
                '${data.marketInsights.genreTrendUp ? "+" : ""}${data.marketInsights.genreTrendPercent}%',
                data.marketInsights.genreTrendUp ? _green : _red,
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _buildInsightCard(
                'Platform Fit',
                data.marketInsights.platformFit,
                'Recommended',
                _goldColor,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Row(
          children: [
            pw.Expanded(
              child: _buildInsightCard(
                'Budget',
                data.marketInsights.budgetRecommendation,
                'Optimal Range',
                _mediumBlue,
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Expanded(
              child: _buildInsightCard(
                'Target Audience',
                data.marketInsights.targetAudience,
                'Primary Demo',
                _goldColor,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: _lightGray,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Timing Advice',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                  color: _goldColor,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                data.marketInsights.timingAdvice,
                style: pw.TextStyle(
                  fontSize: 11,
                  color: _darkBlue,
                  lineSpacing: 4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildBuyerMatchesSection(PDFReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Buyer Matches'),
        pw.SizedBox(height: 12),
        ...data.topBuyers.take(5).map((buyer) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10),
          padding: const pw.EdgeInsets.all(14),
          decoration: pw.BoxDecoration(
            color: _lightGray,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          buyer.name,
                          style: pw.TextStyle(
                            fontSize: 13,
                            fontWeight: pw.FontWeight.bold,
                            color: _darkBlue,
                          ),
                        ),
                        pw.Text(
                          buyer.type,
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: pw.BoxDecoration(
                      color: _goldColor,
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(16)),
                    ),
                    child: pw.Text(
                      '${buyer.matchPercent}% Match',
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        color: _white,
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Looking for: ${buyer.lookingFor}',
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey700,
                  lineSpacing: 3,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                buyer.reason,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  pw.Widget _buildProducerMatchesSection(PDFReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Producer Matches'),
        pw.SizedBox(height: 12),
        ...data.topProducers.take(5).map((producer) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 10),
          padding: const pw.EdgeInsets.all(14),
          decoration: pw.BoxDecoration(
            color: _lightGray,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      producer.name,
                      style: pw.TextStyle(
                        fontSize: 13,
                        fontWeight: pw.FontWeight.bold,
                        color: _darkBlue,
                      ),
                    ),
                    pw.Text(
                      producer.company,
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey600,
                      ),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      'Specialty: ${producer.specialty}',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.Text(
                      'Budget Range: ${producer.budgetRange}',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: pw.BoxDecoration(
                  color: _goldColor,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(16)),
                ),
                child: pw.Text(
                  '${producer.matchPercent}%',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: _white,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  pw.Widget _buildSimilarTitlesSection(PDFReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Comparable Titles'),
        pw.SizedBox(height: 4),
        pw.Text(
          'Similarity Risk: ${data.similarityRisk}',
          style: pw.TextStyle(
            fontSize: 11,
            color: PdfColors.grey600,
          ),
        ),
        pw.SizedBox(height: 12),
        ...data.similarTitles.take(5).map((title) => pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8),
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: _lightGray,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Row(
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '${title.title} (${title.year})',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                        color: _darkBlue,
                      ),
                    ),
                    pw.Text(
                      title.platform,
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey600,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Differentiator: ${title.differentiator}',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontStyle: pw.FontStyle.italic,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: pw.BoxDecoration(
                  color: title.similarityPercent > 70 ? _orange : _mediumBlue,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
                ),
                child: pw.Text(
                  '${title.similarityPercent}%',
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: _white,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  pw.Widget _buildRecommendationsSection(PDFReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Recommendations'),
        pw.SizedBox(height: 12),
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: _lightGray,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (data.similarityDescription.isNotEmpty) ...[
                pw.Text(
                  'Differentiation Strategy',
                  style: pw.TextStyle(
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    color: _goldColor,
                  ),
                ),
                pw.SizedBox(height: 6),
                pw.Text(
                  data.similarityDescription,
                  style: pw.TextStyle(
                    fontSize: 11,
                    color: _darkBlue,
                    lineSpacing: 4,
                  ),
                ),
                pw.SizedBox(height: 16),
              ],
              pw.Text(
                'Next Steps',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                  color: _goldColor,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Bullet(
                text: 'Review and refine logline based on market positioning',
                style: pw.TextStyle(fontSize: 10, color: _darkBlue),
                bulletSize: 4,
              ),
              pw.SizedBox(height: 4),
              pw.Bullet(
                text: 'Target top-matched buyers for initial outreach',
                style: pw.TextStyle(fontSize: 10, color: _darkBlue),
                bulletSize: 4,
              ),
              pw.SizedBox(height: 4),
              pw.Bullet(
                text: 'Consider timing recommendations for submission',
                style: pw.TextStyle(fontSize: 10, color: _darkBlue),
                bulletSize: 4,
              ),
              pw.SizedBox(height: 4),
              pw.Bullet(
                text: 'Develop pitch materials highlighting unique differentiators',
                style: pw.TextStyle(fontSize: 10, color: _darkBlue),
                bulletSize: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildSectionHeader(String title) {
    return pw.Text(
      title.toUpperCase(),
      style: pw.TextStyle(
        fontSize: 14,
        fontWeight: pw.FontWeight.bold,
        color: _goldColor,
        letterSpacing: 2,
      ),
    );
  }

  pw.Widget _buildInfoItem(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey600,
          ),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: _darkBlue,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildInsightCard(String label, String value, String badge, PdfColor badgeColor) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: _lightGray,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                label,
                style: pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: pw.BoxDecoration(
                  color: badgeColor,
                  borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
                ),
                child: pw.Text(
                  badge,
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                    color: _white,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: _darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
