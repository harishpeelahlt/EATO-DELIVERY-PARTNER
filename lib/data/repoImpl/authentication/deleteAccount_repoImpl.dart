import 'package:eato_delivery_partner/data/dataSource/authentication/deleteAccount_dataSource.dart';
import 'package:eato_delivery_partner/data/model/authentication/deleteAccount_model.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/deleteAccount_repository.dart';

class DeleteAccountRepositoryImpl implements DeleteAccountRepository {
  final DeleteAccountRemoteDataSource remoteDataSource;

  DeleteAccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DeleteAccountModel> deleteAccount() async {
    return await remoteDataSource.deleteAccount();
  }
}
