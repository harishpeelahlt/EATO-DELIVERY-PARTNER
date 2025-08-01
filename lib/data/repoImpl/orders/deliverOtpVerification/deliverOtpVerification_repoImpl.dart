import 'package:eato_delivery_partner/data/dataSource/orders/deliverOtpVerification/deliverOtpVerification_dataSource.dart';
import 'package:eato_delivery_partner/data/model/orders/deliverOtpVerification/DeliverOtpVerification_model.dart';
import 'package:eato_delivery_partner/domain/repository/orders/deliverOtpVerification/deliverOtpVerification_repository.dart';

class DeliverOtpRepositoryImpl implements DeliverOtpRepository {
  final DeliverOtpRemoteDataSource remoteDataSource;

  DeliverOtpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DeliverTriggerOtpModel> triggerOtp(String orderId) {
    return remoteDataSource.triggerOtp(orderId);
  }

  @override
  Future<DeliverVerifyOtpModel> verifyOtp(String orderId, String otp) {
    return remoteDataSource.verifyOtp(orderId, otp);
  }
}
