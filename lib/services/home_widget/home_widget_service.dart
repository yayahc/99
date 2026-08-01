import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';
import 'package:ninety/data/datasources/local/names_datas.dart';
import 'package:ninety/di.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/router.dart';
import 'package:ninety/services/audio/background_audio_handler.dart';

class HomeWidgetService {
  HomeWidgetService._();
  static final HomeWidgetService instance = HomeWidgetService._();

  static const _nameProvider = 'NameOfDayWidgetProvider';
  static const _nowPlayingProvider = 'NowPlayingWidgetProvider';
  static const _pkg = 'dev.ninety.app';

  StreamSubscription<MediaItem?>? _mediaSub;

  BackgroundAudioHandler get _handler => locator<BackgroundAudioHandler>();

  Future<void> init() async {
    try {
      await refreshNameOfDay();
      await _refreshNowPlaying(_handler.mediaItem.valueOrNull);

      _mediaSub ??= _handler.mediaItem.listen(_refreshNowPlaying);
      HomeWidget.widgetClicked.listen(_handleUri);

      final launchUri = await HomeWidget.initiallyLaunchedFromHomeWidget();
      _handleUri(launchUri);
    } catch (error) {
      debugPrint('HomeWidgetService init failed: $error');
    }
  }

  Future<void> refreshNameOfDay() async {
    final names = NamesDatas.names;
    if (names.isEmpty) return;

    final now = DateTime.now();
    final dayIndex = now.difference(DateTime(now.year)).inDays;
    final Name name = names[dayIndex % names.length];

    await HomeWidget.saveWidgetData<String>('name_arabe', name.arabe);
    await HomeWidget.saveWidgetData<String>(
        'name_transliteration', name.transliteration);
    await HomeWidget.saveWidgetData<String>(
        'name_translation', name.translation);
    await HomeWidget.saveWidgetData<int>('name_id', name.id);
    await _update(_nameProvider);
  }

  Future<void> _refreshNowPlaying(MediaItem? item) async {
    await HomeWidget.saveWidgetData<bool>('np_active', item != null);
    await HomeWidget.saveWidgetData<String>('np_title', item?.title ?? '');
    await _update(_nowPlayingProvider);
  }

  Future<void> _update(String provider) async {
    try {
      await HomeWidget.updateWidget(
        name: provider,
        androidName: provider,
        qualifiedAndroidName: '$_pkg.$provider',
      );
    } catch (error) {
      debugPrint('HomeWidget update failed for $provider: $error');
    }
  }

  void _handleUri(Uri? uri) {
    if (uri == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (uri.host) {
        case 'name':
          final id = int.tryParse(uri.queryParameters['id'] ?? '');
          final names = NamesDatas.names;
          final name = names.firstWhere(
            (n) => n.id == id,
            orElse: () => names.first,
          );
          AppRouter.router.push('/name', extra: name);
          break;
        case 'quran':
          AppRouter.router.push('/quran');
          break;
      }
    });
  }
}
