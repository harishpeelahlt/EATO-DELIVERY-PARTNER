import 'package:eato_delivery_partner/data/model/orders/FetchOrders/fetchOrders_model.dart';

abstract class FetchOrdersState {}

class FetchOrdersInitial extends FetchOrdersState {}

class FetchOrdersLoading extends FetchOrdersState {}

class FetchOrdersSuccess extends FetchOrdersState {
  final FetchOrdersModel orders;

  FetchOrdersSuccess({required this.orders});
}

class FetchOrdersFailure extends FetchOrdersState {
  final String message;

  FetchOrdersFailure({required this.message});
}
