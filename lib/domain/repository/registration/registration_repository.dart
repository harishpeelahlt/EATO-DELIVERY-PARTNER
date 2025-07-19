import 'package:eato_delivery_partner/data/model/registration/registration_model.dart';

abstract class RegistrationRepository {
  Future<RegistrationModel> registration(dynamic body);
}
