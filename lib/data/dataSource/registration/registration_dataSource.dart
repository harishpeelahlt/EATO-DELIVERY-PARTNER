import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/constants/api_constants.dart';
import 'package:eato_delivery_partner/data/model/registration/registration_model.dart';


abstract class RegistrationRemoteDataSource {
  Future<RegistrationModel> registration(dynamic body);
}

class RegistrationRemoteDataSourceImpl implements RegistrationRemoteDataSource {
  final Dio client;

  RegistrationRemoteDataSourceImpl({required this.client});

  @override
  Future<RegistrationModel> registration(dynamic body) async {
    print(body);
    try {
      final response = await client.post(
        '$baseUrl$registrationUrl',
        data: body,
      );

      print('Registration Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegistrationModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to Registration. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Registration Error: $e');
      throw Exception('Registration failed: ${e.toString()}');
    }
  }
}
