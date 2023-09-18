import 'package:flutter/material.dart';
import 'package:ninety/core/common/widgets/containers/audio_player_widget.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';
import 'package:ninety/core/theme/colors/light_colors.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entities/name/name.dart';

class NameItemScreen extends StatelessWidget {
  final Name name;

  const NameItemScreen({super.key, required this.name});

  @override
  Scaffold build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: LightColors.background,
      body: Center(
        child: Column(
          children: [
            name.arabe.asWidget(fontSize: 25.sp),
            _getTranslation(myLocale: myLocale, name: name).asWidget(),
            AudioPlayerWidget(audioPath: name.audioPath)
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

  String _getTranslation({Locale? myLocale, Name? name}) {
    switch (myLocale!.toString()) {
      case 'en':
        return name!.translationInEn;
      case 'ar':
        return name!.translationInAr;
      default:
        return name!.translationInFr;
    }
  }
}
