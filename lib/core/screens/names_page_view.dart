import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/core/common/widgets/containers/name_container.dart';
import 'package:ninety/core/models/name.dart';
import 'package:ninety/providers/cubit_provider.dart';

class NamesPageView extends StatelessWidget {
  const NamesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitProvider, List<Name>>(builder: (context, state) {
      return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.length,
          itemBuilder: (context, index) {
            return NameContainer(
              nameData: state[index],
            );
          });
    });
  }
}
