import 'package:ninety/core/models/name.dart';

class NamesProvider {
  static List<Name> names = [
    Name(
      id: 1,
      audioPath: 'audio_path_1',
      transliteration: 'Ar-Rahman',
      translation: 'Le Tout-Miséricordieux',
      reference: 'Sourate Al-Fatiha (1:1)',
      benefite:
          'Celui qui récite ce nom 100 fois après la prière du matin et du soir, recevra des bénédictions spéciales.',
      sampleDoua: ['Doua associé au nom Ar-Rahman'],
      imagePath: 'image_path_1',
    ),
    Name(
      id: 2,
      audioPath: 'audio_path_2',
      transliteration: 'Ar-Rahim',
      translation: 'Le Très-Miséricordieux',
      reference: 'Sourate Al-Fatiha (1:2)',
      benefite:
          "Celui qui récite ce nom régulièrement, Allah lui accordera sa miséricorde dans ce monde et dans l'au-delà.",
      sampleDoua: ['Doua associé au nom Ar-Rahim'],
      imagePath: 'image_path_2',
    ),
    Name(
      id: 3,
      audioPath: 'audio_path_3',
      transliteration: 'Al-Malik',
      translation: 'Le Souverain',
      reference: 'Sourate Al-Hashr (59:23)',
      benefite:
          'Celui qui récite ce nom 100 fois après la prière du fajr, recevra la richesse et la prospérité.',
      sampleDoua: ['Doua associé au nom Al-Malik'],
      imagePath: 'image_path_3',
    ),
  ];
}
