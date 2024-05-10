import 'package:flutter_course/src/features/map/models/named_location.dart';

abstract class AbstractMapLocationsRepository {
  Future<List<NamedLocation>> getLocations();
}
