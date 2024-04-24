import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/map/bloc/locations_list_bloc.dart';
import 'package:flutter_course/src/features/menu/data/strings_data.dart';
import 'package:flutter_course/src/features/menu/data/text_styles.dart';
import 'package:flutter_course/src/repositories/map_locations/abstract_map_locations.dart';
import 'package:get_it/get_it.dart';

class MapListScreen extends StatefulWidget {
  const MapListScreen({Key? key}) : super(key: key);

  @override
  State<MapListScreen> createState() => _MapListScreenState();
}

class _MapListScreenState extends State<MapListScreen> {
  final locationsBloc = GetIt.I<LocationsListBloc>();
  //LocationsListBloc(GetIt.I<AbstractMapLocationsRepository>());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.modalLocationsTitle,
          style: AppTextStyles.modalLocationsTitle,
        ),
      ),
      body: BlocBuilder<LocationsListBloc, LocationsListState>(
        bloc: locationsBloc,
        builder: (context, state) {
          if (state is LocationsListLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(state.locationsList[index].name),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20,
                ),
                onTap: () {
                  locationsBloc.add(
                      SelectLocation(location: state.locationsList[index]));
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              itemCount: state.locationsList.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
