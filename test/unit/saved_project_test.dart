import 'package:flutter_test/flutter_test.dart';
import 'package:tinseltown_iq/main.dart';

void main() {
  group('SavedProject', () {
    test('creates instance with required fields', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'My Movie',
        logline: 'A hero saves the day',
        synopsis: 'Detailed story here',
        genre: 'Action',
        format: 'Feature Film',
        score: 75,
        verdict: 'Consider Development',
        analyzedAt: DateTime(2024, 1, 15),
      );

      expect(project.id, equals('proj123'));
      expect(project.title, equals('My Movie'));
      expect(project.score, equals(75));
      expect(project.verdict, equals('Consider Development'));
    });

    test('subtitle returns format and genre', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'My Movie',
        logline: 'A hero saves the day',
        synopsis: '',
        genre: 'Action',
        format: 'Feature Film',
        score: 75,
        verdict: 'Consider Development',
        analyzedAt: DateTime(2024, 1, 15),
      );

      // Subtitle format is "Format • Genre"
      expect(project.subtitle, equals('Feature Film • Action'));
    });

    test('isFavorite defaults to false', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'My Movie',
        logline: 'A hero saves the day',
        synopsis: '',
        genre: 'Action',
        format: 'Feature Film',
        score: 75,
        verdict: 'Consider Development',
        analyzedAt: DateTime.now(),
      );

      expect(project.isFavorite, isFalse);
    });

    test('copyWith updates fields correctly', () {
      final original = SavedProject(
        id: 'proj123',
        title: 'Original Title',
        logline: 'Original logline',
        synopsis: '',
        genre: 'Drama',
        format: 'Feature Film',
        score: 60,
        verdict: 'Needs Work',
        analyzedAt: DateTime(2024, 1, 15),
      );

      final updated = original.copyWith(
        title: 'Updated Title',
        score: 85,
      );

      expect(updated.title, equals('Updated Title'));
      expect(updated.score, equals(85));
      expect(updated.logline, equals('Original logline'));
      expect(updated.genre, equals('Drama'));
    });
  });

  group('ScoreHistory', () {
    test('creates instance with all fields', () {
      final history = ScoreHistory(
        score: 72,
        analyzedAt: DateTime(2024, 1, 15),
        version: 1,
      );

      expect(history.score, equals(72));
      expect(history.version, equals(1));
      expect(history.analyzedAt, equals(DateTime(2024, 1, 15)));
    });

    test('toJson serializes correctly', () {
      final history = ScoreHistory(
        score: 72,
        analyzedAt: DateTime(2024, 1, 15),
        version: 1,
      );

      final json = history.toJson();

      expect(json['score'], equals(72));
      expect(json['version'], equals(1));
      expect(json['analyzedAt'], isNotEmpty);
    });

    test('fromJson deserializes correctly', () {
      final json = {
        'score': 85,
        'version': 2,
        'analyzedAt': DateTime(2024, 2, 1).toIso8601String(),
      };

      final history = ScoreHistory.fromJson(json);

      expect(history.score, equals(85));
      expect(history.version, equals(2));
    });
  });

  group('SavedProject score tracking', () {
    test('scoreHistory tracks multiple analyses', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'Evolving Script',
        logline: 'A story that improves',
        synopsis: '',
        genre: 'Drama',
        format: 'Feature Film',
        score: 75,
        verdict: 'Consider Development',
        analyzedAt: DateTime(2024, 1, 15),
        scoreHistory: [
          ScoreHistory(score: 60, analyzedAt: DateTime(2024, 1, 1), version: 1),
          ScoreHistory(score: 68, analyzedAt: DateTime(2024, 1, 8), version: 2),
          ScoreHistory(score: 75, analyzedAt: DateTime(2024, 1, 15), version: 3),
        ],
      );

      expect(project.scoreHistory.length, equals(3));
      expect(project.scoreHistory.first.score, equals(60));
      expect(project.scoreHistory.last.score, equals(75));
    });

    test('scoreChange calculates improvement', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'Improving Script',
        logline: 'Getting better',
        synopsis: '',
        genre: 'Drama',
        format: 'Feature Film',
        score: 75,
        verdict: 'Consider Development',
        analyzedAt: DateTime(2024, 1, 15),
        scoreHistory: [
          ScoreHistory(score: 60, analyzedAt: DateTime(2024, 1, 1), version: 1),
          ScoreHistory(score: 75, analyzedAt: DateTime(2024, 1, 15), version: 2),
        ],
      );

      expect(project.scoreChange, equals(15));
    });

    test('hasImproved returns true for positive change', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'Better Script',
        logline: 'Improved',
        synopsis: '',
        genre: 'Drama',
        format: 'Feature Film',
        score: 80,
        verdict: 'Greenlight',
        analyzedAt: DateTime(2024, 1, 15),
        scoreHistory: [
          ScoreHistory(score: 65, analyzedAt: DateTime(2024, 1, 1), version: 1),
          ScoreHistory(score: 80, analyzedAt: DateTime(2024, 1, 15), version: 2),
        ],
      );

      expect(project.hasImproved, isTrue);
    });

    test('hasImproved returns false for no improvement', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'Same Script',
        logline: 'No change',
        synopsis: '',
        genre: 'Drama',
        format: 'Feature Film',
        score: 65,
        verdict: 'Needs Work',
        analyzedAt: DateTime(2024, 1, 15),
        scoreHistory: [
          ScoreHistory(score: 65, analyzedAt: DateTime(2024, 1, 1), version: 1),
          ScoreHistory(score: 65, analyzedAt: DateTime(2024, 1, 15), version: 2),
        ],
      );

      expect(project.hasImproved, isFalse);
    });
  });

  group('SavedProject JSON serialization', () {
    test('toJson includes all fields', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'Test Project',
        logline: 'A test logline',
        synopsis: 'Test synopsis',
        genre: 'Thriller',
        format: 'Limited Series',
        score: 82,
        verdict: 'Strong Consider',
        analyzedAt: DateTime(2024, 1, 15),
        isFavorite: true,
      );

      final json = project.toJson();

      expect(json['id'], equals('proj123'));
      expect(json['title'], equals('Test Project'));
      expect(json['score'], equals(82));
      expect(json['isFavorite'], isTrue);
    });

    test('fromJson reconstructs project correctly', () {
      final json = {
        'id': 'proj456',
        'title': 'Loaded Project',
        'logline': 'Loaded logline',
        'synopsis': 'Loaded synopsis',
        'genre': 'Comedy',
        'format': 'Feature Film',
        'score': 70,
        'verdict': 'Consider',
        'analyzedAt': DateTime(2024, 2, 1).toIso8601String(),
        'isFavorite': false,
        'scoreHistory': [],
      };

      final project = SavedProject.fromJson(json);

      expect(project.id, equals('proj456'));
      expect(project.title, equals('Loaded Project'));
      expect(project.score, equals(70));
      expect(project.genre, equals('Comedy'));
    });
  });

  group('SavedProject.toConceptData', () {
    test('converts to ConceptData for re-analysis', () {
      final project = SavedProject(
        id: 'proj123',
        title: 'Re-analyze This',
        logline: 'A compelling story',
        synopsis: 'Full synopsis here',
        genre: 'Sci-Fi',
        format: 'Feature Film',
        score: 72,
        verdict: 'Consider',
        analyzedAt: DateTime.now(),
      );

      final conceptData = project.toConceptData();

      expect(conceptData.logline, equals('A compelling story'));
      expect(conceptData.synopsis, equals('Full synopsis here'));
      expect(conceptData.genre, equals('Sci-Fi'));
      expect(conceptData.format, equals('Feature Film'));
    });
  });
}
