import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/domain/entities/quiz_question.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:ninety/presentation/bloc/quiz_cubit.dart';
import 'package:ninety/presentation/bloc/quiz_state.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const _optionLetters = ['A', 'B', 'C', 'D', 'E', 'F'];

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
            return Center(
              child: CircularProgressIndicator(color: context.colors.emerald),
            );
          }
          if (state.error != null) return _buildError(context, state.error!);
          if (state.isCompleted) return _buildResult(context, state);
          final question = state.currentQuestion;
          if (question == null) return _buildEmpty(context);

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.sp, 16.sp, 20.sp, 28.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ProgressHeader(state: state),
                SizedBox(height: 24.sp),
                _QuestionHero(question: question),
                SizedBox(height: 22.sp),
                ...List.generate(question.options.length, (i) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.sp),
                    child: _OptionTile(
                      letter: _optionLetters[i],
                      option: question.options[i],
                      state: state,
                    ),
                  );
                }),
                if (state.showFeedback) ...[
                  SizedBox(height: 6.sp),
                  _Feedback(state: state, question: question),
                  SizedBox(height: 18.sp),
                  _NextButton(),
                ],
              ],
            ),
          );
        },
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
          padding: EdgeInsets.all(28.sp),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(28.sp),
            boxShadow: [
              BoxShadow(
                color: context.colors.emerald.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88.sp,
                height: 88.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.colors.gold,
                      context.colors.gold.withValues(alpha: 0.75),
                    ],
                  ),
                ),
                child: Icon(Icons.emoji_events_rounded,
                    color: Colors.white, size: 44.sp),
              ),
              SizedBox(height: 18.sp),
              Text(
                l10n.quizCompleted,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colors.black,
                ),
              ),
              SizedBox(height: 12.sp),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${state.score}',
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w800,
                        color: context.colors.emerald,
                      ),
                    ),
                    TextSpan(
                      text: ' / ${state.questions.length}',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colors.black.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.sp),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final locale = Localizations.localeOf(context).languageCode;
                    context.read<QuizCubit>().restartQuiz(locale: locale);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.emerald,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.sp),
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
            Icon(Icons.error_outline_rounded,
                color: Colors.redAccent, size: 56.sp),
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
                backgroundColor: context.colors.emerald,
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

class _ProgressHeader extends StatelessWidget {
  final QuizState state;
  const _ProgressHeader({required this.state});

  @override
  Widget build(BuildContext context) {
    final total = state.questions.length;
    final current = state.questions.isEmpty ? 0 : state.currentIndex + 1;
    final progress = total == 0 ? 0.0 : current / total;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$current',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: context.colors.black,
                    ),
                  ),
                  Text(
                    ' / $total',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colors.black.withValues(alpha: 0.45),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.sp),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8.sp,
                  backgroundColor:
                      context.colors.emerald.withValues(alpha: 0.15),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(context.colors.emerald),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.sp),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 9.sp),
          decoration: BoxDecoration(
            color: context.colors.gold.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(
              color: context.colors.gold.withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_rounded, color: context.colors.gold, size: 18.sp),
              SizedBox(width: 6.sp),
              Text(
                '${state.score}',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colors.gold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuestionHero extends StatelessWidget {
  final QuizQuestion question;
  const _QuestionHero({required this.question});

  String _questionLine(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (question.mode) {
      case QuizQuestionMode.transliteration:
        return l10n.transliterationPrompt;
      case QuizQuestionMode.translation:
        return l10n.translationPrompt;
      case QuizQuestionMode.arabic:
        return l10n.arabicPrompt;
    }
  }

  String _subject() {
    switch (question.mode) {
      case QuizQuestionMode.transliteration:
        return question.name.translation;
      case QuizQuestionMode.translation:
        return question.name.arabe;
      case QuizQuestionMode.arabic:
        return question.name.transliteration;
    }
  }

  bool get _subjectIsArabic => question.mode == QuizQuestionMode.translation;

  @override
  Widget build(BuildContext context) {
    final emerald = context.colors.emerald;
    return Container(
      padding: EdgeInsets.fromLTRB(24.sp, 16.sp, 24.sp, 16.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [emerald, emerald.withValues(alpha: 0.78)],
        ),
        borderRadius: BorderRadius.circular(24.sp),
        boxShadow: [
          BoxShadow(
            color: emerald.withValues(alpha: 0.30),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            top: -22.sp,
            right: -18.sp,
            child: Opacity(
              opacity: 0.10,
              child:
                  Icon(Icons.auto_awesome, size: 130.sp, color: Colors.white),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.quizTitle.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.2,
                ),
              ),
              SizedBox(height: 10.sp),
              Text(
                _questionLine(context),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 16.sp),
              _Ornament(),
              SizedBox(height: 10.sp),
              Center(
                child: Text(
                  _subject(),
                  textAlign: TextAlign.center,
                  textDirection:
                      _subjectIsArabic ? TextDirection.rtl : TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _subjectIsArabic ? 40.sp : 28.sp,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Ornament extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget line() => Expanded(
          child: Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.35),
          ),
        );
    return Row(
      children: [
        line(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Icon(Icons.diamond_outlined,
              color: context.colors.gold, size: 14.sp),
        ),
        line(),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String letter;
  final String option;
  final QuizState state;
  const _OptionTile({
    required this.letter,
    required this.option,
    required this.state,
  });

  bool get _isArabicText {
    return option.runes.any((r) => r >= 0x0600 && r <= 0x06FF);
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = state.selectedAnswer == option;
    final isCorrect = state.currentQuestion?.correctAnswer == option;
    final showFeedback = state.showFeedback;
    final emerald = context.colors.emerald;

    late Color bg;
    late Color border;
    late Color letterBg;
    late Color letterFg;
    late Color textColor;

    if (showFeedback && isCorrect) {
      bg = emerald;
      border = emerald;
      letterBg = Colors.white;
      letterFg = emerald;
      textColor = Colors.white;
    } else if (showFeedback && isSelected) {
      bg = Colors.redAccent;
      border = Colors.redAccent;
      letterBg = Colors.white;
      letterFg = Colors.redAccent;
      textColor = Colors.white;
    } else {
      bg = context.colors.surface;
      border = context.colors.black.withValues(alpha: 0.08);
      letterBg = emerald.withValues(alpha: 0.12);
      letterFg = emerald;
      textColor = context.colors.black;
    }

    return GestureDetector(
      onTap: () => context.read<QuizCubit>().selectAnswer(option),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 8.sp),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18.sp),
          border: Border.all(color: border, width: 1.2),
        ),
        child: Row(
          children: [
            Container(
              width: 36.sp,
              height: 36.sp,
              decoration: BoxDecoration(
                color: letterBg,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: letterFg,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.sp),
            Expanded(
              child: Text(
                option,
                textDirection:
                    _isArabicText ? TextDirection.rtl : TextDirection.ltr,
                style: TextStyle(
                  fontSize: _isArabicText ? 19.sp : 15.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
            if (showFeedback && (isCorrect || isSelected))
              Padding(
                padding: EdgeInsets.only(left: 8.sp),
                child: Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Feedback extends StatelessWidget {
  final QuizState state;
  final QuizQuestion question;
  const _Feedback({required this.state, required this.question});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final correct = state.isCurrentCorrect == true;
    final tint = correct ? context.colors.emerald : Colors.redAccent;
    final text =
        correct ? l10n.correctAnswer : l10n.wrongAnswer(question.correctAnswer);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 14.sp),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16.sp),
        border: Border.all(color: tint.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(
            correct ? Icons.check_circle_rounded : Icons.info_rounded,
            color: tint,
            size: 22.sp,
          ),
          SizedBox(width: 10.sp),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: tint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.read<QuizCubit>().nextQuestion(),
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.emerald,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.sp),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.nextQuestion,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 6.sp),
            Icon(Icons.arrow_forward_rounded, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
