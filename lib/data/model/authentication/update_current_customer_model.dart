class UpdateCurrentCustomerModel {
    UpdateCurrentCustomerModel({
        required this.message,
        required this.status,
        required this.data,
    });

    final String? message;
    final String? status;
    final String? data;

    factory UpdateCurrentCustomerModel.fromJson(Map<String, dynamic> json){ 
        return UpdateCurrentCustomerModel(
            message: json["message"],
            status: json["status"],
            data: json["data"],
        );
    }

}
