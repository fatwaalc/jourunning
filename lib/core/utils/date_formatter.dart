import 'package:intl/intl.dart';

class DateFormatter {
  /// Contoh: Wednesday, 21 October 2026 - 06.00 AM
  static String full(DateTime date) =>
      DateFormat('EEEE, d MMMM y - hh.mm a', 'en_US').format(date);
}