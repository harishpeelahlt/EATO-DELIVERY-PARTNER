class CurrentCustomerModel {
    CurrentCustomerModel({
        required this.id,
        required this.fullName,
        required this.email,
        required this.roles,
        required this.primaryContact,
        required this.gender,
        required this.creationTime,
        required this.token,
        required this.version,
        required this.skillrat,
        required this.yardly,
        required this.eato,
        required this.sancharalakshmi,
        required this.registered,
    });

    final int? id;
    final String? fullName;
    final String? email;
    final List<Role> roles;
    final String? primaryContact;
    final String? gender;
    final DateTime? creationTime;
    final String? token;
    final int? version;
    final bool? skillrat;
    final bool? yardly;
    final bool? eato;
    final bool? sancharalakshmi;
    final bool? registered;

    factory CurrentCustomerModel.fromJson(Map<String, dynamic> json){ 
        return CurrentCustomerModel(
            id: json["id"],
            fullName: json["fullName"],
            email: json["email"],
            roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
            primaryContact: json["primaryContact"],
            gender: json["gender"],
            creationTime: DateTime.tryParse(json["creationTime"] ?? ""),
            token: json["token"],
            version: json["version"],
            skillrat: json["skillrat"],
            yardly: json["yardly"],
            eato: json["eato"],
            sancharalakshmi: json["sancharalakshmi"],
            registered: json["registered"],
        );
    }

}

class Role {
    Role({
        required this.name,
        required this.id,
    });

    final String? name;
    final int? id;

    factory Role.fromJson(Map<String, dynamic> json){ 
        return Role(
            name: json["name"],
            id: json["id"],
        );
    }

}
