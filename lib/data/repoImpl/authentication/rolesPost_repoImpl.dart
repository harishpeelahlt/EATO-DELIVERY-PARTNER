import 'package:eato_delivery_partner/data/dataSource/authentication/rolesPost_dataSource.dart';
import 'package:eato_delivery_partner/data/model/authentication/rolesPost_model.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/rolesPost_repository.dart';

class RolePostRepoImpl implements RolePostRepository {
  final RolePostRemoteDatasource remoteDataSource;

  RolePostRepoImpl({required this.remoteDataSource});

  @override
  Future<RolePostModel> rolePost(String? role) async {
    try {
      final model = await remoteDataSource.RolePost(
        role: role,
      );
      return RolePostModel(
        message: model.message,
        role: model.role,
      );
    } catch (e) {
      throw Exception('Failed to fetch payment approval: ${e.toString()}');
    }
  }
}
