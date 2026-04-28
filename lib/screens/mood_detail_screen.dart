import 'package:flutter/material.dart';

import 'mood_model.dart';

class MoodDetailScreen extends StatefulWidget {
  const MoodDetailScreen({
    super.key,
    required this.definition,
    required this.initialEnergy,
  });

  final MoodDefinition definition;
  final String initialEnergy;

  @override
  State<MoodDetailScreen> createState() => _MoodDetailScreenState();
}

class _MoodDetailScreenState extends State<MoodDetailScreen> {
  String? selectedFeeling;
  String selectedEnergy = 'Sedang';
  final Set<String> selectedActivities = <String>{};
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedEnergy = widget.initialEnergy;
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Catat Mood'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: widget.definition.color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.definition.icon,
                  size: 58,
                  color: widget.definition.color,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Bagaimana detail perasaanmu?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.definition.color,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: widget.definition.feelings.map((item) {
                final isSelected = selectedFeeling == item;
                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      selectedFeeling = item;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.definition.color
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : widget.definition.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            const Text(
              'Energi hari ini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: energyLevels.map((level) {
                final isSelected = selectedEnergy == level;
                return ChoiceChip(
                  selected: isSelected,
                  label: Text(level),
                  onSelected: (_) => setState(() => selectedEnergy = level),
                  selectedColor: appSecondary.withValues(alpha: 0.18),
                  labelStyle: TextStyle(
                    color: isSelected ? appPrimary : const Color(0xFF5F6A8A),
                    fontWeight: FontWeight.w600,
                  ),
                  side: BorderSide(
                    color: isSelected ? appPrimary : const Color(0xFFE1E7F6),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            const Text(
              'Apa yang kamu lakukan?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: activityOptions.map((activity) {
                final isSelected = selectedActivities.contains(activity);
                return FilterChip(
                  selected: isSelected,
                  showCheckmark: false,
                  label: Text(activity),
                  onSelected: (_) {
                    setState(() {
                      if (isSelected) {
                        selectedActivities.remove(activity);
                      } else {
                        selectedActivities.add(activity);
                      }
                    });
                  },
                  backgroundColor: Colors.white,
                  selectedColor: appSecondary.withValues(alpha: 0.18),
                  side: BorderSide(
                    color: isSelected ? appPrimary : const Color(0xFFE2E7F8),
                  ),
                  labelStyle: TextStyle(
                    color: isSelected ? appPrimary : const Color(0xFF5A6485),
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            const Text(
              'Catatan hari ini',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Tulis perasaanmu di sini...',
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedFeeling == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pilih detail perasaan dulu ya.'),
                      ),
                    );
                    return;
                  }

                  Navigator.of(context).pop(
                    MoodModel(
                      date: DateTime.now(),
                      mood: widget.definition.label,
                      feeling: selectedFeeling!,
                      note: noteController.text.trim(),
                      energy: selectedEnergy,
                      activities: selectedActivities.toList(),
                    ),
                  );
                },
                child: const Text('Simpan Mood'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
