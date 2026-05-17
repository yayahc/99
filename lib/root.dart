import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/di.dart';
import 'package:ninety/domain/usecases/favorite/add_name_to_favorite_usecase.dart';
import 'package:ninety/domain/usecases/favorite/get_favorite_names_usecase.dart';
import 'package:ninety/domain/usecases/favorite/remove_name_to_favorite_usecase.dart';
import 'package:ninety/domain/usecases/name/get_names_usecase.dart';
import 'package:ninety/domain/usecases/quiz/get_quiz_questions_usecase.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';
import 'package:ninety/presentation/bloc/name_cubit.dart';
import 'package:ninety/presentation/bloc/quiz_cubit.dart';
import 'package:ninety/presentation/screens/home_screen.dart';
import 'package:ninety/router.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NameCubit(locator.get<GetNamesUsecase>())),
        BlocProvider(
          create: (context) => FavoriteCubit(
            locator.get<AddNameToFavoriteUsecase>(),
            locator.get<GetFavoriteNamesUsecase>(),
            locator.get<RemoveNameToFavoriteUsecase>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              QuizCubit(locator.get<GetQuizQuestionsUsecase>()),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          child: const HomeScreen(),
          builder: (_, child) {
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
                Locale('fr'),
              ],
              builder: (context, child) => child ?? const SizedBox(),
            );
          }),
    );
  }
}
