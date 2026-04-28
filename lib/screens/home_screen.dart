import 'package:flutter/material.dart';

import 'calendar_screen.dart';
import 'home_content.dart';
import 'mood_detail_screen.dart';
import 'mood_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userName});

  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  MoodModel? currentMood;
  String energyLevel = 'Sedang';
  final List<MoodModel> moodHistory = [];
  final Set<String> selectedInfluences = {};

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeContent(
        userName: widget.userName,
        currentMood: currentMood,
        energyLevel: energyLevel,
        selectedInfluences: selectedInfluences,
        onProfileTap: _openProfileSheet,
        onMoodTap: _openMoodDetail,
        onInfluenceTap: _toggleInfluence,
        onEnergyTap: _showEnergySheet,
        onLogMoodTap: () =>
            _openMoodDetail(currentMood?.definition ?? moodDefinitions[1]),
        onStreakTap: _showStreakSheet,
        onReflectionTap: _showReflectionSheet,
      ),
      CalendarScreen(
        moodHistory: moodHistory,
        onOpenMoodEntry: () =>
            _openMoodDetail(currentMood?.definition ?? moodDefinitions[2]),
      ),
      _buildAnalysisPage(),
      _buildStatisticsPage(),
      _buildSettingsPage(),
    ];

    return Scaffold(
      backgroundColor: appBackground,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: List.generate(_tabs.length, (index) {
              final tab = _tabs[index];
              final selected = _selectedIndex == index;
              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () => setState(() => _selectedIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? appPrimary.withValues(alpha: 0.14)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          tab.icon,
                          color: selected
                              ? appPrimary
                              : const Color(0xFF9AA3C0),
                          size: 22,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tab.label,
                          style: TextStyle(
                            fontSize: 11,
                            color: selected
                                ? appPrimary
                                : const Color(0xFF9AA3C0),
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> _openMoodDetail(MoodDefinition definition) async {
    final result = await Navigator.of(context).push<MoodModel>(
      MaterialPageRoute(
        builder: (_) => MoodDetailScreen(
          definition: definition,
          initialEnergy: energyLevel,
        ),
      ),
    );

    if (result == null) return;

    setState(() {
      currentMood = result;
      energyLevel = result.energy;
      moodHistory.removeWhere(
        (item) => DateUtils.isSameDay(item.date, result.date),
      );
      moodHistory.add(result);
      moodHistory.sort((a, b) => b.date.compareTo(a.date));
      _selectedIndex = 0;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood ${result.mood} berhasil disimpan.')),
    );
  }

  void _toggleInfluence(String tag) {
    setState(() {
      if (!selectedInfluences.add(tag)) {
        selectedInfluences.remove(tag);
      }
    });
  }

  void _showEnergySheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Energi Kamu Hari Ini',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: energyLevels.map((level) {
                  final selected = energyLevel == level;
                  final color = switch (level) {
                    'Rendah' => const Color(0xFFE57373),
                    'Tinggi' => const Color(0xFF66BB6A),
                    _ => const Color(0xFFFFB74D),
                  };

                  return InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      setState(() => energyLevel = level);
                      Navigator.of(context).pop();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selected ? color : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          if (selected)
                            BoxShadow(
                              color: color.withValues(alpha: 0.36),
                              blurRadius: 14,
                              spreadRadius: 1,
                            ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            level == 'Rendah'
                                ? Icons.battery_1_bar_rounded
                                : level == 'Sedang'
                                ? Icons.battery_3_bar_rounded
                                : Icons.battery_full_rounded,
                            color: selected ? Colors.white : color,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            level,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showReflectionSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Refleksi Hari Ini',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF33406B),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                currentMood == null
                    ? 'Coba mulai dengan satu catatan mood sederhana hari ini.'
                    : 'Perasaan ${currentMood!.mood.toLowerCase()} muncul bersama energi ${currentMood!.energy.toLowerCase()}. Coba jaga ritme yang membuatmu lebih nyaman.',
                style: const TextStyle(height: 1.5, color: Color(0xFF657091)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStreakSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mood Streak',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF33406B),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                moodHistory.isEmpty
                    ? 'Belum ada streak. Yuk mulai check-in hari ini.'
                    : 'Kamu sudah punya ${moodHistory.length} catatan mood. Pertahankan konsistensimu ya.',
                style: const TextStyle(height: 1.5, color: Color(0xFF657091)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openProfileSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profil Kamu',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Hai ${widget.userName}, terus lanjutkan perjalanan refleksimu bersama MoodSpace.',
                style: const TextStyle(color: Color(0xFF657091), height: 1.5),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() => _selectedIndex = 4);
                },
                icon: const Icon(Icons.settings_rounded),
                label: const Text('Buka Pengaturan'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnalysisPage() {
    final moodCount = <String, int>{};
    for (final mood in moodHistory) {
      moodCount.update(mood.mood, (value) => value + 1, ifAbsent: () => 1);
    }

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
        children: [
          const Text(
            'Analisis Suasana Hati',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF33406B),
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Mingguan', label: Text('Mingguan')),
              ButtonSegment(value: 'Bulanan', label: Text('Bulanan')),
              ButtonSegment(value: 'Tahunan', label: Text('Tahunan')),
            ],
            selected: const {'Bulanan'},
            onSelectionChanged: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Filter ${value.first} dipilih.')),
              );
            },
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: _cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Distribusi Emosi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...moodDefinitions.map((definition) {
                  final count = moodCount[definition.label] ?? 0;
                  final maxValue = moodHistory.isEmpty
                      ? 1.0
                      : moodHistory.length.toDouble();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(
                          definition.icon,
                          color: definition.color,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(width: 70, child: Text(definition.label)),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: count / maxValue,
                              minHeight: 9,
                              backgroundColor: const Color(0xFFE5E9F8),
                              color: definition.color,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('$count'),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _showReflectionSheet,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Lihat Detail'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _insightCard(
            title: 'Pola Ditemukan',
            body:
                'Kamu cenderung lebih tenang ketika ada waktu istirahat yang cukup dan rutinitas yang terjaga.',
            primaryLabel: 'Pelajari Pola',
            onPrimaryTap: _showReflectionSheet,
            secondaryLabel: 'Lihat Hubungan',
            onSecondaryTap: () => _showSimpleDialog(
              'Hubungan Emosi',
              'Aktivitas keluarga dan tidur cukup paling sering muncul saat mood kamu lebih stabil.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsPage() {
    final counts = <String, int>{};
    for (final mood in moodHistory) {
      counts.update(mood.mood, (value) => value + 1, ifAbsent: () => 1);
    }
    final topMood = counts.entries.isEmpty
        ? 'Belum ada data'
        : counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
        children: [
          const Text(
            'Tren Perasaanmu',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF33406B),
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Mingguan', label: Text('Mingguan')),
              ButtonSegment(value: 'Bulanan', label: Text('Bulanan')),
            ],
            selected: const {'Mingguan'},
            onSelectionChanged: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Statistik ${value.first} dibuka.')),
              );
            },
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: _cardDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ringkasan Mood',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: moodDefinitions.map((definition) {
                      final value = (counts[definition.label] ?? 0).toDouble();
                      final height = 30 + (value * 22);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: height,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      definition.color.withValues(alpha: 0.5),
                                      definition.color,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Icon(
                                definition.icon,
                                size: 16,
                                color: definition.color,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                const Icon(Icons.insights_rounded, color: appPrimary, size: 30),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mood Terbanyak',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        topMood,
                        style: const TextStyle(color: Color(0xFF697391)),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => _showSimpleDialog(
                    'Wawasan Mingguan',
                    'Mood yang paling sering muncul saat ini adalah $topMood.',
                  ),
                  child: const Text('Pelajari Tren'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsPage() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
        children: [
          const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF33406B),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Color(0xFFE6EAFA),
                  child: Icon(Icons.person_rounded, color: appPrimary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Lihat profil dan pengaturan akun',
                        style: TextStyle(color: Color(0xFF6A7597)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _openProfileSheet,
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...[
            (
              'Notifikasi',
              Icons.notifications_none_rounded,
              _showNotificationSheet,
            ),
            ('Waktu Pengingat', Icons.schedule_rounded, _showReminderSheet),
            (
              'Keamanan & Privasi',
              Icons.lock_outline_rounded,
              () {
                _showSimpleDialog(
                  'Keamanan & Privasi',
                  'Atur kenyamanan akses aplikasi dan privasi data mood kamu di sini.',
                );
              },
            ),
            (
              'Ekspor Data',
              Icons.file_download_outlined,
              () {
                _showSimpleDialog(
                  'Ekspor Data',
                  'Data mood bisa diekspor ke format CSV atau PDF pada versi berikutnya.',
                );
              },
            ),
          ].map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: item.$3,
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: _cardDecoration(),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: appSecondary.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(item.$2, color: appPrimary),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          item.$1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF95A0C1),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  Widget _insightCard({
    required String title,
    required String body,
    required String primaryLabel,
    required VoidCallback onPrimaryTap,
    required String secondaryLabel,
    required VoidCallback onSecondaryTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(height: 1.5, color: Color(0xFF697391)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onPrimaryTap,
                  child: Text(primaryLabel),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: onSecondaryTap,
                  child: Text(secondaryLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showNotificationSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        bool notifOn = true;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    value: notifOn,
                    onChanged: (value) => setModalState(() => notifOn = value),
                    title: const Text('Aktifkan notifikasi harian'),
                    subtitle: const Text(
                      'Pengingat akan muncul di waktu pilihanmu.',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showReminderSheet() {
    showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 20, minute: 0),
    );
  }

  void _showSimpleDialog(String title, String content) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.label, this.icon);

  final String label;
  final IconData icon;
}

const List<_NavItem> _tabs = [
  _NavItem('Beranda', Icons.home_rounded),
  _NavItem('Kalender', Icons.calendar_month_rounded),
  _NavItem('Analisis', Icons.psychology_alt_rounded),
  _NavItem('Statistik', Icons.bar_chart_rounded),
  _NavItem('Pengaturan', Icons.settings_rounded),
];
