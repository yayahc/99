import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/helpers/error_catcher.dart';
import 'package:ninety/domain/entities/quiz_question.dart';
import 'package:ninety/domain/params/quiz/get_quiz_questions_param.dart';
import 'package:ninety/domain/repositories/quiz/i_quiz_repository.dart';
import 'package:ninety/domain/usecases/usecase.dart';

@singleton
class GetQuizQuestionsUsecase
    implements Usecase<GetQuizQuestionsParam, List<QuizQuestion>> {
  final IQuizRepository _quizRepository;

  GetQuizQuestionsUsecase(this._quizRepository);

  @override
  Future<Either<AppError, List<QuizQuestion>>> trigger(
      GetQuizQuestionsParam param) async {
    return await ErrorCatcher.trycatch(_quizRepository.getQuizQuestions(param));
  }
}
