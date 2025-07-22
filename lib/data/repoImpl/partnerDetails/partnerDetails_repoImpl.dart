import 'package:eato_delivery_partner/data/dataSource/partnerDetails/partnerDetails_dataSource.dart';
import 'package:eato_delivery_partner/data/model/partnerDetails/partnerDetails_model.dart';
import 'package:eato_delivery_partner/domain/repository/partnerDetails/partnerDetails_repository.dart';

class PartnerDetailsRepositoryImpl implements PartnerDetailsRepository {
  final PartnerDetailsRemoteDataSource remoteDataSource;

  PartnerDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PartnerDetailsModel> getPartnerDetails() {
    return remoteDataSource.partnerDetails();
  }
}
