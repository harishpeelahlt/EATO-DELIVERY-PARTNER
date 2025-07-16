import 'package:eato_delivery_partner/data/model/authentication/update_current_customer_model.dart';

class UpdateCurrentCustomerState {
  final bool isLoading;
  final UpdateCurrentCustomerModel? data;
  final String? error;

  UpdateCurrentCustomerState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  UpdateCurrentCustomerState copyWith({
    bool? isLoading,
    UpdateCurrentCustomerModel? data,
    String? error,
  }) {
    return UpdateCurrentCustomerState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }
}
