import 'package:eato_delivery_partner/data/model/registration/registration_model.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final RegistrationModel model;

  RegistrationSuccess(this.model);
}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure(this.error);
}
