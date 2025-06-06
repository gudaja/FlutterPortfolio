import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;

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
        // Wykryj język z przeglądarki
        final browserLanguage = html.window.navigator.language.toLowerCase();
        if (browserLanguage.startsWith('pl')) {
          _locale = const Locale('pl');
        } else {
          _locale = const Locale('en');
        }
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
