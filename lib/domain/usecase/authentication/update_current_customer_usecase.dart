import 'package:eato_delivery_partner/data/model/authentication/update_current_customer_model.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/update_current_customer_repository.dart';

class UpdateCurrentCustomerUseCase {
  final UpdateCurrentCustomerRepository repository;

  UpdateCurrentCustomerUseCase({required this.repository});

  Future<UpdateCurrentCustomerModel> call(Map<String, dynamic> payload) {
    return repository.updateCurrentCustomer(payload);
  }
}