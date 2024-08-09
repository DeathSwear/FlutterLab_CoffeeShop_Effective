import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'dart:developer' as developer;
import 'package:flutter_course/src/features/menu/models/tag_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';
import 'package:flutter_course/src/repositories/menu_categories/sources/menu_categories_api.dart';
import 'package:flutter_course/src/repositories/menu_categories/sources/menu_categories_database.dart';

class MenuCategoriesRepository implements AbstractMenuCategoriesRepository {
  MenuCategoriesRepository({
    required this.dio,
  }) {
    MenuCategories_API = MenuCategoriesAPI(dio: dio);
  }
  final Dio dio;
  late final MenuCategoriesAPI MenuCategories_API;
  final MenuCategories_DB = MenuCategoriesDataBase();

  @override
  Future<List<TagModel>> getCategoriesTagsList() async {
    developer.log('start getTags', name: 'REPO');

    List<TagModel> rawCategories = [];
    try {
      rawCategories = await MenuCategories_API.getCategoriesTagsList();
      MenuCategories_DB.saveCategoriesToDB(rawCategories);
    } catch (e) {
      developer.log('category error', name: 'REPO');
      rawCategories = await MenuCategories_DB.getCategoriesTagsList();
      if (rawCategories.length == 0) return throw Exception('nothing in DB');
    }
    developer.log('category return ', name: 'REPO');

    return rawCategories;
  }

  @override
  Future<List<CardModel>> getProductsByCategoryList(int id, int page) async {
    developer.log('start get ProductsByCategory', name: 'REPO');

    List<CardModel> productsByCategoryID = [];
    try {
      productsByCategoryID =
          await MenuCategories_API.getProductsByCategoryList(id, page);
      if (page == 0)
        MenuCategories_DB.saveProductsToDB(productsByCategoryID, id);
      else
        MenuCategories_DB.addProductsToDB(productsByCategoryID, id);
    } catch (e) {
      developer.log('get products error', name: 'REPO');
      productsByCategoryID =
          await MenuCategories_DB.getProductsByCategoryList(id, page);
    }
    developer.log('get products return ', name: 'REPO');
    return productsByCategoryID;
  }

  @override
  Future<bool> postProductsList(List<CardModel> cards) async {
    developer.log('Post Start', name: 'REPO');
    bool postResult = await MenuCategories_API.postProductsList(cards);
    return postResult;
  }
}
