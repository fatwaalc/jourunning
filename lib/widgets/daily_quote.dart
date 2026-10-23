import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';

class DailyQuote extends StatefulWidget {
  const DailyQuote({super.key});

  @override
  State<DailyQuote> createState() => _DailyQuoteState();
}

class _DailyQuoteState extends State<DailyQuote> {
  late final Future<Quote> _future;

  @override
  void initState() {
    super.initState();
    _future = QuoteService().getDailyQuote();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quote>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(color: AppColors.black);
        }
        final quote = snapshot.data!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '“${quote.text}”',
              textAlign: TextAlign.center,
              style: AppTextStyles.brush(30).copyWith(height: 1.3),
            ),
            const SizedBox(height: 8),
            Text(
              '— ${quote.author}',
              textAlign: TextAlign.center,
              style: AppTextStyles.brush(20, color: AppColors.grey),
            ),
          ],
        );
      },
    );
  }
}