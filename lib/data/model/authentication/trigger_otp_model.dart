class TriggerOtpModel {
  String? creationTime;
  String? otp;

  TriggerOtpModel({this.creationTime, this.otp});

  TriggerOtpModel.fromJson(Map<String, dynamic> json) {
    creationTime = json['creationTime'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creationTime'] = creationTime;
    data['otp'] = otp;
    return data;
  }
}
