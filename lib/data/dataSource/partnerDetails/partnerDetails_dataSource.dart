import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/constants/api_constants.dart';
import 'package:eato_delivery_partner/data/model/partnerDetails/partnerDetails_model.dart';


abstract class PartnerDetailsRemoteDataSource {
  Future<PartnerDetailsModel> partnerDetails();
}

class PartnerDetailsRemoteDataSourceImpl implements PartnerDetailsRemoteDataSource {
  final Dio client;

  PartnerDetailsRemoteDataSourceImpl({required this.client});

  @override
  Future<PartnerDetailsModel> partnerDetails() async {
    try {
      final response = await client.request(
        '$baseUrl$partnerDetailsUrl',
        options: Options(method: 'GET'),
      );
      if (response.statusCode == 200) {
        print('responce of PartnerDetails:: $response');
        return PartnerDetailsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load PartnerDetails data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load PartnerDetails data: ${e.toString()}');
    }
  }
}
