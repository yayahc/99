import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/core/extensions/localized_name_extensions.dart';
import 'package:ninety/data/datasources/local/i18n/names_i18n.dart';
import 'package:ninety/data/datasources/local/names_datas.dart';

void main() {
  final names = NamesDatas.names;

  test('the English source itself is complete', () {
    expect(names, hasLength(99));
    for (final n in names) {
      expect(n.arabe.trim(), isNotEmpty, reason: 'arabe of ${n.id}');
      expect(n.transliteration.trim(), isNotEmpty,
          reason: 'transliteration of ${n.id}');
      expect(n.transliteration, n.transliteration.trim(),
          reason: 'transliteration of ${n.id} has stray whitespace');
      expect(n.translation.trim(), isNotEmpty, reason: 'translation of ${n.id}');
      expect(n.details.trim(), isNotEmpty, reason: 'details of ${n.id}');
    }
  });

  test('ids are unique and cover 1..99', () {
    expect(names.map((n) => n.id).toSet(), List.generate(99, (i) => i + 1).toSet());
  });

  for (final lang in NamesI18n.byLanguage.keys) {
    group(lang, () {
      final table = NamesI18n.byLanguage[lang]!;

      test('covers every name with non-empty text', () {
        for (final n in names) {
          final entry = table[n.id];
          expect(entry, isNotNull, reason: '$lang is missing name ${n.id}');
          expect(entry!.translation.trim(), isNotEmpty,
              reason: '$lang translation of ${n.id}');
          expect(entry.details.trim(), isNotEmpty,
              reason: '$lang details of ${n.id}');
        }
      });

      test('has no entries beyond the 99 names', () {
        expect(table.keys.toSet().difference(names.map((n) => n.id).toSet()),
            isEmpty);
      });

      test('translations are distinct, so quiz options are never ambiguous', () {
        final translations = names.map((n) => n.translationIn(lang)).toList();
        final duplicates = translations
            .where((t) => translations.where((o) => o == t).length > 1)
            .toSet();
        expect(duplicates, isEmpty, reason: 'duplicate $lang meanings');
      });

      test('does not fall back to the English text', () {
        for (final n in names) {
          expect(n.translationIn(lang), isNot(n.translation),
              reason: '$lang translation of ${n.id} is untranslated');
        }
      });
    });
  }

  test('an unsupported language falls back to English', () {
    final n = names.first;
    expect(n.translationIn('de'), n.translation);
    expect(n.detailsIn('de'), n.details);
  });
}
