import 'package:flutter/material.dart';
import 'package:ninety/features/name/presentation/cubit/name_cubit.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/local_names.dart';
import 'root.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (_) => CubitProvider(NamesProvider.names),
    child: const Root(),
  ));
}
