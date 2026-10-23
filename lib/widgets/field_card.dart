import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/theme/app_text_styles.dart';

/// Kartu berlabel. Dipakai di form (isi: text field) dan di detail (isi: teks).
class FieldCard extends StatelessWidget {
  final String label;
  final Widget child;

  const FieldCard({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.brush(18)),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}

/// Kartu berisi text field (hint abu-abu = contoh isian untuk user).
class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? suffix;
  final int minLines;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.suffix,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: controller,
      keyboardType: minLines > 1 ? TextInputType.multiline : keyboardType,
      minLines: minLines,
      maxLines: minLines > 1 ? null : 1,
      style: AppTextStyles.brush(28),
      decoration: InputDecoration.collapsed(
        hintText: hint,
        hintStyle: AppTextStyles.brush(28, color: AppColors.grey),
      ),
    );

    return FieldCard(
      label: label,
      child: suffix == null
          ? field
          : Row(
        children: [
          Expanded(child: field),
          Text(suffix!, style: AppTextStyles.brush(28, color: AppColors.grey)),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}