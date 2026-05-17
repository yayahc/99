import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/l10n/app_localizations.dart';

import '../widgets/setting_button.dart';

class DrawlerMenu extends StatelessWidget {
  const DrawlerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Drawer(
      backgroundColor: context.colors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 8.sp),
                children: [
                  _buildSection(
                    context,
                    label: l10n.theme,
                    child: _ThemeToggle(),
                  ),
                  SizedBox(height: 24.sp),
                  _buildSection(
                    context,
                    label: l10n.notifications,
                    child: _NotificationToggle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 8.sp, 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.appTitle,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: context.colors.black,
                ),
              ),
              SizedBox(height: 2.sp),
              Text(
                l10n.appSubtitle,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: context.colors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.close, color: context.colors.black, size: 22.sp),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade500,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: 10.sp),
        child,
      ],
    );
  }
}

class _ThemeToggle extends StatefulWidget {
  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  final _light = ValueNotifier(true);
  final _dark = ValueNotifier(false);

  @override
  void dispose() {
    _light.dispose();
    _dark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        SettingButton(
          title: l10n.light,
          isEnable: _light,
        ),
        SizedBox(width: 10.sp),
        SettingButton(
          title: l10n.dark,
          isEnable: _dark,
        ),
      ],
    );
  }
}

class _NotificationToggle extends StatefulWidget {
  @override
  State<_NotificationToggle> createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<_NotificationToggle> {
  final _enable = ValueNotifier(false);
  final _disable = ValueNotifier(true);

  @override
  void dispose() {
    _enable.dispose();
    _disable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        SettingButton(
          title: l10n.enable,
          isEnable: _enable,
        ),
        SizedBox(width: 10.sp),
        SettingButton(
          title: l10n.disable,
          isEnable: _disable,
        ),
      ],
    );
  }
}
