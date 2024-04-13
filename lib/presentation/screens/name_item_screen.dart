import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';

class NameItemScreen extends StatelessWidget {
  const NameItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.colors.background,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Container(
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back, color: context.colors.black),
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(right: 24.sp, left: 24.sp, top: 24.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              context.gaps.extra,
              context.gaps.small,
              _buildContent(context)
            ],
          )),
    );
  }

  Column _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        "Allah".regular(fontColor: context.colors.black).body,
        context.gaps.small,
        "Clément envers ses créatures. La clémence d'une mère envers son enfant est une partie infime de Son immense clémence envers Ses créatures. Son châtiment est le plus dur et sévère de tous les châtiments mais Sa clémence a précédé Sa colère ; et ce nom fait partie des noms que l’on n’attribue à nul autre qu'Allah."
            .light(fontColor: context.colors.black, textAlign: TextAlign.left)
            .label
      ],
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            "Name".medium(fontColor: context.colors.black).title,
            context.gaps.small,
            context.gaps.small,
            InkWell(
              enableFeedback: true,
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: context.colors.primary,
                child: Icon(Icons.play_arrow, color: context.colors.white),
              ),
            ),
          ],
        ),
        InkWell(
          enableFeedback: true,
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            alignment: Alignment.center,
            child: const Icon(Icons.favorite, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
