import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/repositories/map_locations/abstract_map_locations.dart';
import 'package:flutter_course/src/repositories/map_locations/sources/map_locations_api.dart';
import 'package:flutter_course/src/repositories/map_locations/sources/map_locations_db.dart';

class MapLocationsRepository implements AbstractMapLocationsRepository {
  MapLocationsRepository({
    required this.dio,
  }) {
    MapLocations_API = MapLocationsAPI(dio: dio);
  }
  final Dio dio;
  late final MapLocationsAPI MapLocations_API;
  final MapLocations_DB = MapLocationsDataBase();

  @override
  Future<List<NamedLocation>> getLocations() async {
    List<NamedLocation> rawLocations = [];
    try {
      rawLocations = await MapLocations_API.getLocations();
      MapLocations_DB.saveLocations(rawLocations);
    } catch (e) {
      rawLocations = await MapLocations_DB.getLocations();
      if (rawLocations.isEmpty) return throw Exception('nothing in DB');
    }
    return rawLocations;
  }
}
