// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get quizTitle => 'Quiz';

  @override
  String questionCount(int count, int total) {
    return 'Question $count of $total';
  }

  @override
  String score(int value) {
    return 'Score $value';
  }

  @override
  String get nextQuestion => 'Next question';

  @override
  String get correctAnswer => 'Correct answer';

  @override
  String wrongAnswer(String answer) {
    return 'Wrong answer, correct one is $answer';
  }

  @override
  String get quizCompleted => 'Quiz completed';

  @override
  String finalScore(int score, int total) {
    return 'You scored $score out of $total';
  }

  @override
  String get playAgain => 'Play again';

  @override
  String get retry => 'Retry';

  @override
  String get noQuestionsAvailable => 'No quiz questions available';

  @override
  String get transliterationPrompt => 'Which transliteration matches this meaning?';

  @override
  String get translationPrompt => 'What does this Arabic name mean?';

  @override
  String get arabicPrompt => 'Which Arabic form matches this name?';

  @override
  String get appTitle => 'The 99';

  @override
  String get appSubtitle => 'Asma ul Husna';

  @override
  String get searchHint => 'Search names, meanings...';

  @override
  String get quranTitle => 'Quran';

  @override
  String get searchSurahHint => 'Search surah by name, meaning or number';

  @override
  String get noSurahMatches => 'No surah matches your search';

  @override
  String get selectReciter => 'Select reciter';

  @override
  String get meaning => 'Meaning';

  @override
  String get playAudio => 'Play audio';

  @override
  String get pause => 'Pause';

  @override
  String get nameOfTheDay => 'NAME OF THE DAY';

  @override
  String get favoriteTitle => 'Favorite';

  @override
  String get noSavedNames => 'No saved names yet';

  @override
  String get noSavedNamesSubtitle => 'Tap the heart on any name to save it here';

  @override
  String get theme => 'THEME';

  @override
  String get notifications => 'NOTIFICATIONS';

  @override
  String get quranSection => 'QURAN';

  @override
  String get autoPlayQuran => 'Play on app launch';

  @override
  String get autoPlayQuranSubtitle => 'Start a quiet recitation in the background every time you open the app';

  @override
  String get backgroundVolume => 'Background volume';

  @override
  String get volume => 'Volume';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get enable => 'Enable';

  @override
  String get disable => 'Disable';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get system => 'System';

  @override
  String notifNameOfDayTitle(String arabe, String transliteration) {
    return '$arabe — $transliteration';
  }

  @override
  String notifNameOfDayBody(String translation, String details) {
    return '$translation · $details';
  }

  @override
  String get notifEveningTitle => 'Stay with Allah';

  @override
  String get notifEveningBody1 => 'Close your day with His remembrance — SubhanAllah, Alhamdulillah, Allahu Akbar.';

  @override
  String get notifEveningBody2 => 'Before you sleep, ask Him for forgiveness. He is Al-Ghafoor, The Forgiving.';

  @override
  String get notifEveningBody3 => 'Whatever the day held, He was never absent. Turn to Him now.';

  @override
  String get notifEveningBody4 => 'Send peace upon the Prophet ﷺ and let your heart rest.';

  @override
  String get notifEveningBody5 => 'Say Alhamdulillah for what you were given today, seen and unseen.';

  @override
  String get notifEveningBody6 => 'Sleep upon dhikr, wake upon light. Remember Him and He remembers you.';

  @override
  String get notifEveningBody7 => 'One more day closer to Him. Do not end it heedless.';
}
