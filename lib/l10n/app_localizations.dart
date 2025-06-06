import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get appTitle;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello! 👋'**
  String get hello;

  /// No description provided for @iAm.
  ///
  /// In en, this message translates to:
  /// **'I\'m [U#-dev]'**
  String get iAm;

  /// No description provided for @flutterDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get flutterDeveloper;

  /// No description provided for @mobileAppCreator.
  ///
  /// In en, this message translates to:
  /// **'Mobile App Creator'**
  String get mobileAppCreator;

  /// No description provided for @uiUxEnthusiast.
  ///
  /// In en, this message translates to:
  /// **'UI/UX Enthusiast'**
  String get uiUxEnthusiast;

  /// No description provided for @heroDescription.
  ///
  /// In en, this message translates to:
  /// **'Passion meets code. I create modern mobile applications that combine excellent design with functionality.'**
  String get heroDescription;

  /// No description provided for @viewProjects.
  ///
  /// In en, this message translates to:
  /// **'View Projects'**
  String get viewProjects;

  /// No description provided for @contactMe.
  ///
  /// In en, this message translates to:
  /// **'Contact Me'**
  String get contactMe;

  /// No description provided for @findMeOnline.
  ///
  /// In en, this message translates to:
  /// **'Find me online'**
  String get findMeOnline;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @interests.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interests;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutMe;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'I\'m a passionate Flutter developer who loves creating beautiful and functional mobile applications. With experience in cross-platform development, I focus on delivering high-quality solutions that provide excellent user experience.'**
  String get aboutDescription;

  /// No description provided for @mySkills.
  ///
  /// In en, this message translates to:
  /// **'My Skills'**
  String get mySkills;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'experience'**
  String get experience;

  /// No description provided for @madeWithLove.
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ using Flutter'**
  String get madeWithLove;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @polish.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get polish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @aboutMeTitle.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutMeTitle;

  /// No description provided for @aboutMeDescription.
  ///
  /// In en, this message translates to:
  /// **'I\'m a passionate mobile technology enthusiast with years of experience in creating Flutter applications. I specialize in transforming ideas into functional, beautiful mobile applications.'**
  String get aboutMeDescription;

  /// No description provided for @mySkillsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Skills'**
  String get mySkillsTitle;

  /// No description provided for @interestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interestsTitle;

  /// No description provided for @flutterDevelopmentInterest.
  ///
  /// In en, this message translates to:
  /// **'Flutter Development'**
  String get flutterDevelopmentInterest;

  /// No description provided for @uiUxDesignInterest.
  ///
  /// In en, this message translates to:
  /// **'UI/UX Design'**
  String get uiUxDesignInterest;

  /// No description provided for @mobileAppsInterest.
  ///
  /// In en, this message translates to:
  /// **'Mobile Apps'**
  String get mobileAppsInterest;

  /// No description provided for @problemSolvingInterest.
  ///
  /// In en, this message translates to:
  /// **'Problem Solving'**
  String get problemSolvingInterest;

  /// No description provided for @techInnovationInterest.
  ///
  /// In en, this message translates to:
  /// **'Tech Innovation'**
  String get techInnovationInterest;

  /// No description provided for @codeQualityInterest.
  ///
  /// In en, this message translates to:
  /// **'Code Quality'**
  String get codeQualityInterest;

  /// No description provided for @copyrightText.
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2024 Portfolio'**
  String get copyrightText;

  /// No description provided for @allRightsReserved.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved'**
  String get allRightsReserved;

  /// No description provided for @madeWithText.
  ///
  /// In en, this message translates to:
  /// **'Made with'**
  String get madeWithText;

  /// No description provided for @usingFlutterText.
  ///
  /// In en, this message translates to:
  /// **'using Flutter'**
  String get usingFlutterText;

  /// No description provided for @flutterSkillDescription.
  ///
  /// In en, this message translates to:
  /// **'Cross-platform mobile development with Dart. Creating modern iOS and Android applications.'**
  String get flutterSkillDescription;

  /// No description provided for @cppSkillDescription.
  ///
  /// In en, this message translates to:
  /// **'Performance-critical applications, game development, system programming, embedded systems.'**
  String get cppSkillDescription;

  /// No description provided for @golangSkillDescription.
  ///
  /// In en, this message translates to:
  /// **'Concurrent programming, microservices, cloud-native development, backend APIs.'**
  String get golangSkillDescription;

  /// No description provided for @linuxSkillDescription.
  ///
  /// In en, this message translates to:
  /// **'System administration, shell scripting, server management, DevOps, automation.'**
  String get linuxSkillDescription;

  /// No description provided for @embeddedSkillDescription.
  ///
  /// In en, this message translates to:
  /// **'Microcontrollers, IoT devices, real-time systems, firmware development, hardware integration.'**
  String get embeddedSkillDescription;

  /// No description provided for @contactTitle.
  ///
  /// In en, this message translates to:
  /// **'Get in touch'**
  String get contactTitle;

  /// No description provided for @contactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Always open to new opportunities and interesting projects'**
  String get contactSubtitle;

  /// No description provided for @findMeOn.
  ///
  /// In en, this message translates to:
  /// **'Or find me on'**
  String get findMeOn;

  /// No description provided for @emailCopied.
  ///
  /// In en, this message translates to:
  /// **'Email copied to clipboard!'**
  String get emailCopied;

  /// No description provided for @clickToCopy.
  ///
  /// In en, this message translates to:
  /// **'Click to copy'**
  String get clickToCopy;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @polandKrakow.
  ///
  /// In en, this message translates to:
  /// **'Poland, Kraków'**
  String get polandKrakow;

  /// No description provided for @openToRemote.
  ///
  /// In en, this message translates to:
  /// **'Open to remote work'**
  String get openToRemote;

  /// No description provided for @copyrightFullText.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Łukasz Górkiewicz. All rights reserved.'**
  String get copyrightFullText;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
