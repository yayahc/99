import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/i_quiz_datasource.dart';
import 'package:ninety/data/datasources/local/names_datas.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/domain/entities/quiz_question.dart';
import 'package:ninety/domain/params/quiz/get_quiz_questions_param.dart';

@Singleton(as: IQuizDatasource)
class LocalQuizDatasourceImpl implements IQuizDatasource {
  final Random _random = Random();
  final List<Name> _names = NamesDatas.names;

  @override
  Future<List<QuizQuestion>> getQuizQuestions(
      GetQuizQuestionsParam param) async {
    final count = param.count.clamp(1, _names.length).toInt();
    final selected = List<Name>.from(_names)..shuffle(_random);
    return List.generate(
        count, (index) => _buildQuestion(selected[index], index, param.locale));
  }

  QuizQuestion _buildQuestion(Name name, int index, String locale) {
    final mode = QuizQuestionMode
        .values[_random.nextInt(QuizQuestionMode.values.length)];
    final isArabic = locale == 'ar';
    switch (mode) {
      case QuizQuestionMode.transliteration:
        return _questionFromPool(
          id: index + 1,
          name: name,
          mode: mode,
          prompt: isArabic
              ? 'أي نطق يطابق هذا المعنى؟'
              : 'Which transliteration matches this meaning?',
          correct: name.transliteration,
          optionsPool: _names.map((item) => item.transliteration).toList(),
        );
      case QuizQuestionMode.translation:
        return _questionFromPool(
          id: index + 1,
          name: name,
          mode: mode,
          prompt: isArabic
              ? 'ماذا يعني هذا الاسم العربي؟'
              : 'What does this Arabic name mean?',
          correct: name.translation,
          optionsPool: _names.map((item) => item.translation).toList(),
        );
      case QuizQuestionMode.arabic:
        return _questionFromPool(
          id: index + 1,
          name: name,
          mode: mode,
          prompt: isArabic
              ? 'أي الشكل العربي يطابق هذا الاسم؟'
              : 'Which Arabic form matches this name?',
          correct: name.arabe,
          optionsPool: _names.map((item) => item.arabe).toList(),
        );
    }
  }

  QuizQuestion _questionFromPool({
    required int id,
    required Name name,
    required QuizQuestionMode mode,
    required String prompt,
    required String correct,
    required List<String> optionsPool,
  }) {
    final pool = optionsPool.where((value) => value != correct).toSet().toList()
      ..shuffle(_random);
    final options = <String>[correct, ...pool.take(3).toList()]
      ..shuffle(_random);
    return QuizQuestion(
      id: id,
      prompt: '$prompt ${_questionLabel(mode, name)}',
      options: options,
      correctIndex: options.indexOf(correct),
      name: name,
      mode: mode,
    );
  }

  String _questionLabel(QuizQuestionMode mode, Name name) {
    switch (mode) {
      case QuizQuestionMode.transliteration:
        return name.translation;
      case QuizQuestionMode.translation:
        return name.arabe;
      case QuizQuestionMode.arabic:
        return name.transliteration;
    }
  }
}
