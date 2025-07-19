import 'package:eato_delivery_partner/data/dataSource/registration/registration_dataSource.dart';
import 'package:eato_delivery_partner/data/model/registration/registration_model.dart';
import 'package:eato_delivery_partner/domain/repository/registration/registration_repository.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationRemoteDataSource remoteDataSource;

  RegistrationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<RegistrationModel> registration(dynamic body) async {
    return await remoteDataSource.registration(body);
  }
}
