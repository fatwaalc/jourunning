import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_text_styles.dart';
import '../core/utils/date_formatter.dart';
import '../models/journal_entry.dart';

class JournalListItem extends StatelessWidget {
  final JournalEntry entry;
  const JournalListItem({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: AppColors.listCard,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.detail,
            arguments: entry.id,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormatter.full(entry.dateTime),
                        style: AppTextStyles.brush(18, color: AppColors.grey),
                      ),
                      Text(
                        entry.title.toUpperCase(),
                        style: AppTextStyles.brush(36),
                      ),
                    ],
                  ),
                ),
                const Icon(LucideIcons.chevronRight, size: 34),
              ],
            ),
          ),
        ),
      ),
    );
  }
}