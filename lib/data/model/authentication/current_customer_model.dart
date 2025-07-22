class CurrentCustomerModel {
  CurrentCustomerModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.roles,
    required this.primaryContact,
    required this.creationTime,
    required this.token,
    required this.version,
    required this.skillrat,
    required this.yardly,
    required this.eato,
    required this.sancharalakshmi,
    required this.deliveryPartner,
    required this.media,
    required this.userVerificationStatus,
    required this.registered,
  });

  final int? id;
  final String? fullName;
  final String? email;
  final List<Role> roles;
  final String? primaryContact;
  final DateTime? creationTime;
  final String? token;
  final int? version;
  final bool? skillrat;
  final bool? yardly;
  final bool? eato;
  final bool? sancharalakshmi;
  final bool? deliveryPartner;
  final List<dynamic> media;
  final String? userVerificationStatus;
  final bool? registered;

  factory CurrentCustomerModel.fromJson(Map<String, dynamic> json) {
    return CurrentCustomerModel(
      id: json["id"],
      fullName: json["fullName"],
      email: json["email"],
      roles: json["roles"] == null
          ? []
          : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      primaryContact: json["primaryContact"],
      creationTime: DateTime.tryParse(json["creationTime"] ?? ""),
      token: json["token"],
      version: json["version"],
      skillrat: json["skillrat"],
      yardly: json["yardly"],
      eato: json["eato"],
      sancharalakshmi: json["sancharalakshmi"],
      deliveryPartner: json["deliveryPartner"],
      media: json["media"] == null
          ? []
          : List<dynamic>.from(json["media"]!.map((x) => x)),
      userVerificationStatus: json["userVerificationStatus"],
      registered: json["registered"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email": email,
        "roles": roles.map((x) => x.toJson()).toList(),
        "primaryContact": primaryContact,
        "creationTime": creationTime?.toIso8601String(),
        "token": token,
        "version": version,
        "skillrat": skillrat,
        "yardly": yardly,
        "eato": eato,
        "sancharalakshmi": sancharalakshmi,
        "deliveryPartner": deliveryPartner,
        "media": media.map((x) => x).toList(),
        "userVerificationStatus": userVerificationStatus,
        "registered": registered,
      };
}

class Role {
  Role({
    required this.name,
    required this.id,
  });

  final String? name;
  final int? id;

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json["name"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
