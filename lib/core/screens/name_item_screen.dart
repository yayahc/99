import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';
import 'package:ninety/core/theme/colors/light_colors.dart';
import 'package:ninety/providers/cubit_provider.dart';
import 'package:sizer/sizer.dart';

class NameItemScreen extends StatelessWidget {
  final int id;

  const NameItemScreen({super.key, required this.id});

  @override
  Scaffold build(BuildContext context) {
    final names = BlocProvider.of<CubitProvider>(context);
    final name = names.getName(id);

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: LightColors.background,
      body: Center(
        child: Column(
          children: [
            name.arabe.asWidget(fontSize: 25.sp),
            name.translation.asWidget()
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: LightColors.background,
      leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.back_hand)),
    );
  }
}
