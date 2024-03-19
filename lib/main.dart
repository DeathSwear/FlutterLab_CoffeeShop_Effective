import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/src/app.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';
import 'package:flutter_course/src/repositories/menu_categories/menu_categories_api.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractMenuCategoriesAPI>(() => MenuCategoriesAPI(dio: Dio()));
  runZonedGuarded(() => runApp(const CoffeeShopApp()), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  }); // feature/lab-1_menu_screen branch
}
