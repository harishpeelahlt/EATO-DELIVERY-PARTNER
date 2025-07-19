import 'package:eato_delivery_partner/data/model/registration/registration_model.dart';
import 'package:eato_delivery_partner/domain/repository/registration/registration_repository.dart';

class RegistrationUseCase {
  final RegistrationRepository repository;

  RegistrationUseCase({required this.repository});

  Future<RegistrationModel> call(dynamic body) async {
    return await repository.registration(body);
  }
}
