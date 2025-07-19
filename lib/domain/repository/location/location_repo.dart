
import 'package:eato_delivery_partner/data/model/location/lattitude_longitude_model.dart';
import 'package:eato_delivery_partner/data/model/location/location_model.dart';

abstract class LocationRepository {
  Future<LocationSearchModel> LocationSearch(String input, String apiKey);
  Future<LatLangModel> LatlangSearch(String placeId, String key);
}