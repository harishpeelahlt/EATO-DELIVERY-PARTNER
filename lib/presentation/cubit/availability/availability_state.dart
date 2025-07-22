import 'package:eato_delivery_partner/data/model/availability/availability_model.dart';

abstract class AvailabilityState {}

class AvailabilityInitial extends AvailabilityState {}

class AvailabilityLoading extends AvailabilityState {}

class AvailabilitySuccess extends AvailabilityState {
  final AvailabilityModel model;
  AvailabilitySuccess(this.model);
}

class AvailabilityFailure extends AvailabilityState {
  final String message;
  AvailabilityFailure(this.message);
}
