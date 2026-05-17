import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/presentation/bloc/quiz_cubit.dart';
import 'package:ninety/presentation/bloc/quiz_state.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = Localizations.localeOf(context).languageCode;
      context.read<QuizCubit>().loadQuiz(locale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.quizTitle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: context.colors.black,
          ),
        ),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: context.colors.black, size: 24.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return _buildError(context, state.error!);
          }

          if (state.isCompleted) {
            return _buildResult(context, state);
          }

          final question = state.currentQuestion;
          if (question == null) {
            return _buildEmpty(context);
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.sp, 16.sp, 16.sp, 24.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, state),
                SizedBox(height: 16.sp),
                _buildQuestionCard(context, question),
                SizedBox(height: 16.sp),
                ...question.options.map(
                  (option) => Padding(
                    padding: EdgeInsets.only(bottom: 10.sp),
                    child: _buildOptionButton(context, state, option),
                  ),
                ),
                if (state.showFeedback) ...[
                  SizedBox(height: 8.sp),
                  _buildFeedback(context, state, question),
                  SizedBox(height: 16.sp),
                  ElevatedButton(
                    onPressed: () => context.read<QuizCubit>().nextQuestion(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D46),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.sp),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.nextQuestion,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, QuizState state) {
    final progress = state.questions.isEmpty ? 0 : state.currentIndex + 1;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D46),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.questionCount(progress, state.questions.length),
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8.sp),
                Text(
                  l10n.score(state.score),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 56.sp,
            height: 56.sp,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.quiz,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, dynamic question) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.prompt,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: context.colors.black,
            ),
          ),
          SizedBox(height: 16.sp),
          Text(
            question.name.arabe,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2E7D46),
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton(
      BuildContext context, QuizState state, String option) {
    final question = state.currentQuestion;
    final isSelected = state.selectedAnswer == option;
    final isCorrectAnswer = question?.correctAnswer == option;
    final activeColor = state.showFeedback
        ? isCorrectAnswer
            ? const Color(0xFF2E7D46)
            : isSelected
                ? Colors.redAccent
                : Colors.white
        : Colors.white;

    return GestureDetector(
      onTap: () => context.read<QuizCubit>().selectAnswer(option),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(16.sp),
          border: Border.all(
            color: state.showFeedback
                ? isCorrectAnswer
                    ? const Color(0xFF2E7D46)
                    : isSelected
                        ? Colors.redAccent
                        : Colors.transparent
                : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: state.showFeedback
                      ? isCorrectAnswer || isSelected
                          ? Colors.white
                          : context.colors.black
                      : context.colors.black,
                ),
              ),
            ),
            if (state.showFeedback)
              Icon(
                isCorrectAnswer
                    ? Icons.check_circle
                    : isSelected
                        ? Icons.cancel
                        : Icons.circle_outlined,
                color: isCorrectAnswer ? Colors.white : Colors.white70,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedback(
      BuildContext context, QuizState state, dynamic question) {
    final l10n = AppLocalizations.of(context)!;
    final text = state.isCurrentCorrect == true
        ? l10n.correctAnswer
        : l10n.wrongAnswer(question.correctAnswer);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: state.isCurrentCorrect == true
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: state.isCurrentCorrect == true
              ? const Color(0xFF2E7D46)
              : Colors.redAccent,
        ),
      ),
    );
  }

  Widget _buildResult(BuildContext context, QuizState state) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events,
                  color: const Color(0xFF2E7D46), size: 56.sp),
              SizedBox(height: 16.sp),
              Text(
                l10n.quizCompleted,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colors.black,
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                l10n.finalScore(state.score, state.questions.length),
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.sp),
              ElevatedButton(
                onPressed: () {
                  final locale = Localizations.localeOf(context).languageCode;
                  context.read<QuizCubit>().restartQuiz(locale: locale);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D46),
                  foregroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.sp, vertical: 14.sp),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.sp),
                  ),
                ),
                child: Text(
                  l10n.playAgain,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.redAccent, size: 56.sp),
            SizedBox(height: 16.sp),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.black,
              ),
            ),
            SizedBox(height: 16.sp),
            ElevatedButton(
              onPressed: () {
                final locale = Localizations.localeOf(context).languageCode;
                context.read<QuizCubit>().loadQuiz(locale: locale);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D46),
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Text(
        l10n.noQuestionsAvailable,
        style: TextStyle(
          fontSize: 15.sp,
          color: context.colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
