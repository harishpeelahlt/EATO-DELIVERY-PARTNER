import 'package:eato_delivery_partner/core/constants/global_exception_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/network_helper.dart';
import '../../../../../core/network/network_service.dart';
import '../../../../../domain/usecase/authentication/current_customer_usecase.dart';
import 'current_customer_state.dart';

class CurrentCustomerCubit extends Cubit<CurrentCustomerState> {
  final CurrentCustomerValidationUseCase currentCustomerValidationUseCase;
  final NetworkService networkService;

  CurrentCustomerCubit(
    this.currentCustomerValidationUseCase,
    this.networkService,
  ) : super(CurrentCustomerInitial());

  void startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!isClosed) {
        emit(CurrentCustomerInitial());
      }
    });
  }

  void reset() {
    emit(CurrentCustomerInitial());
  }

  Future<void> GetCurrentCustomer(BuildContext context) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      emit(CurrentCustomerLoading());

      final currentCustomerModel = await currentCustomerValidationUseCase();

      if (!isClosed) {
        emit(CurrentCustomerLoaded(currentCustomerModel));
      }
    } on AppException catch (e) {
      debugPrint('AppException: $e');
      if (!isClosed) {
        emit(CurrentCustomerError(e.message)); // ✅ Use clean message
      }
    } catch (e) {
      debugPrint('Unexpected error: $e');
      if (!isClosed) {
        emit(CurrentCustomerError("Something went wrong. Please try again."));
      }
    }
  }
}
