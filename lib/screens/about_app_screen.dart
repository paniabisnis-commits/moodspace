import 'package:flutter/material.dart';
import 'mood_decor.dart';
import 'mood_model.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({
    super.key,
    required this.version,
    required this.buildNumber,
  });

  final String version;
  final String buildNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: MoodDecorBackground(
      accentColor: appPrimary,
      child: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                children: [

                  ScreenBackButton(
                    onTap: () => Navigator.pop(context),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            appPrimary.withValues(alpha: 0.92),
                            appPrimary.withValues(alpha: 0.72),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: appPrimary.withValues(alpha: 0.22),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 14),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Tentang Aplikasi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 2),

                                Text(
                                  'Informasi Aplikasi dan Fitur Utama',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.cover,
                          ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'MoodSpace',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: appPrimary,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Version $version ($buildNumber)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7E88A8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    SectionAccentCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Tentang MoodSpace',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: appInk,
                            ),
                          ),

                          SizedBox(height: 14),

                          Text(
                            'MoodSpace adalah aplikasi mood tracker dan refleksi diri '
                            'yang membantu pengguna memahami pola emosi, '
                            'mencatat suasana hati, serta membangun '
                            'kebiasaan self-awareness secara lebih mindful.',
                            style: TextStyle(
                              height: 1.7,
                              color: Color(0xFF697391),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    SectionAccentCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Fitur Utama',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: appInk,
                            ),
                          ),

                          SizedBox(height: 16),

                          _FeatureTile(
                            icon: Icons.mood_rounded,
                            title: 'Mood Tracking',
                          ),

                          _FeatureTile(
                            icon: Icons.calendar_month_rounded,
                            title: 'Riwayat Kalender Mood',
                          ),

                          _FeatureTile(
                            icon: Icons.psychology_alt_rounded,
                            title: 'Analisis Pola Mood',
                          ),

                          _FeatureTile(
                            icon: Icons.bar_chart_rounded,
                            title: 'Statistik Emosi',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: Text(
                        '© 2025 MoodSpace',
                        style: TextStyle(
                          color: Color(0xFF9AA3BD),
                          fontSize: 12,
                        ),
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
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: appSecondary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: appPrimary,
            ),
          ),

          const SizedBox(width: 14),

          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: appInk,
            ),
          ),
        ],
      ),
    );
  }
}