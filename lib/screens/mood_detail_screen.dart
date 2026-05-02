import 'package:flutter/material.dart';

import 'mood_decor.dart';
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
      
      body: Stack(
        children: [
      MoodDecorBackground(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
  
                      Center(
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: widget.definition.color.withValues(
                              alpha: 0.15,
                            ),
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
                                border: Border.all(
                                  color: widget.definition.color.withValues(
                                    alpha: isSelected ? 0 : 0.18,
                                  ),
                                ),
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
                      Text(
                        'Energi hari ini',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: widget.definition.color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: energyLevels.map((level) {
                          final isSelected = selectedEnergy == level;
                          return _ColorChip(
                            label: level,
                            selected: isSelected,
                            color: widget.definition.color,
                            icon: energyIcon(level),
                            onTap: () {
                              setState(() => selectedEnergy = level);
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Apa yang kamu lakukan?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: widget.definition.color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: activityOptions.map((activity) {
                          final isSelected = selectedActivities.contains(
                            activity,
                          );
                          return _ColorChip(
                            label: activity,
                            selected: isSelected,
                            color: widget.definition.color,
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selectedActivities.remove(activity);
                                } else {
                                  selectedActivities.add(activity);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Catatan hari ini',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: widget.definition.color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: noteController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Tulis perasaanmu di sini...',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: widget.definition.color,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.definition.color,
                  ),
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
      ),
       Positioned(
            top: 0,
            left: 12,
            child: SafeArea(
              child: Material(
                color: widget.definition.color.withValues(alpha: 0.2),
                shape: const CircleBorder(),
                child: IconButton(
                  padding: const EdgeInsets.all(12),
                  iconSize: 26,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: widget.definition.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? color : color.withValues(alpha: 0.18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 17, color: selected ? Colors.white : color),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
