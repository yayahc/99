import 'package:ninety/core/common/app_assets/app_assets.dart';

import '../../../../models/i_name_model.dart';

class ArabeNames {
  static List<ITranslationModel> names = [
    GenericTranslationModel(
        description:
            "الله هو الرحمان (بالعربية: ٱلْرَّحْمَـانُ). هو الذي يمنح جميع خلقه بالرخاء ويخلصهم من الاختلاف. إنه أكثر الأرحام واللطف والمحبة تجاه كل مخلوق. رحمته شاملة للجميع وتشمل الجميع.",
        details: "الذي يريد الخير والرحمة لجميع مخلوقاته",
        id: 0,
        reference: [],
        transliteration: "Ar-Rahman",
        arabe: 'ٱلْرَّحْمَـانُ',
        audioPath: AudioAssets.arRahman,
        imagePath: '',
        sampleDoua: [],
        translation: 'المحسن'),
    GenericTranslationModel(
        description:
            "اسم الرحيم (بالعربية: ٱلْرَّحِيْمُ) يأتي من نفس جذور الرحمن الذي يشير إلى صفة الله بأنه رحيم. على الرغم من الصلة المماثلة، إلا أن المعاني مختلفة. يمكن تفسير الرحمن كمرجع إلى الله كمصدر لجميع الرحمة، بينما الرحيم يشير إلى دورها المستدام ولا نهاية له. يعتبر البعض اسم الرحيم بأنه رحيم بخلقه يستحقون الرحمة (أساسا الرحمة المخصصة للمؤمنين)",
        details: "الذي يتصرف بكرم شديد",
        id: 1,
        reference: [],
        transliteration: "Ar-Raheem",
        arabe: 'ٱلْرَّحِيمُ',
        audioPath: AudioAssets.arRaheem,
        imagePath: '',
        sampleDoua: [],
        translation: 'الرحيم'),
  ];
}
