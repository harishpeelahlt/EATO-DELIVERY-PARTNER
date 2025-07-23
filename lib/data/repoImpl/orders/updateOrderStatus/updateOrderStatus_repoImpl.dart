import 'package:eato_delivery_partner/data/dataSource/orders/updateOrderStatus/updateOrderStatus_dataSource.dart';
import 'package:eato_delivery_partner/data/model/orders/updateOrderStatus/updateOrderStatus_model.dart';
import 'package:eato_delivery_partner/domain/repository/orders/updateOrderStatus/updateOrderStatus_repository.dart';

class UpdateOrderStatusRepositoryImpl implements UpdateOrderStatusRepository {
  final UpdateOrderStatusRemoteDataSource remoteDataSource;

  UpdateOrderStatusRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UpdateOrderStatusModel> updateOrderStatus(String orderId, String status) {
    return remoteDataSource.updateOrderStatus(orderId,status);
  }
}
