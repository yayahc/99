import 'package:flutter/material.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';
import 'package:ninety/core/theme/colors/light_colors.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';
import 'package:sizer/sizer.dart';

class NameItemScreen extends StatelessWidget {
  final ITranslationModel name;

  const NameItemScreen({super.key, required this.name});

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: LightColors.background,
      body: Center(
        child: Column(
          children: [
            name.benefite.asWidget(fontSize: 25.sp),
            name.details.asWidget(),
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
          child: const Icon(Icons.backspace_rounded)),
    );
  }
}
