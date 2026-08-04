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

  @override
  String notifNameOfDayTitle(String arabe, String transliteration) {
    return '$arabe — $transliteration';
  }

  @override
  String notifNameOfDayBody(String translation, String details) {
    return '$translation · $details';
  }

  @override
  String get notifEveningTitle => 'Reste avec Allah';

  @override
  String get notifEveningBody1 =>
      'Termine ta journée par Son rappel — SubhanAllah, Alhamdulillah, Allahu Akbar.';

  @override
  String get notifEveningBody2 =>
      'Avant de dormir, demande-Lui pardon. Il est Al-Ghafour, Le Pardonneur.';

  @override
  String get notifEveningBody3 =>
      'Quoi qu’ait porté ce jour, Il n’était jamais absent. Reviens à Lui.';

  @override
  String get notifEveningBody4 =>
      'Prie sur le Prophète ﷺ et laisse ton cœur s’apaiser.';

  @override
  String get notifEveningBody5 =>
      'Dis Alhamdulillah pour ce qui t’a été donné aujourd’hui, visible et invisible.';

  @override
  String get notifEveningBody6 =>
      'Dors sur un dhikr, réveille-toi dans la lumière. Rappelle-toi de Lui, Il se rappelle de toi.';

  @override
  String get notifEveningBody7 =>
      'Un jour de plus qui te rapproche de Lui. Ne le termine pas dans l’insouciance.';
}
