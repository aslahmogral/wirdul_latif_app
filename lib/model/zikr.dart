class Zikr {
  final String zikr;
  final String english;
  final int count;
  int? counted;
  bool? completed;
  bool? isFavorite;

  Zikr(
      {required this.zikr,
      required this.english,
      required this.count,
      this.counted,
      this.completed,
      this.isFavorite});
}
