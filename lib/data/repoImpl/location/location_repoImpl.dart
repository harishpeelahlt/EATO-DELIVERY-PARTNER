
import 'package:eato_delivery_partner/data/dataSource/location/location_remotedatasource.dart';
import 'package:eato_delivery_partner/data/model/location/lattitude_longitude_model.dart';
import 'package:eato_delivery_partner/data/model/location/location_model.dart';
import 'package:eato_delivery_partner/domain/repository/location/location_repo.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final LocationRemoteDataSource latLangRemoteDataSource;

  LocationRepositoryImpl(
      {required this.remoteDataSource, required this.latLangRemoteDataSource});

  @override
  Future<LocationSearchModel> LocationSearch(
      String input, String apiKey) async {
    final model = await remoteDataSource.LocationSearch(input, apiKey);
    return LocationSearchModel(
      predictions: model.predictions
          ?.map((prediction) => Predictions(
                description: prediction.description,
                matchedSubstrings: prediction.matchedSubstrings,
                placeId: prediction.placeId,
                reference: prediction.reference,
                structuredFormatting: prediction.structuredFormatting,
                terms: prediction.terms,
                types: prediction.types,
              ))
          .toList(),
      status: model.status,
    );
  }

  @override
  Future<LatLangModel> LatlangSearch(String placeId, String key) async {
    final model = await remoteDataSource.LatlangSearch(placeId, key);
    return LatLangModel(
      status: model.status,
      results: model.results
          ?.map((result) => Results(
                addressComponents: result.addressComponents,
                formattedAddress: result.formattedAddress,
                geometry: result.geometry,
                placeId: result.placeId,
                types: result.types,
              ))
          .toList(),
    );
  }
}
