import 'package:bloc/bloc.dart';
import 'package:eato_delivery_partner/presentation/screens/authentication/otp_screen.dart';
import 'package:flutter/material.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../core/network/network_helper.dart';
import '../../../../core/network/network_service.dart';
import '../../../../domain/usecase/authentication/trigger_otp_usecase.dart';
import 'trigger_otp_state.dart';

class TriggerOtpCubit extends Cubit<TriggerOtpState> {
  final TriggerOtpValidationUseCase useCase;
  final NetworkService networkService;

  TriggerOtpCubit({required this.useCase, required this.networkService})
      : super(TriggerOtpInitial());

  Future<void> fetchOtp(BuildContext context, String mobileNumber) async {
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
    }

    if (mobileNumber.isEmpty) {
      CustomSnackbars.showErrorSnack(
        context: context,
        title: 'Attention',
        message: 'Please enter a mobile number',
      );
      return;
    } else if (mobileNumber.length < 10) {
      CustomSnackbars.showErrorSnack(
        context: context,
        message: 'Please enter a valid mobile number',
        title: 'Attention',
      );
      return;
    }

    try {
      emit(TriggerOtpLoading());
      final otpEntity = await useCase(mobileNumber);
      emit(TriggerOtpLoaded(otpEntity));

      final otpValue =
          otpEntity.otp?.isNotEmpty == true ? otpEntity.otp! : 'true';

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            mobileNumber: mobileNumber,
            otp: otpValue,
            fullName: '',
            otpValue: otpValue,
          ),
        ),
        (route) => false,
      );

      print('OTP response received and stored in state');
    } catch (e) {
      print('error in trigger otp: $e');
      emit(TriggerOtpError('Failed to load OTP data: ${e.toString()}'));
    }
  }

  Future<void> resendOtp(BuildContext context, String mobileNumber) async {
    bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
      context: context,
      networkService: networkService,
    );
    if (!isConnected) return;

    try {
      final otpEntity = await useCase(mobileNumber);
      emit(ResendOtpLoaded(otpEntity));
      if (otpEntity.creationTime?.isNotEmpty == true) {
        final otpValue =
            otpEntity.otp?.isNotEmpty == true ? otpEntity.otp! : 'true';
        print(otpValue);
      } else {
        CustomSnackbars.showErrorSnack(
          context: context,
          title: 'Alert',
          message: 'Something went wrong, please try again later',
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
