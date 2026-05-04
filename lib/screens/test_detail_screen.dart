import 'package:flutter/material.dart';

import 'mood_decor.dart';
import 'mood_model.dart';
import 'test_category_model.dart';
import 'test_result_model.dart';

class TestDetailScreen extends StatefulWidget {
  const TestDetailScreen({super.key, required this.category});

  final TestCategory category;

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  late final List<int?> answers;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    answers = List<int?>.filled(widget.category.questions.length, null);
  }

  double get progress => (currentIndex + 1) / widget.category.questions.length;

  void next() {
    if (currentIndex < widget.category.questions.length - 1) {
      setState(() => currentIndex++);
      return;
    }
    _showResult();
  }

  Future<void> _showResult() async {
    final result = TestScoring.calculate(
      testId: DateTime.now().toIso8601String(),
      testName: widget.category.title,
      answersByDimension: {
        widget.category.title: answers.map((e) => e ?? 0).toList(),
      },
    );

    final saved = await Navigator.of(context).push<TestResultModel>(
      MaterialPageRoute(builder: (_) => ResultScreen(resultModel: result)),
    );

    if (!mounted || saved == null) return;
    Navigator.of(context).pop(saved);
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.category.questions[currentIndex];

    return Scaffold(
      backgroundColor: appBackground,
      body: MoodDecorBackground(
        accentColor: widget.category.color,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Row(
                  children: [
                    ScreenBackButton(
                      onTap: () => Navigator.of(context).pop(),
                      color: widget.category.color,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MoodHeader(
                        title: widget.category.title,
                        subtitle:
                            'Jawab dengan jujur agar insight lebih akurat',
                        icon: widget.category.icon,
                        accentColor: widget.category.color,
                        compact: true,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionAccentCard(
                        accentColor: widget.category.color,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Pertanyaan ${currentIndex + 1}/${widget.category.questions.length}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF6D7695),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${(progress * 100).round()}%',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: widget.category.color,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 9,
                                color: widget.category.color,
                                backgroundColor: const Color(0xFFE8ECF9),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              question.text,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: appInk,
                                height: 1.35,
                              ),
                            ),
                            if (question.helper != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                question.helper!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF7B84A4),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(5, (index) {
                        final value = index + 1;
                        final selected = answers[currentIndex] == value;
                        final labels = [
                          'Sangat Tidak Sesuai',
                          'Tidak Sesuai',
                          'Netral',
                          'Sesuai',
                          'Sangat Sesuai',
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () =>
                                setState(() => answers[currentIndex] = value),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: selected
                                    ? widget.category.color.withValues(
                                        alpha: 0.14,
                                      )
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selected
                                      ? widget.category.color
                                      : const Color(0xFFE2E7F6),
                                  width: selected ? 1.6 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? widget.category.color
                                          : widget.category.color.withValues(
                                              alpha: 0.10,
                                            ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$value',
                                        style: TextStyle(
                                          color: selected
                                              ? Colors.white
                                              : widget.category.color,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      labels[index],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: selected
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                        color: selected
                                            ? widget.category.color
                                            : appInk,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    selected
                                        ? Icons.check_circle_rounded
                                        : Icons.radio_button_unchecked_rounded,
                                    color: selected
                                        ? widget.category.color
                                        : const Color(0xFFB2BAD3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.category.color,
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: answers[currentIndex] == null ? null : next,
                    child: Text(
                      currentIndex == widget.category.questions.length - 1
                          ? 'Lihat Hasil'
                          : 'Lanjut',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.resultModel});

  final TestResultModel resultModel;

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Sangat Tinggi':
        return const Color(0xFFE05C5C);
      case 'Tinggi':
        return const Color(0xFFF3A33D);
      case 'Sedang':
        return appPrimary;
      case 'Rendah':
        return const Color(0xFF5FB878);
      default:
        return const Color(0xFF40A2A2);
    }
  }

  List<Color> _resultGradientColors(String level) {
    switch (level) {
      case 'Sangat Tinggi':
        return const [Color(0xFFBF2F4A), Color(0xFFFF8A5B)];
      case 'Tinggi':
        return const [Color(0xFFDB7C1B), Color(0xFFFFC857)];
      case 'Sedang':
        return const [Color(0xFF4F5BCB), Color(0xFF9CA7F5)];
      case 'Rendah':
        return const [Color(0xFF2E9E6F), Color(0xFF8DE0B1)];
      default:
        return const [Color(0xFF2E8E9A), Color(0xFF84D8DB)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final levelColor = _getLevelColor(resultModel.level);
    final gradientColors = _resultGradientColors(resultModel.level);
    return Scaffold(
      backgroundColor: appBackground,
      body: MoodDecorBackground(
        accentColor: levelColor,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Row(
                  children: [
                    ScreenBackButton(
                      onTap: () => Navigator.of(context).pop(),
                      color: levelColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MoodHeader(
                        title: 'Hasil Tes',
                        subtitle: 'Ringkasan dari jawabanmu',
                        icon: Icons.auto_graph_rounded,
                        accentColor: levelColor,
                        compact: true,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                  child: Column(
                    children: [
                      SectionAccentCard(
                        accentColor: levelColor,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: gradientColors,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.18,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.psychology_alt_rounded,
                                      color: Colors.white,
                                      size: 34,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    resultModel.testName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    resultModel.level,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Skor ${resultModel.totalScore.toStringAsFixed(1)} dari 100',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCard(
                        title: 'Interpretasi',
                        icon: Icons.insights_rounded,
                        color: levelColor,
                        child: Text(
                          resultModel.interpretation,
                          style: const TextStyle(
                            height: 1.6,
                            color: Color(0xFF697391),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCard(
                        title: 'Skor Dimensi',
                        icon: Icons.stacked_bar_chart_rounded,
                        color: levelColor,
                        child: Column(
                          children: resultModel.dimensionScores.entries.map((
                            e,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      e.key,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: LinearProgressIndicator(
                                        value: e.value / 100,
                                        minHeight: 10,
                                        backgroundColor: Colors.grey.shade200,
                                        color: levelColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: 44,
                                    child: Text(
                                      '${e.value.toStringAsFixed(0)}%',
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildCard(
                        title: 'Rekomendasi',
                        icon: Icons.favorite_rounded,
                        color: levelColor,
                        child: Column(
                          children: resultModel.recommendations.map((rec) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                rec,
                                style: const TextStyle(
                                  color: Color(0xFF697391),
                                  height: 1.5,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: levelColor,
                    ),
                    onPressed: () => Navigator.of(context).pop(resultModel),
                    child: const Text('Simpan Hasil'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return SectionAccentCard(
      accentColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
