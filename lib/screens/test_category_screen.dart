import 'package:flutter/material.dart';
import 'test_result_model.dart';
import 'test_category_model.dart';
import 'mood_decor.dart';
import 'mood_model.dart';

class TestCategoryScreen extends StatelessWidget {
  const TestCategoryScreen({super.key});

  static const categories = [
    TestCategory(
      title: 'Kepribadian',
      icon: Icons.psychology_rounded,
      color: Color(0xFF7C8CF8),
    ),
    TestCategory(
      title: 'Kecemasan',
      icon: Icons.health_and_safety_rounded,
      color: Color(0xFFE57373),
    ),
    TestCategory(
      title: 'Hubungan',
      icon: Icons.favorite_rounded,
      color: Color(0xFFEC407A),
    ),
    TestCategory(
      title: 'Stres',
      icon: Icons.bolt_rounded,
      color: Color(0xFFFFB74D),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: MoodDecorBackground(
    accentColor: const Color(0xFF7C8CF8), 
    child: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final item = categories[index];
            return InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TestDetailScreen(category: item),
                  ),
                );

                if (!context.mounted) return;

                if (result != null) {
                  Navigator.pop(context, result); // kirim ke Home
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, color: item.color, size: 30),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

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
          builder: (_) => ResultScreen(
            resultModel: result,
          ),
        ),
      );

      if (!mounted) return;
      Navigator.pop(context, result);
    }
  

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.category.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 20),
            Text(
              'Pertanyaan ${currentIndex + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(q.text, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),

            Wrap(
              spacing: 10,
              children: List.generate(5, (index) {
                final value = index + 1;
                final selected = answers[currentIndex] == value;

                return ChoiceChip(
                  label: Text('$value'),
                  selected: selected,
                  onSelected: (_) {
                    setState(() => answers[currentIndex] = value);
                  },
                );
              }),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: answers[currentIndex] == null ? null : next,
                child: const Text('Lanjut'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final TestResultModel resultModel;

  const ResultScreen({
    super.key,
    required this.resultModel,
  });

  Color _getLevelColor(String level) {
  switch (level) {
    case 'Sangat Tinggi':
      return Colors.red;
    case 'Tinggi':
      return Colors.orange;
    case 'Sedang':
      return Colors.blue;
    case 'Rendah':
      return Colors.green;
    default:
      return Colors.teal;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Hasil Tes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MoodDecorBackground(
        accentColor: appPrimary,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        appPrimary,
                        _getLevelColor(resultModel.level).withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: _getLevelColor(resultModel.level)
                            .withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.auto_graph_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        resultModel.testName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        resultModel.level,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Skor ${resultModel.totalScore.toStringAsFixed(1)}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                _buildCard(
                  title: 'Interpretasi',
                  icon: Icons.insights,
                  child: Text(
                    resultModel.interpretation,
                    style: const TextStyle(height: 1.6),
                  ),
                ),

                const SizedBox(height: 16),

                ...resultModel.dimensionScores.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(width: 80, child: Text(e.key)),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: e.value / 100,
                              minHeight: 8,
                              color: _getLevelColor(resultModel.level),
                              backgroundColor: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(e.value.toStringAsFixed(1)),
                      ],
                    )
                  );
                }),

                const SizedBox(height: 16),

                _buildCard(
                  title: 'Rekomendasi',
                  icon: Icons.check_circle,
                  child: Column(
                    children: resultModel.recommendations.map((rec) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_rounded, color: Colors.green, size: 18),
                            const SizedBox(width: 8),
                            Expanded(child: Text(rec)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hasil tes berhasil disimpan'),
                          duration: Duration(milliseconds: 800),
                        ),
                      );

                      await Future.delayed(const Duration(milliseconds: 800));

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Selesai',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

    Widget _buildCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return SectionAccentCard(
      accentColor: appPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: appPrimary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
