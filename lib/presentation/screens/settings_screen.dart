import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:ninety/presentation/bloc/theme_cubit.dart';
import 'package:ninety/presentation/widgets/arrow_back_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        elevation: 0,
        leading: const ArrowBackWidget(),
        title: Text(
          l10n.settingsTitle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: context.colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.theme,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade500,
                  letterSpacing: 1.4,
                ),
              ),
              SizedBox(height: 10.sp),
              const _ThemeModePicker(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeModePicker extends StatelessWidget {
  const _ThemeModePicker();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, current) {
        return Wrap(
          spacing: 10.sp,
          runSpacing: 10.sp,
          children: [
            _ModeChip(
              label: l10n.light,
              selected: current == ThemeMode.light,
              onTap: () =>
                  context.read<ThemeCubit>().setThemeMode(ThemeMode.light),
            ),
            _ModeChip(
              label: l10n.dark,
              selected: current == ThemeMode.dark,
              onTap: () =>
                  context.read<ThemeCubit>().setThemeMode(ThemeMode.dark),
            ),
            _ModeChip(
              label: l10n.system,
              selected: current == ThemeMode.system,
              onTap: () =>
                  context.read<ThemeCubit>().setThemeMode(ThemeMode.system),
            ),
          ],
        );
      },
    );
  }
}

class _ModeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.sp),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? context.colors.black : context.colors.gray,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 32.sp),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: selected ? context.colors.white : context.colors.black,
          ),
        ),
      ),
    );
  }
}
