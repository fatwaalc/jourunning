import 'package:flutter/material.dart';

import '../core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(label, style: AppTextStyles.brush(26)),
      ),
    );
  }
}