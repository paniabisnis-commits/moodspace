import 'package:flutter/material.dart';

import 'mood_decor.dart';
import 'onboarding_screen.dart';

class IntroFlowScreen extends StatefulWidget {
  const IntroFlowScreen({super.key});

  @override
  State<IntroFlowScreen> createState() => _IntroFlowScreenState();
}

class _IntroFlowScreenState extends State<IntroFlowScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<Map<String, dynamic>> pages = const [
    {
      'title': 'Kenali Perasaanmu',
      'desc':
          'MoodSpace membantu kamu memahami emosi dengan cara yang sederhana.',
      'icon': Icons.favorite_rounded,
    },
    {
      'title': 'Lebih Dekat dengan Dirimu',
      'desc': 'Lihat pola perasaanmu dan temukan versi terbaik dari dirimu.',
      'icon': Icons.spa_rounded,
    },
    {
      'title': 'Mulai Perjalananmu',
      'desc':
          'Setiap hari adalah kesempatan baru untuk mengenal dirimu lebih dalam.',
      'icon': Icons.auto_awesome_rounded,
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: MoodDecorBackground(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.skip_next_rounded),
                  label: const Text('Lewati'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _AnimatedPage(
                      title: pages[index]['title'] as String,
                      desc: pages[index]['desc'] as String,
                      icon: pages[index]['icon'] as IconData,
                      isActive: index == currentPage,
                      controller: _controller,
                      index: index,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? const Color(0xFF5C6BC0)
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: nextPage,
                    child: Text(
                      currentPage == pages.length - 1
                          ? 'Mulai Perjalanan'
                          : 'Selanjutnya',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedPage extends StatelessWidget {
  const _AnimatedPage({
    required this.title,
    required this.desc,
    required this.icon,
    required this.isActive,
    required this.controller,
    required this.index,
  });

  final String title;
  final String desc;
  final IconData icon;
  final bool isActive;
  final PageController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 0;

        try {
          value =
              (controller.page ?? controller.initialPage.toDouble()) - index;
        } catch (_) {
          value = 0;
        }

        final translateX = value * 80;

        return Transform.translate(
          offset: Offset(translateX, 0),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.9, end: 1.05),
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: isActive ? scale : 0.9,
                          child: child,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(
                                0xFF5C6BC0,
                              ).withValues(alpha: 0.08),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF5C6BC0,
                                  ).withValues(alpha: 0.25),
                                  blurRadius: 40,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 24,
                            left: 18,
                            child: Icon(
                              Icons.auto_awesome_rounded,
                              color: const Color(
                                0xFF98A4E8,
                              ).withValues(alpha: 0.6),
                              size: 22,
                            ),
                          ),
                          Positioned(
                            bottom: 28,
                            right: 26,
                            child: Transform.rotate(
                              angle: 0.2,
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(
                                      0xFF7986CB,
                                    ).withValues(alpha: 0.45),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          Icon(icon, size: 70, color: const Color(0xFF5C6BC0)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isActive ? 1 : 0.3,
                      child: Transform.translate(
                        offset: Offset(0, isActive ? 0 : 20),
                        child: Column(
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              desc,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
