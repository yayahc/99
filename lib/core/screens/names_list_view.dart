import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';
import 'package:ninety/core/models/name.dart';
import 'package:ninety/providers/cubit_provider.dart';
import 'package:sizer/sizer.dart';

class NamesListView extends StatelessWidget {
  const NamesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitProvider, List<Name>>(builder: (context, state) {
      return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: 100.h,
                color: Colors.teal,
                child: ListTile(
                  title: state[index].translation.asWidget(),
                ),
              ),
            );
          });
    });
  }
}
