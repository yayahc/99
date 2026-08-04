import 'package:ninety/data/datasources/local/i18n/localized_name_text.dart';
import 'package:ninety/data/datasources/local/i18n/names_ar.dart';
import 'package:ninety/data/datasources/local/i18n/names_fr.dart';

/// Translations of the meaning and explanation of each name.
///
/// English lives in `NamesDatas` itself and is the fallback, so a language
/// without a table here simply keeps the English text.
class NamesI18n {
  const NamesI18n._();

  static const Map<String, Map<int, LocalizedNameText>> byLanguage = {
    'ar': namesAr,
    'fr': namesFr,
  };

  static LocalizedNameText? lookup(String languageCode, int id) =>
      byLanguage[languageCode]?[id];
}
