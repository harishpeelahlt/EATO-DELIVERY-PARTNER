import 'package:eato_delivery_partner/data/model/authentication/signup_model.dart';

abstract class SignUpRepository {
  Future<SignUpModel> getOtp(String mobileNumber);
}
