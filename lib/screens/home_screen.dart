import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_text_styles.dart';
import '../providers/journal_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/journal_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = context.watch<JournalProvider>().entries;

    return Scaffold(
      body: Column(
        children: [
          const BrandHeader(),
          Expanded(
            child: entries.isEmpty
                ? const _EmptyState()
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
              itemCount: entries.length + 1,
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Your Running Journaling History',
                      style: AppTextStyles.brush(20, color: AppColors.grey),
                    ),
                  );
                }
                return JournalListItem(entry: entries[i - 1]);
              },
            ),
          ),
          BottomBar(
            child: AppButton(
              label: 'LET\'S START JOURNALING',
              color: AppColors.green,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.formRun),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your next run starts here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.brush(30, weight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Put on your shoes, find your rhythm, and come back to capture it.',
              textAlign: TextAlign.center,
              style: AppTextStyles.brush(22, color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}