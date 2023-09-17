import 'package:flutter/material.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/name_local_datasource_impl.dart';
import 'package:ninety/features/name/presentation/cubit/name_cubit.dart';
import 'root.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final nameLocal = await NameLocalDataSourceImpl().getNames();
  final name = nameLocal.fold((l) => null, (r) => null);

  runApp(BlocProvider(
    create: (_) => NameCubit(name),
    child: const Root(),
  ));
}
