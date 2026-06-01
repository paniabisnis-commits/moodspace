import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/app_lock_service.dart';
import 'home_screen.dart';
import 'mood_decor.dart';
import 'mood_model.dart';

class PatternLockScreen extends StatefulWidget {
  final String userName;

  const PatternLockScreen({
    super.key,
    required this.userName,
  });

  @override
  State<PatternLockScreen> createState() =>
      _PatternLockScreenState();
}

class _PatternLockScreenState
    extends State<PatternLockScreen> {

  final List<int> selectedDots = [];

  Future<void> verifyPattern() async {

  final navigator = Navigator.of(context);
  final messenger = ScaffoldMessenger.of(context);

  final prefs =
      await SharedPreferences.getInstance();

  final savedPattern =
      prefs.getString('security_pattern') ?? '';

  final currentPattern =
      selectedDots.join('-');

  if (savedPattern == currentPattern) {

  AppLockService.setLockShowing(false);

  if (!mounted) return;

  navigator.pushReplacement(
    MaterialPageRoute(
      builder: (_) => HomeScreen(
        userName: widget.userName,
      ),
    ),
  );
}
  else {

    messenger.showSnackBar(
      const SnackBar(
        content: Text('Pola salah'),
      ),
    );

    setState(() {
      selectedDots.clear();
    });

  }

}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: appBackground,
    body: MoodDecorBackground(
      accentColor: appPrimary,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                MoodHeader(
                  title: 'Keamanan MoodSpace',
                  subtitle:
                      'Masukkan pola untuk membuka aplikasi',
                  icon: Icons.gesture_rounded,
                  accentColor: appPrimary,
                ),

                const SizedBox(height: 24),

                SectionAccentCard(
                  child: Column(
                    children: [

                      SizedBox(
                        width: 240,
                        height: 240,
                        child: GridView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: 9,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 18,
                          ),
                          itemBuilder: (context, index) {

                            final dot = index + 1;

                            final selected =
                                selectedDots.contains(dot);

                            return InkWell(
                              borderRadius:
                                  BorderRadius.circular(999),
                              onTap: () {

                                setState(() {

                                  if (!selected) {
                                    selectedDots.add(dot);
                                  }

                                });

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selected
                                      ? appPrimary
                                      : appPrimary.withValues(
                                          alpha: 0.12,
                                        ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$dot',
                                    style: TextStyle(
                                      color: selected
                                          ? Colors.white
                                          : appPrimary,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: verifyPattern,
                          child: const Text(
                            'Verifikasi Pola',
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedDots.clear();
                          });
                        },
                        child: const Text(
                          'Ulangi Pola',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}