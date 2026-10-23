import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_text_styles.dart';
import '../core/utils/date_formatter.dart';
import '../models/journal_entry.dart';
import '../widgets/app_button.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/field_card.dart';

/// Form 1 - Run Metrics. Jika [entry] diisi, form ini berjalan sebagai mode edit.
class FormRunScreen extends StatefulWidget {
  final JournalEntry? entry;
  const FormRunScreen({super.key, this.entry});

  @override
  State<FormRunScreen> createState() => _FormRunScreenState();
}

class _FormRunScreenState extends State<FormRunScreen> {
  late final DateTime _dateTime;
  late final TextEditingController _title;
  late final TextEditingController _distance;
  late final TextEditingController _duration;
  late final TextEditingController _pace;
  late final TextEditingController _location;

  @override
  void initState() {
    super.initState();
    final e = widget.entry;
    _dateTime = e?.dateTime ?? DateTime.now(); // hari, tanggal & jam otomatis
    _title = TextEditingController(text: e?.title ?? '');
    _distance = TextEditingController(text: e?.distance ?? '');
    _duration = TextEditingController(text: e?.duration ?? '');
    _pace = TextEditingController(text: e?.pace ?? '');
    _location = TextEditingController(text: e?.location ?? '');
  }

  @override
  void dispose() {
    _title.dispose();
    _distance.dispose();
    _duration.dispose();
    _pace.dispose();
    _location.dispose();
    super.dispose();
  }

  void _continue() {
    if (_title.text.trim().isEmpty || _distance.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in the activity title and distance.',
            style: AppTextStyles.brush(20, color: Colors.white),
          ),
        ),
      );
      return;
    }

    final base = widget.entry;
    final entry = JournalEntry(
      id: base?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      dateTime: _dateTime,
      title: _title.text.trim(),
      distance: _distance.text.trim(),
      duration: _duration.text.trim(),
      pace: _pace.text.trim(),
      location: _location.text.trim(),
      mood: base?.mood ?? Mood.happy,
      gratitude: base?.gratitude ?? '',
      improvement: base?.improvement ?? '',
      notes: base?.notes ?? '',
    );

    Navigator.pushNamed(
      context,
      AppRoutes.formReflection,
      arguments: FormArgs(entry: entry, isEdit: base != null),
    );
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 14);

    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            title: 'SECTION 1/2\nRUN METRICS',
            onBack: () => Navigator.pop(context),
            onClose: () => AppRoutes.closeFlow(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(36, 16, 36, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormatter.full(_dateTime),
                    style: AppTextStyles.brush(20, color: AppColors.grey),
                  ),
                  const SizedBox(height: 10),
                  LabeledTextField(
                    label: 'ACTIVITY TITLE',
                    hint: 'Write your activity title',
                    controller: _title,
                  ),
                  gap,
                  LabeledTextField(
                    label: 'DISTANCE',
                    hint: '00.00',
                    controller: _distance,
                    suffix: 'km',
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                  ),
                  gap,
                  LabeledTextField(
                    label: 'DURATION',
                    hint: '00:00:00',
                    controller: _duration,
                    keyboardType: TextInputType.datetime,
                  ),
                  gap,
                  LabeledTextField(
                    label: 'AVERAGE PACE',
                    hint: '00:00',
                    controller: _pace,
                    suffix: '/km',
                    keyboardType: TextInputType.datetime,
                  ),
                  gap,
                  LabeledTextField(
                    label: 'LOCATION',
                    hint: 'Where did you run?',
                    controller: _location,
                  ),
                ],
              ),
            ),
          ),
          BottomBar(
            child: AppButton(
              label: 'CONTINUE',
              color: AppColors.orange,
              onPressed: _continue,
            ),
          ),
        ],
      ),
    );
  }
}