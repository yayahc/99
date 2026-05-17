import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/domain/params/quiz/get_quiz_questions_param.dart';
import 'package:ninety/domain/usecases/quiz/get_quiz_questions_usecase.dart';

import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final GetQuizQuestionsUsecase _getQuizQuestionsUsecase;

  QuizCubit(this._getQuizQuestionsUsecase) : super(const QuizState());

  Future<void> loadQuiz({int questionCount = 10}) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _getQuizQuestionsUsecase
        .trigger(GetQuizQuestionsParam(count: questionCount));
    result.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          error: error.getError(),
        ),
      ),
      (questions) => emit(
        state.copyWith(
          isLoading: false,
          questions: questions,
          currentIndex: 0,
          score: 0,
          clearSelectedAnswer: true,
          showFeedback: false,
          isCurrentCorrect: null,
          isCompleted: false,
          clearError: true,
        ),
      ),
    );
  }

  void selectAnswer(String answer) {
    final question = state.currentQuestion;
    if (question == null || state.showFeedback || state.isCompleted) {
      return;
    }
    final isCorrect = question.correctAnswer == answer;
    emit(
      state.copyWith(
        score: isCorrect ? state.score + 1 : state.score,
        selectedAnswer: answer,
        showFeedback: true,
        isCurrentCorrect: isCorrect,
      ),
    );
  }

  void nextQuestion() {
    if (!state.showFeedback || state.currentQuestion == null) {
      return;
    }
    final nextIndex = state.currentIndex + 1;
    if (nextIndex >= state.questions.length) {
      emit(
        state.copyWith(
          isCompleted: true,
          showFeedback: false,
          clearSelectedAnswer: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        currentIndex: nextIndex,
        clearSelectedAnswer: true,
        showFeedback: false,
        isCurrentCorrect: null,
      ),
    );
  }

  Future<void> restartQuiz() async {
    await loadQuiz(
        questionCount: state.questions.isEmpty ? 10 : state.questions.length);
  }
}
