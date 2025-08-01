class DeliverTriggerOtpModel {
  DeliverTriggerOtpModel({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final String? status;
  final bool? data;

  factory DeliverTriggerOtpModel.fromJson(Map<String, dynamic> json) {
    return DeliverTriggerOtpModel(
      message: json["message"],
      status: json["status"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data,
      };
}

class DeliverVerifyOtpModel {
  DeliverVerifyOtpModel({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final String? status;
  final bool? data;

  factory DeliverVerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return DeliverVerifyOtpModel(
      message: json["message"],
      status: json["status"],
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data,
      };
}
