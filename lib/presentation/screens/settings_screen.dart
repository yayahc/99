import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ninety/core/extensions/context_extension.dart';
import 'package:ninety/domain/entities/app_language.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:ninety/presentation/bloc/language_cubit.dart';
import 'package:ninety/presentation/bloc/quran_auto_play_cubit.dart';
import 'package:ninety/presentation/bloc/theme_cubit.dart';
import 'package:ninety/presentation/widgets/glass_app_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: GlassAppBar(title: l10n.settingsTitle, showBack: true),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.sp, 8.sp, 16.sp, 24.sp),
        children: [
          const _QuranAutoPlayCard(),
          SizedBox(height: 16.sp),
          const _PreferencesCard(),
          SizedBox(height: 28.sp),
          const _AppVersionLabel(),
        ],
      ),
    );
  }
}

class _PreferencesCard extends StatelessWidget {
  const _PreferencesCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _SettingsCard(
      child: Column(
        children: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) => _ValueRow(
              icon: _themeIcon(mode),
              label: l10n.theme,
              value: _themeLabel(l10n, mode),
              onTap: () => _pickOption<ThemeMode>(
                context: context,
                title: l10n.theme,
                current: mode,
                options: [
                  for (final m in ThemeMode.values)
                    _Option(m, _themeLabel(l10n, m), _themeIcon(m)),
                ],
                onPicked: context.read<ThemeCubit>().setThemeMode,
              ),
            ),
          ),
          const _RowDivider(),
          BlocBuilder<LanguageCubit, AppLanguage>(
            builder: (context, language) => _ValueRow(
              icon: Icons.translate_rounded,
              label: l10n.language,
              value: _languageLabel(l10n, language),
              onTap: () => _pickOption<AppLanguage>(
                context: context,
                title: l10n.language,
                current: language,
                options: [
                  for (final lang in AppLanguage.values)
                    _Option(lang, _languageLabel(l10n, lang), null),
                ],
                onPicked: context.read<LanguageCubit>().setLanguage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _themeIcon(ThemeMode mode) => switch (mode) {
        ThemeMode.light => Icons.light_mode_rounded,
        ThemeMode.dark => Icons.dark_mode_rounded,
        ThemeMode.system => Icons.brightness_auto_rounded,
      };

  String _themeLabel(AppLocalizations l10n, ThemeMode mode) => switch (mode) {
        ThemeMode.light => l10n.light,
        ThemeMode.dark => l10n.dark,
        ThemeMode.system => l10n.system,
      };

  String _languageLabel(AppLocalizations l10n, AppLanguage language) =>
      switch (language) {
        AppLanguage.system => l10n.system,
        AppLanguage.english => l10n.english,
        AppLanguage.french => l10n.french,
        AppLanguage.arabic => l10n.arabic,
      };
}

class _Option<T> {
  final T value;
  final String label;
  final IconData? icon;
  const _Option(this.value, this.label, this.icon);
}

Future<void> _pickOption<T>({
  required BuildContext context,
  required String title,
  required T current,
  required List<_Option<T>> options,
  required ValueChanged<T> onPicked,
}) async {
  final picked = await showModalBottomSheet<T>(
    context: context,
    backgroundColor: context.colors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.sp),
          Container(
            width: 36.sp,
            height: 4.sp,
            decoration: BoxDecoration(
              color: context.colors.black.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.sp),
            ),
          ),
          SizedBox(height: 14.sp),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: context.colors.black,
            ),
          ),
          SizedBox(height: 6.sp),
          for (final option in options)
            _OptionTile(
              option: option,
              selected: option.value == current,
              onTap: () => Navigator.of(sheetContext).pop(option.value),
            ),
          SizedBox(height: 8.sp),
        ],
      ),
    ),
  );
  if (picked != null && picked != current) onPicked(picked);
}

class _OptionTile<T> extends StatelessWidget {
  final _Option<T> option;
  final bool selected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final emerald = context.colors.emerald;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.sp, vertical: 13.sp),
        child: Row(
          children: [
            if (option.icon != null) ...[
              Icon(
                option.icon,
                size: 20.sp,
                color: selected
                    ? emerald
                    : context.colors.black.withValues(alpha: 0.45),
              ),
              SizedBox(width: 12.sp),
            ],
            Expanded(
              child: Text(
                option.label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? emerald : context.colors.black,
                ),
              ),
            ),
            if (selected)
              Icon(Icons.check_rounded, size: 20.sp, color: emerald),
          ],
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 46.sp, end: 10.sp),
      child: Divider(
        height: 1,
        thickness: 1,
        color: context.colors.black.withValues(alpha: 0.06),
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ValueRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 14.sp),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: context.colors.emerald),
            SizedBox(width: 14.sp),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: context.colors.black,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: context.colors.black.withValues(alpha: 0.45),
              ),
            ),
            SizedBox(width: 2.sp),
            Transform.flip(
              flipX: isRtl,
              child: Icon(
                Icons.chevron_right_rounded,
                size: 20.sp,
                color: context.colors.black.withValues(alpha: 0.30),
              ),
            ),
          ],
        ),
      ),
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
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
                child: Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline_rounded,
                      size: 22.sp,
                      color: autoPlay.enabled
                          ? context.colors.emerald
                          : context.colors.black.withValues(alpha: 0.45),
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
                              fontSize: 10.sp,
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
    final emerald = context.colors.emerald;
    return Padding(
      padding: EdgeInsets.fromLTRB(14.sp, 4.sp, 14.sp, 12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.volume_up_rounded,
                size: 18.sp,
                color: emerald,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 3.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Text(
                  '${(value * 100).round()}%',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    color: emerald,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.sp),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6.sp,
              trackShape: const RoundedRectSliderTrackShape(),
              activeTrackColor: emerald,
              inactiveTrackColor: emerald.withValues(alpha: 0.12),
              thumbColor: emerald,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 9.sp,
                elevation: 2,
                pressedElevation: 5,
              ),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 18.sp),
              overlayColor: emerald.withValues(alpha: 0.12),
              tickMarkShape: SliderTickMarkShape.noTickMark,
              showValueIndicator: ShowValueIndicator.never,
              padding: EdgeInsets.zero,
            ),
            child: Slider(
              min: 0.05,
              max: 1,
              value: value.clamp(0.05, 1),
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
        border: Border.all(
          color: context.colors.emerald.withValues(alpha: 0.10),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.emerald.withValues(alpha: 0.06),
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
