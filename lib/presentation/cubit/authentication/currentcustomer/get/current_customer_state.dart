import '../../../../../data/model/authentication/current_customer_model.dart';

abstract class CurrentCustomerState {}

class CurrentCustomerInitial extends CurrentCustomerState {}

class CurrentCustomerLoading extends CurrentCustomerState {}

class CurrentCustomerLoaded extends CurrentCustomerState {
  final CurrentCustomerModel currentCustomerModel;
  CurrentCustomerLoaded(this.currentCustomerModel);
}

class CurrentCustomerError extends CurrentCustomerState {
  final String message;
  CurrentCustomerError(this.message);
}
