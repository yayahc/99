// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get quizTitle => 'اختبار';

  @override
  String questionCount(int count, int total) {
    return 'السؤال $count من $total';
  }

  @override
  String score(int value) {
    return 'النقاط $value';
  }

  @override
  String get nextQuestion => 'السؤال التالي';

  @override
  String get correctAnswer => 'إجابة صحيحة';

  @override
  String wrongAnswer(String answer) {
    return 'إجابة خاطئة، الإجابة الصحيحة هي $answer';
  }

  @override
  String get quizCompleted => 'انتهى الاختبار';

  @override
  String finalScore(int score, int total) {
    return 'حصلت على $score من $total';
  }

  @override
  String get playAgain => 'العب مجددًا';

  @override
  String get retry => 'حاول مجددًا';

  @override
  String get noQuestionsAvailable => 'لا توجد أسئلة متاحة';

  @override
  String get transliterationPrompt => 'أي نطق يطابق هذا المعنى؟';

  @override
  String get translationPrompt => 'ماذا يعني هذا الاسم العربي؟';

  @override
  String get arabicPrompt => 'أي الشكل العربي يطابق هذا الاسم؟';

  @override
  String get appTitle => 'الـ99';

  @override
  String get appSubtitle => 'أسماء الله الحسنى';

  @override
  String get searchHint => 'ابحث عن الأسماء والمعاني...';

  @override
  String get quranTitle => 'القرآن';

  @override
  String get searchSurahHint => 'ابحث عن السورة بالاسم أو المعنى أو الرقم';

  @override
  String get noSurahMatches => 'لا توجد سورة تطابق بحثك';

  @override
  String get selectReciter => 'اختر القارئ';

  @override
  String get meaning => 'المعنى';

  @override
  String get playAudio => 'تشغيل الصوت';

  @override
  String get pause => 'إيقاف';

  @override
  String get nameOfTheDay => 'اسم اليوم';

  @override
  String get favoriteTitle => 'المفضلة';

  @override
  String get noSavedNames => 'لا توجد أسماء محفوظة بعد';

  @override
  String get noSavedNamesSubtitle => 'اضغط على القلب لحفظ أي اسم هنا';

  @override
  String get theme => 'المظهر';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get enable => 'تفعيل';

  @override
  String get disable => 'تعطيل';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get system => 'النظام';

  @override
  String notifNameOfDayTitle(String arabe, String transliteration) {
    return '$arabe — $transliteration';
  }

  @override
  String notifNameOfDayBody(String translation, String details) {
    return '$translation · $details';
  }

  @override
  String get notifEveningTitle => 'ابقَ مع الله';

  @override
  String get notifEveningBody1 =>
      'اختم يومك بذكره — سبحان الله، الحمد لله، الله أكبر.';

  @override
  String get notifEveningBody2 => 'قبل أن تنام، استغفره؛ فهو الغفور الرحيم.';

  @override
  String get notifEveningBody3 =>
      'مهما حمل يومك، لم يغب عنك سبحانه. عُد إليه الآن.';

  @override
  String get notifEveningBody4 => 'صلِّ على النبي ﷺ ودع قلبك يطمئن.';

  @override
  String get notifEveningBody5 =>
      'قل الحمد لله على ما رُزقت اليوم، ما علمتَ منه وما لم تعلم.';

  @override
  String get notifEveningBody6 => 'نَم على ذكر، تستيقظ على نور. اذكره يذكرك.';

  @override
  String get notifEveningBody7 => 'يوم آخر يقرّبك إليه، فلا تختمه بغفلة.';
}
