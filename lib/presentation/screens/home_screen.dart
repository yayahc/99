import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:ninety/data/datasources/local/names_datas.dart';
import 'package:ninety/presentation/screens/drawer_menu.dart';
import 'package:ninety/presentation/widgets/custom_app_bar.dart';

import '../widgets/name_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawlerMenu(),
      backgroundColor: context.colors.background,
      appBar: _appBar(context),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              context.gaps.extra,
              _buildScreenTitle(context),
              context.gaps.extra,
              context.gaps.extra,
              NamesWidget(
                names: NamesDatas.names,
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
          borderRadius: BorderRadius.circular(8.sp),
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
      leading: Builder(builder: (context) {
        return InkWell(
          enableFeedback: true,
          borderRadius: BorderRadius.circular(8.sp),
          onTap: () async => Scaffold.of(context).openDrawer(),
          child: Container(
            alignment: Alignment.center,
            child: Icon(Icons.menu, color: context.colors.primary),
          ),
        );
      }),
    );
  }
}
