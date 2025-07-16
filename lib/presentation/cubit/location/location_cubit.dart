import 'package:eato_delivery_partner/components/custom_snackbar.dart';
import 'package:eato_delivery_partner/core/network/network_service.dart';
import 'package:eato_delivery_partner/domain/usecase/location/location_usecase.dart';
import 'package:eato_delivery_partner/presentation/cubit/location/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationUsecase usecase;
  final NetworkService networkService;
  final String apiKey = 'AIzaSyDRYGEGXZ3PBObX8dqhr6nJ3vzx58-Bjd4';
  final String key = 'AIzaSyDRYGEGXZ3PBObX8dqhr6nJ3vzx58-Bjd4';
  final String? latitude;

  LocationCubit(
      {required this.usecase, this.latitude, required this.networkService})
      : super(LocationInitial());

  Future<void> searchLocation(String text, context) async {
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
      emit(LocationLoading());
      try {
        final result = await usecase.call(text, apiKey);
        print(
            "Search Location Result: ${result.predictions?[0].placeId} status: ${result.status}");
        final responce =
            await usecase.latlang(result.predictions![0].placeId!, key);

        if (result.status == "OK") {
          print(
              'result of search loaction : ${result.predictions?[0].placeId}');
        }
        emit(LocationLoaded(model: result, latLangModel: responce));
      } catch (e) {
        emit(LocationFailure(message: e.toString()));
      }
    }
  }
}
