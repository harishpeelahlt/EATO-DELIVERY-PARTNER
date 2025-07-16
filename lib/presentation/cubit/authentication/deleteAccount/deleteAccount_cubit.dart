import 'package:eato_delivery_partner/domain/usecase/authentication/deleteAccount_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'deleteAccount_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccountUseCase deleteAccountUseCase;

  DeleteAccountCubit(this.deleteAccountUseCase) : super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    try {
      final response = await deleteAccountUseCase();
      emit(DeleteAccountSuccess(response));
    } catch (e) {
      emit(DeleteAccountFailure(e.toString()));
    }
  }
}
