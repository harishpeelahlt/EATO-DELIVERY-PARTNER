
import 'package:eato_delivery_partner/data/model/authentication/rolesPost_model.dart';

abstract class RolePostState {}

class RolePostInitial extends RolePostState {}

class RolePostLoading extends RolePostState {}

class RolePostSuccess extends RolePostState {
  final RolePostModel rolePostModel;

  RolePostSuccess(this.rolePostModel);
}

class RolePostFailure extends RolePostState {
  final String error;

  RolePostFailure(this.error);
}
