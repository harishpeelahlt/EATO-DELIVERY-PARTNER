import 'package:eato_delivery_partner/domain/usecase/orders/deliverOtpVerification/deliverOtpVerification_usecase.dart';
import 'package:eato_delivery_partner/presentation/cubit/orders/deliverOtpVerification/deliverOtpVerification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliverOtpCubit extends Cubit<DeliverOtpState> {
  final DeliverOtpUseCase useCase;

  DeliverOtpCubit({required this.useCase}) : super(DeliverOtpInitial());

  Future<void> triggerOtp(String orderId) async {
    emit(DeliverOtpLoading());
    try {
      final result = await useCase.triggerOtp(orderId);
      emit(DeliverOtpTriggerSuccess(result));
    } catch (e) {
      emit(DeliverOtpFailure(e.toString()));
    }
  }

  Future<void> verifyOtp(String orderId, String otp) async {
    emit(DeliverOtpLoading());
    try {
      final result = await useCase.verifyOtp(orderId, otp);
      emit(DeliverOtpVerifySuccess(result));
    } catch (e) {
      emit(DeliverOtpFailure(e.toString()));
    }
  }
}
