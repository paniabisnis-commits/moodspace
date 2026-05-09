import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'intro_flow_screen.dart';
import 'mood_decor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

     _controller.forward();

    checkUser();
  }

  Future<void> checkUser() async {

  final prefs = await SharedPreferences.getInstance();

  final isOnboardingDone =
      prefs.getBool('is_onboarding_done') ?? false;

  final savedName =
      prefs.getString('user_name') ?? '';

  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return;

  if (isOnboardingDone) {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          userName: savedName,
        ),
      ),
    );

  } else {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const IntroFlowScreen(),
      ),
    );

  }
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: MoodDecorBackground(
        child: Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF7986CB,
                          ).withValues(alpha: 0.35),
                          blurRadius: 35,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 130,
                      height: 130,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'MoodSpace',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C6BC0),
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Track your feelings beautifully',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
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
