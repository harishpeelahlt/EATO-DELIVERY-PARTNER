import 'package:eato_delivery_partner/data/model/orders/updateOrderStatus/updateOrderStatus_model.dart';

abstract class UpdateOrderStatusRepository {
  Future<UpdateOrderStatusModel> updateOrderStatus(String orderId, String status);
}
