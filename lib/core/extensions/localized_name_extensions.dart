import 'package:flutter/widgets.dart';
import 'package:ninety/data/datasources/local/i18n/names_i18n.dart';
import 'package:ninety/domain/entities/name.dart';

extension LocalizedName on Name {
  String translationIn(String languageCode) =>
      NamesI18n.lookup(languageCode, id)?.translation ?? translation;

  String detailsIn(String languageCode) =>
      NamesI18n.lookup(languageCode, id)?.details ?? details;

  String translationOf(BuildContext context) =>
      translationIn(context.languageCode);

  String detailsOf(BuildContext context) => detailsIn(context.languageCode);
}

extension LocalizedNameContext on BuildContext {
  String get languageCode => Localizations.localeOf(this).languageCode;
}
