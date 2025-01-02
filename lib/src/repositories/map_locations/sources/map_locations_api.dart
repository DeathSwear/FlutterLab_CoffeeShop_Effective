import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/repositories/map_locations/abstract_map_locations.dart';

class MapLocationsAPI implements AbstractMapLocationsRepository {
  MapLocationsAPI({
    required this.dio,
  });
  final Dio dio;

  @override
  Future<List<NamedLocation>> getLocations() async {
    Response<dynamic> categoriesResponse;
    List<NamedLocation> rawCategories = [];
    try {
      categoriesResponse = await dio.get(
        'https://coffeeshop.academy.effective.band/api/v1/locations/?page=0&limit=50',
      );
      final body = categoriesResponse.data;
      rawCategories = List<NamedLocation>.from(
        (body['data'] as List<dynamic>).map(
          (value) => NamedLocation(
            name: value['address'].toString(),
            lat: double.parse(value['lat'].toString()),
            long: double.parse(value['lng'].toString()),
          ),
        ),
      );
      return rawCategories;
    } catch (e) {
      rethrow;
    }
  }
}
