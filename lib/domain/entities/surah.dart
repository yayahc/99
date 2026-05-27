class Surah {
  final int number;
  final String nameArabic;
  final String nameLatin;
  final String meaning;

  const Surah({
    required this.number,
    required this.nameArabic,
    required this.nameLatin,
    required this.meaning,
  });

  String get paddedNumber => number.toString().padLeft(3, '0');
}
