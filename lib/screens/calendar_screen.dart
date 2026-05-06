import 'package:flutter/material.dart';

import 'mood_decor.dart';
import 'mood_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    super.key,
    required this.moodHistory,
    required this.onOpenMoodEntry,
  });

  final List<MoodModel> moodHistory;
  final VoidCallback onOpenMoodEntry;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime currentMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(
      currentMonth.year,
      currentMonth.month,
    );
    final firstDayWeekday = DateTime(
      currentMonth.year,
      currentMonth.month,
      1,
    ).weekday;
    final selectedMood = _getMoodForDate(selectedDate);

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
                    title: 'Kalender Mood',
                    subtitle: 'Pantau catatan emosimu',
                    icon: Icons.calendar_month_rounded,
                    accentColor: appPrimary,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
                child: Column(
                  children: [
                    SectionAccentCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                currentMonth = DateTime(
                                  currentMonth.year,
                                  currentMonth.month - 1,
                                );
                              });
                            },
                            icon: const Icon(Icons.chevron_left_rounded),
                          ),
                          Text(
                            '${_monthName(currentMonth.month)} ${currentMonth.year}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                currentMonth = DateTime(
                                  currentMonth.year,
                                  currentMonth.month + 1,
                                );
                              });
                            },
                            icon: const Icon(Icons.chevron_right_rounded),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: const [
                        _DayLabel('Sen'),
                        _DayLabel('Sel'),
                        _DayLabel('Rab'),
                        _DayLabel('Kam'),
                        _DayLabel('Jum'),
                        _DayLabel('Sab'),
                        _DayLabel('Min'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: daysInMonth + (firstDayWeekday - 1),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                      itemBuilder: (context, index) {
                        if (index < firstDayWeekday - 1) {
                          return const SizedBox.shrink();
                        }

                        final day = index - (firstDayWeekday - 2);
                        final date = DateTime(
                          currentMonth.year,
                          currentMonth.month,
                          day,
                        );
                        final mood = _getMoodForDate(date);
                        final isSelected = DateUtils.isSameDay(
                          date,
                          selectedDate,
                        );
                        final isToday = DateUtils.isSameDay(
                          date,
                          DateTime.now(),
                        );

                        return InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () => setState(() => selectedDate = date),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            decoration: BoxDecoration(
                              color: mood != null
                                  ? mood.definition.color.withValues(
                                      alpha: isSelected ? 0.92 : 0.18,
                                    )
                                  : isSelected
                                  ? appPrimary.withValues(alpha: 0.16)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isToday
                                    ? appPrimary
                                    : mood != null
                                    ? mood.definition.color.withValues(
                                        alpha: 0.24,
                                      )
                                    : const Color(0xFFE4E9F8),
                                width: isToday ? 1.5 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: mood != null
                                ? Center(
                                    child: Icon(
                                      mood.definition.icon,
                                      size: 22,
                                      color: isSelected
                                          ? Colors.white
                                          : mood.definition.color,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      '$day',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: isSelected
                                            ? appPrimary
                                            : const Color(0xFF4D587A),
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    SectionAccentCard(
                      child: selectedMood == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _dateLabel(selectedDate),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Belum ada catatan mood di tanggal ini.',
                                  style: TextStyle(color: Color(0xFF727C9D)),
                                ),
                                const SizedBox(height: 14),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: widget.onOpenMoodEntry,
                                    icon: const Icon(Icons.edit_note_rounded),
                                    label: const Text('Catat Mood'),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _dateLabel(selectedDate),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: selectedMood.definition.color
                                            .withValues(alpha: 0.16),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        selectedMood.definition.icon,
                                        color: selectedMood.definition.color,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      selectedMood.mood,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: appInk,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  selectedMood.note.isEmpty
                                      ? 'Tidak ada catatan tambahan.'
                                      : selectedMood.note,
                                  style: const TextStyle(
                                    color: Color(0xFF6C7799),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: selectedMood.activities.map((
                                    activity,
                                  ) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedMood.definition.color
                                            .withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Text(
                                        activity,
                                        style: TextStyle(
                                          color: selectedMood.definition.color,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 52,
                                        child: OutlinedButton.icon(
                                          onPressed: () {

                                            showGeneralDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              barrierLabel: "",
                                              barrierColor: Colors.black.withValues(alpha: 0.4),
                                              transitionDuration: const Duration(milliseconds: 300),
                                              pageBuilder: (context, animation, secondaryAnimation) {
                                                return Center(
                                                  child: MoodDetailDialog(mood: selectedMood),
                                                );
                                              },
                                              transitionBuilder: (context, animation, secondaryAnimation, child) {
                                                final scale = CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves.easeOutBack,
                                                );

                                                return ScaleTransition(
                                                  scale: scale,
                                                  child: child,
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.visibility_rounded,
                                          ),
                                          label: const Text('Lihat Detail'),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: SizedBox(
                                        height: 52,
                                        child: OutlinedButton.icon(
                                          onPressed: widget.onOpenMoodEntry,
                                          icon: const Icon(Icons.edit_rounded),
                                          label: const Text('Ubah Entri'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  MoodModel? _getMoodForDate(DateTime date) {
    for (final mood in widget.moodHistory) {
      if (DateUtils.isSameDay(mood.date, date)) {
        return mood;
      }
    }
    return null;
  }

  String _monthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  String _dateLabel(DateTime date) {
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    return '${days[date.weekday - 1]}, ${date.day} ${_monthName(date.month)}';
  }
}

class _DayLabel extends StatelessWidget {
  const _DayLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF7A84A6),
          ),
        ),
      ),
    );
  }
}

class MoodDetailDialog extends StatelessWidget {
  final MoodModel mood;

  const MoodDetailDialog({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              mood.definition.color.withValues(alpha: 0.9),
              mood.definition.color.withValues(alpha: 0.6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: mood.definition.color.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              mood.definition.icon,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              mood.mood,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Energi: ${mood.energy}",
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            Text(
              mood.note.isEmpty ? "Tidak ada catatan" : mood.note,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 6,
              children: mood.activities.map((e) {
                return Chip(
                  label: Text(e),
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  labelStyle: const TextStyle(color: Colors.white),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Tutup",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
