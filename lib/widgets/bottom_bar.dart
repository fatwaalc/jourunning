import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

/// Bar bawah yang tetap terlihat saat halaman di-scroll.
class BottomBar extends StatelessWidget {
  final Widget child;
  const BottomBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bar,
      padding: const EdgeInsets.fromLTRB(36, 16, 36, 16),
      child: SafeArea(top: false, child: child),
    );
  }
}