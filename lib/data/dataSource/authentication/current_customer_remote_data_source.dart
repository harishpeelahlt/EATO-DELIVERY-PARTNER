import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/constants/global_exception_handler.dart';
import 'package:eato_delivery_partner/data/model/authentication/current_customer_model.dart';
import '../../../core/constants/api_constants.dart';

abstract class CurrentCustomerRemoteDataSource {
  Future<CurrentCustomerModel> currentCustomer();
}

class CurrentCustomerRemoteDataSourceImpl
    implements CurrentCustomerRemoteDataSource {
  final Dio client;

  CurrentCustomerRemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentCustomerModel> currentCustomer() async {
    try {
      final response = await client.request(
        '$baseUrl$userDetails',
        options: Options(method: 'GET'),
      );

      if (response.statusCode == 200) {
        print('Response of current customer: $response');
        return CurrentCustomerModel.fromJson(response.data);
      } else {
        final code = response.data['code'] ?? response.statusCode;
        final message = response.data['message'] ?? 'Unknown error occurred';
        throw mapErrorCodeToException(code, message);
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw UnknownBackendException('Unexpected error: ${e.toString()}');
    }
  }
}
