class Initialize {
  static const morningImage = "assets/images/morning.png";
  static const eveningImage = "assets/images/evening.png";
  static const quranQuotes = "asset/quotes1.jpg";

  static Initialize? _instance;

  factory Initialize() {
    _instance ??= Initialize._internal();
    return _instance!;
  }

  Initialize._internal();
}