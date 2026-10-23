import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  final List<JournalEntry> _entries = [];

  UnmodifiableListView<JournalEntry> get entries =>
      UnmodifiableListView(_entries);

  JournalEntry? getById(String id) {
    for (final e in _entries) {
      if (e.id == id) return e;
    }
    return null;
  }

  /// Tambah baru (paling atas), atau timpa jika id sudah ada (mode edit).
  void save(JournalEntry entry) {
    final index = _entries.indexWhere((e) => e.id == entry.id);
    if (index >= 0) {
      _entries[index] = entry;
    } else {
      _entries.insert(0, entry); // terbaru di atas
    }
    notifyListeners();
  }

  void delete(String id) {
    _entries.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}