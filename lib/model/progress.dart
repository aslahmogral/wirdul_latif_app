class Progress {
  final DateTime time;
  final String type;
  final int count;

  Progress({required this.time, required this.type, required this.count});

  Map<String, dynamic> toJson() => {
        'time': time.toIso8601String(), 
        'type': type,
        'count': count,
      };

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        time: DateTime.parse(json['time']),
        type: json['type'],
        count: json['count'],
      );
}
