import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/string_extension.dart';

import '../widgets/setting_button.dart';

class DrawlerMenu extends StatelessWidget {
  const DrawlerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
        child: Column(
          children: [
            context.gaps.extra,
            context.gaps.extra,
            _buildThemeSetting(context),
            context.gaps.large,
            _buildNotificationSetting(context)
          ],
        ),
      ),
    );
  }

  Column _buildNotificationSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        context.gaps.small,
        _buildTtitle(context, 'Notification'),
        context.gaps.small,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SettingButton(
              title: "Enable",
              isEnable: ValueNotifier(false),
            ),
            context.gaps.small,
            SettingButton(
              title: "Disable",
              isEnable: ValueNotifier(true),
            ),
          ],
        )
      ],
    );
  }

  Column _buildThemeSetting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        context.gaps.small,
        _buildTtitle(context, 'Thème'),
        context.gaps.small,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SettingButton(
              title: "Light",
              isEnable: ValueNotifier(true),
            ),
            context.gaps.small,
            SettingButton(
              title: "Dark",
              isEnable: ValueNotifier(false),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTtitle(BuildContext context, String title) {
    return title.medium(fontColor: context.colors.black).body;
  }
}
