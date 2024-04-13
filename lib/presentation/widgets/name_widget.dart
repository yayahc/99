import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/assets/assets.gen.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:ninety/presentation/screens/name_item_screen.dart';

import '../../domain/entities/name.dart';

class NamesWidget extends StatelessWidget {
  final List<Name> names;
  final bool isFav;
  const NamesWidget({
    super.key,
    required this.names,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    final fake = Name(
        id: 0,
        arabe: "Name",
        transliteration: "transliteration",
        translationInAr: "translationInAr",
        translationInEn: "translationInEn",
        translationInFr: "translationInFr",
        details: "details",
        sampleDoua: [],
        benefite: "benefite",
        reference: "reference",
        audioPath: "audioPath",
        imagePath: "imagePath");
    final fakeL = List.generate(
      15,
      (index) => fake,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Wrap(
        runSpacing: 8.sp,
        children: fakeL.map((e) => _buildName(fakeL, context)).toList(),
      ),
    );
  }

  Widget _buildName(List<Name> fakeL, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !isFav
            ? _buildIndexWithSeparator(context, fakeL)
            : _buildFavButton(context),
        _buildContent(fakeL, context),
      ],
    );
  }

  Widget _buildContent(List<Name> fakeL, BuildContext context) {
    return InkWell(
        onTap: () => context.push("/name"),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
          decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fakeL[0]
                      .transliteration
                      .regular(fontColor: context.colors.black)
                      .body,
                  fakeL[0]
                      .translationInFr
                      .light(fontColor: context.colors.black)
                      .label
                ],
              ),
              context.gaps.extra,
              context.gaps.extra,
              context.gaps.extra,
              context.gaps.extra,
              fakeL[0].arabe.regular(fontColor: context.colors.primary).title
            ],
          ),
        ));
  }

  Row _buildIndexWithSeparator(BuildContext context, dynamic fakeL) {
    return Row(
      children: [
        fakeL[0].id.toString().light(fontColor: context.colors.black).label,
        context.gaps.small,
        Assets.svgs.separator.svg(),
      ],
    );
  }

  Widget _buildFavButton(BuildContext context) {
    return InkWell(
      enableFeedback: true,
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        alignment: Alignment.center,
        child: const Icon(Icons.favorite, color: Colors.red),
      ),
    );
  }
}
