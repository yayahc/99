import 'package:ninety/features/name/domain/entities/doua/doua.dart';
import 'package:ninety/features/name/domain/entities/name/name.dart';
import 'package:ninety/features/name/domain/entities/reference/reference.dart';

class NameModel extends Name {
  final List<Doua> sampleDouas;
  final List<Reference> references;
  NameModel(
      {required super.id,
      required super.arabe,
      required super.transliteration,
      required super.translationInAr,
      required super.translationInEn,
      required super.translationInFr,
      required super.details,
      required super.description,
      required super.audioPath,
      required super.imagePath,
      required this.references,
      required this.sampleDouas});
}
