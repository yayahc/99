class Name {
  final int id;
  final String audioPath;
  final String imagePath;
  final String transliteration;
  final String translation;
  final String reference;
  final String benefite;
  final List<String> sampleDoua;

  Name(
      {required this.id,
      required this.audioPath,
      required this.transliteration,
      required this.translation,
      required this.reference,
      required this.benefite,
      required this.sampleDoua,
      required this.imagePath});
}
