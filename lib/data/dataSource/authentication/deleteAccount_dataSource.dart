import 'package:dio/dio.dart';
import 'package:eato_delivery_partner/core/constants/api_constants.dart';
import 'package:eato_delivery_partner/data/model/authentication/deleteAccount_model.dart';

abstract class DeleteAccountRemoteDataSource {
  Future<DeleteAccountModel> deleteAccount();
}

class DeleteAccountRemoteDataSourceImpl
    implements DeleteAccountRemoteDataSource {
  final Dio client;

  DeleteAccountRemoteDataSourceImpl({required this.client});

  @override
  Future<DeleteAccountModel> deleteAccount() async {
    try {
      final response = await client.delete(
        '$baseUrl$deleteAccountUrl',
      );

      print('DeleteAccount Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DeleteAccountModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to DeleteAccount. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('DeleteAccount Error: $e');
      throw Exception('DeleteAccount failed: ${e.toString()}');
    }
  }
}
