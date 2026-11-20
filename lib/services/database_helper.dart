import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/journal_entry.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static const _dbName = 'jourunning.db';
  static const _dbVersion = 1;
  static const _table = 'journals';

  Database? _db;

  Future<Database> get _database async => _db ??= await _open();

  Future<Database> _open() async {
    final path = join(await getDatabasesPath(), _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_table (
            id TEXT PRIMARY KEY,
            date_time TEXT NOT NULL,
            title TEXT NOT NULL,
            distance TEXT NOT NULL,
            duration TEXT NOT NULL,
            pace TEXT NOT NULL,
            location TEXT NOT NULL,
            mood TEXT NOT NULL,
            gratitude TEXT NOT NULL,
            improvement TEXT NOT NULL,
            notes TEXT NOT NULL
          )
        ''');
      },
    );
  }

  /// Semua journaling, terbaru di atas.
  Future<List<JournalEntry>> getAll() async {
    final db = await _database;
    final rows = await db.query(_table, orderBy: 'date_time DESC');
    return rows.map(JournalEntry.fromMap).toList();
  }

  Future<void> upsert(JournalEntry entry) async {
    final db = await _database;
    await db.insert(
      _table,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final db = await _database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}