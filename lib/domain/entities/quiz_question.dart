import 'package:ninety/domain/entities/name.dart';

enum QuizQuestionMode {
  transliteration,
  translation,
  arabic,
}

class QuizQuestion {
  final int id;
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final Name name;
  final QuizQuestionMode mode;

  const QuizQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.name,
    required this.mode,
  });

  String get correctAnswer => options[correctIndex];
}
