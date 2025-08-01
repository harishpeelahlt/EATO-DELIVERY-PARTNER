
import 'package:eato_delivery_partner/data/model/orders/deliverOtpVerification/DeliverOtpVerification_model.dart';
import 'package:eato_delivery_partner/domain/repository/orders/deliverOtpVerification/deliverOtpVerification_repository.dart';

class DeliverOtpUseCase {
  final DeliverOtpRepository repository;

  DeliverOtpUseCase({required this.repository});

  Future<DeliverTriggerOtpModel> triggerOtp(String orderId) {
    return repository.triggerOtp(orderId);
  }

  Future<DeliverVerifyOtpModel> verifyOtp(String orderId, String otp) {
    return repository.verifyOtp(orderId, otp);
  }
}
