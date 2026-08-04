import 'package:ninety/data/datasources/local/names_datas.dart';
import 'package:ninety/domain/entities/name.dart';

class NameOfDay {
  const NameOfDay._();

  static Name forDate(DateTime date) {
    final names = NamesDatas.names;
    final dayIndex = DateTime(date.year, date.month, date.day)
        .difference(DateTime(date.year))
        .inDays;
    return names[dayIndex % names.length];
  }

  static Name get today => forDate(DateTime.now());
}
