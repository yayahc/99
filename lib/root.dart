import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/di.dart';
import 'package:ninety/domain/usecases/name/get_name_usecase.dart';
import 'package:ninety/presentation/bloc/favorite_cubit.dart';
import 'package:ninety/presentation/bloc/name_cubit.dart';
import 'package:ninety/router.dart';

import 'domain/usecases/favorite/add_name_to_favorite_usecase.dart';
import 'domain/usecases/favorite/get_favorite_names_usecase.dart';
import 'domain/usecases/favorite/remove_name_to_favorite_usecase.dart';
import 'domain/usecases/name/get_names_usecase.dart';
import 'presentation/screens/home_screen.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
          );
        });
  }
}
