import 'package:eato_delivery_partner/data/dataSource/authentication/signin_remote_data_source.dart';

import '../../../domain/repository/authentication/signin_repository.dart';
import '../../model/authentication/signin_model.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInRemoteDataSource remoteDataSource;

  SignInRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SignInModel> logIn(String mobileNumber, String otp,String fullName) async {
    final model = await remoteDataSource.signIn(mobileNumber, otp,fullName);
    return SignInModel(
      token: model.token,
      refreshToken: model.refreshToken,
      type: model.type,
      id: model.id,
      roles: model.roles,
      primaryContact: model.primaryContact,
    );
  }
}
