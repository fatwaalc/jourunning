import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/journal_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Muat riwayat dari database sebelum aplikasi tampil,
  // sehingga Home Screen langsung berisi data.
  final provider = JournalProvider();
  await provider.load();

  runApp(
    ChangeNotifierProvider.value(
      value: provider,
      child: const JourunningApp(),
    ),
  );
}