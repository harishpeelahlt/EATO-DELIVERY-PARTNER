class SignUpModel {
  String? creationTime;
  String? otp;

  SignUpModel({this.creationTime, this.otp});

  SignUpModel.fromJson(Map<String, dynamic> json) {
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
