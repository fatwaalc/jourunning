import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../utils/app_colors.dart';
import '../widgets/track_button.dart';
import 'add_journal_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String quoteText = "Mengambil kutipan hari ini...";
  String quoteAuthor = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchZenQuote();
  }

  Future<void> fetchZenQuote() async {
    try {
      final response = await http.get(Uri.parse('https://zenquotes.io/api/today'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          quoteText = '"${data[0]['q']}"';
          quoteAuthor = data[0]['a'];
          isLoading = false;
        });
      } else {
        _setFallbackQuote();
      }
    } catch (e) {
      _setFallbackQuote();
    }
  }

  void _setFallbackQuote() {
    setState(() {
      quoteText = '"My PACE My PEACE"';
      quoteAuthor = "Don't compare yourself";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "JOURUNNING",
                style: GoogleFonts.permanentMarker(
                  fontSize: 36,
                  color: AppColors.textBlack,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 20),

              Image.asset(
                'asset/icon/logojourunning.png',
                width: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 0.5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Text(
                      quoteText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.caveatBrush(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (!isLoading && quoteAuthor.isNotEmpty)
                      Text(
                        "- $quoteAuthor",
                        style: GoogleFonts.caveatBrush(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              TrackButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddJournalPage()),
                  );
                },
              ),
              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  print("Masuk ke riwayat jurnal");
                },
                child: Text(
                  "View My Journal",
                  style: GoogleFonts.caveatBrush(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}