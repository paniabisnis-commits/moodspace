import 'package:flutter/material.dart';

import 'calendar_screen.dart';
import 'home_content.dart';
import 'mood_decor.dart';
import 'mood_detail_screen.dart';
import 'mood_model.dart';
import 'settings_detail_screens.dart';
import 'test_category_screen.dart';
import 'test_result_model.dart' as result_model;

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
  String userName = '';
  int selectedAvatarIndex = 0;
  final List<MoodModel> moodHistory = [];
  final List<result_model.TestResultModel> testHistory = [];
  final Set<String> selectedInfluences = {};
  String _analysisRange = 'Bulanan';
  String _statisticsRange = 'Mingguan';

  @override
  void initState() {
    super.initState();
    userName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeContent(
        userName: userName,
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
                  final color = energyColor(level);
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
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            energyIcon(level),
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
                  color: appInk,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                currentMood == null
                    ? 'Coba mulai dengan satu catatan mood sederhana hari ini.'
                    : 'Perasaan ${currentMood!.mood.toLowerCase()} muncul bersama energi ${energyLevel.toLowerCase()}. Coba jaga ritme yang membuatmu lebih nyaman.',
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
                  color: appInk,
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
                'Hai $userName, terus lanjutkan perjalanan refleksimu bersama MoodSpace.',
                style: const TextStyle(color: Color(0xFF657091), height: 1.5),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final updated = await Navigator.of(context)
                      .push<ProfileSettingsResult>(
                        MaterialPageRoute(
                          builder: (_) => ProfileDetailScreen(
                            userName: userName,
                            avatarIndex: selectedAvatarIndex,
                          ),
                        ),
                      );
                  if (updated is ProfileSettingsResult &&
                      updated.userName.isNotEmpty) {
                    setState(() {
                      userName = updated.userName;
                      selectedAvatarIndex = updated.avatarIndex;
                    });
                  }
                },
                icon: const Icon(Icons.person_outline_rounded),
                label: const Text('Lihat Profil'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnalysisPage() {
    final moodCount = _moodCountForRange(_analysisRange);
    final total = moodCount.values.fold<int>(0, (sum, value) => sum + value);
    final summary = _analysisSummary(_analysisRange);

    return SafeArea(
      child: MoodDecorBackground(
        accentColor: appPrimary,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverPinnedHeader(
                height: 142,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                  child: MoodHeader(
                    title: 'Analisis Suasana Hati',
                    subtitle: 'Pahami pola perasaanmu',
                    icon: Icons.psychology_rounded,
                    accentColor: appPrimary,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  children: [
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'Mingguan',
                          label: Text('Mingguan'),
                        ),
                        ButtonSegment(value: 'Bulanan', label: Text('Bulanan')),
                        ButtonSegment(value: 'Tahunan', label: Text('Tahunan')),
                      ],
                      selected: {_analysisRange},
                      onSelectionChanged: (value) {
                        setState(() => _analysisRange = value.first);
                      },
                    ),
                    const SizedBox(height: 18),
                    SectionAccentCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Distribusi Emosi ${summary['label']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...moodDefinitions.map((definition) {
                            final count = moodCount[definition.label] ?? 0;
                            final maxValue = total == 0
                                ? 1.0
                                : total.toDouble();
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
                                  SizedBox(
                                    width: 70,
                                    child: Text(definition.label),
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: LinearProgressIndicator(
                                        value: count / maxValue,
                                        minHeight: 9,
                                        backgroundColor: const Color(
                                          0xFFE5E9F8,
                                        ),
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => _showSimpleDialog(
                                'Rangkuman ${summary['label']}',
                                summary['distribution']!,
                              ),
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
                      body: summary['pattern']!,
                      primaryLabel: 'Pelajari Pola',
                      onPrimaryTap: () => _showSimpleDialog(
                        'Pola ${summary['label']}',
                        summary['pattern']!,
                      ),
                      secondaryLabel: 'Lihat Hubungan',
                      onSecondaryTap: () => _showSimpleDialog(
                        'Hubungan Emosi',
                        summary['relationship']!,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _insightCard(
                      title: 'Analisis Kepribadian',
                      body: summary['personality']!,
                      primaryLabel: 'Lihat Kepribadian',
                      onPrimaryTap: _openTestCategory,
                      secondaryLabel: 'Riwayat Tes',
                      onSecondaryTap: _showTestHistory,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsPage() {
    final counts = _moodCountForRange(_statisticsRange);
    final topMood = counts.entries.isEmpty
        ? 'Belum ada data'
        : counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    final stats = _statisticsSummary(_statisticsRange, topMood);

    return SafeArea(
      child: MoodDecorBackground(
        accentColor: appPrimary,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverPinnedHeader(
                height: 142,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                  child: MoodHeader(
                    title: 'Pola Perasaanmu',
                    subtitle: 'Statistik emosimu',
                    icon: Icons.bar_chart_rounded,
                    accentColor: appPrimary,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  children: [
                    SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'Mingguan',
                          label: Text('Mingguan'),
                        ),
                        ButtonSegment(value: 'Bulanan', label: Text('Bulanan')),
                      ],
                      selected: {_statisticsRange},
                      onSelectionChanged: (value) {
                        setState(() => _statisticsRange = value.first);
                      },
                    ),
                    const SizedBox(height: 18),
                    SectionAccentCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ringkasan Mood ${stats['label']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 190,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: moodDefinitions.map((definition) {
                                final value = (counts[definition.label] ?? 0)
                                    .toDouble();
                                final height = (42 + (value * 18)).clamp(
                                  42.0,
                                  140.0,
                                );
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            height: height,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  definition.color.withValues(
                                                    alpha: 0.5,
                                                  ),
                                                  definition.color,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
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
                    SectionAccentCard(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.insights_rounded,
                            color: appPrimary,
                            size: 30,
                          ),
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
                                  style: const TextStyle(
                                    color: Color(0xFF697391),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => _showSimpleDialog(
                              'Wawasan ${stats['label']}',
                              stats['topMood']!,
                            ),
                            child: const Text('Pelajari Tren'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    _insightCard(
                      title: 'Dampak Aktivitas',
                      body: stats['activities']!,
                      primaryLabel: 'Lihat Aktivitas',
                      onPrimaryTap: () => _showSimpleDialog(
                        'Aktivitas yang Paling Berpengaruh',
                        _activityInsightText(),
                      ),
                      secondaryLabel: 'Ringkasan Energi',
                      onSecondaryTap: () => _showSimpleDialog(
                        'Ringkasan Energi',
                        stats['energy']!,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _insightCard(
                      title: 'Konsistensi Check-in',
                      body: stats['consistency']!,
                      primaryLabel: 'Saran Lanjutan',
                      onPrimaryTap: () =>
                          _showSimpleDialog('Saran', stats['suggestion']!),
                      secondaryLabel: 'Lihat Riwayat',
                      onSecondaryTap: _showStreakSheet,
                    ),
                    if (testHistory.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      SectionAccentCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hasil Tes Terbaru',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${testHistory.last.testName} - ${testHistory.last.level}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: appInk,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _getRecommendation(testHistory.last),
                              style: const TextStyle(color: Color(0xFF697391)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsPage() {
    return SafeArea(
      child: MoodDecorBackground(
        accentColor: appPrimary,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverPinnedHeader(
                height: 142,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                  child: MoodHeader(
                    title: 'Preferensi Kamu',
                    subtitle: 'Atur pengalamanmu',
                    icon: Icons.settings_rounded,
                    accentColor: appPrimary,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: _openProfileDetail,
                      child: SectionAccentCard(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundColor: const Color(0xFFE6EAFA),
                              child: Icon(
                                profileAvatarOptions[selectedAvatarIndex],
                                color: appPrimary,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
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
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Color(0xFF9CA4C0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...[
                      (
                        'Notifikasi',
                        Icons.notifications_none_rounded,
                        _openNotificationSettings,
                      ),
                      (
                        'Waktu Pengingat',
                        Icons.schedule_rounded,
                        _showReminderSheet,
                      ),
                      (
                        'Keamanan & Privasi',
                        Icons.lock_outline_rounded,
                        _openSecuritySettings,
                      ),
                      (
                        'Ekspor Data',
                        Icons.file_download_outlined,
                        _openExportData,
                      ),
                    ].map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: item.$3,
                          child: SectionAccentCard(
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
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: Color(0xFF9CA4C0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openProfileDetail() async {
    final updated = await Navigator.of(context).push<ProfileSettingsResult>(
      MaterialPageRoute(
        builder: (_) => ProfileDetailScreen(
          userName: userName,
          avatarIndex: selectedAvatarIndex,
        ),
      ),
    );
    if (updated != null && updated.userName.isNotEmpty) {
      setState(() {
        userName = updated.userName;
        selectedAvatarIndex = updated.avatarIndex;
      });
    }
  }

  Future<void> _openNotificationSettings() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()),
    );
  }

  Future<void> _openSecuritySettings() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SecuritySettingsScreen()));
  }

  Future<void> _openExportData() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ExportDataScreen()));
  }

  Map<String, int> _moodCountForRange(String range) {
    final seed = switch (range) {
      'Mingguan' => <String, int>{
        'Senang': 2,
        'Tenang': 4,
        'Netral': 2,
        'Sedih': 1,
        'Marah': 1,
      },
      'Tahunan' => <String, int>{
        'Senang': 18,
        'Tenang': 24,
        'Netral': 14,
        'Sedih': 9,
        'Marah': 6,
      },
      _ => <String, int>{
        'Senang': 8,
        'Tenang': 10,
        'Netral': 7,
        'Sedih': 4,
        'Marah': 3,
      },
    };

    final merged = Map<String, int>.from(seed);
    for (final mood in moodHistory) {
      merged.update(mood.mood, (value) => value + 1, ifAbsent: () => 1);
    }
    return merged;
  }

  Map<String, String> _analysisSummary(String range) {
    switch (range) {
      case 'Mingguan':
        return {
          'label': 'Mingguan',
          'distribution':
              'Dalam seminggu ini, mood tenang paling sering muncul. Saat jadwalmu rapi, respons emosimu juga terlihat lebih lembut.',
          'pattern':
              'Pola mingguan menunjukkan kamu lebih stabil di hari dengan ritme yang teratur dan waktu istirahat yang cukup.',
          'relationship':
              'Interaksi hangat dengan keluarga atau teman dekat cenderung berkaitan dengan mood yang lebih tenang.',
          'personality':
              'Secara personalitas, kamu terlihat reflektif dan butuh ruang tenang sebelum memproses emosi besar.',
        };
      case 'Tahunan':
        return {
          'label': 'Tahunan',
          'distribution':
              'Dalam gambaran tahunan, tenang dan senang masih mendominasi, tapi ada fase sedih yang muncul saat tekanan menumpuk.',
          'pattern':
              'Pola tahunan menunjukkan kamu tumbuh paling baik saat punya batasan sehat dan rutinitas yang konsisten.',
          'relationship':
              'Hubungan yang suportif membuat emosi negatif lebih cepat reda dan membantu kamu kembali ke ritme stabil.',
          'personality':
              'Kepribadianmu tampak empatik, sensitif terhadap suasana sekitar, tetapi tetap punya daya pulih yang baik.',
        };
      default:
        return {
          'label': 'Bulanan',
          'distribution':
              'Dalam sebulan ini, mood tenang dan senang cukup dominan. Itu menandakan kamu sedang punya ruang pulih yang baik.',
          'pattern':
              'Pola bulanan menunjukkan kamu lebih nyaman saat aktivitasmu seimbang antara produktif dan istirahat.',
          'relationship':
              'Aktivitas sosial yang hangat dan waktu sendiri yang cukup sama-sama berperan menjaga kestabilan emosimu.',
          'personality':
              'Kamu terlihat intuitif, hangat, dan cukup sadar kapan perlu berhenti sejenak untuk menata ulang energi.',
        };
    }
  }

  Map<String, String> _statisticsSummary(String range, String topMood) {
    switch (range) {
      case 'Bulanan':
        return {
          'label': 'Bulanan',
          'topMood':
              'Dalam sebulan ini, mood yang paling sering muncul adalah $topMood. Itu memberi gambaran arah emosimu secara lebih luas.',
          'activities':
              'Aktivitas yang paling membantu adalah tidur cukup, waktu sendiri, dan ngobrol dengan orang yang kamu percaya.',
          'energy':
              'Energi cenderung naik di awal minggu lalu menurun saat tugas menumpuk. Jeda pendek sangat membantu memulihkannya.',
          'consistency':
              'Frekuensi check-in bulananmu cukup baik. Semakin konsisten kamu mencatat, semakin jelas pola emosinya.',
          'suggestion':
              'Coba pertahankan jam tidur dan sisihkan waktu refleksi singkat 5 menit setiap malam.',
        };
      default:
        return {
          'label': 'Mingguan',
          'topMood':
              'Dalam minggu ini, mood yang paling sering muncul adalah $topMood. Ini bisa jadi sinyal bagaimana ritme harianmu berjalan.',
          'activities':
              'Kegiatan yang paling berdampak positif minggu ini adalah istirahat cukup, hobi ringan, dan aktivitas yang tidak terburu-buru.',
          'energy':
              'Energi terbaik biasanya muncul setelah pagi yang tidak tergesa dan saat kamu punya ruang bernapas di sela aktivitas.',
          'consistency':
              'Check-in mingguanmu mulai terbentuk dengan baik. Sedikit konsistensi tambahan akan membuat insight makin akurat.',
          'suggestion':
              'Pertahankan rutinitas check-in di jam yang sama agar pola mood harianmu lebih mudah dikenali.',
        };
    }
  }

  String _getRecommendation(result_model.TestResultModel test) {
    if (test.dimensionScores.isEmpty) {
      return 'Belum ada data untuk dianalisis.';
    }

    final highest = test.dimensionScores.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );

    if (highest.value >= 70) {
      return 'Aspek "${highest.key}" cukup tinggi. Coba lakukan relaksasi, journaling, atau kurangi beban yang terlalu padat.';
    }
    return 'Kondisi emosimu cukup seimbang. Pertahankan pola hidup sehat dan ritme istirahatmu.';
  }

  Widget _insightCard({
    required String title,
    required String body,
    required String primaryLabel,
    required VoidCallback onPrimaryTap,
    required String secondaryLabel,
    required VoidCallback onSecondaryTap,
  }) {
    const buttonTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
    return SectionAccentCard(
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
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onPrimaryTap,
                    child: Text(primaryLabel, style: buttonTextStyle),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: onSecondaryTap,
                    child: Text(secondaryLabel, style: buttonTextStyle),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

  Future<void> _openTestCategory() async {
    final result = await Navigator.of(context)
        .push<result_model.TestResultModel>(
          MaterialPageRoute(builder: (_) => const TestCategoryScreen()),
        );

    if (result == null) return;
    setState(() => testHistory.add(result));
  }

  void _showTestHistory() {
    if (testHistory.isEmpty) {
      _showSimpleDialog('Riwayat Tes', 'Belum ada hasil tes.');
      return;
    }
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Riwayat Tes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: appInk,
                ),
              ),
              const SizedBox(height: 14),
              ...testHistory.reversed.map((test) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SectionAccentCard(
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: appPrimary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.psychology_alt_rounded,
                            color: appPrimary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test.testName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: appInk,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Hasil akhir: ${test.level} • Skor ${test.totalScore.toStringAsFixed(1)}',
                                style: const TextStyle(
                                  color: Color(0xFF6D7695),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  String _activityInsightText() {
    if (moodHistory.isEmpty) {
      return 'Belum ada aktivitas yang cukup untuk dianalisis. Coba catat mood beserta aktivitasmu beberapa hari lagi.';
    }

    final counts = <String, int>{};
    for (final mood in moodHistory) {
      for (final activity in mood.activities) {
        counts.update(activity, (value) => value + 1, ifAbsent: () => 1);
      }
    }
    if (counts.isEmpty) {
      return 'Kamu sudah mencatat mood, tapi belum banyak aktivitas yang dipilih. Tambahkan aktivitas supaya insight ini lebih akurat.';
    }

    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final primary = sorted.first;
    final secondary = sorted.length > 1 ? sorted[1] : null;

    return secondary == null
        ? 'Aktivitas yang paling sering muncul bersama catatan mood kamu adalah ${primary.key.toLowerCase()} sebanyak ${primary.value} kali. Aktivitas ini tampaknya cukup berpengaruh pada ritme emosimu.'
        : 'Dua aktivitas yang paling sering muncul adalah ${primary.key.toLowerCase()} (${primary.value} kali) dan ${secondary.key.toLowerCase()} (${secondary.value} kali). Coba perhatikan bagaimana keduanya memengaruhi energi dan suasana hatimu.';
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
