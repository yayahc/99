import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/i_quiz_datasource.dart';
import 'package:ninety/domain/entities/quiz_question.dart';
import 'package:ninety/domain/params/quiz/get_quiz_questions_param.dart';
import 'package:ninety/domain/repositories/quiz/i_quiz_repository.dart';

@Singleton(as: IQuizRepository)
class QuizRepositoryImpl implements IQuizRepository {
  final IQuizDatasource _quizDatasource;

  QuizRepositoryImpl(this._quizDatasource);

  @override
  Future<List<QuizQuestion>> getQuizQuestions(
      GetQuizQuestionsParam param) async {
    return await _quizDatasource.getQuizQuestions(param);
  }
}
