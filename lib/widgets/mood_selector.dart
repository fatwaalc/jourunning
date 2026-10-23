import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../models/journal_entry.dart';

/// Satu kotak mood (emoji + label). Dipakai di form dan detail.
class MoodTile extends StatelessWidget {
  final Mood mood;
  final bool selected;
  final VoidCallback? onTap;

  const MoodTile({
    super.key,
    required this.mood,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.moodSelected : AppColors.moodUnselected,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(mood.emoji, style: const TextStyle(fontSize: 30)),
          ),
          const SizedBox(height: 4),
          Text(mood.label, style: AppTextStyles.brush(16, color: AppColors.grey)),
        ],
      ),
    );
  }
}

/// Pilihan mood di Form 2.
class MoodSelector extends StatelessWidget {
  final Mood selected;
  final ValueChanged<Mood> onChanged;

  const MoodSelector({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 36,
      children: Mood.values
          .map((m) => MoodTile(
        mood: m,
        selected: m == selected,
        onTap: () => onChanged(m),
      ))
          .toList(),
    );
  }
}