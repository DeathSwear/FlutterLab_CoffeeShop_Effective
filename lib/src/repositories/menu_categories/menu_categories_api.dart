import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'package:flutter_course/src/features/menu/models/category_model.dart';
import 'dart:developer' as developer;

import 'package:flutter_course/src/features/menu/models/tag_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';


class MenuCategoriesAPI implements AbstractMenuCategoriesAPI{

  MenuCategoriesAPI({
    required this.dio,
  });
  final Dio dio;

  @override
  Future<void> getCategoriesList() async {

    developer.log('start get All', name: 'API');

    final Response<dynamic> categoriesResponse = await dio.get(
        'https://coffeeshop.academy.effective.band/api/v1/products/categories?page=0&limit=25');
    final body = categoriesResponse.data;
    final List<TagModel> rawCategories = List<TagModel>.from((body['data'] as List<dynamic>)
        .map((value) => TagModel(
          id: int.parse(value['id'].toString()),
          tag: value['slug'].toString(),
        )));

    List<CategoryModel> categoriesList = [];
    for (var p in rawCategories) {
      int id = p.id;
      String title = p.tag;
      Response<dynamic> productsResponse = await dio.get(
          'https://coffeeshop.academy.effective.band/api/v1/products?page=0&limit=50&category=$id');
      var body = productsResponse.data;
      List<CardModel> productsByCategoryID = List<CardModel>.from((body['data'] as List<dynamic>)
          .map((value) => CardModel(
        id: int.parse(value['id'].toString()),
        ico: value['imageUrl'].toString(),
        name: value['name'].toString(),
        description: value['description'].toString(),
        price: '100 руб',
      )));
      categoriesList.add(CategoryModel(title: title, card: productsByCategoryID));
    }
    debugPrint(categoriesList.toString());


  }

  @override
  Future<List<TagModel>> getCategoriesTagsList() async {

    developer.log('start getTags', name: 'API');

    final Response<dynamic> categoriesResponse = await dio.get(
        'https://coffeeshop.academy.effective.band/api/v1/products/categories?page=0&limit=25');
    final body = categoriesResponse.data;
    final List<TagModel> rawCategories = List<TagModel>.from((body['data'] as List<dynamic>)
        .map((value) => TagModel(
      id: int.parse(value['id'].toString()),
      tag: value['slug'].toString(),
    )));

    return rawCategories;
  }

  @override
  Future<List<CardModel>> getProductsByCategoryList(int id) async {

    developer.log('start get ProductsByCategory', name: 'API');

      Response<dynamic> productsResponse = await dio.get(
          'https://coffeeshop.academy.effective.band/api/v1/products?page=0&limit=50&category=$id');
      var body = productsResponse.data;
      List<CardModel> productsByCategoryID = List<CardModel>.from((body['data'] as List<dynamic>)
          .map((value) => CardModel(
        id: int.parse(value['id'].toString()),
        ico: value['imageUrl'].toString(),
        name: value['name'].toString(),
        description: value['description'].toString(),
        price: '100 руб',
      )));

    return productsByCategoryID;
  }

  @override
  Future<void> postProductsList() async {
    developer.log('Отправил данные!!!!!', name: 'API');
  }

}