enum Mood {
  happy('😄', 'HAPPY'),
  normal('🙂', 'NORMAL'),
  sad('😢', 'SAD');

  const Mood(this.emoji, this.label);
  final String emoji;
  final String label;
}

class JournalEntry {
  final String id;
  final DateTime dateTime;
  final String title;
  final String distance;
  final String duration;
  final String pace;
  final String location;
  final Mood mood;
  final String gratitude;
  final String improvement;
  final String notes;

  const JournalEntry({
    required this.id,
    required this.dateTime,
    required this.title,
    required this.distance,
    required this.duration,
    required this.pace,
    required this.location,
    this.mood = Mood.happy,
    this.gratitude = '',
    this.improvement = '',
    this.notes = '',
  });

  JournalEntry copyWith({
    Mood? mood,
    String? gratitude,
    String? improvement,
    String? notes,
  }) {
    return JournalEntry(
      id: id,
      dateTime: dateTime,
      title: title,
      distance: distance,
      duration: duration,
      pace: pace,
      location: location,
      mood: mood ?? this.mood,
      gratitude: gratitude ?? this.gratitude,
      improvement: improvement ?? this.improvement,
      notes: notes ?? this.notes,
    );
  }
}

/// Data yang dikirim dari Form 1 ke Form 2.
class FormArgs {
  final JournalEntry entry;
  final bool isEdit;
  const FormArgs({required this.entry, required this.isEdit});
}