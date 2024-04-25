import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/repositories/map_locations/abstract_map_locations.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

part 'locations_list_event.dart';
part 'locations_list_state.dart';

class LocationsListBloc extends Bloc<LocationsListEvent, LocationsListState> {
  LocationsListBloc(this.mapLocationsRepository)
      : super(LocationsListInitial()) {
    on<LoadLocationsList>(_load);
    on<SelectLocation>(_select);
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
}
