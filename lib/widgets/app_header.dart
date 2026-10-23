import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../core/constants/app_colors.dart';
import '../core/theme/app_text_styles.dart';

/// App bar untuk halaman form & detail (panah kembali, judul, tombol X).
class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onClose;

  const AppHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bar,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 84,
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(LucideIcons.arrowLeft, size: 32),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.brush(28).copyWith(height: 1.1),
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(LucideIcons.x, size: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// App bar untuk Home Screen (judul JOURUNNING + sub judul).
class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bar,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(36, 14, 36, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('JOURUNNING', style: AppTextStyles.marker(38)),
              Text('Journaling Running', style: AppTextStyles.brush(22)),
            ],
          ),
        ),
      ),
    );
  }
}