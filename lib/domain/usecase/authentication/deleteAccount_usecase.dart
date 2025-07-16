import 'package:eato_delivery_partner/data/model/authentication/deleteAccount_model.dart';
import 'package:eato_delivery_partner/domain/repository/authentication/deleteAccount_repository.dart';

class DeleteAccountUseCase {
  final DeleteAccountRepository repository;

  DeleteAccountUseCase({required this.repository});

  Future<DeleteAccountModel> call() async {
    return await repository.deleteAccount();
  }
}
