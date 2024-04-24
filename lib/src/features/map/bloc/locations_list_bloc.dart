import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/repositories/map_locations/abstract_map_locations.dart';
import 'dart:async';

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
    try {
      if (state is! LocationsListLoaded) {
        emit(LocationsListLoading());
      }
      locationsList = await mapLocationsRepository.getLocations();
      emit(LocationsListLoaded(locationsList: locationsList));
    } catch (e) {
      emit(LocationsListLoadingFailure(exception: e));
    }
  }

  NamedLocation selectedLocation =
      NamedLocation(name: 'Не выбрано', lat: 0, long: 0);

  Future<void> _select(
    SelectLocation event,
    Emitter<LocationsListState> emit,
  ) async {
    if (state is LocationsListLoaded) {
      selectedLocation = event.location;
      emit(LocationsListLoaded(locationsList: locationsList));
    }
  }
}
