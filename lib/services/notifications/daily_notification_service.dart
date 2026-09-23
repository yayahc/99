import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:ninety/core/extensions/localized_name_extensions.dart';
import 'package:ninety/core/helpers/name_of_day.dart';
import 'package:ninety/domain/entities/name.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class DailyNotificationService {
  DailyNotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tzdata.initializeTimeZones();

    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
    } catch (e) {
      debugPrint('DailyNotificationService: falling back to UTC ($e)');
    }

    const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosInit = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _plugin.initialize(settings: settings);
  }

  static Future<void> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }
  }

  static Future<void> scheduleDailyReminders({
    int morningHour = 9,
    int morningMinute = 0,
    int eveningHour = 21,
    int eveningMinute = 0,
    Locale? locale,
  }) async {
    final l10n = await _localizations(locale);
    final lang = _languageCode(locale);
    final scheduleMode = await _androidScheduleMode();
    final now = tz.TZDateTime.now(tz.local);

    await _clearWindow();

    final mornings = upcomingSlots(
      now: now,
      hour: morningHour,
      minute: morningMinute,
      days: _windowDays,
    );

    for (var i = 0; i < mornings.length; i++) {
      final slot = mornings[i];
      final Name name = NameOfDay.forDate(slot);
      await _schedule(
        id: _morningIdBase + i,
        when: slot,
        title: l10n.notifNameOfDayTitle(name.arabe, name.transliteration),
        body: l10n.notifNameOfDayBody(
            name.translationIn(lang), name.detailsIn(lang)),
        channelId: _morningChannelId,
        channelName: 'Name of the day',
        channelDescription: 'The daily name of Allah (SWT)',
        scheduleMode: scheduleMode,
      );
    }

    final evenings = upcomingSlots(
      now: now,
      hour: eveningHour,
      minute: eveningMinute,
      days: _windowDays,
    );

    for (var i = 0; i < evenings.length; i++) {
      final slot = evenings[i];
      await _schedule(
        id: _eveningIdBase + i,
        when: slot,
        title: l10n.notifEveningTitle,
        body: eveningBodyFor(l10n, slot),
        channelId: _eveningChannelId,
        channelName: 'Evening remembrance',
        channelDescription: 'A nightly reminder to end the day with dhikr',
        scheduleMode: scheduleMode,
      );
    }
  }

  @visibleForTesting
  static List<tz.TZDateTime> upcomingSlots({
    required tz.TZDateTime now,
    required int hour,
    required int minute,
    required int days,
  }) {
    final slots = <tz.TZDateTime>[];
    for (var offset = 0; slots.length < days; offset++) {
      final base = DateTime.utc(now.year, now.month, now.day)
          .add(Duration(days: offset));
      final slot = tz.TZDateTime(
          tz.local, base.year, base.month, base.day, hour, minute);
      if (slot.isAfter(now)) slots.add(slot);
    }
    return slots;
  }

  @visibleForTesting
  static String eveningBodyFor(AppLocalizations l10n, DateTime date) {
    final bodies = <String>[
      l10n.notifEveningBody1,
      l10n.notifEveningBody2,
      l10n.notifEveningBody3,
      l10n.notifEveningBody4,
      l10n.notifEveningBody5,
      l10n.notifEveningBody6,
      l10n.notifEveningBody7,
    ];
    final dayIndex = DateTime.utc(date.year, date.month, date.day)
        .difference(DateTime.utc(date.year))
        .inDays;
    return bodies[dayIndex % bodies.length];
  }

  static Future<void> _schedule({
    required int id,
    required tz.TZDateTime when,
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    required String channelDescription,
    required AndroidScheduleMode scheduleMode,
  }) async {
    await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: when,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            channelName,
            channelDescription: channelDescription,
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(
              body,
              contentTitle: title,
            ),
          ),
          iOS: DarwinNotificationDetails(threadIdentifier: channelId),
        ),
        androidScheduleMode: scheduleMode);
  }

  static Future<void> _clearWindow() async {
    await _plugin.cancel(id: _legacyReminderId);
    for (var i = 0; i < _windowDays; i++) {
      await _plugin.cancel(id: _morningIdBase + i);
      await _plugin.cancel(id: _eveningIdBase + i);
    }
  }

  static Future<AppLocalizations> _localizations(Locale? override) async =>
      AppLocalizations.delegate.load(Locale(_languageCode(override)));

  static String _languageCode(Locale? override) {
    final device = override ?? PlatformDispatcher.instance.locale;
    return AppLocalizations.supportedLocales
        .map((l) => l.languageCode)
        .firstWhere((code) => code == device.languageCode, orElse: () => 'en');
  }

  static Future<AndroidScheduleMode> _androidScheduleMode() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return AndroidScheduleMode.exactAllowWhileIdle;
    }

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final canScheduleExact =
        await android?.canScheduleExactNotifications() ?? false;

    return canScheduleExact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }

  static Future<void> debugFireTestNotification({Locale? locale}) async {
    final l10n = await _localizations(locale);
    final lang = _languageCode(locale);
    final name = NameOfDay.today;

    await _schedule(
      id: _debugId,
      when: tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      title: l10n.notifNameOfDayTitle(name.arabe, name.transliteration),
      body: l10n.notifNameOfDayBody(
          name.translationIn(lang), name.detailsIn(lang)),
      channelId: _morningChannelId,
      channelName: 'Name of the day',
      channelDescription: 'The daily name of Allah (SWT)',
      scheduleMode: await _androidScheduleMode(),
    );
  }

  static Future<List<PendingNotificationRequest>> pendingNotifications() =>
      _plugin.pendingNotificationRequests();

  static const int _windowDays = 14;
  static const int _morningIdBase = 100;
  static const int _eveningIdBase = 200;
  static const int _legacyReminderId = 1;
  static const int _debugId = 999;
  static const String _morningChannelId = 'name_of_day_channel';
  static const String _eveningChannelId = 'evening_dhikr_channel';
}
