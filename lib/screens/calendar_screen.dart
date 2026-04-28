import 'package:flutter/material.dart';

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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kalender Mood',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF33406B),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
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
                    tooltip: 'Bulan sebelumnya',
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
                    tooltip: 'Bulan berikutnya',
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
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                itemCount: daysInMonth + (firstDayWeekday - 1),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
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
                  final isSelected = DateUtils.isSameDay(date, selectedDate);
                  final isToday = DateUtils.isSameDay(date, DateTime.now());

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? appPrimary.withValues(alpha: 0.16)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isToday ? appPrimary : const Color(0xFFE4E9F8),
                          width: isToday ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$day',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? appPrimary
                                  : const Color(0xFF4D587A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (mood != null)
                            Icon(
                              mood.definition.icon,
                              size: 16,
                              color: mood.definition.color,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
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
                          child: ElevatedButton(
                            onPressed: widget.onOpenMoodEntry,
                            child: const Text('Catat Mood'),
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
                            Icon(
                              selectedMood.definition.icon,
                              color: selectedMood.definition.color,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              selectedMood.mood,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF33406B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          selectedMood.note.isEmpty
                              ? 'Tidak ada catatan tambahan.'
                              : selectedMood.note,
                          style: const TextStyle(color: Color(0xFF6C7799)),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: selectedMood.activities.map((activity) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: appSecondary.withValues(alpha: 0.13),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                activity,
                                style: const TextStyle(
                                  color: appPrimary,
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
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        'Detail ${selectedMood.mood}',
                                      ),
                                      content: Text(
                                        'Perasaan: ${selectedMood.feeling}\n\nCatatan:\n${selectedMood.note.isEmpty ? '-' : selectedMood.note}\n\nEnergi: ${selectedMood.energy}',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('Tutup'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.visibility_rounded),
                                label: const Text('Lihat Detail'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: widget.onOpenMoodEntry,
                                icon: const Icon(Icons.edit_rounded),
                                label: const Text('Ubah Entri'),
                              ),
                            ),
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
