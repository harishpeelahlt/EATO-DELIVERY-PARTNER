class RolePostModel {
  String? role;
  String? message;

  RolePostModel({this.role, this.message});

  RolePostModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['message'] = message;
    return data;
  }
}
