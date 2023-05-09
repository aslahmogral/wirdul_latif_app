class WirdModel {
  final int id;
  final String arabic;
  final int rep;

  WirdModel({required this.id, required this.arabic, required this.rep});

  factory WirdModel.fromJson(Map<String, dynamic> json) {
    return WirdModel(
      id: json['id'],
      arabic: json['arabic'],
      rep: json['repetition'],
    );
  }
}
