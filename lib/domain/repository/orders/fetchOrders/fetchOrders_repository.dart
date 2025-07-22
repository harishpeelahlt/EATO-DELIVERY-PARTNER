import 'package:eato_delivery_partner/data/model/orders/FetchOrders/fetchOrders_model.dart';

abstract class FetchOrdersRepository {
  Future<FetchOrdersModel> fetchOrders(Map<String, dynamic> params);
}
