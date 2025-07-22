import 'package:eato_delivery_partner/data/model/partnerDetails/partnerDetails_model.dart';

abstract class PartnerDetailsRepository {
  Future<PartnerDetailsModel> getPartnerDetails();
}
