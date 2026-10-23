import 'package:flutter/material.dart';

import 'core/constants/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'models/journal_entry.dart';
import 'screens/home_screen.dart';
import 'screens/journal_detail_screen.dart';
import 'screens/form_reflection_screen.dart';
import 'screens/form_run_screen.dart';
import 'screens/landing_screen.dart';

class JourunningApp extends StatelessWidget {
  const JourunningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jourunning',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.landing,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final Widget page;
    switch (settings.name) {
      case AppRoutes.home:
        page = const HomeScreen();
        break;
      case AppRoutes.formRun:
        page = FormRunScreen(entry: settings.arguments as JournalEntry?);
        break;
      case AppRoutes.formReflection:
        page = FormReflectionScreen(args: settings.arguments as FormArgs);
        break;
      case AppRoutes.detail:
        page = JournalDetailScreen(entryId: settings.arguments as String);
        break;
      default:
        page = const LandingScreen();
    }
    return MaterialPageRoute(builder: (_) => page, settings: settings);
  }
}