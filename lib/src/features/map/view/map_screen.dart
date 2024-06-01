import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/map/bloc/locations_list_bloc.dart';
import 'package:flutter_course/src/features/map/models/latlong_location.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/features/map/view/map_list_screen.dart';
import 'package:flutter_course/src/features/map/view/widgets/map_object.dart';
import 'package:flutter_course/src/features/menu/data/button_styles.dart';
import 'package:get_it/get_it.dart';
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
  late final YandexMapController _mapController;
  final mapControllerCompleter = Completer<YandexMapController>();

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
          zoom: 16,
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
          (point) =>
              AppMapObject(point: point, context: context).getPlacemarkObject(),
        )
        .toList();
    return mapPoints;
  }

  final locationsBloc = GetIt.I<LocationsListBloc>();

  @override
  void initState() {
    super.initState();
    locationsBloc.add(GetPermissions(move: _moveToCurrentLocation));
  }

  ClusterizedPlacemarkCollection _getClusterizedCollection({
    required List<PlacemarkMapObject> placemarks,
  }) {
    return ClusterizedPlacemarkCollection(
        mapId: const MapObjectId('clusterized-1'),
        placemarks: placemarks,
        radius: 50,
        minZoom: 15,
        onClusterAdded: (self, cluster) async {
          return cluster.copyWith(
            appearance: cluster.appearance.copyWith(
              opacity: 1.0,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                    'lib/src/assets/images/points.png',
                  ),
                  scale: 2,
                ),
              ),
            ),
          );
        },
        onClusterTap: (self, cluster) async {
          await _mapController.moveCamera(
            animation: const MapAnimation(
                type: MapAnimationType.linear, duration: 0.3),
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: cluster.placemarks.first.point,
                zoom: _mapZoom + 1,
              ),
            ),
          );
        });
  }

  double _mapZoom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationsListBloc, LocationsListState>(
        bloc: locationsBloc,
        builder: (context, state) {
          return YandexMap(
            onCameraPositionChanged: (cameraPosition, _, __) {
              setState(() {
                _mapZoom = cameraPosition.zoom;
              });
            },
            onMapCreated: (controller) {
              mapControllerCompleter.complete(controller);
              _mapController = controller;
            },
            mapObjects: [
              _getClusterizedCollection(
                placemarks: state is LocationsListLoaded
                    ? _getPlacemarkObjects(context, state.locationsList)
                    : [],
              ),
            ],
          );
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
