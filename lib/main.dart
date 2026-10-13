import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const JourunningApp());
}

class JourunningApp extends StatelessWidget {
  const JourunningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jourunning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const LandingPage(),
    );
  }
}