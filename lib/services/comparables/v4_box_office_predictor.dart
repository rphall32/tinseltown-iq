/// V4 BOX OFFICE PREDICTOR
/// Predicts potential box office performance based on comparable titles

class BoxOfficePrediction {
  final int predictedDomesticLow;
  final int predictedDomesticHigh;
  final int predictedWorldwideLow;
  final int predictedWorldwideHigh;
  final double predictedROI;
  final String confidence; // "High", "Medium", "Low"
  final List<String> basedOnTitles;
  final String rationale;
  
  BoxOfficePrediction({
    required this.predictedDomesticLow,
    required this.predictedDomesticHigh,
    required this.predictedWorldwideLow,
    required this.predictedWorldwideHigh,
    required this.predictedROI,
    required this.confidence,
    required this.basedOnTitles,
    required this.rationale,
  });
  
  String get domesticRange => '\$${predictedDomesticLow}M - \$${predictedDomesticHigh}M';
  String get worldwideRange => '\$${predictedWorldwideLow}M - \$${predictedWorldwideHigh}M';
  String get roiDisplay => '${predictedROI.toStringAsFixed(1)}x';
}

class BoxOfficePredictor {
  
  /// Predict box office based on genre, budget tier, and comparable performance
  BoxOfficePrediction predict({
    required String genre,
    required String format,
    String? budgetTier,
    List<ComparablePerformance> comparables = const [],
  }) {
    // Get baseline by genre and format
    final baseline = _getGenreBaseline(genre, format);
    
    // Adjust based on budget tier
    final budgetMultiplier = _getBudgetMultiplier(budgetTier);
    
    // Calculate from comparables if available
    if (comparables.isNotEmpty) {
      return _predictFromComparables(comparables, baseline, budgetMultiplier);
    }
    
    // Use genre baseline
    return BoxOfficePrediction(
      predictedDomesticLow: (baseline.avgDomestic * 0.5 * budgetMultiplier).round(),
      predictedDomesticHigh: (baseline.avgDomestic * 1.5 * budgetMultiplier).round(),
      predictedWorldwideLow: (baseline.avgWorldwide * 0.5 * budgetMultiplier).round(),
      predictedWorldwideHigh: (baseline.avgWorldwide * 1.5 * budgetMultiplier).round(),
      predictedROI: baseline.avgROI,
      confidence: 'Medium',
      basedOnTitles: baseline.referenceTitles,
      rationale: 'Based on ${genre.toLowerCase()} genre averages for ${format.toLowerCase()}s',
    );
  }
  
  BoxOfficePrediction _predictFromComparables(
    List<ComparablePerformance> comparables,
    _GenreBaseline baseline,
    double budgetMultiplier,
  ) {
    // Calculate weighted average from comparables
    double totalDomestic = 0;
    double totalWorldwide = 0;
    double totalROI = 0;
    int count = 0;
    
    for (final comp in comparables) {
      if (comp.domesticGross != null) {
        totalDomestic += comp.domesticGross!;
        count++;
      }
      if (comp.worldwideGross != null) {
        totalWorldwide += comp.worldwideGross!;
      }
      if (comp.roi != null) {
        totalROI += comp.roi!;
      }
    }
    
    if (count == 0) {
      return BoxOfficePrediction(
        predictedDomesticLow: (baseline.avgDomestic * 0.5).round(),
        predictedDomesticHigh: (baseline.avgDomestic * 1.5).round(),
        predictedWorldwideLow: (baseline.avgWorldwide * 0.5).round(),
        predictedWorldwideHigh: (baseline.avgWorldwide * 1.5).round(),
        predictedROI: baseline.avgROI,
        confidence: 'Low',
        basedOnTitles: baseline.referenceTitles,
        rationale: 'Limited comparable data available',
      );
    }
    
    final avgDomestic = (totalDomestic / count * budgetMultiplier).round();
    final avgWorldwide = (totalWorldwide / count * budgetMultiplier).round();
    final avgROI = totalROI / count;
    
    // Calculate variance for range
    final domesticVariance = _calculateVariance(comparables.map((c) => c.domesticGross ?? 0).toList());
    final worldwideVariance = _calculateVariance(comparables.map((c) => c.worldwideGross ?? 0).toList());
    
    // Determine confidence based on sample size and variance
    String confidence;
    if (count >= 3 && domesticVariance < 0.5) {
      confidence = 'High';
    } else if (count >= 2) {
      confidence = 'Medium';
    } else {
      confidence = 'Low';
    }
    
    return BoxOfficePrediction(
      predictedDomesticLow: (avgDomestic * 0.7).round(),
      predictedDomesticHigh: (avgDomestic * 1.4).round(),
      predictedWorldwideLow: (avgWorldwide * 0.7).round(),
      predictedWorldwideHigh: (avgWorldwide * 1.4).round(),
      predictedROI: avgROI,
      confidence: confidence,
      basedOnTitles: comparables.map((c) => c.title).toList(),
      rationale: 'Based on performance of ${comparables.length} similar titles',
    );
  }
  
  double _calculateVariance(List<int> values) {
    if (values.isEmpty || values.length == 1) return 1.0;
    final avg = values.reduce((a, b) => a + b) / values.length;
    if (avg == 0) return 1.0;
    final variance = values.map((v) => (v - avg).abs() / avg).reduce((a, b) => a + b) / values.length;
    return variance;
  }
  
  double _getBudgetMultiplier(String? budgetTier) {
    switch (budgetTier?.toLowerCase()) {
      case 'micro':
        return 0.3;
      case 'low':
        return 0.6;
      case 'medium':
        return 1.0;
      case 'high':
        return 1.8;
      case 'blockbuster':
        return 3.0;
      default:
        return 1.0;
    }
  }
  
  _GenreBaseline _getGenreBaseline(String genre, String format) {
    // Film baselines (in millions)
    if (format.toLowerCase().contains('film') || format.toLowerCase().contains('feature')) {
      return _filmBaselines[genre] ?? _filmBaselines['Drama']!;
    }
    // TV/Streaming baselines
    return _tvBaselines[genre] ?? _tvBaselines['Drama']!;
  }
  
  static final Map<String, _GenreBaseline> _filmBaselines = {
    'Horror': _GenreBaseline(
      avgDomestic: 65,
      avgWorldwide: 140,
      avgROI: 8.5,
      referenceTitles: ['A Quiet Place', 'Get Out', 'Smile', 'M3GAN'],
    ),
    'Thriller': _GenreBaseline(
      avgDomestic: 55,
      avgWorldwide: 130,
      avgROI: 4.2,
      referenceTitles: ['Gone Girl', 'Knives Out', 'Don\'t Worry Darling'],
    ),
    'Action': _GenreBaseline(
      avgDomestic: 120,
      avgWorldwide: 350,
      avgROI: 3.5,
      referenceTitles: ['John Wick 4', 'Mission: Impossible', 'Top Gun: Maverick'],
    ),
    'Comedy': _GenreBaseline(
      avgDomestic: 70,
      avgWorldwide: 150,
      avgROI: 4.0,
      referenceTitles: ['Barbie', 'Anyone But You', 'No Hard Feelings'],
    ),
    'Drama': _GenreBaseline(
      avgDomestic: 40,
      avgWorldwide: 100,
      avgROI: 3.0,
      referenceTitles: ['Oppenheimer', 'The Holdovers', 'Past Lives'],
    ),
    'Sci-Fi': _GenreBaseline(
      avgDomestic: 100,
      avgWorldwide: 300,
      avgROI: 2.8,
      referenceTitles: ['Dune: Part Two', 'Avatar', 'Interstellar'],
    ),
    'Romance': _GenreBaseline(
      avgDomestic: 50,
      avgWorldwide: 120,
      avgROI: 5.0,
      referenceTitles: ['Anyone But You', 'Ticket to Paradise', 'The Idea of You'],
    ),
    'Animation': _GenreBaseline(
      avgDomestic: 150,
      avgWorldwide: 400,
      avgROI: 3.2,
      referenceTitles: ['Inside Out 2', 'The Wild Robot', 'Spider-Verse'],
    ),
  };
  
  static final Map<String, _GenreBaseline> _tvBaselines = {
    'Horror': _GenreBaseline(
      avgDomestic: 0, // N/A for TV
      avgWorldwide: 0,
      avgROI: 0,
      referenceTitles: ['The Last of Us', 'Midnight Mass', 'The Haunting of Hill House'],
    ),
    'Thriller': _GenreBaseline(
      avgDomestic: 0,
      avgWorldwide: 0,
      avgROI: 0,
      referenceTitles: ['Severance', 'Slow Horses', 'The Night Agent'],
    ),
    'Drama': _GenreBaseline(
      avgDomestic: 0,
      avgWorldwide: 0,
      avgROI: 0,
      referenceTitles: ['Shōgun', 'The Bear', 'Succession'],
    ),
    'Comedy': _GenreBaseline(
      avgDomestic: 0,
      avgWorldwide: 0,
      avgROI: 0,
      referenceTitles: ['The White Lotus', 'Abbott Elementary', 'Hacks'],
    ),
    'Sci-Fi': _GenreBaseline(
      avgDomestic: 0,
      avgWorldwide: 0,
      avgROI: 0,
      referenceTitles: ['Severance', 'Black Mirror', 'Silo'],
    ),
    'Action': _GenreBaseline(
      avgDomestic: 0,
      avgWorldwide: 0,
      avgROI: 0,
      referenceTitles: ['Reacher', 'Jack Ryan', 'The Terminal List'],
    ),
    'Crime': _GenreBaseline(
      avgDomestic: 0,
      avgWorldwide: 0,
      avgROI: 0,
      referenceTitles: ['The Penguin', 'True Detective', 'Mare of Easttown'],
    ),
    'Romance': _GenreBaseline(
      avgDomestic: 0,
      avgWorldwide: 0,
      avgROI: 0,
      referenceTitles: ['Bridgerton', 'Normal People', 'Fleabag'],
    ),
  };
}

class _GenreBaseline {
  final int avgDomestic;
  final int avgWorldwide;
  final double avgROI;
  final List<String> referenceTitles;
  
  _GenreBaseline({
    required this.avgDomestic,
    required this.avgWorldwide,
    required this.avgROI,
    required this.referenceTitles,
  });
}

class ComparablePerformance {
  final String title;
  final int? domesticGross;
  final int? worldwideGross;
  final int? budget;
  final double? roi;
  
  ComparablePerformance({
    required this.title,
    this.domesticGross,
    this.worldwideGross,
    this.budget,
    this.roi,
  });
}
