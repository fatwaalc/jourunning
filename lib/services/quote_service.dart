import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quote.dart';

class QuoteService {
  static const _url = 'https://zenquotes.io/api/today';
  static const _keyDate = 'quote_date';
  static const _keyText = 'quote_text';
  static const _keyAuthor = 'quote_author';

  // Dipakai saat offline atau API gagal.
  static const _fallback = Quote(
    text: 'My PACE My PEACE. Don\'t compare yourself.',
    author: 'Jourunning',
  );

  Future<Quote> getDailyQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (prefs.getString(_keyDate) == today) {
      final text = prefs.getString(_keyText);
      final author = prefs.getString(_keyAuthor);
      if (text != null && author != null) {
        return Quote(text: text, author: author);
      }
    }

    try {
      final response =
      await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final first = data.first as Map<String, dynamic>;
        final text = first['q'] as String;
        final author = first['a'] as String;

        // ZenQuotes membalas "zenquotes.io" sebagai author saat kena rate limit.
        if (author != 'zenquotes.io') {
          await prefs.setString(_keyDate, today);
          await prefs.setString(_keyText, text);
          await prefs.setString(_keyAuthor, author);
          return Quote(text: text, author: author);
        }
      }
    } catch (_) {

    }
    return _fallback;
  }
}