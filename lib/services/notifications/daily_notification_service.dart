import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class DailyNotificationService {
  DailyNotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tzdata.initializeTimeZones();

    // initializeTimeZones() only loads the database; without this tz.local
    // stays UTC and every reminder is scheduled at the wrong wall-clock hour.
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

    await _plugin.initialize(settings);
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

  static Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
    String title = 'Reminder',
    String body = 'Take a moment and open the app today.',
  }) async {
    await _plugin.cancel(_dailyReminderId);

    final scheduled = nextDailyOccurrence(
        now: tz.TZDateTime.now(tz.local), hour: hour, minute: minute);

    await _plugin.zonedSchedule(
      _dailyReminderId,
      title,
      body,
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: await _androidScheduleMode(),
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// On Android 12+ exact alarms need a permission that is denied by default
  /// on Android 14+. Asking for it anyway and then scheduling exactly would
  /// throw `exact_alarms_not_permitted`, so fall back to an inexact alarm —
  /// a daily reminder does not need minute precision.
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

  static tz.TZDateTime nextDailyOccurrence({
    required tz.TZDateTime now,
    required int hour,
    required int minute,
  }) {
    final scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      return scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// Fires a notification a few seconds from now. Useful to verify the whole
  /// pipeline (channel, icon, permissions) without waiting for the real slot.
  static Future<void> debugFireTestNotification() async {
    await _plugin.zonedSchedule(
      _debugId,
      'Test',
      'If you can read this, local notifications work.',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: await _androidScheduleMode(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<List<PendingNotificationRequest>> pendingNotifications() =>
      _plugin.pendingNotificationRequests();

  static const int _dailyReminderId = 1;
  static const int _debugId = 999;
}
