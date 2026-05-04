import 'package:flutter/material.dart';

class TestResult {
  final DateTime date;
  final Map<String, double> scores;
  final String summary;

  TestResult({
    required this.date,
    required this.scores,
    required this.summary,
  });
}

class TestHistory {
  static final List<TestResult> results = [];
}

class ResultScreen extends StatelessWidget {
  final Map<String, double> scores;

  const ResultScreen({super.key, required this.scores});

  String getSummary() {
    final avg = scores.values.reduce((a, b) => a + b) / scores.length;

    if (avg >= 4) return "Kondisi sangat baik";
    if (avg >= 3) return "Cukup stabil";
    if (avg >= 2) return "Perlu perhatian";
    return "Perlu bantuan serius";
  }

  List<String> getRecommendation() {
    List<String> rec = [];

    scores.forEach((key, value) {
      if (value < 3) {
        if (key == "Emosi") {
          rec.add("Coba journaling atau meditasi");
        } else if (key == "Energi") {
          rec.add("Perbaiki pola tidur");
        } else if (key == "Sosial") {
          rec.add("Coba hubungi teman dekat");
        }
      }
    });

    if (rec.isEmpty) rec.add("Pertahankan kebiasaan baikmu ✨");

    return rec;
  }

  @override
  Widget build(BuildContext context) {
    final summary = getSummary();
    final recommendations = getRecommendation();

    return Scaffold(
      appBar: AppBar(title: Text("Hasil Tes")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Summary: $summary", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),

            Text("Skor:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...scores.entries.map((e) => Text("${e.key}: ${e.value.toStringAsFixed(1)}")),

            const SizedBox(height: 20),

            Text("Rekomendasi:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...recommendations.map((r) => Text("• $r")),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                final result = TestResult(
                  date: DateTime.now(),
                  scores: scores,
                  summary: summary,
                );

                TestHistory.results.add(result);

                Navigator.pop(context, result);
              },
              child: Text("Simpan Hasil"),
            )
          ],
        ),
      ),
    );
  }
}

class DimensionChart extends StatelessWidget {
  final Map<String, double> scores;

  const DimensionChart({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: scores.entries.map((e) {
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: e.value * 40,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 4),
              Text(e.key, style: TextStyle(fontSize: 10))
            ],
          ),
        );
      }).toList(),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = TestHistory.results;

    return Scaffold(
      appBar: AppBar(title: Text("Riwayat Tes")),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];

          return Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.summary, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(item.date.toString()),
                  SizedBox(height: 12),
                  SizedBox(height: 120, child: DimensionChart(scores: item.scores))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
