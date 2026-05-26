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
}
