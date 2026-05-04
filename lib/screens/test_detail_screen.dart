import 'package:flutter/material.dart';
import 'test_result_model.dart';
import 'test_category_screen.dart';
import 'test_category_model.dart';
import 'mood_decor.dart';

class Question {
  final String text;

  const Question(this.text);
}

class TestDetailScreen extends StatefulWidget {
  final TestCategory category;

  const TestDetailScreen({super.key, required this.category});

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  final List<Question> questions = const [
    Question('Saya merasa mudah cemas'),
    Question('Saya sulit rileks'),
    Question('Saya sering overthinking'),
    Question('Saya merasa tegang sepanjang hari'),
    Question('Saya sulit tidur karena pikiran'),
  ];

  final List<int?> answers = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    answers.addAll(List.generate(questions.length, (_) => null));
  }

  double get progress => (currentIndex + 1) / questions.length;

  void next() {
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    } else {
      _showResult();
    }
  }

  Future<void> _showResult() async {
    final answersByDimension = {
      widget.category.title: answers.map((e) => e ?? 0).toList(),
    };

    final result = TestScoring.calculate(
      testId: DateTime.now().toString(),
      testName: widget.category.title,
      answersByDimension: answersByDimension,
    );

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(resultModel: result),
      ),
    );

    if (!mounted) return;
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MoodDecorBackground(
        accentColor: widget.category.color,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SectionAccentCard(
              accentColor: widget.category.color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔥 HEADER (ganti AppBar)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.category.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// PROGRESS
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      color: widget.category.color,
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Pertanyaan ${currentIndex + 1}/${questions.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// QUESTION CARD
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Text(
                      q.text,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// CHOICE
                  Wrap(
                    spacing: 10,
                    children: List.generate(5, (index) {
                      final value = index + 1;
                      final selected = answers[currentIndex] == value;

                      return ChoiceChip(
                        label: Text('$value'),
                        selected: selected,
                        selectedColor: widget.category.color,
                        onSelected: (_) {
                          setState(() => answers[currentIndex] = value);
                        },
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.category.color,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed:
                          answers[currentIndex] == null ? null : next,
                      child: const Text(
                        'Lanjut',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}