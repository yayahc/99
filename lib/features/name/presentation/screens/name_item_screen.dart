import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/core/common/widgets/containers/audio_player_widget.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';
import 'package:ninety/core/theme/colors/light_colors.dart';
import 'package:ninety/features/name/presentation/cubit/name_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entities/name/name.dart';

class NameItemScreen extends StatefulWidget {
  final int id;

  const NameItemScreen({super.key, required this.id});

  @override
  State<NameItemScreen> createState() => _NameItemScreenState();
}

class _NameItemScreenState extends State<NameItemScreen> {
  late final Name name;

  @override
  Scaffold build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final nameList = await getDatas(context);
        setState(() {
          name = nameList!.firstWhere((element) => element.id == widget.id);
        });
      },
    );

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

  Future<List<Name>?> getDatas(context) async {
    final names = BlocProvider.of<NameCubit>(context);
    final name = await names.getName(widget.id);
    return name;
  }
}
