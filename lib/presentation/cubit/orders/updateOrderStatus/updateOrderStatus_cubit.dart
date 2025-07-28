import 'package:bloc/bloc.dart';
import 'package:eato_delivery_partner/domain/usecase/orders/updateOrderStatus/updateOrderStatus_usecase.dart';
import 'updateOrderStatus_state.dart';

class UpdateOrderStatusCubit extends Cubit<UpdateOrderStatusState> {
  final UpdateOrderStatusUseCase useCase;

  UpdateOrderStatusCubit(this.useCase)
      : super(UpdateOrderStatusInitial());

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      emit(UpdateOrderStatusLoading());
      final result = await useCase.call(orderId,status);
      emit(UpdateOrderStatusSuccess(result));
    } catch (e) {
      emit(UpdateOrderStatusFailure(e.toString()));
    }
  }
}
