import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/features/map/view/widgets/modal_sheet_view.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class AppMapObject {
  const AppMapObject({
    required this.point,
    required this.context,
  });

  final NamedLocation point;
  final BuildContext context;
  PlacemarkMapObject getPlacemarkObject() {
    return PlacemarkMapObject(
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
    );
  }
}
