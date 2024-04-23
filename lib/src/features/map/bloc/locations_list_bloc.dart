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
  }

  final AbstractMapLocationsRepository mapLocationsRepository;

  Future<void> _load(
    LoadLocationsList event,
    Emitter<LocationsListState> emit,
  ) async {
    try {
      if (state is! LocationsListLoaded) {
        emit(LocationsListLoading());
      }
      final locationsList = await mapLocationsRepository.getLocations();
      emit(LocationsListLoaded(locationsList: locationsList));
    } catch (e) {
      emit(LocationsListLoadingFailure(exception: e));
    }
  }
}
