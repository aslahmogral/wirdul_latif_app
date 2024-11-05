class WirdHistroyItem {
  final int? id;
  final String? createdDate;
  final int? currentWird;
  final String? status;
  final String? wirdType;

  WirdHistroyItem( {this.createdDate, this.currentWird, this.id, this.status,this.wirdType,});

  // Convert a User object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdDate': createdDate,
      'currentWird': currentWird,
      'status': status,
      'wirdType': wirdType
    };
  }

  // Create a User from a Map object
  factory WirdHistroyItem.fromMap(Map<String, dynamic> map) {
    return WirdHistroyItem(
      id: map['id'],
      createdDate: map['createdDate'],
      currentWird: map['currentWird'],
      status: map['status'],
      wirdType : map['wirdType'],
    );
  }
}
