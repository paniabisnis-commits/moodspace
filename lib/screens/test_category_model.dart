import 'package:flutter/material.dart';

class TestQuestion {
  const TestQuestion({required this.text, this.helper});

  final String text;
  final String? helper;
}

class TestCategory {
  const TestCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.questions,
  });

  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final List<TestQuestion> questions;
}

const List<TestCategory> testCategories = [
  TestCategory(
    title: 'Tes Kepribadian',
    icon: Icons.psychology_rounded,
    color: Color(0xFF6E7FE3),
    description:
        'Kenali kecenderungan dirimu saat merespons emosi dan situasi.',
    questions: [
      TestQuestion(text: 'Saya mudah memahami perasaan diri sendiri.'),
      TestQuestion(text: 'Saya butuh waktu sendiri untuk memulihkan energi.'),
      TestQuestion(text: 'Saya nyaman menyampaikan perasaan dengan jujur.'),
      TestQuestion(text: 'Saya tetap tenang saat menghadapi perubahan.'),
      TestQuestion(text: 'Saya mampu mengenali batas kemampuan diri.'),
    ],
  ),
  TestCategory(
    title: 'Tes Kecemasan',
    icon: Icons.air_rounded,
    color: Color(0xFFE57373),
    description: 'Lihat pengaruh cemas pada harimu.',
    questions: [
      TestQuestion(text: 'Saya sering merasa gugup tanpa alasan yang jelas.'),
      TestQuestion(text: 'Saya kesulitan rileks sebelum tidur.'),
      TestQuestion(text: 'Saya sering overthinking terhadap hal kecil.'),
      TestQuestion(text: 'Tubuh saya mudah tegang saat menghadapi tekanan.'),
      TestQuestion(text: 'Saya merasa cemas saat memikirkan hari esok.'),
    ],
  ),
  TestCategory(
    title: 'Tes Hubungan',
    icon: Icons.diversity_3_rounded,
    color: Color(0xFFF06292),
    description:
        'Pahami kenyamanan emosimu dalam relasi dengan orang terdekat.',
    questions: [
      TestQuestion(text: 'Saya merasa aman saat terbuka pada orang terdekat.'),
      TestQuestion(text: 'Saya mudah terluka saat merasa diabaikan.'),
      TestQuestion(text: 'Saya bisa menyampaikan kebutuhan dengan jelas.'),
      TestQuestion(text: 'Saya nyaman menerima bantuan dari orang lain.'),
      TestQuestion(text: 'Konflik kecil sering memengaruhi suasana hati saya.'),
    ],
  ),
  TestCategory(
    title: 'Tes Stress',
    icon: Icons.thermostat_rounded,
    color: Color.fromARGB(255, 246, 163, 40),
    description: 'Ukur tekanan harian dan energimu.',
    questions: [
      TestQuestion(text: 'Saya merasa hari-hari saya berjalan terlalu cepat.'),
      TestQuestion(
        text: 'Saya sulit fokus saat banyak tugas datang bersamaan.',
      ),
      TestQuestion(text: 'Saya merasa kelelahan secara emosional.'),
      TestQuestion(text: 'Saya sering menunda istirahat meski tubuh lelah.'),
      TestQuestion(
        text: 'Saya sulit berhenti memikirkan pekerjaan atau tugas.',
      ),
    ],
  ),
  TestCategory(
    title: 'Tes Burnout',
    icon: Icons.battery_alert_rounded,
    color: Color(0xFF8D6E63),
    description: 'Kenali tanda lelah mental berkepanjangan.',
    questions: [
      TestQuestion(text: 'Saya merasa lelah bahkan setelah beristirahat.'),
      TestQuestion(
        text: 'Motivasi saya menurun dalam beberapa waktu terakhir.',
      ),
      TestQuestion(text: 'Saya merasa kosong saat menjalani aktivitas harian.'),
      TestQuestion(text: 'Tugas kecil terasa jauh lebih berat dari biasanya.'),
      TestQuestion(
        text: 'Saya sulit merasa antusias pada hal yang dulu menyenangkan.',
      ),
    ],
  ),
  TestCategory(
    title: 'Tes Fokus',
    icon: Icons.center_focus_strong_rounded,
    color: Color(0xFF4DB6AC),
    description: 'Lihat seberapa stabil konsentrasimu sehari-hari.',
    questions: [
      TestQuestion(text: 'Saya mudah terdistraksi saat mengerjakan sesuatu.'),
      TestQuestion(
        text: 'Saya sering lupa hal yang baru saja ingin saya lakukan.',
      ),
      TestQuestion(text: 'Saya sulit mempertahankan fokus dalam waktu lama.'),
      TestQuestion(
        text: 'Saya sering berpindah tugas sebelum satu tugas selesai.',
      ),
      TestQuestion(text: 'Saya merasa pikiran saya mudah bercabang.'),
    ],
  ),
  TestCategory(
    title: 'Tes Self-Esteem',
    icon: Icons.workspace_premium_rounded,
    color: Color(0xFFBA68C8),
    description: 'Pahami bagaimana kamu memandang nilai dirimu.',
    questions: [
      TestQuestion(text: 'Saya merasa diri saya cukup berharga.'),
      TestQuestion(text: 'Saya sering meragukan kemampuan diri sendiri.'),
      TestQuestion(text: 'Saya bisa menghargai pencapaian kecil saya.'),
      TestQuestion(text: 'Saya mudah membandingkan diri dengan orang lain.'),
      TestQuestion(text: 'Saya percaya saya pantas mendapatkan hal baik.'),
    ],
  ),
];
