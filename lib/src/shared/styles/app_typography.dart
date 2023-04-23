import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme data = TextTheme(
    displayLarge: GoogleFonts.lora(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.nunito(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.nunito(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.nunito(
      fontSize: 19,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.nunito(
      fontSize: 12,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.lora(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  );
}
