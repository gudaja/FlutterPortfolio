import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/screens/portfolio.dart';
import 'package:portfolio/utils/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: CustomColors.primary,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors.primary,
          brightness: Brightness.light,
          primary: CustomColors.primary,
          surface: CustomColors.brightBackground,
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primary,
            foregroundColor: CustomColors.darkBackground,
            elevation: 8,
            shadowColor: CustomColors.primary.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors.primary,
          brightness: Brightness.dark,
          primary: CustomColors.primary,
          surface: CustomColors.darkBackground,
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.dark,
      title: 'Portfolio - Nowoczesne CV',
      home: const Portfolio(),
      debugShowCheckedModeBanner: false,
    );
  }
}
