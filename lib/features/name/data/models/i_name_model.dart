abstract class ITranslationModel {
  int get id;
  String get transliteration;
  String get details;
  String get benefite;
  String get reference;
}

class GenericTranslationModel implements ITranslationModel {
  GenericTranslationModel(
      {required String benefite,
      required String details,
      required int id,
      required String reference,
      required String transliteration})
      : _benefite = benefite,
        _details = details,
        _id = id,
        _reference = reference,
        _transliteration = transliteration;

  final String _benefite;
  final String _details;
  final int _id;
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
}
