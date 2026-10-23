import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_text_styles.dart';
import '../core/utils/date_formatter.dart';
import '../models/journal_entry.dart';
import '../providers/journal_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/field_card.dart';
import '../widgets/mood_selector.dart';

class JournalDetailScreen extends StatelessWidget {
  final String entryId;
  const JournalDetailScreen({super.key, required this.entryId});

  Future<void> _confirmDelete(BuildContext context, JournalEntry entry) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text('Delete this journal?', style: AppTextStyles.brush(28)),
        content: Text(
          'This run will be removed from your history.',
          style: AppTextStyles.brush(20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('CANCEL', style: AppTextStyles.brush(20)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'DELETE',
              style: AppTextStyles.brush(20, color: AppColors.delete),
            ),
          ),
        ],
      ),
    );

    if (ok == true && context.mounted) {
      context.read<JournalProvider>().delete(entry.id);
      AppRoutes.goHome(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final entry = context.watch<JournalProvider>().getById(entryId);
    if (entry == null) return const Scaffold(); // sesaat setelah dihapus

    const gap = SizedBox(height: 14);

    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            title: 'JOURNALING\nDETAIL',
            onBack: () => Navigator.pop(context),
            onClose: () => AppRoutes.closeFlow(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(36, 16, 36, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormatter.full(entry.dateTime),
                    style: AppTextStyles.brush(20, color: AppColors.grey),
                  ),
                  Text(entry.title.toUpperCase(), style: AppTextStyles.brush(42)),
                  const SizedBox(height: 10),
                  FieldCard(
                    label: 'DISTANCE',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _Value(entry.distance),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: _Value('km'),
                        ),
                      ],
                    ),
                  ),
                  gap,
                  Row(
                    children: [
                      Expanded(
                        child: FieldCard(
                          label: 'DURATION',
                          child: _Value(entry.duration),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FieldCard(
                          label: 'AVERAGE PACE',
                          child: Row(
                            children: [
                              Flexible(child: _Value(entry.pace)),
                              const SizedBox(width: 8),
                              _Value('/km'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  gap,
                  FieldCard(label: 'LOCATION', child: _Value(entry.location)),
                  const SizedBox(height: 24),
                  MoodTile(mood: entry.mood, selected: true),
                  const SizedBox(height: 16),
                  FieldCard(label: 'GRATITUDE', child: _Value(entry.gratitude)),
                  gap,
                  FieldCard(label: 'IMPROVEMENT', child: _Value(entry.improvement)),
                  gap,
                  FieldCard(label: 'NOTES', child: _Value(entry.notes)),
                ],
              ),
            ),
          ),
          BottomBar(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: AppButton(
                    label: 'EDIT',
                    color: AppColors.editButton,
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.formRun,
                      arguments: entry,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: AppButton(
                    label: 'DELETE',
                    color: AppColors.delete,
                    onPressed: () => _confirmDelete(context, entry),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final String text;
  const _Value(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.isEmpty ? '-' : text,
      style: AppTextStyles.brush(28),
    );
  }
}