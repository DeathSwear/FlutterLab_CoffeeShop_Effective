import 'package:flutter_course/src/features/map/database/locations_database.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'dart:developer' as developer;
import 'package:flutter_course/src/repositories/map_locations/abstract_map_locations.dart';

class MapLocationsDataBase implements AbstractMapLocationsRepository {
  final LocationsDatabase LocationsDB = LocationsDatabase();

  @override
  Future<List<NamedLocation>> getLocations() async {
    developer.log('start getLocations', name: 'DB');
    List<LocationsItem> dbCategories =
        await LocationsDB.select(LocationsDB.locationsItems).get();

    List<NamedLocation> rawLocations = dbCategories.map((loc) {
      return NamedLocation(
        lat: loc.lat,
        long: loc.long,
        name: loc.addres,
      );
    }).toList();
    developer.log('return', name: 'DB');
    return rawLocations;
  }

  void saveLocations(List<NamedLocation> locationsToSave) async {
    await LocationsDB.delete(LocationsDB.locationsItems).go();
    locationsToSave.map((loc) async {
      developer.log('saving Category', name: 'DB');
      await LocationsDB.into(LocationsDB.locationsItems).insert(
        LocationsItemsCompanion.insert(
          lat: loc.lat,
          long: loc.long,
          addres: loc.name,
        ),
      );
      developer.log('Category saved', name: 'DB');
    });
  }
}
