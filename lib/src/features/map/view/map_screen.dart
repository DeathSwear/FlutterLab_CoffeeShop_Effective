import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/map/bloc/locations_list_bloc.dart';
import 'package:flutter_course/src/features/map/models/latlong_location.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/features/map/view/map_list_screen.dart';
import 'package:flutter_course/src/features/map/view/widgets/modal_sheet_view.dart';
import 'package:flutter_course/src/features/menu/data/button_styles.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static BoxDecoration boxDecorationStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: const Offset(1, 2),
      ),
    ],
  );

  final mapControllerCompleter = Completer<YandexMapController>();
  final Location location = Location();

  bool havePermissions = false;

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
    havePermissions = true;
    return true;
  }

  Future<void> _start() async {
    LocationData locationData;
    if (!await _checkAndAskPermossion()) return;
    locationData = await location.getLocation();
    LatLongLocation userLocation = LatLongLocation(
      lat: locationData.latitude ?? 0,
      long: locationData.longitude ?? 0,
    );
    _moveToCurrentLocation(userLocation);
  }

  Future<void> _moveToCurrentLocation(
    LatLongLocation appLatLong,
  ) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 22,
        ),
      ),
    );
  }

  List<PlacemarkMapObject> _getPlacemarkObjects(
    BuildContext context,
    List<NamedLocation> locations,
  ) {
    List<PlacemarkMapObject> mapPoints = locations
        .map(
          (point) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject ${point.name}'),
            point: Point(latitude: point.lat, longitude: point.long),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  'lib/src/assets/images/point.png',
                ),
                scale: 2,
              ),
            ),
            onTap: (_, __) => showModalBottomSheet(
              context: context,
              builder: (context) => ModalSheetView(
                point: point,
              ),
            ),
          ),
        )
        .toList();
    return mapPoints;
  }

  final locationsBloc = GetIt.I<LocationsListBloc>();

  @override
  void initState() {
    super.initState();
    _start().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationsListBloc, LocationsListState>(
        bloc: locationsBloc,
        builder: (context, state) {
          if (state is LocationsListLoaded) {
            if (!havePermissions) {
              _moveToCurrentLocation(
                LatLongLocation(
                  lat: locationsBloc.selectedLocation.lat,
                  long: locationsBloc.selectedLocation.long,
                ),
              );
            }
            return YandexMap(
              onMapCreated: (controller) {
                mapControllerCompleter.complete(controller);
              },
              mapObjects: _getPlacemarkObjects(context, state.locationsList),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: boxDecorationStyle,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: AppButtonStyles.mapActionButtonStyle,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 48,
              width: 48,
              decoration: boxDecorationStyle,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapListScreen(),
                  ),
                ),
                style: AppButtonStyles.mapActionButtonStyle,
                child: const Icon(
                  Icons.map_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
