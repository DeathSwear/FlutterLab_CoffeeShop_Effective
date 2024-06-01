import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/src/app.dart';
import 'package:flutter_course/src/features/map/bloc/locations_list_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/categories/categories_list_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/selected_products/selected_products_list_bloc.dart';
import 'package:flutter_course/src/repositories/map_locations/map_locations_repository.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';
import 'package:flutter_course/src/repositories/menu_categories/menu_categories_repository.dart';
import 'package:flutter_course/src/repositories/messaging/firebase_api.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  GetIt.I.registerLazySingleton<FirebaseAPI>(
    () => FirebaseAPI(),
  );
  FirebaseAPI fapi = GetIt.I<FirebaseAPI>();
  await fapi.initNotifications();

  GetIt.I.registerLazySingleton<AbstractMenuCategoriesRepository>(
    () => MenuCategoriesRepository(dio: Dio()),
  );

  GetIt.I.registerLazySingleton<CategoriesListBloc>(
    () => CategoriesListBloc(GetIt.I<AbstractMenuCategoriesRepository>()),
  );
  GetIt.I.registerLazySingleton<SelectedProductsListBloc>(
    () => SelectedProductsListBloc(GetIt.I<AbstractMenuCategoriesRepository>()),
  );
  GetIt.I.registerLazySingleton<LocationsListBloc>(
    () => LocationsListBloc(MapLocationsRepository(dio: Dio())),
  );

  runZonedGuarded(() => runApp(const CoffeeShopApp()), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
