import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/services/notifications/daily_notification_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(() {
    tzdata.initializeTimeZones();
  });

  group('DailyNotificationService', () {
    test('computes the next occurrence for a time later today', () {
      final now = tz.TZDateTime.parse(tz.local, '2026-01-01 09:00:00');
      final next = DailyNotificationService.nextDailyOccurrence(
        now: now,
        hour: 12,
        minute: 30,
      );

      expect(next.year, 2026);
      expect(next.month, 1);
      expect(next.day, 1);
      expect(next.hour, 12);
      expect(next.minute, 30);
    });

    test('rolls the occurrence to the next day when the time has passed', () {
      final now = tz.TZDateTime.parse(tz.local, '2026-01-01 23:30:00');
      final next = DailyNotificationService.nextDailyOccurrence(
        now: now,
        hour: 9,
        minute: 0,
      );

      expect(next.year, 2026);
      expect(next.month, 1);
      expect(next.day, 2);
      expect(next.hour, 9);
      expect(next.minute, 0);
    });
  });
}
