import 'package:flutter/material.dart';

class CustomColors {
  // Główne kolory
  static const Color brightBackground = Color(0xff1A1B23);
  static const Color darkBackground = Color(0xff0F1419);
  static const Color imageCircleBackground = Color(0xff28292D);
  static const Color primary = Color(0xff64FFDA);
  static const Color secondary = Color(0xffFF6B9D);
  static const Color accent = Color(0xffFFE066);
  static const Color purple = Color(0xff8B5FBF);
  static const Color gray = Color(0xffB8BCC8);

  // Nowe kolory dla gradientów
  static const Color primaryDark = Color(0xff00BFA5);
  static const Color secondaryDark = Color(0xffE91E63);
  static const Color accentDark = Color(0xffFF9800);

  // Kolory tekstu
  static const Color textPrimary = Color(0xffF5F5F5);
  static const Color textSecondary = Color(0xffB8BCC8);
  static const Color textMuted = Color(0xff8892B0);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
    stops: [0.0, 1.0],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, secondaryDark],
    stops: [0.0, 1.0],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [brightBackground, darkBackground],
    stops: [0.0, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff1E2A3A), Color(0xff2A3B4C)],
    stops: [0.0, 1.0],
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: primary.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];

  static List<BoxShadow> glowShadow = [
    BoxShadow(
      color: primary.withOpacity(0.3),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];
}
