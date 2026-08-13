import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:ninety/presentation/bloc/theme_cubit.dart';

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
        centerTitle: true,
        title: Text(
          l10n.settingsTitle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w800,
            color: context.colors.black,
          ),
        ),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: context.colors.black, size: 24.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 24.sp),
        children: [
          _SectionLabel(text: l10n.theme),
          SizedBox(height: 10.sp),
          const _ThemeModeSelector(),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade500,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(8.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(6.sp),
          child: Column(
            children: [
              _ThemeOption(
                icon: Icons.light_mode_rounded,
                label: l10n.light,
                selected: mode == ThemeMode.light,
                onTap: () =>
                    context.read<ThemeCubit>().setThemeMode(ThemeMode.light),
              ),
              _ThemeOption(
                icon: Icons.dark_mode_rounded,
                label: l10n.dark,
                selected: mode == ThemeMode.dark,
                onTap: () =>
                    context.read<ThemeCubit>().setThemeMode(ThemeMode.dark),
              ),
              _ThemeOption(
                icon: Icons.brightness_auto_rounded,
                label: l10n.system,
                selected: mode == ThemeMode.system,
                onTap: () =>
                    context.read<ThemeCubit>().setThemeMode(ThemeMode.system),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 14.sp),
        decoration: BoxDecoration(
          color: selected
              ? context.colors.primary.withValues(alpha: 0.14)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.sp),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: selected ? context.colors.primary : context.colors.black,
            ),
            SizedBox(width: 14.sp),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: context.colors.black,
                ),
              ),
            ),
            AnimatedScale(
              duration: const Duration(milliseconds: 220),
              scale: selected ? 1 : 0,
              child: Icon(
                Icons.check_circle_rounded,
                size: 22.sp,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
