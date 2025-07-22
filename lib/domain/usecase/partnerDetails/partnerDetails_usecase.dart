import 'package:eato_delivery_partner/data/model/partnerDetails/partnerDetails_model.dart';
import 'package:eato_delivery_partner/domain/repository/partnerDetails/partnerDetails_repository.dart';

class PartnerDetailsUseCase {
  final PartnerDetailsRepository repository;

  PartnerDetailsUseCase({required this.repository});

  Future<PartnerDetailsModel> execute() {
    return repository.getPartnerDetails();
  }
}
