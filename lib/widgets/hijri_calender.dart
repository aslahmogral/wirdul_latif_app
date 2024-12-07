class HijriCalendar {
  // Private list of Hijri month names
  static const List<String> _hijriMonths = [
    "Muharram",
    "Safar",
    "Rabi' al-Awwal",
    "Rabi' al-Thani",
    "Jumada al-Awwal",
    "Jumada al-Thani",
    "Rajab",
    "Sha'ban",
    "Ramadan",
    "Shawwal",
    "Dhu al-Qi'dah",
    "Dhu al-Hijjah",
  ];

  // Method to get the Hijri month name
  String getMonthName(int monthNumber) {
    if (monthNumber < 1 || monthNumber > 12) {
      throw ArgumentError("Month number must be between 1 and 12.");
    }
    return _hijriMonths[monthNumber - 1];
  }
}
