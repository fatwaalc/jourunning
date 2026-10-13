import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextEditingController? controller;

  const CustomInput({
    super.key,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.caveatBrush(
              fontSize: 26,
              color: AppColors.textBlack,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.coral,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              style: GoogleFonts.caveatBrush(
                fontSize: 22,
                color: AppColors.textBlack,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.caveatBrush(
                  color: AppColors.textBlack.withOpacity(0.4),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}