import 'package:flutter/material.dart';

class TestQuestionScreen extends StatefulWidget {
  final String title;
  const TestQuestionScreen({super.key, required this.title});

  @override
  State<TestQuestionScreen> createState() => _TestQuestionScreenState();
}

class _TestQuestionScreenState extends State<TestQuestionScreen> {
  int currentIndex = 0;

  // Skala Likert 1–5
  final List<int?> answers = List.filled(_questions.length, null);

  static const List<String> _questions = [
    "Saya mudah merasa cemas tanpa alasan jelas",
    "Saya bisa mengontrol emosi dengan baik",
    "Saya sering overthinking",
    "Saya merasa percaya diri dalam mengambil keputusan",
    "Saya mudah lelah secara mental",
  ];

  double get progress => (currentIndex + 1) / _questions.length;

  void next() {
    if (answers[currentIndex] == null) return;

    if (currentIndex < _questions.length - 1) {
      setState(() => currentIndex++);
    } else {
      _finishTest();
    }
  }

  void _finishTest() {
    final result = _calculateResult();

    Navigator.pop(context, result);
  }

  Map<String, dynamic> _calculateResult() {
    final total = answers.whereType<int>().reduce((a, b) => a + b);
    final avg = total / _questions.length;

    // contoh scoring kompleks
    String label;
    String desc;

    if (avg >= 4.2) {
      label = "Sangat Stabil";
      desc = "Kamu memiliki kontrol emosi yang sangat baik dan resilien.";
    } else if (avg >= 3.4) {
      label = "Cukup Stabil";
      desc = "Secara umum kamu stabil, tapi ada beberapa momen rentan.";
    } else if (avg >= 2.6) {
      label = "Perlu Perhatian";
      desc = "Ada tanda-tanda kecemasan atau tekanan emosional.";
    } else {
      label = "Rentan";
      desc = "Disarankan lebih memperhatikan kesehatan mentalmu.";
    }

    return {
      "score": avg,
      "label": label,
      "desc": desc,
      "answers": answers,
      "date": DateTime.now(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 20),

            Text(
              "Pertanyaan ${currentIndex + 1}/${_questions.length}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            Text(
              _questions[currentIndex],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // Likert Scale 1–5
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final value = index + 1;
                final selected = answers[currentIndex] == value;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      answers[currentIndex] = value;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: selected ? Colors.blue : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "$value",
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 10),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Tidak setuju"), Text("Sangat setuju")],
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: answers[currentIndex] == null ? null : next,
                child: Text(
                  currentIndex == _questions.length - 1
                      ? "Lihat Hasil"
                      : "Selanjutnya",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
