import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_lock/pattern_lock.dart';
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
  messenger.showSnackBar(
  const SnackBar(
    backgroundColor: Colors.green,
    content: Text('Pola benar'),
    duration: Duration(milliseconds: 800),
  ),
);

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
        backgroundColor: Colors.red,
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
                      width: 220,
                      height: 220,
                      child: Stack(
                        children: [


                          PatternLock(
                            selectedColor: Colors.indigo,
                            notSelectedColor: Colors.indigo.shade200,
                            pointRadius: 10,

                            onInputComplete: (List<int> input) {

                              HapticFeedback.mediumImpact();

                              setState(() {
                                selectedDots.clear();
                                selectedDots.addAll(input);
                              });

                            },
                          ),

                          const SizedBox(height: 10),

                          Text(
                            selectedDots.isEmpty
                                ? 'Belum ada pola'
                                : 'Pola: ${selectedDots.join("-")}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
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

