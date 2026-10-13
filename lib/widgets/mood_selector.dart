import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class MoodSelector extends StatefulWidget {
  final Function(String) onMoodSelected;

  const MoodSelector({super.key, required this.onMoodSelected});

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  String _selectedMood = 'HAPPY';

  final List<Map<String, String>> _moods = [
    {'label': 'HAPPY', 'emoji': '😄'},
    {'label': 'NORMAL', 'emoji': '🙂'},
    {'label': 'SAD', 'emoji': '😢'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _moods.map((mood) {
        bool isSelected = _selectedMood == mood['label'];

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedMood = mood['label']!;
            });
            widget.onMoodSelected(_selectedMood);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.textBlack : AppColors.coral,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      mood['emoji']!,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  mood['label']!,
                  style: GoogleFonts.caveatBrush(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}