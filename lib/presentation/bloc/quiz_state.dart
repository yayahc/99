import 'package:equatable/equatable.dart';
import 'package:ninety/domain/entities/quiz_question.dart';

class QuizState extends Equatable {
  final bool isLoading;
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int score;
  final String? selectedAnswer;
  final bool showFeedback;
  final bool? isCurrentCorrect;
  final bool isCompleted;
  final String? error;

  const QuizState({
    this.isLoading = false,
    this.questions = const [],
    this.currentIndex = 0,
    this.score = 0,
    this.selectedAnswer,
    this.showFeedback = false,
    this.isCurrentCorrect,
    this.isCompleted = false,
    this.error,
  });

  QuizQuestion? get currentQuestion {
    if (questions.isEmpty || currentIndex >= questions.length) {
      return null;
    }
    return questions[currentIndex];
  }

  QuizState copyWith({
    bool? isLoading,
    List<QuizQuestion>? questions,
    int? currentIndex,
    int? score,
    String? selectedAnswer,
    bool? showFeedback,
    bool? isCurrentCorrect,
    bool? isCompleted,
    String? error,
    bool clearSelectedAnswer = false,
    bool clearError = false,
  }) {
    return QuizState(
      isLoading: isLoading ?? this.isLoading,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      selectedAnswer:
          clearSelectedAnswer ? null : selectedAnswer ?? this.selectedAnswer,
      showFeedback: showFeedback ?? this.showFeedback,
      isCurrentCorrect: isCurrentCorrect ?? this.isCurrentCorrect,
      isCompleted: isCompleted ?? this.isCompleted,
      error: clearError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        questions,
        currentIndex,
        score,
        selectedAnswer,
        showFeedback,
        isCurrentCorrect,
        isCompleted,
        error,
      ];
}
