import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/assets/assets.gen.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Wrap(
        runSpacing: 8.sp,
        children: names.map((e) => _buildName(e, context)).toList(),
      ),
    );
  }

  Widget _buildName(Name name, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !isFav
            ? _buildIndexWithSeparator(context, name)
            : _buildFavButton(context),
        _buildContent(name, context),
      ],
    );
  }

  Widget _buildContent(Name name, BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(8.sp),
        onTap: () => context.push("/name", extra: name),
        child: Container(
          width: 300.sp,
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 10.sp),
          decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  name.transliteration
                      .regular(fontColor: context.colors.black)
                      .body,
                  name.translation.light(fontColor: context.colors.black).label
                ],
              ),
              name.arabe.medium(fontColor: context.colors.primary).title
            ],
          ),
        ));
  }

  Row _buildIndexWithSeparator(BuildContext context, Name name) {
    return Row(
      children: [
        name.id.toString().light(fontColor: context.colors.black).label,
        context.gaps.small,
        Assets.svgs.separator.svg(),
      ],
    );
  }

  Widget _buildFavButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.sp),
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
