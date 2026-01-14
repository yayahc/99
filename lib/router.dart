import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/di.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/presentation/bloc/name_cubit.dart';
import 'package:ninety/presentation/screens/favorite_name_screen.dart';
import 'package:ninety/presentation/screens/home_screen.dart';
import 'package:ninety/presentation/screens/name_item_screen.dart';

import 'domain/usecases/favorite/add_name_to_favorite_usecase.dart';
import 'domain/usecases/favorite/get_favorite_names_usecase.dart';
import 'domain/usecases/favorite/remove_name_to_favorite_usecase.dart';
import 'domain/usecases/name/get_names_usecase.dart';
import 'presentation/bloc/favorite_cubit.dart';

class AppRouter {
  static GoRouter get router =>
      GoRouter(initialLocation: "/home", debugLogDiagnostics: true, routes: [
        GoRoute(
          path: "/home",
          builder: (context, state) => BlocProvider(
              create: (context) => NameCubit(locator.get<GetNamesUsecase>()),
              child: const HomeScreen()),
        ),
        GoRoute(
          path: "/favorite",
          builder: (context, state) => BlocProvider(
            create: (context) => FavoriteCubit(
              locator.get<AddNameToFavoriteUsecase>(),
              locator.get<GetFavoriteNamesUsecase>(),
              locator.get<RemoveNameToFavoriteUsecase>(),
            ),
            child: const FavoriteNameScreen(),
          ),
        ),
        GoRoute(
          pageBuilder: (context, state) {
            final name = state.extra as Name;
            return MaterialPage<void>(child: NameItemScreen(name: name));
          },
          path: "/name",
        ),
      ]);
}
