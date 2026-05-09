import 'package:flutter/material.dart';

import 'mood_decor.dart';
import 'mood_model.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    super.key,
    required this.userName,
    required this.currentMood,
    required this.energyLevel,
    required this.reminderTime,
    required this.selectedInfluences,
    required this.onProfileTap,
    required this.onMoodTap,
    required this.onInfluenceTap,
    required this.onEnergyTap,
    required this.onLogMoodTap,
    required this.onStreakTap,
    required this.onReflectionTap,
    required this.customInfluenceTags,
    required this.onAddCustomInfluence,
    required this.onReminderTap,
  });

  final String userName;
  final MoodModel? currentMood;
  final String energyLevel;
  final String reminderTime;
  final Set<String> selectedInfluences;
  final VoidCallback onProfileTap;
  final ValueChanged<MoodDefinition> onMoodTap;
  final ValueChanged<String> onInfluenceTap;
  final VoidCallback onEnergyTap;
  final VoidCallback onLogMoodTap;
  final VoidCallback onStreakTap;
  final VoidCallback onReflectionTap;
  final List<String> customInfluenceTags;
  final ValueChanged<String> onAddCustomInfluence;
  final VoidCallback onReminderTap;


  @override
  State<HomeContent> createState() => _HomeContentState();
}
class _HomeContentState extends State<HomeContent> {
  final List<String> customTags = [];
  final TextEditingController tagController = TextEditingController();
  List<String> get allTags => [
  ...homeInfluenceTags,
  ...customTags,
];

  void _addTag(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;

    widget.onAddCustomInfluence(trimmed); 
    widget.onInfluenceTap(trimmed); 

    tagController.clear();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moodDefinition = widget.currentMood?.definition;
      final combinedTags = [
    ...allTags,
    ...widget.customInfluenceTags,
  ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: MoodDecorBackground(
          showSparkles: false,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 26),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [appPrimary, appSecondary, appBackground],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 18,
                      top: 60,
                      child: Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white.withValues(alpha: 0.25),
                        size: 28,
                      ),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 14,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.16),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                  const SizedBox(height: 8),
                                  Text(
                                    'Halo, ${widget.userName}',
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: const CircleBorder(),
                              child: IconButton(
                                onPressed: widget.onProfileTap,
                                icon: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                ),
                                tooltip: 'Buka profil',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Bagaimana perasaanmu hari ini?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width -
                                    44, 
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: moodDefinitions.map((mood) {
                                  final selected =
                                      moodDefinition?.label == mood.label;

                                  return InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () => widget.onMoodTap(mood),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 220,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12, 
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selected
                                            ? mood.color.withValues(alpha: 0.16)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            mood.icon,
                                            color: mood.color,
                                            size: selected
                                                ? 30
                                                : 26, 
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            mood.label,
                                            style: TextStyle(
                                              fontSize: 12, 
                                              fontWeight: selected
                                                  ? FontWeight.w700
                                                  : FontWeight.w500,
                                              color: const Color(0xFF46506F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Faktor apa yang memengaruhi perasaanmu saat ini?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3B4565),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: combinedTags.map((tag) {
                          final selected = widget.selectedInfluences.contains(tag);

                          return InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () {
                              widget.onInfluenceTap(tag);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? appSecondary.withValues(alpha: 0.18)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: selected
                                      ? appPrimary
                                      : const Color(0xFFE2E7F8),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: selected
                                      ? const Color(0xFF384B9B)
                                      : const Color(0xFF5A6485),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: tagController,
                            decoration: InputDecoration(
                              hintText: 'Tambah faktor lain...',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(999),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onSubmitted: (value) {
                              _addTag(value);
                            },
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: appPrimary),
                          onPressed: () {
                            _addTag(tagController.text);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: _InfoCard(
                            title: 'Perasaan',
                            icon:
                                moodDefinition?.icon ??
                                Icons.sentiment_neutral_rounded,
                            value: moodDefinition?.label ?? 'Belum dipilih',
                            tint: (moodDefinition?.color ?? Colors.grey)
                                .withValues(alpha: 0.16),
                            iconColor:
                                moodDefinition?.color ??
                                const Color(0xFF5163B9),
                            onTap: widget.onLogMoodTap,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _InfoCard(
                            title: 'Energi',
                            icon: energyIcon(widget.energyLevel),
                            value: widget.energyLevel,
                            tint: energyColor(
                              widget.energyLevel,
                            ).withValues(alpha: 0.16),
                            iconColor: energyColor(widget.energyLevel),
                            onTap: widget.onEnergyTap,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: widget.onLogMoodTap,
                        icon: const Icon(Icons.edit_note_rounded),
                        label: const Text('Catat Mood'),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _ActionCard(
                      title: 'Pola Terlihat',
                      body: widget.currentMood == null
                          ? 'Catat mood pertamamu untuk mulai melihat pola emosi harian.'
                          : 'Kamu cenderung lebih stabil saat punya ritme istirahat yang cukup.',
                      icon: Icons.hub_rounded,
                      onTap: widget.onReflectionTap,
                      actionLabel: 'Lihat Refleksi',
                    ),
                    const SizedBox(height: 14),
                    _ActionCard(
                      title: 'Mood Streak',
                      body:
                          'Jaga konsistensimu dengan melakukan check-in setiap hari.',
                      icon: Icons.local_fire_department_rounded,
                      onTap: widget.onStreakTap,
                      actionLabel: 'Lihat Riwayat',
                    ),

                    const SizedBox(height: 14),

                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: appPrimary.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.schedule_rounded,
                                    color: appPrimary,
                                  ),
                                ),

                                const SizedBox(width: 14),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Pengingat Mood',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF33406B),
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        'Pengingat harian pukul ${widget.reminderTime}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF697391),
                                          height: 1.4,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      InkWell(
                                        onTap: widget.onReminderTap,
                                        borderRadius: BorderRadius.circular(12),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Flexible(
                                              child: Text(
                                                'Lihat Waktu Pengingat',
                                                overflow: TextOverflow.ellipsis,
                                                style:  TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(255, 0, 0, 0),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(
                                              Icons.arrow_forward_rounded, color: Color.fromARGB(255, 0, 0, 0),
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.tint,
    required this.iconColor,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final String value;
  final Color tint;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        height: 144,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF7783AF),
                ),
              ],
            ),

            const Spacer(), 

            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Color(0xFF5A6485)),
            ),

            const SizedBox(height: 4),

            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF33406B),
              ),
            ),
          ],
        )
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.onTap,
    required this.actionLabel,
  });

  final String title;
  final String body;
  final IconData icon;
  final VoidCallback onTap;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: appSecondary.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: appPrimary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33406B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6A7597),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          actionLabel,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded, size: 18,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
