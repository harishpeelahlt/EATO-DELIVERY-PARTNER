import 'package:eato_delivery_partner/data/model/orders/updateOrderStatus/updateOrderStatus_model.dart';
import 'package:eato_delivery_partner/domain/repository/orders/updateOrderStatus/updateOrderStatus_repository.dart';

class UpdateOrderStatusUseCase {
  final UpdateOrderStatusRepository repository;

  UpdateOrderStatusUseCase({required this.repository});

  Future<UpdateOrderStatusModel> call(String orderId, String status) {
    return repository.updateOrderStatus(orderId,status);
  }
}
