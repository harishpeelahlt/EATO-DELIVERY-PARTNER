import 'package:eato_delivery_partner/data/dataSource/orders/fetchOrders/fetchOrders_dataSource.dart';
import 'package:eato_delivery_partner/data/model/orders/FetchOrders/fetchOrders_model.dart';
import 'package:eato_delivery_partner/domain/repository/orders/fetchOrders/fetchOrders_repository.dart';

class FetchOrdersRepositoryImpl implements FetchOrdersRepository {
  final FetchOrdersRemoteDataSource remoteDataSource;

  FetchOrdersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<FetchOrdersModel> fetchOrders(Map<String, dynamic> params) async {
    return await remoteDataSource.fetchOrders(params);
  }
}
