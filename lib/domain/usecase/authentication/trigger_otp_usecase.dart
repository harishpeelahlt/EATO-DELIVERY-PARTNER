import '../../../data/model/authentication/trigger_otp_model.dart';
import '../../repository/authentication/trigger_otp_repository.dart';

class TriggerOtpValidationUseCase {
  final TriggerOtpRepository repository;

  TriggerOtpValidationUseCase({required this.repository});

  Future<TriggerOtpModel> call(String mobileNumber) async {
    return await repository.getOtp(mobileNumber);
  }
}
