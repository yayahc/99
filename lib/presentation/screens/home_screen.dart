import 'package:flutter/material.dart';
import 'package:ninety/core/assets/assets.gen.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.colors.background,
        actions: [
          InkWell(
            child: Container(
              alignment: Alignment.center,
              child: const Icon(Icons.favorite, color: Colors.red),
            ),
          )
        ],
        leading: InkWell(
          child: Container(
            alignment: Alignment.center,
            child: Icon(Icons.menu, color: context.colors.primary),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "The 99 Names of Allah"
                  .medium(fontColor: context.colors.black)
                  .title,
              _buildStack(context)
            ],
          ),
        ),
      ),
    );
  }

  Stack _buildStack(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [Assets.svgs.separator.svg()],
    );
  }
}
