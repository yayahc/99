import '../../domain/entities/doua/doua.dart';

abstract class ITranslationModel {
  int get id;
  String get arabe;
  String get translation;
  String get transliteration;
  String get details;
  String get description;
  List<String> get reference;
  String get audioPath;
  String get imagePath;
  List<Doua> get sampleDoua;
}

class GenericTranslationModel implements ITranslationModel {
  GenericTranslationModel(
      {required String description,
      required String details,
      required int id,
      required String arabe,
      required List<Doua> sampleDoua,
      required String translation,
      required String imagePath,
      required String audioPath,
      required List<String> reference,
      required String transliteration})
      : _description = description,
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
  final String _description;
  final String _details;
  final List<String> _reference;
  final String _transliteration;

  @override
  String get description => _description;

  @override
  String get details => _details;

  @override
  int get id => _id;

  @override
  List<String> get reference => _reference;

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
