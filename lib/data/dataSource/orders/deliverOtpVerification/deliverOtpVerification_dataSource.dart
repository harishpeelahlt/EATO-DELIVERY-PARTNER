import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/constants/api_constants.dart';
import 'package:eato_delivery_partner/data/model/orders/deliverOtpVerification/DeliverOtpVerification_model.dart';

abstract class DeliverOtpRemoteDataSource {
  Future<DeliverTriggerOtpModel> triggerOtp(String orderId);
  Future<DeliverVerifyOtpModel> verifyOtp(String orderId, String otp);
}

class DeliverOtpRemoteDataSourceImpl implements DeliverOtpRemoteDataSource {
  final Dio client;

  DeliverOtpRemoteDataSourceImpl({required this.client});

  @override
  Future<DeliverTriggerOtpModel> triggerOtp(String orderId) async {
    final url = deliverTriggerOtpUrl(orderId);
    try {
      final response = await client.post(url);
      if (response.statusCode == 200) {
        return DeliverTriggerOtpModel.fromJson(response.data);
      } else {
        throw Exception('Failed to trigger OTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error triggering OTP: $e');
      throw Exception('Trigger OTP failed: ${e.toString()}');
    }
  }

  @override
  Future<DeliverVerifyOtpModel> verifyOtp(String orderId, String otp) async {
    final url = deliverVerifyOtpUrl(orderId, otp);
    try {
      final response = await client.post(url);
      if (response.statusCode == 200) {
        return DeliverVerifyOtpModel.fromJson(response.data);
      } else {
        throw Exception('Failed to verify OTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      throw Exception('Verify OTP failed: ${e.toString()}');
    }
  }
}
