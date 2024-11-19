class Wird {
  final String wird;
  final String english;
  final String transliteration;
  final int count;
  int? counted;
  bool? completed;

  Wird(
      {required this.wird,
      required this.english,
      required this.transliteration,
      required this.count,
      this.counted,
      this.completed});
}
