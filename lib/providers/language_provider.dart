import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en'); // Domyślnie angielski

  Locale get locale => _locale;

  static const List<Locale> supportedLocales = [
    Locale('pl'),
    Locale('en'),
  ];

  LanguageProvider() {
    _loadLanguage();
  }

  void _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString('language');

      if (savedLanguage != null) {
        _locale = Locale(savedLanguage);
        notifyListeners();
      } else {
        // Wykryj język z systemu
        String detectedLanguage = 'en'; // domyślnie angielski

        if (kIsWeb) {
          // Na web używamy navigator
          final browserLanguage =
              html.window.navigator.language?.toLowerCase() ?? '';
          if (browserLanguage.startsWith('pl')) {
            detectedLanguage = 'pl';
          }
        } else {
          // Na desktop/mobile używamy locale systemu
          try {
            final systemLocale = Platform.localeName.toLowerCase();
            if (systemLocale.startsWith('pl')) {
              detectedLanguage = 'pl';
            }
          } catch (e) {
            // Fallback jeśli nie można wykryć locale systemu
            print('Nie można wykryć locale systemu: $e');
          }
        }

        _locale = Locale(detectedLanguage);
        // Zapisz wykryty język
        await prefs.setString('language', _locale.languageCode);
        notifyListeners();
      }
    } catch (e) {
      // Fallback do angielskiego w przypadku błędu
      _locale = const Locale('en');
      notifyListeners();
    }
  }

  void changeLanguage(Locale locale) async {
    print('🌍 Zmiana języka na: ${locale.languageCode}'); // Debug

    if (_locale == locale) {
      print('🌍 Język już ustawiony na: ${locale.languageCode}');
      return;
    }

    _locale = locale;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', locale.languageCode);
      print('🌍 Język zapisany w SharedPreferences: ${locale.languageCode}');
    } catch (e) {
      print('🌍 Błąd zapisywania języka: $e');
    }

    notifyListeners();
    print('🌍 notifyListeners() wywołane dla języka: ${locale.languageCode}');
  }

  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'pl':
        return 'Polski';
      case 'en':
        return 'English';
      default:
        return 'Unknown';
    }
  }

  String getLanguageFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'pl':
        return '🇵🇱';
      case 'en':
        return '🇬🇧';
      default:
        return '🌐';
    }
  }
}
