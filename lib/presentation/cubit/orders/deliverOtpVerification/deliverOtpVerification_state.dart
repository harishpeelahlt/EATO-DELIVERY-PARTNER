import 'package:eato_delivery_partner/data/model/orders/deliverOtpVerification/DeliverOtpVerification_model.dart';

abstract class DeliverOtpState {}

class DeliverOtpInitial extends DeliverOtpState {}

class DeliverOtpLoading extends DeliverOtpState {}

class DeliverOtpTriggerSuccess extends DeliverOtpState {
  final DeliverTriggerOtpModel model;
  DeliverOtpTriggerSuccess(this.model);
}

class DeliverOtpVerifySuccess extends DeliverOtpState {
  final DeliverVerifyOtpModel model;
  DeliverOtpVerifySuccess(this.model);
}

class DeliverOtpFailure extends DeliverOtpState {
  final String message;
  DeliverOtpFailure(this.message);
}
