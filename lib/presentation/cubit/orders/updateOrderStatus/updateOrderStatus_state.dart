import 'package:eato_delivery_partner/data/model/orders/updateOrderStatus/updateOrderStatus_model.dart';

abstract class UpdateOrderStatusState {}

class UpdateOrderStatusInitial extends UpdateOrderStatusState {}

class UpdateOrderStatusLoading extends UpdateOrderStatusState {}

class UpdateOrderStatusSuccess extends UpdateOrderStatusState {
  final UpdateOrderStatusModel response;

  UpdateOrderStatusSuccess(this.response);
}

class UpdateOrderStatusFailure extends UpdateOrderStatusState {
  final String error;

  UpdateOrderStatusFailure(this.error);
}
