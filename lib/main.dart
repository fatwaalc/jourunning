import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/journal_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => JournalProvider(),
      child: const JourunningApp(),
    ),
  );
}