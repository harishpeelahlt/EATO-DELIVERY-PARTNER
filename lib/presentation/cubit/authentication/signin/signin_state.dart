import '../../../../data/model/authentication/signin_model.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInLoaded extends SignInState {
  final SignInModel signInModel;
  SignInLoaded(this.signInModel);
}

class SignInSuccess extends SignInState {
  final SignInModel signInModel;
  SignInSuccess(this.signInModel);
}

class SignInError extends SignInState {
  final String message;
  SignInError(this.message);
}
