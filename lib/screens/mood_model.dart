import 'package:flutter/material.dart';

const Color appPrimary = Color(0xFF5C6BC0);
const Color appSecondary = Color(0xFF7986CB);
const Color appBackground = Color(0xFFF7F8FC);
const Color appInk = Color(0xFF33406B);

class MoodDefinition {
  const MoodDefinition({
    required this.label,
    required this.icon,
    required this.color,
    required this.feelings,
  });

  final String label;
  final IconData icon;
  final Color color;
  final List<String> feelings;
}

class MoodModel {
  const MoodModel({
    required this.date,
    required this.mood,
    required this.feeling,
    required this.note,
    required this.energy,
    required this.activities,
  });

  final DateTime date;
  final String mood;
  final String feeling;
  final String note;
  final String energy;
  final List<String> activities;

  MoodDefinition get definition => moodDefinitions.firstWhere(
    (item) => item.label == mood,
    orElse: () => moodDefinitions[2],
  );
}

const List<MoodDefinition> moodDefinitions = [
  MoodDefinition(
    label: 'Senang',
    icon: Icons.sentiment_very_satisfied_rounded,
    color: Color(0xFF66BB6A),
    feelings: [
      'Bahagia',
      'Antusias',
      'Bersyukur',
      'Bangga',
      'Bersemangat',
      'Optimis',
      'Terinspirasi',
      'Puas',
    ],
  ),
  MoodDefinition(
    label: 'Tenang',
    icon: Icons.sentiment_satisfied_alt_rounded,
    color: Color(0xFF5C6BC0),
    feelings: [
      'Damai',
      'Santai',
      'Nyaman',
      'Lega',
      'Ikhlas',
      'Mindful',
      'Seimbang',
    ],
  ),
  MoodDefinition(
    label: 'Netral',
    icon: Icons.sentiment_neutral_rounded,
    color: Color(0xFF90A4AE),
    feelings: [
      'Biasa saja',
      'Fokus',
      'Stabil',
      'Tidak banyak emosi',
      'Flat',
      'Diam',
      'Mengalir saja',
    ],
  ),
  MoodDefinition(
    label: 'Sedih',
    icon: Icons.sentiment_dissatisfied_rounded,
    color: Color(0xFF8A7FD1),
    feelings: [
      'Kecewa',
      'Sepi',
      'Lelah emosional',
      'Cemas',
      'Galau',
      'Kehilangan',
      'Tidak berdaya',
      'Sedikit down',
    ],
  ),
  MoodDefinition(
    label: 'Marah',
    icon: Icons.sentiment_very_dissatisfied_rounded,
    color: Color(0xFFEF5350),
    feelings: [
      'Kesal',
      'Frustrasi',
      'Tersinggung',
      'Jengkel',
      'Kesal berulang',
      'Tidak dihargai',
      'Emosi meledak',
    ],
  ),
];

const List<Map<String, dynamic>> onboardingGoals = [
  {'title': 'Temukan kepribadian', 'icon': Icons.psychology_rounded},
  {
    'title': 'Kurangi stres dan kecemasan',
    'icon': Icons.self_improvement_rounded,
  },
  {
    'title': 'Sembuhkan trauma masa lalu',
    'icon': Icons.favorite_outline_rounded,
  },
  {'title': 'Atasi rasa kesepian', 'icon': Icons.people_outline_rounded},
  {'title': 'Berhenti overthinking', 'icon': Icons.lightbulb_outline_rounded},
  {'title': 'Lebih produktif', 'icon': Icons.task_alt_rounded},
  {'title': 'Tingkatkan energi diri', 'icon': Icons.bolt_rounded},
];

const List<String> activityOptions = [
  'Kerja',
  'Sekolah',
  'Olahraga',
  'Tidur',
  'Makan',
  'Healing',
  'Bersosialisasi',
];

const List<String> homeInfluenceTags = [
  'Pekerjaan',
  'Keluarga',
  'Kesehatan',
  'Cuaca',
  'Tidur',
  'Hobi',
];

const List<String> energyLevels = ['Rendah', 'Sedang', 'Tinggi'];

Color energyColor(String level) {
  switch (level) {
    case 'Rendah':
      return const Color(0xFFE57373);
    case 'Tinggi':
      return const Color(0xFF66BB6A);
    default:
      return const Color(0xFFFFB74D);
  }
}

IconData energyIcon(String level) {
  switch (level) {
    case 'Rendah':
      return Icons.battery_1_bar_rounded;
    case 'Tinggi':
      return Icons.battery_full_rounded;
    default:
      return Icons.battery_3_bar_rounded;
  }
}
