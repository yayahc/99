import 'package:ninety/features/name/data/models/i_name_model.dart';

class LocalNames {
  static List<ITranslationModel> getList(String lang) {
    switch (lang) {
      case 'fr':
        return frenchNames;
      case 'en':
        return englishNames;
      default:
        return arabeNames;
    }
  }

  static List<ITranslationModel> arabeNames = [
    GenericTranslationModel(
        benefite: "الله",
        details: "اللهالله",
        id: 0,
        reference: "الله",
        transliteration: "الله"),
    GenericTranslationModel(
        benefite: "ٱلْرَّحْمَـٰنُ",
        details: "ٱلْرَّحْمَـٰنُٱلْرَّحْمَـٰنُ",
        id: 1,
        reference: "ٱلْرَّحْمَـٰنُ",
        transliteration:
            "ٱلْرَّحْمَـٰنُٱلْرَّحْمَـٰنُٱلْرَّحْمَـٰنُٱلْرَّحْمَـٰنُ")
  ];
  static List<ITranslationModel> frenchNames = [
    GenericTranslationModel(
        benefite: "Allah",
        details: "Allah Dieu",
        id: 0,
        reference: "s1:02",
        transliteration: "Allah (\"Le Dieu\" littéralement)"),
    GenericTranslationModel(
        benefite: "Ar-Rahmān",
        details: "Le Tout-Miséricordieux",
        id: 0,
        reference: "s1:03",
        transliteration: "Clément envers ses créatures.")
  ];
  static List<ITranslationModel> englishNames = [
    GenericTranslationModel(
        benefite: "Allah",
        details: "Allah God",
        id: 0,
        reference: "s1:02",
        transliteration: "Allah Litteraly"),
    GenericTranslationModel(
        benefite: "Ar-Rahmān",
        details: "The most",
        id: 0,
        reference: "s1:03",
        transliteration: "Grateful")
  ];
}
