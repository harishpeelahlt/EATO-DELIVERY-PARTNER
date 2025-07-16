import '../../../data/model/authentication/trigger_otp_model.dart';

abstract class TriggerOtpRepository {
  Future<TriggerOtpModel> getOtp(String mobileNumber);
}
