import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';
import 'package:ninety/core/models/name.dart';
import 'package:ninety/core/screens/name_item_screen.dart';
import 'package:ninety/providers/cubit_provider.dart';
import 'package:sizer/sizer.dart';

import '../l10n/generated/app_localizations_export.dart';

class NamesListScreen extends StatelessWidget {
  const NamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitProvider, List<Name>>(builder: (context, state) {
      return PageView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            // final inter = state[index].translation;
            return TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NameItemScreen(id: state[index].id)));
                },
                child: Container(
                  width: double.infinity,
                  height: 100.h,
                  color: Colors.teal,
                  child: ListTile(
                    title: (AppLocalizations.of(context)!.translationOfAllah)
                        .asWidget(),
                  ),
                ));
          });
    });
  }
}
