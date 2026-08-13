import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @quizTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quizTitle;

  /// Displays current question number and total
  ///
  /// In en, this message translates to:
  /// **'Question {count} of {total}'**
  String questionCount(int count, int total);

  /// Shows current quiz score
  ///
  /// In en, this message translates to:
  /// **'Score {value}'**
  String score(int value);

  /// No description provided for @nextQuestion.
  ///
  /// In en, this message translates to:
  /// **'Next question'**
  String get nextQuestion;

  /// No description provided for @correctAnswer.
  ///
  /// In en, this message translates to:
  /// **'Correct answer'**
  String get correctAnswer;

  /// Shows the correct answer when user selects wrong one
  ///
  /// In en, this message translates to:
  /// **'Wrong answer, correct one is {answer}'**
  String wrongAnswer(String answer);

  /// No description provided for @quizCompleted.
  ///
  /// In en, this message translates to:
  /// **'Quiz completed'**
  String get quizCompleted;

  /// Shows final quiz results
  ///
  /// In en, this message translates to:
  /// **'You scored {score} out of {total}'**
  String finalScore(int score, int total);

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play again'**
  String get playAgain;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noQuestionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No quiz questions available'**
  String get noQuestionsAvailable;

  /// No description provided for @transliterationPrompt.
  ///
  /// In en, this message translates to:
  /// **'Which transliteration matches this meaning?'**
  String get transliterationPrompt;

  /// No description provided for @translationPrompt.
  ///
  /// In en, this message translates to:
  /// **'What does this Arabic name mean?'**
  String get translationPrompt;

  /// No description provided for @arabicPrompt.
  ///
  /// In en, this message translates to:
  /// **'Which Arabic form matches this name?'**
  String get arabicPrompt;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'The 99'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Asma ul Husna'**
  String get appSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search names, meanings...'**
  String get searchHint;

  /// No description provided for @quranTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quranTitle;

  /// No description provided for @searchSurahHint.
  ///
  /// In en, this message translates to:
  /// **'Search surah by name, meaning or number'**
  String get searchSurahHint;

  /// No description provided for @noSurahMatches.
  ///
  /// In en, this message translates to:
  /// **'No surah matches your search'**
  String get noSurahMatches;

  /// No description provided for @selectReciter.
  ///
  /// In en, this message translates to:
  /// **'Select reciter'**
  String get selectReciter;

  /// No description provided for @meaning.
  ///
  /// In en, this message translates to:
  /// **'Meaning'**
  String get meaning;

  /// No description provided for @playAudio.
  ///
  /// In en, this message translates to:
  /// **'Play audio'**
  String get playAudio;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @nameOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'NAME OF THE DAY'**
  String get nameOfTheDay;

  /// No description provided for @favoriteTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favoriteTitle;

  /// No description provided for @noSavedNames.
  ///
  /// In en, this message translates to:
  /// **'No saved names yet'**
  String get noSavedNames;

  /// No description provided for @noSavedNamesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on any name to save it here'**
  String get noSavedNamesSubtitle;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get french;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get notifications;

  /// No description provided for @quranSection.
  ///
  /// In en, this message translates to:
  /// **'QURAN'**
  String get quranSection;

  /// No description provided for @autoPlayQuran.
  ///
  /// In en, this message translates to:
  /// **'Play on app launch'**
  String get autoPlayQuran;

  /// No description provided for @autoPlayQuranSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start a quiet recitation in the background every time you open the app'**
  String get autoPlayQuranSubtitle;

  /// No description provided for @backgroundVolume.
  ///
  /// In en, this message translates to:
  /// **'Background volume'**
  String get backgroundVolume;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @enable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enable;

  /// No description provided for @disable.
  ///
  /// In en, this message translates to:
  /// **'Disable'**
  String get disable;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Title of the morning Name of the Day notification
  ///
  /// In en, this message translates to:
  /// **'{arabe} — {transliteration}'**
  String notifNameOfDayTitle(String arabe, String transliteration);

  /// Body of the morning Name of the Day notification
  ///
  /// In en, this message translates to:
  /// **'{translation} · {details}'**
  String notifNameOfDayBody(String translation, String details);

  /// No description provided for @notifEveningTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay with Allah'**
  String get notifEveningTitle;

  /// No description provided for @notifEveningBody1.
  ///
  /// In en, this message translates to:
  /// **'Close your day with His remembrance — SubhanAllah, Alhamdulillah, Allahu Akbar.'**
  String get notifEveningBody1;

  /// No description provided for @notifEveningBody2.
  ///
  /// In en, this message translates to:
  /// **'Before you sleep, ask Him for forgiveness. He is Al-Ghafoor, The Forgiving.'**
  String get notifEveningBody2;

  /// No description provided for @notifEveningBody3.
  ///
  /// In en, this message translates to:
  /// **'Whatever the day held, He was never absent. Turn to Him now.'**
  String get notifEveningBody3;

  /// No description provided for @notifEveningBody4.
  ///
  /// In en, this message translates to:
  /// **'Send peace upon the Prophet ﷺ and let your heart rest.'**
  String get notifEveningBody4;

  /// No description provided for @notifEveningBody5.
  ///
  /// In en, this message translates to:
  /// **'Say Alhamdulillah for what you were given today, seen and unseen.'**
  String get notifEveningBody5;

  /// No description provided for @notifEveningBody6.
  ///
  /// In en, this message translates to:
  /// **'Sleep upon dhikr, wake upon light. Remember Him and He remembers you.'**
  String get notifEveningBody6;

  /// No description provided for @notifEveningBody7.
  ///
  /// In en, this message translates to:
  /// **'One more day closer to Him. Do not end it heedless.'**
  String get notifEveningBody7;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
