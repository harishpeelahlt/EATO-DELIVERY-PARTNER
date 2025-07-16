
import 'package:eato_delivery_partner/data/model/authentication/location/lattitude_longitude_model.dart';
import 'package:eato_delivery_partner/data/model/authentication/location/location_model.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationSearchModel model;
  final LatLangModel latLangModel;

  LocationLoaded({required this.model, required this.latLangModel});
}

class LocationFailure extends LocationState {
  final String message;
  LocationFailure({required this.message});
}
