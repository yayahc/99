import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/assets/assets.gen.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/presentation/screens/favorite_name_screen.dart';
import 'package:ninety/presentation/widgets/custom_app_bar.dart';

import '../widgets/name_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _appBar(context),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              context.gaps.extra,
              _buildScreenTitle(context),
              context.gaps.extra,
              context.gaps.extra,
              const NamesWidget(
                names: [],
                isFav: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildScreenTitle(BuildContext context) {
    return SizedBox(
      width: 193.sp,
      height: 71.sp,
      child: "The 99 Names of Allah"
          .medium(fontColor: context.colors.black, textAlign: TextAlign.center)
          .title,
    );
  }

  AppBar _appBar(BuildContext context) {
    return CustomAppBar.build(
      actions: [
        InkWell(
          enableFeedback: true,
          onTap: () {
            context.push("/favorite");
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            alignment: Alignment.center,
            child: const Icon(Icons.favorite, color: Colors.red),
          ),
        ),
      ],
      leading: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          child: Icon(Icons.menu, color: context.colors.primary),
        ),
      ),
    );
  }
}
