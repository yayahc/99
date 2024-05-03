import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';

class SettingButton extends StatelessWidget {
  final ValueNotifier<bool> isEnable;
  final String title;
  const SettingButton({
    super.key,
    required this.isEnable,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => isEnable.value = !isEnable.value,
      child: ListenableBuilder(
        listenable: isEnable,
        builder: (context, child) => Container(
          decoration: BoxDecoration(
              color:
                  isEnable.value ? context.colors.black : context.colors.gray,
              borderRadius: BorderRadius.circular(8.sp)),
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 32.sp),
          child: title
              .medium(
                  fontColor: isEnable.value
                      ? context.colors.white
                      : context.colors.black)
              .body,
        ),
      ),
    );
  }
}
