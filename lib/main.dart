import 'package:flutter/material.dart';
import 'services/app_lock_service.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AppLockService.backgroundTime = DateTime.now();
    }

    if (state == AppLifecycleState.resumed) {
      _checkLock();
    }
  }

  Future<void> _checkLock() async {
    final hasSecurity = await AppLockService.hasSecurity();

    if (!hasSecurity) return;

    final last = AppLockService.backgroundTime;
    if (last == null) return;

    final diff = DateTime.now().difference(last).inSeconds;

    if (diff > 10) {
      AppLockService.setLockShowing(true);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoodSpace',
      home: const SplashScreen(),
    );
  }
}


