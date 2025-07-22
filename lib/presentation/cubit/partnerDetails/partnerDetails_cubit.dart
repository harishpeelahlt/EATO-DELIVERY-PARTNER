import 'package:eato_delivery_partner/domain/usecase/partnerDetails/partnerDetails_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'partnerDetails_state.dart';

class PartnerDetailsCubit extends Cubit<PartnerDetailsState> {
  final PartnerDetailsUseCase getPartnerDetailsUseCase;

  PartnerDetailsCubit( this.getPartnerDetailsUseCase)
      : super(PartnerDetailsInitial());

  Future<void> fetchPartnerDetails() async {
    emit(PartnerDetailsLoading());
    try {
      final result = await getPartnerDetailsUseCase.execute();
      emit(PartnerDetailsLoaded(result));
    } catch (e) {
      emit(PartnerDetailsError(e.toString()));
    }
  }
}
