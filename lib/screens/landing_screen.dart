import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_text_styles.dart';
import '../widgets/app_button.dart';
import '../widgets/daily_quote.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            children: [
              const SizedBox(height: 24),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('JOURUNNING', style: AppTextStyles.marker(46)),
              ),
              Text('Your Running Journaling App', style: AppTextStyles.brush(24)),
              const SizedBox(height: 32),
              Image.asset('asset/icon/logojourunning.png', width: 240),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(child: const DailyQuote()),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
                child: Text(
                  'View My Journal',
                  style: AppTextStyles.brush(
                    28,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AppButton(
                label: 'LET\'S START JOURNALING',
                color: AppColors.green,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.formRun),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}