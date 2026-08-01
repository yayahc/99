// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get quizTitle => 'Quiz';

  @override
  String questionCount(int count, int total) {
    return 'Question $count sur $total';
  }

  @override
  String score(int value) {
    return 'Score $value';
  }

  @override
  String get nextQuestion => 'Question suivante';

  @override
  String get correctAnswer => 'Bonne réponse';

  @override
  String wrongAnswer(String answer) {
    return 'Mauvaise réponse, la bonne est $answer';
  }

  @override
  String get quizCompleted => 'Quiz terminé';

  @override
  String finalScore(int score, int total) {
    return 'Vous avez marqué $score sur $total';
  }

  @override
  String get playAgain => 'Rejouer';

  @override
  String get retry => 'Réessayer';

  @override
  String get noQuestionsAvailable => 'Aucune question de quiz disponible';

  @override
  String get transliterationPrompt => 'Quelle est la translittération ?';

  @override
  String get translationPrompt => 'Quelle est la traduction ?';

  @override
  String get arabicPrompt => 'Quel est le nom en arabe ?';

  @override
  String get appTitle => 'Les 99';

  @override
  String get appSubtitle => 'Asma ul Husna';

  @override
  String get searchHint => 'Rechercher des noms, des significations...';

  @override
  String get quranTitle => 'Coran';

  @override
  String get searchSurahHint =>
      'Rechercher une sourate par nom, sens ou numéro';

  @override
  String get noSurahMatches => 'Aucune sourate ne correspond à votre recherche';

  @override
  String get selectReciter => 'Sélectionner un récitant';

  @override
  String get meaning => 'Signification';

  @override
  String get playAudio => 'Lire l\'audio';

  @override
  String get pause => 'Pause';

  @override
  String get nameOfTheDay => 'NOM DU JOUR';

  @override
  String get favoriteTitle => 'Favoris';

  @override
  String get noSavedNames => 'Aucun nom enregistré pour le moment';

  @override
  String get noSavedNamesSubtitle =>
      'Appuyez sur le cœur d’un nom pour l’enregistrer ici';

  @override
  String get theme => 'THÈME';

  @override
  String get notifications => 'NOTIFICATIONS';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get enable => 'Activer';

  @override
  String get disable => 'Désactiver';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get system => 'Système';
}
