import 'package:eato_delivery_partner/data/model/authentication/update_current_customer_model.dart';

abstract class UpdateCurrentCustomerRepository {
  Future<UpdateCurrentCustomerModel> updateCurrentCustomer(Map<String, dynamic> payload);
}

