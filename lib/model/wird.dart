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

  factory Wird.fromJson(Map<String, dynamic> json) => Wird(
        wird: json['wird'],
        english: json['english'],
        transliteration: json['transliteration'],
        count: json['count'],
        counted: json['counted'],
        completed: json['completed'],
      );

  Map<String, dynamic> toJson() => {
        'wird': wird,
        'english': english,
        'transliteration': transliteration,
        'count': count,
        'counted': counted,
        'completed': completed,
      };
}

