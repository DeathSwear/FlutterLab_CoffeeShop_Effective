part of 'locations_list_bloc.dart';

abstract class LocationsListEvent {}

class LoadLocationsList extends LocationsListEvent {}

class SelectLocation extends LocationsListEvent {
  SelectLocation({required this.location});
  final NamedLocation location;
}
