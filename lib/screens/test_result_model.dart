class TestResultModel {
  final String testId;
  final String testName;
  final double totalScore;
  final String level;
  final String interpretation;
  final List<String> recommendations;
  final DateTime date;

  final Map<String, double> dimensionScores;

  TestResultModel({
    required this.testId,
    required this.testName,
    required this.totalScore,
    required this.level,
    required this.interpretation,
    required this.recommendations,
    required this.dimensionScores,
    required this.date,
  });
}

class TestScoring {
  static TestResultModel calculate({
    required String testId,
    required String testName,
    required Map<String, List<int>> answersByDimension,
  }) {
    final Map<String, double> dimensionScores = {};

    answersByDimension.forEach((dimension, answers) {
      if (answers.isEmpty) {
        dimensionScores[dimension] = 0;
      } else {
        final avg = answers.reduce((a, b) => a + b) / answers.length.toDouble();

        dimensionScores[dimension] = (avg / 5) * 100;
      }
    });

    final totalScore = dimensionScores.values.isEmpty
        ? 0.0
        : (dimensionScores.values.reduce((a, b) => a + b) /
                  dimensionScores.length)
              .toDouble();

    final level = _getLevel(totalScore);

    final interpretation = _generateInterpretation(totalScore, dimensionScores);

    final recommendations = _generateRecommendations(dimensionScores);

    return TestResultModel(
      testId: testId,
      testName: testName,
      date: DateTime.now(),
      dimensionScores: dimensionScores,
      totalScore: totalScore,
      level: level,
      interpretation: interpretation,
      recommendations: recommendations,
    );
  }

  static String _getLevel(double score) {
    if (score < 30) return 'Rendah';
    if (score < 50) return 'Cukup';
    if (score < 70) return 'Sedang';
    if (score < 85) return 'Tinggi';
    return 'Sangat Tinggi';
  }

  static String _generateInterpretation(
    double total,
    Map<String, double> dims,
  ) {
    if (dims.isEmpty) return 'Tidak ada data';
    final highest = dims.entries.reduce((a, b) => a.value > b.value ? a : b);
    final lowest = dims.entries.reduce((a, b) => a.value < b.value ? a : b);

    return '''
Skor keseluruhan kamu berada di kategori "${_getLevel(total)}".

Dimensi paling dominan: ${highest.key} (${highest.value.toStringAsFixed(1)})
Dimensi terendah: ${lowest.key} (${lowest.value.toStringAsFixed(1)})

Ini menunjukkan bahwa aspek "${highest.key}" lebih berpengaruh dalam kondisi psikologismu saat ini.
Perhatikan keseimbangan dengan aspek "${lowest.key}" agar kondisi mental tetap stabil.
''';
  }

  static List<String> _generateRecommendations(Map<String, double> dims) {
    final List<String> recs = [];

    dims.forEach((key, value) {
      if (value >= 75) {
        recs.add(
          'Tingkat "$key" cukup tinggi. Disarankan melakukan relaksasi, journaling, atau konsultasi ringan.',
        );
      } else if (value >= 50) {
        recs.add(
          'Aspek "$key" berada di level sedang. Pertahankan dengan pola hidup seimbang.',
        );
      } else {
        recs.add(
          'Aspek "$key" relatif rendah. Ini bisa menjadi area yang stabil dalam kondisi psikologismu.',
        );
      }
    });

    double avg = 0;
    if (dims.isNotEmpty) {
      avg = dims.values.reduce((a, b) => a + b) / dims.length;
    }

    if (avg > 70) {
      recs.add('Disarankan lebih banyak self-care.');
    } else if (avg < 40) {
      recs.add('Kondisi cukup baik, pertahankan.');
    }

    return recs;
  }
}
