import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/theme/app_text_styles.dart';
import '../models/journal_entry.dart';
import '../providers/journal_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_header.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/field_card.dart';
import '../widgets/mood_selector.dart';

/// Form 2 - Mind & Reflection.
class FormReflectionScreen extends StatefulWidget {
  final FormArgs args;
  const FormReflectionScreen({super.key, required this.args});

  @override
  State<FormReflectionScreen> createState() => _FormReflectionScreenState();
}

class _FormReflectionScreenState extends State<FormReflectionScreen> {
  late Mood _mood;
  late final TextEditingController _gratitude;
  late final TextEditingController _improvement;
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    final e = widget.args.entry;
    _mood = e.mood;
    _gratitude = TextEditingController(text: e.gratitude);
    _improvement = TextEditingController(text: e.improvement);
    _notes = TextEditingController(text: e.notes);
  }

  @override
  void dispose() {
    _gratitude.dispose();
    _improvement.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() {
    final updated = widget.args.entry.copyWith(
      mood: _mood,
      gratitude: _gratitude.text.trim(),
      improvement: _improvement.text.trim(),
      notes: _notes.text.trim(),
    );
    context.read<JournalProvider>().save(updated);
    AppRoutes.goHome(context);
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 14);

    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            title: 'SECTION 2/2\nMIND & REFLECTION',
            onBack: () => Navigator.pop(context),
            onClose: () => AppRoutes.closeFlow(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(36, 16, 36, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Today\'s Running Mood', style: AppTextStyles.brush(28)),
                  const SizedBox(height: 10),
                  MoodSelector(
                    selected: _mood,
                    onChanged: (m) => setState(() => _mood = m),
                  ),
                  const SizedBox(height: 24),
                  LabeledTextField(
                    label: 'GRATITUDE',
                    hint: 'What felt good today?',
                    controller: _gratitude,
                  ),
                  gap,
                  LabeledTextField(
                    label: 'IMPROVEMENT',
                    hint: 'What would you improve?',
                    controller: _improvement,
                  ),
                  gap,
                  LabeledTextField(
                    label: 'NOTES',
                    hint: 'Anything else on your mind?',
                    controller: _notes,
                    minLines: 4,
                  ),
                ],
              ),
            ),
          ),
          BottomBar(
            child: AppButton(
              label: 'SAVE',
              color: AppColors.green,
              onPressed: _save,
            ),
          ),
        ],
      ),
    );
  }
}