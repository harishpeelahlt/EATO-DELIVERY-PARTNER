import 'package:eato_delivery_partner/data/model/partnerDetails/partnerDetails_model.dart';

abstract class PartnerDetailsState {}

class PartnerDetailsInitial extends PartnerDetailsState {}

class PartnerDetailsLoading extends PartnerDetailsState {}

class PartnerDetailsLoaded extends PartnerDetailsState {
  final PartnerDetailsModel partnerDetails;

  PartnerDetailsLoaded(this.partnerDetails);
}

class PartnerDetailsError extends PartnerDetailsState {
  final String message;

  PartnerDetailsError(this.message);
}
