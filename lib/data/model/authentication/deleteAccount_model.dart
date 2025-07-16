class DeleteAccountModel {
  DeleteAccountModel({
    required this.message,
    required this.status,
    required this.data,
  });

  final String? message;
  final String? status;
  final dynamic data;

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) {
    return DeleteAccountModel(
      message: json["message"],
      status: json["status"],
      data: json["data"],
    );
  }
}
