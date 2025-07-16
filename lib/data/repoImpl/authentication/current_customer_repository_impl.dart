import 'package:eato_delivery_partner/data/dataSource/authentication/current_customer_remote_data_source.dart';

import '../../../domain/repository/authentication/current_customer_repository.dart';
import '../../model/authentication/current_customer_model.dart';

class CurrentCustomerRepositoryImpl implements CurrentCustomerRepository {
  final CurrentCustomerRemoteDataSource remoteDataSource;

  CurrentCustomerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CurrentCustomerModel> getCurrentCustomer() {
    return remoteDataSource.currentCustomer();
  }
}

