class PartnerDetailsModel {
  PartnerDetailsModel({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final String? status;
  final Data? data;

  factory PartnerDetailsModel.fromJson(Map<String, dynamic> json) {
    return PartnerDetailsModel(
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
    required this.deliveryPartnerId,
    required this.vehicleNumber,
    required this.active,
    required this.available,
    required this.lastAssignedTime,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? deliveryPartnerId;
  final String? vehicleNumber;
  final bool? active;
  final bool? available;
  final dynamic lastAssignedTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      userId: json["userId"],
      deliveryPartnerId: json["deliveryPartnerId"],
      vehicleNumber: json["vehicleNumber"],
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
        "deliveryPartnerId": deliveryPartnerId,
        "vehicleNumber": vehicleNumber,
        "active": active,
        "available": available,
        "lastAssignedTime": lastAssignedTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
