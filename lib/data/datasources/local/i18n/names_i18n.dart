import 'package:ninety/data/datasources/local/i18n/localized_name_text.dart';
import 'package:ninety/data/datasources/local/i18n/names_ar.dart';
import 'package:ninety/data/datasources/local/i18n/names_fr.dart';

class NamesI18n {
  const NamesI18n._();

  static const Map<String, Map<int, LocalizedNameText>> byLanguage = {
    'ar': namesAr,
    'fr': namesFr,
  };

  static LocalizedNameText? lookup(String languageCode, int id) =>
      byLanguage[languageCode]?[id];
}
