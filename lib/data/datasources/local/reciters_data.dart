import 'package:ninety/domain/entities/reciter.dart';

class RecitersData {
  static const List<Reciter> all = [
    Reciter(
      slug: 'abdurrahmaan_as-sudays',
      nameArabic: 'عبد الرحمن السديس',
      nameLatin: 'Abdurrahmaan As-Sudays',
    ),
    Reciter(
      slug: 'huthayfi',
      nameArabic: 'علي بن عبد الرحمن الحذيفي',
      nameLatin: 'Ali Al-Huthayfi',
    ),
  ];

  static String audioUrl(Reciter reciter, int surahNumber) {
    final padded = surahNumber.toString().padLeft(3, '0');
    return 'https://download.quranicaudio.com/quran/${reciter.slug}/$padded.mp3';
  }
}
