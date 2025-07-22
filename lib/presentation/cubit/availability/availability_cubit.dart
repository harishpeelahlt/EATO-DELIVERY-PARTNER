import 'package:eato_delivery_partner/domain/usecase/availability/availability_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'availability_state.dart';

class AvailabilityCubit extends Cubit<AvailabilityState> {
  final AvailabilityUseCase setAvailabilityUseCase;

  AvailabilityCubit( this.setAvailabilityUseCase)
      : super(AvailabilityInitial());

  void updateAvailability(bool availability) async {
    emit(AvailabilityLoading());
    try {
      final result = await setAvailabilityUseCase(availability);
      emit(AvailabilitySuccess(result));
    } catch (e) {
      emit(AvailabilityFailure(e.toString()));
    }
  }
}
