import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/map/models/latlong_location.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/repositories/map_locations/abstract_map_locations.dart';
import 'package:location/location.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

part 'locations_list_event.dart';
part 'locations_list_state.dart';

class LocationsListBloc extends Bloc<LocationsListEvent, LocationsListState> {
  LocationsListBloc(this.mapLocationsRepository)
      : super(LocationsListInitial()) {
    on<LoadLocationsList>(_load);
    on<SelectLocation>(_select);
    on<GetPermissions>(_getPermissions);
  }

  final AbstractMapLocationsRepository mapLocationsRepository;

  List<NamedLocation> locationsList = [];

  Future<void> _load(
    LoadLocationsList event,
    Emitter<LocationsListState> emit,
  ) async {
    if (state is! LocationsListLoaded) {
      try {
        emit(LocationsListLoading());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        locationsList = await mapLocationsRepository.getLocations();
        String savedLocation = prefs.getString('UserLocation') ?? 'none';
        NamedLocation newSelectedLocation = locationsList.firstWhere(
          (element) => element.name == savedLocation,
          orElse: () => locationsList[0],
        );
        selectedLocation = newSelectedLocation;
        emit(LocationsListLoaded(locationsList: locationsList));
      } catch (e) {
        emit(LocationsListLoadingFailure(exception: e));
      }
    }
  }

  NamedLocation selectedLocation =
      const NamedLocation(name: 'Не выбрано', lat: 0, long: 0);

  Future<void> _select(
    SelectLocation event,
    Emitter<LocationsListState> emit,
  ) async {
    if (state is LocationsListLoaded) {
      emit(LocationsListLoading());
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('UserLocation', event.location.name);
      selectedLocation = event.location;
      emit(LocationsListLoaded(locationsList: locationsList));
    }
  }

  bool havePermissions = false;

  Future<void> _getPermissions(
    GetPermissions event,
    Emitter<LocationsListState> emit,
  ) async {
    if (state is LocationsListLoaded) {
      havePermissions = await _checkAndAskPermossion();

      LatLongLocation userLocation;
      if (havePermissions) {
        LocationData locationData;
        locationData = await location.getLocation();
        userLocation = LatLongLocation(
          lat: locationData.latitude ?? 0,
          long: locationData.longitude ?? 0,
        );
      } else {
        userLocation = LatLongLocation(
          lat: selectedLocation.lat,
          long: selectedLocation.long,
        );
      }
      await event.move(userLocation);
    }
  }

  final Location location = Location();
  Future<bool> _checkAndAskPermossion() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}
