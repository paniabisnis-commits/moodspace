import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/app_lock_service.dart';
import 'home_screen.dart';
import 'mood_decor.dart';
import 'mood_model.dart';

class PinLockScreen extends StatefulWidget {
  final String userName;

  const PinLockScreen({
    super.key,
    required this.userName,
  });

  @override
  State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  final TextEditingController controller =
      TextEditingController();

  Future<void> verifyPin() async {
    final prefs =
        await SharedPreferences.getInstance();

    final savedPin =
        prefs.getString('security_pin') ?? '';

    if (!mounted) return;

    if (controller.text == savedPin) {

      AppLockService.setLockShowing(false);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('PIN benar'),
        duration: Duration(milliseconds: 800),
      ),
    );

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => HomeScreen(
        userName: widget.userName,
      ),
    ),
  );
}
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('PIN salah'),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  subtitle: 'Masukkan PIN untuk membuka aplikasi',
                  icon: Icons.lock_rounded,
                  accentColor: appPrimary,
                ),

                const SizedBox(height: 24),

                SectionAccentCard(
                  child: Column(
                    children: [

                      CircleAvatar(
                        radius: 42,
                        backgroundColor:
                            appPrimary.withValues(alpha: 0.12),
                        child: Icon(
                          Icons.lock_rounded,
                          size: 42,
                          color: appPrimary,
                        ),
                      ),

                      const SizedBox(height: 24),

                      TextField(
                        controller: controller,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          letterSpacing: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: '••••',
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: verifyPin,
                          child: const Text(
                            'Buka MoodSpace',
                          ),
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