import 'package:ninety/features/name/data/models/i_name_model.dart';

import 'arabe/arabe_name.dart';
import 'english/english_name.dart';
import 'french/french_name.dart';

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

  static List<ITranslationModel> arabeNames = ArabeNames.names;
  static List<ITranslationModel> frenchNames = FrenchNames.names;
  static List<ITranslationModel> englishNames = EnglishNames.names;
}
