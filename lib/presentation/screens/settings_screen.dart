import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/core/extensions/localized_name_extensions.dart';
import 'package:ninety/domain/entities/app_language.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:ninety/presentation/bloc/language_cubit.dart';
import 'package:ninety/presentation/bloc/quran_auto_play_cubit.dart';
import 'package:ninety/presentation/bloc/theme_cubit.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
          const _QuranAutoPlayCard(),
          SizedBox(height: 24.sp),
          _SectionLabel(text: l10n.theme),
          SizedBox(height: 10.sp),
          const _ThemeModeSelector(),
          SizedBox(height: 24.sp),
          _SectionLabel(text: l10n.language),
          SizedBox(height: 10.sp),
          const _LanguageSelector(),
          SizedBox(height: 24.sp),
          _SectionLabel(text: l10n.quranSection),
          SizedBox(height: 28.sp),
          const _AppVersionLabel(),
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
        letterSpacing: context.languageCode == 'ar' ? 0 : 1.4,
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
        return _SettingsCard(
          child: Column(
            children: [
              _SelectableOption(
                icon: Icons.light_mode_rounded,
                label: l10n.light,
                selected: mode == ThemeMode.light,
                onTap: () =>
                    context.read<ThemeCubit>().setThemeMode(ThemeMode.light),
              ),
              _SelectableOption(
                icon: Icons.dark_mode_rounded,
                label: l10n.dark,
                selected: mode == ThemeMode.dark,
                onTap: () =>
                    context.read<ThemeCubit>().setThemeMode(ThemeMode.dark),
              ),
              _SelectableOption(
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

class _QuranAutoPlayCard extends StatelessWidget {
  const _QuranAutoPlayCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<QuranAutoPlayCubit, QuranAutoPlay>(
      builder: (context, autoPlay) {
        final cubit = context.read<QuranAutoPlayCubit>();
        return _SettingsCard(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.sp, vertical: 8.sp),
                child: Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline_rounded,
                      size: 22.sp,
                      color: autoPlay.enabled
                          ? context.colors.emerald
                          : context.colors.black,
                    ),
                    SizedBox(width: 14.sp),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.autoPlayQuran,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: autoPlay.enabled
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: context.colors.black,
                            ),
                          ),
                          SizedBox(height: 4.sp),
                          Text(
                            l10n.autoPlayQuranSubtitle,
                            style: TextStyle(
                              fontSize: 11.sp,
                              height: 1.35,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.sp),
                    Switch.adaptive(
                      value: autoPlay.enabled,
                      activeColor: context.colors.emerald,
                      onChanged: cubit.setEnabled,
                    ),
                  ],
                ),
              ),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 220),
                sizeCurve: Curves.easeOut,
                firstCurve: Curves.easeOut,
                secondCurve: Curves.easeOut,
                crossFadeState: autoPlay.enabled
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: _VolumeSlider(
                  label: l10n.backgroundVolume,
                  value: autoPlay.volume,
                  onChanged: cubit.previewVolume,
                  onChangeEnd: cubit.commitVolume,
                ),
                secondChild: const SizedBox(width: double.infinity),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _VolumeSlider extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  const _VolumeSlider({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.sp, 4.sp, 14.sp, 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.volume_down_rounded,
                size: 18.sp,
                color: Colors.grey.shade500,
              ),
              SizedBox(width: 8.sp),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colors.emerald,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 3,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            ),
            child: Slider(
              min: 0.05,
              max: 1,
              divisions: 19,
              value: value.clamp(0.05, 1),
              activeColor: context.colors.emerald,
              inactiveColor: Colors.grey.shade300,
              onChanged: onChanged,
              onChangeEnd: onChangeEnd,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final Widget child;
  const _SettingsCard({required this.child});

  @override
  Widget build(BuildContext context) {
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
      child: child,
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<LanguageCubit, AppLanguage>(
      builder: (context, language) {
        final cubit = context.read<LanguageCubit>();
        return _SettingsCard(
          child: Column(
            children: [
              _SelectableOption(
                icon: Icons.public_rounded,
                label: l10n.system,
                selected: language == AppLanguage.system,
                onTap: () => cubit.setLanguage(AppLanguage.system),
              ),
              _SelectableOption(
                badge: 'EN',
                label: l10n.english,
                selected: language == AppLanguage.english,
                onTap: () => cubit.setLanguage(AppLanguage.english),
              ),
              _SelectableOption(
                badge: 'FR',
                label: l10n.french,
                selected: language == AppLanguage.french,
                onTap: () => cubit.setLanguage(AppLanguage.french),
              ),
              _SelectableOption(
                badge: 'ع',
                label: l10n.arabic,
                selected: language == AppLanguage.arabic,
                onTap: () => cubit.setLanguage(AppLanguage.arabic),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AppVersionLabel extends StatefulWidget {
  const _AppVersionLabel();

  @override
  State<_AppVersionLabel> createState() => _AppVersionLabelState();
}

class _AppVersionLabelState extends State<_AppVersionLabel> {
  late final Future<PackageInfo> _packageInfo;

  @override
  void initState() {
    super.initState();
    _packageInfo = PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: _packageInfo,
      builder: (context, snapshot) {
        final info = snapshot.data;
        return SizedBox(
          height: 20.sp,
          child: info == null
              ? null
              : Center(
                  child: Text(
                    'v${info.version} (${info.buildNumber})',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                      color: context.colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _SelectableOption extends StatelessWidget {
  final IconData? icon;
  final String? badge;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableOption({
    this.icon,
    this.badge,
    required this.label,
    required this.selected,
    required this.onTap,
  }) : assert(icon != null || badge != null);

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
            SizedBox(
              width: 22.sp,
              child: icon != null
                  ? Icon(
                      icon,
                      size: 22.sp,
                      color: selected
                          ? context.colors.primary
                          : context.colors.black,
                    )
                  : Text(
                      badge!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: selected
                            ? context.colors.primary
                            : context.colors.black,
                      ),
                    ),
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
