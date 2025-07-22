import 'package:eato_delivery_partner/data/model/orders/FetchOrders/fetchOrders_model.dart';
import 'package:eato_delivery_partner/domain/repository/orders/fetchOrders/fetchOrders_repository.dart';

class FetchOrdersUseCase {
  final FetchOrdersRepository repository;

  FetchOrdersUseCase({required this.repository});

  Future<FetchOrdersModel> call(Map<String, dynamic> params) async {
    return await repository.fetchOrders(params);
  }
}
