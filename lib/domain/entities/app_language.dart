import 'package:flutter/widgets.dart';

enum AppLanguage {
  system('system'),
  english('en'),
  french('fr'),
  arabic('ar');

  final String code;
  const AppLanguage(this.code);

  static AppLanguage fromCode(String code) => AppLanguage.values.firstWhere(
        (language) => language.code == code,
        orElse: () => AppLanguage.system,
      );

  Locale? get locale => this == AppLanguage.system ? null : Locale(code);
}
