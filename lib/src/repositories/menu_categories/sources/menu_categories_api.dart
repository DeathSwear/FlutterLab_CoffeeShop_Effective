import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'dart:developer' as developer;
import 'package:flutter_course/src/features/menu/models/tag_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';

class MenuCategoriesAPI implements AbstractMenuCategoriesRepository{

  MenuCategoriesAPI({
    required this.dio,
  });
  final Dio dio;

  /*@override
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


  }*/

  @override
  Future<List<TagModel>> getCategoriesTagsList() async {
    developer.log('start getTags', name: 'API');
    Response<dynamic> categoriesResponse;
    List<TagModel> rawCategories = [];
    try{
      categoriesResponse = await dio.get(
        'https://coffeeshop.academy.effective.band/api/v1/products/categories?page=0&limit=25',);
      final body = categoriesResponse.data;
      rawCategories = List<TagModel>.from((body['data'] as List<dynamic>)
          .map((value) => TagModel(
        id: int.parse(value['id'].toString()),
        tag: value['slug'].toString(),
      ),),);
      developer.log('category return', name: 'API');
      return rawCategories;
    } catch(e){
      developer.log('category error, rethrow', name: 'API');
      rethrow;
    }
  }

  @override
  Future<List<CardModel>> getProductsByCategoryList(int id) async {
    developer.log('start get ProductsByCategory', name: 'API');
    Response<dynamic> productsResponse;
    List<CardModel> productsByCategoryID = [];
    try{
      productsResponse = await dio.get(
        'https://coffeeshop.academy.effective.band/api/v1/products?page=0&limit=50&category=$id',);
      var body = productsResponse.data;
      productsByCategoryID = List<CardModel>.from((body['data'] as List<dynamic>)
          .map((value) => CardModel(
        id: int.parse(value['id'].toString()),
        ico: value['imageUrl'].toString(),
        name: value['name'].toString(),
        description: value['description'].toString(),
        price: double.parse(value['prices'][0]['value'].toString()),
        priceType: '₽',
      ),),);
      developer.log('getProductsByCategory return', name: 'API');
      return productsByCategoryID;
    } catch(e) {
      developer.log('product error, rethrow', name: 'API');
      rethrow;
    }
  }

  @override
  Future<bool> postProductsList(List<CardModel> cards) async {
    developer.log('Post Start', name: 'API');
    Map<String, dynamic> requestBody = {
      'positions': {},
      'token': '',
    };


    Map<String, int> cardCountMap = {};
    for (var card in cards) {
      if (cardCountMap.containsKey(card.id)) {
        cardCountMap[card.id.toString()] = (cardCountMap[card.id] ?? 0) + 1;
      } else {
        cardCountMap[card.id.toString()] = 1;
      }
    }

    for (var entry in cardCountMap.entries) {
      requestBody['positions'][entry.key] = entry.value;
    }
    try {
      Response response = await dio.post(
        'https://coffeeshop.academy.effective.band/api/v1/orders/',
        data: jsonEncode(requestBody),
        options: Options(
          contentType: 'application/json',
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }

  }

}