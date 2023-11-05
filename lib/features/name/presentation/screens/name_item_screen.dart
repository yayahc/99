import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninety/core/common/widgets/containers/audio_player_widget.dart';
import 'package:ninety/core/extensions/extension_on_string.dart';
import 'package:ninety/core/theme/colors/i_app_colors.dart';
import 'package:ninety/di.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';
import 'package:sizer/sizer.dart';

import '../cubit/name_cubit.dart';

class NameItemScreen extends StatefulWidget {
  final int id;

  const NameItemScreen({super.key, required this.id});

  @override
  State<NameItemScreen> createState() => _NameItemScreenState();
}

class _NameItemScreenState extends State<NameItemScreen> {
  @override
  Scaffold build(BuildContext context) {
    final name = findName(context, widget.id);

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: locator.get<IAppColors>().background,
      body: Center(
        child: Column(
          children: [
            name.arabe.asWidget(fontSize: 25.sp),
            name.details.asWidget(fontColor: Colors.amber),
            name.description.asWidget(),
            AudioPlayerWidget(audioPath: name.audioPath),
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
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: locator.get<IAppColors>().background,
      leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.backspace_rounded)),
    );
  }

  void changeLang(BuildContext context, String lang) {
    final provider = BlocProvider.of<NameCubit>(context);
    provider.getName(lang);
    setState(() {});
  }

  ITranslationModel findName(
    BuildContext context,
    int id,
  ) {
    final provider = BlocProvider.of<NameCubit>(context);
    final name = provider.state.names!.firstWhere((n) => n.id == id);
    return name;
  }
}
