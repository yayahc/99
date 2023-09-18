import 'package:flutter/material.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/name_local_datasource_impl.dart';
import 'package:ninety/features/name/data/repositories/name_repository_impl.dart';
import 'package:ninety/features/name/domain/usescases/name_usescases/get_names_usescase.dart';
import 'package:ninety/features/name/presentation/cubit/name_cubit.dart';
import 'root.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final nameLocal = NameLocalDataSourceImpl();
  final useCase = GetNamesUsesCase(NameRepositoryImpl(nameLocal));
  final namesT = await nameLocal.getNames();
  final names = namesT.fold((l) => null, (r) => r);

  runApp(BlocProvider(
    create: (_) => NameCubit(
      names,
      useCase,
    ),
    child: const Root(),
  ));
}
