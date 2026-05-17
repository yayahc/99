import 'package:ninety/domain/entities/quiz_question.dart';
import 'package:ninety/domain/params/quiz/get_quiz_questions_param.dart';

abstract class IQuizDatasource {
  Future<List<QuizQuestion>> getQuizQuestions(GetQuizQuestionsParam param);
}
