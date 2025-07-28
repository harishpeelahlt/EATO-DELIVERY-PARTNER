import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/constants/api_constants.dart';
import 'package:eato_delivery_partner/data/model/orders/updateOrderStatus/updateOrderStatus_model.dart';

abstract class UpdateOrderStatusRemoteDataSource {
  Future<UpdateOrderStatusModel> updateOrderStatus(String orderId,String status);
}

class UpdateOrderStatusRemoteDataSourceImpl
    implements UpdateOrderStatusRemoteDataSource {
  final Dio client;

  UpdateOrderStatusRemoteDataSourceImpl({required this.client});

  @override
  Future<UpdateOrderStatusModel> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await client.post(
        '$baseUrl${updateOrderStatusUrl(orderId,status)}',
      );

      print('UpdateOrderStatus Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UpdateOrderStatusModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to UpdateOrderStatus. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('UpdateOrderStatus Error: $e');
      throw Exception('UpdateOrderStatus failed: ${e.toString()}');
    }
  }
}
