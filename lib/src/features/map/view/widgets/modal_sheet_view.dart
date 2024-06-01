import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/map/bloc/locations_list_bloc.dart';
import 'package:flutter_course/src/features/map/models/named_location.dart';
import 'package:flutter_course/src/features/menu/data/button_styles.dart';
import 'package:flutter_course/src/features/menu/data/text_styles.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                Navigator.pop(context);
                Navigator.pop(context);
                locationsBloc.add(SelectLocation(location: widget.point));
              },
              style: AppButtonStyles.buttonStyle,
              child: Text(
                AppLocalizations.of(context)!.bottomsheetConfirm,
                style: AppTextStyles.bottomsheetMakeAnOrder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
