import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTextStyles {
  /// Font judul: Permanent Marker
  static TextStyle marker(double size, {Color color = AppColors.black}) =>
      GoogleFonts.permanentMarker(fontSize: size, color: color);

  /// Font sub judul & isi: Caveat Brush
  static TextStyle brush(
      double size, {
        Color color = AppColors.black,
        FontWeight? weight,
        TextDecoration? decoration,
      }) =>
      GoogleFonts.caveatBrush(
        fontSize: size,
        color: color,
        fontWeight: weight,
        decoration: decoration,
      );
}