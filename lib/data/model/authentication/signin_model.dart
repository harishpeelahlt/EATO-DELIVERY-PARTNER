class SignInModel {
  String? token;
  String? refreshToken;
  String? type;
  int? id;
  List<String>? roles;
  String? primaryContact;

  SignInModel(
      {this.token,
      this.refreshToken,
      this.type,
      this.id,
      this.roles,
      this.primaryContact});

  SignInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    type = json['type'];
    id = json['id'];
    roles = json['roles'].cast<String>();
    primaryContact = json['primaryContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['type'] = type;
    data['id'] = id;
    data['roles'] = roles;
    data['primaryContact'] = primaryContact;
    return data;
  }
}
