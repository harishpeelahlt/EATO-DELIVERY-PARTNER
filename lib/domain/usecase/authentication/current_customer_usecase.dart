import '../../../data/model/authentication/current_customer_model.dart';
import '../../repository/authentication/current_customer_repository.dart';

class CurrentCustomerValidationUseCase {
  final CurrentCustomerRepository repository;

  CurrentCustomerValidationUseCase(this.repository);

  Future<CurrentCustomerModel> call() async {
    return await repository.getCurrentCustomer();
  }
}
