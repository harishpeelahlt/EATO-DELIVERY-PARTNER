import 'dart:convert';
import 'package:eato_delivery_partner/data/model/authentication/location/lattitude_longitude_model.dart';
import 'package:eato_delivery_partner/data/model/authentication/location/location_model.dart';
import 'package:http/http.dart' as http;


abstract class LocationRemoteDataSource {
  Future<LocationSearchModel> LocationSearch(String input, String apiKey);
  Future<LatLangModel> LatlangSearch(String placeId, String key);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final http.Client client;

  LocationRemoteDataSourceImpl({required this.client});

  @override
  Future<LocationSearchModel> LocationSearch(input, apiKey) async {
    try {
      final response = await client.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('responce of  LocationSearchModel:: ${response.body}');
        return LocationSearchModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load LocationSearchModel: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load LocationSearchModel: ${e.toString()}');
    }
  }

  @override
  Future<LatLangModel> LatlangSearch(placeId, key) async {
    try {
      final response = await client.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=$key'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('responce of  LocationSearchModel:: ${response.body}');
        return LatLangModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load LocationSearchModel: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load LocationSearchModel: ${e.toString()}');
    }
  }
}
