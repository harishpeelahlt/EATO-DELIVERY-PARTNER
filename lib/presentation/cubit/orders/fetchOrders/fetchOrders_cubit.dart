import 'package:eato_delivery_partner/domain/usecase/orders/fetchOrders/fetchOrders_usecase.dart';
import 'package:eato_delivery_partner/presentation/cubit/orders/fetchOrders/fetchOrders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FetchOrdersCubit extends Cubit<FetchOrdersState> {
  final FetchOrdersUseCase fetchOrdersUseCase;

  FetchOrdersCubit( this.fetchOrdersUseCase)
      : super(FetchOrdersInitial());

  Future<void> fetchOrders(Map<String, dynamic> params) async {
    try {
      emit(FetchOrdersLoading());
      final result = await fetchOrdersUseCase.call(params);
      emit(FetchOrdersSuccess(orders: result));
    } catch (e) {
      emit(FetchOrdersFailure(message: e.toString()));
    }
  }
}
