import 'package:ninety/features/name/domain/entities/doua/doua.dart';
import 'package:ninety/features/name/domain/entities/name/name.dart';

class NameModel extends Name {
  final List<Doua> sampleDouas;
  NameModel(
      {required super.id,
      required super.arabe,
      required super.transliteration,
      required super.translationInAr,
      required super.translationInEn,
      required super.translationInFr,
      required super.details,
      required super.benefite,
      required super.reference,
      required super.audioPath,
      required super.imagePath,
      required this.sampleDouas});
}
