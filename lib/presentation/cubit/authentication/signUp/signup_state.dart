import 'package:eato_delivery_partner/data/model/authentication/signup_model.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {
  final SignUpModel signUpModel;
  SignUpLoaded(this.signUpModel);
}

class ResendOtpLoaded extends SignUpState {
  final SignUpModel resendOtp;
  ResendOtpLoaded(this.resendOtp);
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}
