
import 'package:eato_delivery_partner/data/model/authentication/deleteAccount_model.dart';

abstract class DeleteAccountRepository {
  Future<DeleteAccountModel> deleteAccount();
}
