import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/map/bloc/locations_list_bloc.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/features/menu/data/strings_data.dart';
import 'package:flutter_course/src/features/menu/data/text_styles.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import 'package:get_it/get_it.dart';

class ModalSheetView extends StatefulWidget {
  const ModalSheetView({
    super.key,
    required this.point,
  });

  final NamedLocation point;

  @override
  ModalSheetViewState createState() => ModalSheetViewState();
}

class ModalSheetViewState extends State<ModalSheetView> {
  static ButtonStyle button_style = ElevatedButton.styleFrom(
    elevation: 0,
    alignment: Alignment.center,
    backgroundColor: AppColors.mainColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.zero,
  );

  final locationsBloc = GetIt.I<LocationsListBloc>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 20, left: 8, right: 8),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 16),
              child: Text(
                widget.point.name,
                style: AppTextStyles.modalBSLocationsTitle,
              ),
            ),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  locationsBloc.add(SelectLocation(location: widget.point));
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: button_style,
                child: const Text(
                  AppStrings.bottomsheetConfirm,
                  style: AppTextStyles.bottomsheetMakeAnOrder,
                ),
              ),
            ),
          ]),
    );
  }
}
