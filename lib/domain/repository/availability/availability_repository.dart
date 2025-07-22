import 'package:eato_delivery_partner/data/model/availability/availability_model.dart';

abstract class AvailabilityRepository {
  Future<AvailabilityModel> setAvailability(bool availability);
}
