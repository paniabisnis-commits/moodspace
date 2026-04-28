import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'mood_decor.dart';
import 'mood_model.dart';

class CommitmentScreen extends StatelessWidget {
  const CommitmentScreen({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final commitments = [
      'Aktif menjaga kenyamanan diri',
      'Menjadi versi terbaik dari diriku',
      'Mulai mengurangi overthinking',
      'Tidak menyalahkan diri sendiri',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: MoodDecorBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF7986CB,
                          ).withValues(alpha: 0.25),
                          blurRadius: 28,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset('assets/logo.png', fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '$userName, yuk kita buat komitmen',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F51B5),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Pelan-pelan, kita bangun kebiasaan yang lebih lembut untuk dirimu.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SectionAccentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mulai saat ini, aku berkomitmen untuk:',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 25),
                        ...commitments.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 22),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: appSecondary.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: Color(0xFF5C6BC0),
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF555555),
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
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(userName: userName),
                        ),
                      );
                    },
                    icon: const Icon(Icons.favorite_rounded),
                    label: const Text('Lanjutkan'),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
