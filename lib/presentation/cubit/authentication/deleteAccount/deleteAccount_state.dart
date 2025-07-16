
import 'package:eato_delivery_partner/data/model/authentication/deleteAccount_model.dart';

abstract class DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {
  final DeleteAccountModel model;

  DeleteAccountSuccess(this.model);
}

class DeleteAccountFailure extends DeleteAccountState {
  final String message;

  DeleteAccountFailure(this.message);
}
