import 'package:eato_delivery_partner/data/model/availability/availability_model.dart';
import 'package:eato_delivery_partner/domain/repository/availability/availability_repository.dart';

class AvailabilityUseCase {
  final AvailabilityRepository repository;

  AvailabilityUseCase({required this.repository});

  Future<AvailabilityModel> call(bool availability) {
    return repository.setAvailability(availability);
  }
}
