import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/core/helpers/name_of_day.dart';
import 'package:ninety/l10n/app_localizations.dart';
import 'package:ninety/services/notifications/daily_notification_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(() {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Paris'));
  });

  group('upcomingSlots', () {
    test('includes today when the time has not passed yet', () {
      final now = tz.TZDateTime(tz.local, 2026, 1, 1, 6, 0);
      final slots = DailyNotificationService.upcomingSlots(
          now: now, hour: 9, minute: 0, days: 3);

      expect(slots, hasLength(3));
      expect(slots.first.hour, 9);
      expect(slots.map((s) => s.day), [1, 2, 3]);
    });

    test('skips today when the time has already passed', () {
      final now = tz.TZDateTime(tz.local, 2026, 1, 1, 23, 30);
      final slots = DailyNotificationService.upcomingSlots(
          now: now, hour: 9, minute: 0, days: 3);

      expect(slots.map((s) => s.day), [2, 3, 4]);
      expect(slots.every((s) => s.isAfter(now)), isTrue);
    });

    test('crosses a month boundary', () {
      final now = tz.TZDateTime(tz.local, 2026, 1, 30, 23, 0);
      final slots = DailyNotificationService.upcomingSlots(
          now: now, hour: 21, minute: 0, days: 3);

      expect(slots.map((s) => '${s.month}-${s.day}'), ['1-31', '2-1', '2-2']);
    });

    test('keeps the wall-clock hour across a DST transition', () {
      // Europe/Paris springs forward on 2026-03-29.
      final now = tz.TZDateTime(tz.local, 2026, 3, 27, 6, 0);
      final slots = DailyNotificationService.upcomingSlots(
          now: now, hour: 9, minute: 0, days: 5);

      expect(slots.map((s) => s.day), [27, 28, 29, 30, 31]);
      expect(slots.every((s) => s.hour == 9), isTrue);
    });
  });

  group('name of the day', () {
    test('is stable for a given date and advances daily', () {
      final first = NameOfDay.forDate(DateTime(2026, 1, 1));
      final again = NameOfDay.forDate(DateTime(2026, 1, 1, 23, 59));
      final next = NameOfDay.forDate(DateTime(2026, 1, 2));

      expect(again.id, first.id);
      expect(next.id, isNot(first.id));
    });

    test('wraps around after the full cycle of names', () {
      final start = NameOfDay.forDate(DateTime(2026, 1, 1));
      final wrapped =
          NameOfDay.forDate(DateTime(2026, 1, 1).add(const Duration(days: 99)));

      expect(wrapped.id, start.id);
    });
  });

  group('eveningBodyFor', () {
    late AppLocalizations l10n;

    setUpAll(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    test('rotates so consecutive nights differ', () {
      final bodies = List.generate(
        7,
        (i) => DailyNotificationService.eveningBodyFor(
            l10n, DateTime(2026, 1, 1).add(Duration(days: i))),
      );

      expect(bodies.toSet(), hasLength(7));
    });

    test('repeats after the full rotation', () {
      final first =
          DailyNotificationService.eveningBodyFor(l10n, DateTime(2026, 1, 1));
      final after =
          DailyNotificationService.eveningBodyFor(l10n, DateTime(2026, 1, 8));

      expect(after, first);
    });
  });
}
