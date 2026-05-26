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
}
