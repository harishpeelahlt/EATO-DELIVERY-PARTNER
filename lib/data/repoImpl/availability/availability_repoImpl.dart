import 'package:eato_delivery_partner/data/dataSource/availability/availability_dataSource.dart';
import 'package:eato_delivery_partner/data/model/availability/availability_model.dart';
import 'package:eato_delivery_partner/domain/repository/availability/availability_repository.dart';

class AvailabilityRepositoryImpl implements AvailabilityRepository {
  final AvailabilityRemoteDataSource remoteDataSource;

  AvailabilityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AvailabilityModel> setAvailability(bool availability) {
    return remoteDataSource.availability(availability);
  }
}
