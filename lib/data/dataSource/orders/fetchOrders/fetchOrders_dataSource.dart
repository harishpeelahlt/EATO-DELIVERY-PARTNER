import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/constants/api_constants.dart';
import 'package:eato_delivery_partner/data/model/orders/FetchOrders/fetchOrders_model.dart';

abstract class FetchOrdersRemoteDataSource {
  Future<FetchOrdersModel> fetchOrders(Map<String, dynamic> params);
}

class FetchOrdersRemoteDataSourceImpl implements FetchOrdersRemoteDataSource {
  final Dio client;

  FetchOrdersRemoteDataSourceImpl({required this.client});

  @override
  Future<FetchOrdersModel> fetchOrders(Map<String, dynamic> params) async {
    try {
      final String partnerId = params['partnerId'];
      final int page = params['page'];
      final int size = params['size'];
      final response = await client.request(
        '$baseUrl${fetchOrdersUrl(partnerId, page, size)}',
        options: Options(method: 'GET'),
      );
      if (response.statusCode == 200) {
        print('responce of FetchOrders:: $response');
        return FetchOrdersModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load FetchOrders data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load FetchOrders data: ${e.toString()}');
    }
  }
}
