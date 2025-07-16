import 'package:eato_delivery_partner/components/custom_snackbar.dart';
import 'package:eato_delivery_partner/core/network/network_service.dart';
import 'package:eato_delivery_partner/domain/usecase/authentication/update_current_customer_usecase.dart';
import 'package:eato_delivery_partner/presentation/cubit/authentication/currentcustomer/update/update_current_customer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCurrentCustomerCubit extends Cubit<UpdateCurrentCustomerState> {
  final UpdateCurrentCustomerUseCase useCase;
  final NetworkService networkService;

  UpdateCurrentCustomerCubit(
      {required this.useCase, required this.networkService})
      : super(UpdateCurrentCustomerState());

  Future<void> updateCustomer(Map<String, dynamic> payload, context) async {
    bool isConnected = await networkService.hasInternetConnection();
    print(isConnected);
    if (!isConnected) {
      print("No Internet Connection");
      CustomSnackbars.showErrorSnack(
        context: context,
        title: 'Alert',
        message: 'Please check Internet Connection',
      );
      return;
    } else {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        final result = await useCase(payload);
        emit(state.copyWith(isLoading: false, data: result));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    }
  }
}
