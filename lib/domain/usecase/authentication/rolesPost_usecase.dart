import 'package:eato_delivery_partner/data/model/authentication/rolesPost_model.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/rolesPost_repository.dart';

class RolePostUsecase {
  final RolePostRepository repository;

  RolePostUsecase(this.repository);

  Future<RolePostModel> call(String? role) async {
    return await repository.rolePost(role);
  }
}
