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

  /// Objek -> baris database.
  Map<String, Object?> toMap() => {
    'id': id,
    'date_time': dateTime.toIso8601String(),
    'title': title,
    'distance': distance,
    'duration': duration,
    'pace': pace,
    'location': location,
    'mood': mood.name,
    'gratitude': gratitude,
    'improvement': improvement,
    'notes': notes,
  };

  /// Baris database -> objek.
  factory JournalEntry.fromMap(Map<String, Object?> map) {
    return JournalEntry(
      id: map['id'] as String,
      dateTime: DateTime.parse(map['date_time'] as String),
      title: map['title'] as String,
      distance: map['distance'] as String,
      duration: map['duration'] as String,
      pace: map['pace'] as String,
      location: map['location'] as String,
      mood: Mood.values.firstWhere(
            (m) => m.name == map['mood'],
        orElse: () => Mood.happy,
      ),
      gratitude: map['gratitude'] as String,
      improvement: map['improvement'] as String,
      notes: map['notes'] as String,
    );
  }
}

/// Data yang dikirim dari Form 1 ke Form 2.
class FormArgs {
  final JournalEntry entry;
  final bool isEdit;
  const FormArgs({required this.entry, required this.isEdit});
}