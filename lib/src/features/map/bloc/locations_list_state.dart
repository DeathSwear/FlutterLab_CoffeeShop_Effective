part of 'locations_list_bloc.dart';

class LocationsListState {}

class LocationsListInitial extends LocationsListState {}

class LocationsListLoading extends LocationsListState {}

class LocationsListLoaded extends LocationsListState {
  LocationsListLoaded({
    required this.locationsList,
  });
  final List<NamedLocation> locationsList;
}

class LocationsListLoadingFailure extends LocationsListState {
  LocationsListLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
