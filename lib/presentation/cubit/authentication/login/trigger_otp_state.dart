import '../../../../data/model/authentication/trigger_otp_model.dart';

abstract class TriggerOtpState {}

class TriggerOtpInitial extends TriggerOtpState {}

class TriggerOtpLoading extends TriggerOtpState {}

class TriggerOtpLoaded extends TriggerOtpState {
  final TriggerOtpModel triggerOtpModel;
  TriggerOtpLoaded(this.triggerOtpModel);
}

class ResendOtpLoaded extends TriggerOtpState {
  final TriggerOtpModel resendOtp;
  ResendOtpLoaded(this.resendOtp);
}

class TriggerOtpError extends TriggerOtpState {
  final String message;
  TriggerOtpError(this.message);
}
