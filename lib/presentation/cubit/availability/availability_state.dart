class AvailabilityModel {
  AvailabilityModel({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final String? status;
  final Data? data;

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
      message: json["message"],
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.vehicleNumber,
    required this.status,
    required this.active,
    required this.available,
    required this.lastAssignedTime,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? vehicleNumber;
  final String? status;
  final bool? active;
  final bool? available;
  final dynamic lastAssignedTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      userId: json["userId"],
      vehicleNumber: json["vehicleNumber"],
      status: json["status"],
      active: json["active"],
      available: json["available"],
      lastAssignedTime: json["lastAssignedTime"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "vehicleNumber": vehicleNumber,
        "status": status,
        "active": active,
        "available": available,
        "lastAssignedTime": lastAssignedTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
