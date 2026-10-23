import 'package:flutter/material.dart';

class AppRoutes {
  static const landing = '/';
  static const home = '/home';
  static const formRun = '/form-run';
  static const formReflection = '/form-reflection';
  static const detail = '/detail';

  /// Ke Home Screen: semua halaman di atas Landing dibuang, lalu Home dibuka.
  static void goHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      home,
          (route) => route.settings.name == landing,
    );
  }

  /// Tombol X: tutup halaman sampai ke Home (atau Landing jika Home belum dibuka).
  static void closeFlow(BuildContext context) {
    Navigator.of(context).popUntil(
          (route) => route.settings.name == landing || route.settings.name == home,
    );
  }
}