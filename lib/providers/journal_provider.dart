import 'package:flutter/foundation.dart';

import '../models/journal_entry.dart';
import '../services/database_helper.dart';

class JournalProvider extends ChangeNotifier {
  final _db = DatabaseHelper.instance;
  List<JournalEntry> _entries = [];

  List<JournalEntry> get entries => List.unmodifiable(_entries);

  /// Baca ulang semua data dari database lalu beri tahu tampilan.
  Future<void> load() async {
    _entries = await _db.getAll();
    notifyListeners();
  }

  JournalEntry? getById(String id) {
    for (final e in _entries) {
      if (e.id == id) return e;
    }
    return null;
  }

  Future<void> save(JournalEntry entry) async {
    await _db.upsert(entry);
    await load();
  }

  Future<void> delete(String id) async {
    await _db.delete(id);
    await load();
  }
}