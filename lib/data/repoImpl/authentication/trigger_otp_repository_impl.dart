import 'package:eato_delivery_partner/data/dataSource/authentication/trigger_otp_remote_data_source.dart';

import '../../../domain/repository/authentication/trigger_otp_repository.dart';
import '../../model/authentication/trigger_otp_model.dart';

class TriggerOtpRepositoryImpl implements TriggerOtpRepository {
  final TriggerOtpRemoteDataSource remoteDataSource;

  TriggerOtpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TriggerOtpModel> getOtp(String mobileNumber) async {
    final model = await remoteDataSource.fetchOtp(mobileNumber);
    return TriggerOtpModel(
      creationTime: model.creationTime,
      otp: model.otp,
    );
  }
}
