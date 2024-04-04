import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/database/categories_database.dart';
import 'package:flutter_course/src/features/menu/database/products_database.dart';
import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'dart:developer' as developer;
import 'package:flutter_course/src/features/menu/models/tag_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';

class MenuCategoriesDataBase implements AbstractMenuCategoriesAPI{

  final CategoriesDB = CategoriesDatabase();
  final ProductsDB = ProductsDatabase();

  void saveCategoriesToDB(List<TagModel> tags) async {
    tags.forEach((tag) async {
      await CategoriesDB.into(CategoriesDB.categoriesItems).insert(
        CategoriesItemsCompanion.insert(
          id: tag.id,
          tag: tag.tag,
        ),
      );
    });
  }

  void saveProductsToDB(List<CardModel> cards, int categoryID) async {
    cards.forEach((card) async {
      await ProductsDB.into(ProductsDB.productsItems).insert(
        ProductsItemsCompanion.insert(
            id: card.id,
            ico: card.ico,
            name: card.name,
            description: card.description,
            price: card.price.toString(),
            priceType: card.priceType,
            categoryID: categoryID,
        ),
      );
    });
  }

  @override
  Future<List<TagModel>> getCategoriesTagsList() async {
    developer.log('start getTags', name: 'DB');

    List<CategoriesItem> dbCategories = await CategoriesDB.select(CategoriesDB.categoriesItems).get();

    List<TagModel> rawCategories = dbCategories.map((category) {
      return TagModel(
          id: category.id,
          tag: category.tag,
      );
    }).toList();

    return rawCategories;
  }

  @override
  Future<List<CardModel>> getProductsByCategoryList(int id) async {

    developer.log('start get ProductsByCategory', name: 'DB');

    /*Future<List<ProductsItem>> getdbProducts() {
    return (ProductsDB.select(ProductsDB.productsItems)..where((p) => p.categoryID.equals(id))).get();
    }*/

    List<ProductsItem> dbProducts = await (ProductsDB.select(ProductsDB.productsItems)..where((p) => p.categoryID.equals(id))).get();

    List<CardModel> productsByCategoryID = dbProducts.map((product) {
      return CardModel(
        id: product.id,
        ico: product.ico,
        name: product.name,
        description: product.description,
        price: double.parse(product.price.toString()),
        priceType: product.priceType,
      );
    }).toList();

    return productsByCategoryID;
  }

  @override
  Future<bool> postProductsList(List<CardModel> cards) async {
    developer.log('Post Start', name: 'DB');
    return false;
  }

}