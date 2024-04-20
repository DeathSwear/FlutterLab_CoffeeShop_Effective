import 'package:flutter_course/src/features/menu/database/categories_database.dart';
import 'package:flutter_course/src/features/menu/database/products_database.dart';
import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'dart:developer' as developer;
import 'package:flutter_course/src/features/menu/models/tag_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';
import 'package:get_it/get_it.dart';

class MenuCategoriesDataBase implements AbstractMenuCategoriesRepository {
  final CategoriesDatabase CategoriesDB = GetIt.I<CategoriesDatabase>();
  final ProductsDatabase ProductsDB = GetIt.I<ProductsDatabase>();

  void saveCategoriesToDB(List<TagModel> tags) async {
    await CategoriesDB.delete(CategoriesDB.categoriesItems).go();
    tags.forEach((tag) async {
      developer.log('saving Category', name: 'DB');
      //await CategoriesDB.update(CategoriesDB.categoriesItems).write(
      await CategoriesDB.into(CategoriesDB.categoriesItems).insert(
        CategoriesItemsCompanion.insert(
          id: tag.id,
          tag: tag.tag,
        ),
      );
      developer.log('Category saved', name: 'DB');
    });
  }

  void saveProductsToDB(List<CardModel> cards, int categoryID) async {
    await (ProductsDB.delete(ProductsDB.productsItems)
          ..where((t) => t.categoryID.equals(categoryID)))
        .go();
    cards.forEach((card) async {
      developer.log('saving Product', name: 'DB');
      await ProductsDB.into(ProductsDB.productsItems).insert(
        ProductsItemsCompanion.insert(
          id: card.id,
          ico: card.ico,
          productName: card.name,
          description: card.description,
          price: card.price.toString(),
          priceType: card.priceType,
          categoryID: categoryID,
        ),
      );
      developer.log('Product saved', name: 'DB');
    });
  }

  @override
  Future<List<TagModel>> getCategoriesTagsList() async {
    developer.log('start getTags', name: 'DB');

    List<CategoriesItem> dbCategories =
        await CategoriesDB.select(CategoriesDB.categoriesItems).get();

    List<TagModel> rawCategories = dbCategories.map((category) {
      return TagModel(
        id: category.id,
        tag: category.tag,
      );
    }).toList();
    developer.log('return', name: 'DB');
    return rawCategories;
  }

  @override
  Future<List<CardModel>> getProductsByCategoryList(int id, int page) async {
    developer.log('start get ProductsByCategory', name: 'DB');

    /*Future<List<ProductsItem>> getdbProducts() {
    return (ProductsDB.select(ProductsDB.productsItems)..where((p) => p.categoryID.equals(id))).get();
    }*/

    List<ProductsItem> dbProducts =
        await (ProductsDB.select(ProductsDB.productsItems)
              ..where((p) => p.categoryID.equals(id)))
            .get();

    List<CardModel> productsByCategoryID = dbProducts.map((product) {
      return CardModel(
        id: product.id,
        ico: product.ico,
        name: product.productName,
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
