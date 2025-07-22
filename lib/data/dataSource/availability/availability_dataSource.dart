import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/constants/api_constants.dart';
import 'package:eato_delivery_partner/data/model/availability/availability_model.dart';

abstract class AvailabilityRemoteDataSource {
  Future<AvailabilityModel> availability(bool availability);
}

class AvailabilityRemoteDataSourceImpl implements AvailabilityRemoteDataSource {
  final Dio client;

  AvailabilityRemoteDataSourceImpl({required this.client});

  @override
  Future<AvailabilityModel> availability(bool availability) async {
    try {
      final response = await client.put(
        '$baseUrl$availabilityUrl=$availability',
      );

      print('Availability Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AvailabilityModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to Availability. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Availability Error: $e');
      throw Exception('Availability failed: ${e.toString()}');
    }
  }
}
