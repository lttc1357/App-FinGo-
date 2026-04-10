import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF004BE2);
  static const Color primaryContainer = Color(0xFF809BFF);
  static const Color onPrimary = Colors.white;
  static const Color surface = Color(0xFFF5F6F7);
  static const Color onSurface = Color(0xFF2C2F30);
  static const Color surfaceVariant = Color(0xFFDADDDF);
  static const Color onSurfaceVariant = Color(0xFF595C5D);
  static const Color tertiary = Color(0xFF6D5A00);
  static const Color tertiaryContainer = Color(0xFFFDD400);
  static const Color error = Color(0xFFB41340);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFF757778);
  static const Color outlineVariant = Color(0xFFABADAe);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primary,
        primaryContainer: primaryContainer,
        secondary: tertiary,
        secondaryContainer: tertiaryContainer,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        surfaceContainerHighest: surfaceVariant,
        error: error,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800),
        displayMedium: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        titleLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        bodyLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500),
        bodyMedium: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400),
        labelLarge: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: primaryContainer, // Lighter primary for dark mode
        primaryContainer: primary,
        secondary: tertiaryContainer,
        secondaryContainer: tertiary,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
        onSurfaceVariant: Colors.grey.shade400,
        surfaceContainerHighest: const Color(0xFF2C2C2C),
        error: error,
      ),
      scaffoldBackgroundColor: const Color(0xFF161618),
      cardColor: const Color(0xFF2C2C2C),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: Colors.white),
        displayMedium: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: Colors.white),
        titleLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: Colors.white),
        bodyLarge: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, color: Colors.white),
        bodyMedium: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w400, color: Colors.white),
        labelLarge: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: primaryContainer,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
