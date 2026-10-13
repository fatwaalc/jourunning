import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_input.dart';
import '../widgets/mood_selector.dart';

class AddJournalPage extends StatefulWidget {
  const AddJournalPage({super.key});

  @override
  State<AddJournalPage> createState() => _AddJournalPageState();
}

class _AddJournalPageState extends State<AddJournalPage> {
  final PageController _pageController = PageController();

  final TextEditingController _distCtrl = TextEditingController();
  final TextEditingController _durCtrl = TextEditingController();
  final TextEditingController _paceCtrl = TextEditingController();
  final TextEditingController _locCtrl = TextEditingController();
  final TextEditingController _gratCtrl = TextEditingController();
  final TextEditingController _impCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();

  final TextEditingController _titleCtrl = TextEditingController(text: "Saturday Long Run");
  final FocusNode _titleFocus = FocusNode();

  String _currentMood = 'HAPPY';

  @override
  void dispose() {
    _pageController.dispose();
    _distCtrl.dispose();
    _durCtrl.dispose();
    _paceCtrl.dispose();
    _locCtrl.dispose();
    _gratCtrl.dispose();
    _impCtrl.dispose();
    _notesCtrl.dispose();
    _titleCtrl.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  String _getFormattedTime() {
    final now = DateTime.now();

    const List<String> weekdays = ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const List<String> months = ["", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

    String dayName = weekdays[now.weekday];
    String monthName = months[now.month];
    String day = now.day.toString();
    String year = now.year.toString();

    int hour = now.hour;
    int minute = now.minute;
    String ampm = hour >= 12 ? "PM" : "AM";

    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;

    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = minute.toString().padLeft(2, '0');

    return "$dayName, $day $monthName $year - $hourStr.$minuteStr $ampm";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [

            // Form Pertama
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_getFormattedTime(), style: GoogleFonts.caveatBrush(color: Colors.grey, fontSize: 16)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleCtrl,
                          focusNode: _titleFocus,
                          style: GoogleFonts.caveatBrush(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _titleFocus.requestFocus();
                        },
                        child: const Icon(Icons.edit, size: 24),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black54, thickness: 1),
                  const SizedBox(height: 24),

                  CustomInput(label: "Distance", hint: "00.00 km", controller: _distCtrl),
                  CustomInput(label: "Duration", hint: "00:00:00", controller: _durCtrl),
                  CustomInput(label: "Average Pace", hint: "00:00 /km", controller: _paceCtrl),
                  CustomInput(label: "Location", hint: "Lapangan Merdeka, Grand City, etc", controller: _locCtrl),

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text("Next >", style: GoogleFonts.caveatBrush(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),

            // Form Kedua
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text("< Back", style: GoogleFonts.caveatBrush(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),

                  Text("Mood", style: GoogleFonts.caveatBrush(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  MoodSelector(
                    onMoodSelected: (selectedMood) {
                      _currentMood = selectedMood;
                      print("Mood yang dipilih: $_currentMood");
                    },
                  ),
                  const SizedBox(height: 24),

                  CustomInput(label: "Gratitude", hint: "what's you grateful for today?", controller: _gratCtrl),
                  CustomInput(label: "Improvement", hint: "What's your improve for next running?", controller: _impCtrl),
                  CustomInput(label: "Notes", hint: "Tell about your running or anything...", maxLines: 4, controller: _notesCtrl),

                  const SizedBox(height: 0.5),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        print("Data Disimpan! Judul: ${_titleCtrl.text}, Jarak: ${_distCtrl.text}, Mood: $_currentMood");
                        Navigator.pop(context);
                      },
                      child: Text("SAVE", style: GoogleFonts.caveatBrush(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}