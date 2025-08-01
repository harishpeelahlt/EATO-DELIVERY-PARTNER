import 'package:eato_delivery_partner/data/model/orders/deliverOtpVerification/DeliverOtpVerification_model.dart';

abstract class DeliverOtpRepository {
  Future<DeliverTriggerOtpModel> triggerOtp(String orderId);
  Future<DeliverVerifyOtpModel> verifyOtp(String orderId, String otp);
}
