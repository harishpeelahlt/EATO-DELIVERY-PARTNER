import '../../../data/model/authentication/current_customer_model.dart';

abstract class CurrentCustomerRepository {
  Future<CurrentCustomerModel> getCurrentCustomer();
}
