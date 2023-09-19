import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';
import 'package:ninety/features/name/presentation/screens/name_item_screen.dart';
import 'package:ninety/features/name/presentation/cubit/name_cubit.dart';
import 'package:sizer/sizer.dart';

class NamesListScreen extends StatelessWidget {
  const NamesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameCubit, NameCubitState>(builder: (context, state) {
      return PageView.builder(
          itemCount: state.names!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Column(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NameItemScreen(name: state.names![index])));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 20.h,
                      color: Colors.teal,
                      child: ListTile(
                          title: state.names![index].benefite.asWidget()),
                    )),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () => changeLang(context, 'fr'),
                        child: 'fr'.asWidget()),
                    ElevatedButton(
                        onPressed: () => changeLang(context, 'en'),
                        child: 'en'.asWidget()),
                    ElevatedButton(
                        onPressed: () => changeLang(context, 'ar'),
                        child: 'ar'.asWidget())
                  ],
                )
              ],
            );
          });
    });
  }

  void changeLang(BuildContext context, String lang) {
    final provider = BlocProvider.of<NameCubit>(context);
    provider.getName(lang);
  }
}
