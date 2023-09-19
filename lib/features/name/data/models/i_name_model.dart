import '../../domain/entities/doua/doua.dart';

abstract class ITranslationModel {
  int get id;
  String get arabe;
  String get translation;
  String get transliteration;
  String get details;
  String get benefite;
  String get reference;
  String get audioPath;
  String get imagePath;
  List<Doua> get sampleDoua;
}

class GenericTranslationModel implements ITranslationModel {
  GenericTranslationModel(
      {required String benefite,
      required String details,
      required int id,
      required String arabe,
      required List<Doua> sampleDoua,
      required String translation,
      required String imagePath,
      required String audioPath,
      required String reference,
      required String transliteration})
      : _benefite = benefite,
        _details = details,
        _id = id,
        _arabe = arabe,
        _audioPath = audioPath,
        _imagePath = imagePath,
        _translation = translation,
        _sampleDoua = sampleDoua,
        _reference = reference,
        _transliteration = transliteration;

  final int _id;
  final String _arabe;
  final String _audioPath;
  final String _imagePath;
  final String _translation;
  final List<Doua> _sampleDoua;
  final String _benefite;
  final String _details;
  final String _reference;
  final String _transliteration;

  @override
  String get benefite => _benefite;

  @override
  String get details => _details;

  @override
  int get id => _id;

  @override
  String get reference => _reference;

  @override
  String get transliteration => _transliteration;

  @override
  String get arabe => _arabe;

  @override
  String get audioPath => _audioPath;

  @override
  String get imagePath => _imagePath;

  @override
  List<Doua> get sampleDoua => _sampleDoua;

  @override
  String get translation => _translation;
}
