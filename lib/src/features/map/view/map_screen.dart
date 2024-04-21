import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/map/models/latlong_location.dart';
import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();
  final Location location = Location();

  Future<bool> _checkAndAskPermossion() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> _checkPermossion() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) return false;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) return false;

    return true;
  }

  Future<void> _start() async {
    LocationData _locationData;
    if (!await _checkAndAskPermossion()) return;
    _locationData = await location.getLocation();
    LatLongLocation _userLocation = LatLongLocation(
        lat: _locationData.latitude ?? 0, long: _locationData.longitude ?? 0);

    _moveToCurrentLocation(_userLocation);
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
          zoom: 12,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _start().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Текущее местоположение'),
      ),
      body: YandexMap(
        onMapCreated: (controller) {
          mapControllerCompleter.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, 'testText'); // Вернуться на экран MenuScreen
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
