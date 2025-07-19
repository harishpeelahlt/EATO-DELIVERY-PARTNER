import 'package:eato_delivery_partner/domain/usecase/registration/registration_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationUseCase registrationUseCase;

  RegistrationCubit( this.registrationUseCase)
      : super(RegistrationInitial());

  Future<void> register(dynamic body) async {
    emit(RegistrationLoading());
    try {
      final result = await registrationUseCase.call(body);
      emit(RegistrationSuccess(result));
    } catch (e) {
      emit(RegistrationFailure(e.toString()));
    }
  }
}
