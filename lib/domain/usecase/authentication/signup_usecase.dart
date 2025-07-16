import 'package:eato_delivery_partner/data/model/authentication/signup_model.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/signup_repository.dart';

class SignUpValidationUseCase {
  final SignUpRepository repository;

  SignUpValidationUseCase({required this.repository});

  Future<SignUpModel> call(String mobileNumber) async {
    return await repository.getOtp(mobileNumber);
  }
}
