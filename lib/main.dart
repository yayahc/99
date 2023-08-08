import 'package:flutter/material.dart';
import 'package:ninety/providers/cubit_provider.dart';
import 'package:ninety/providers/names_provider.dart';
import 'root.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (_) => CubitProvider(NamesProvider.names),
    child: const Root(),
  ));
}
