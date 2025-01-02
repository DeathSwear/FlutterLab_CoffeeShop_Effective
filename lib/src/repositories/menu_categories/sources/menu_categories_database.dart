import 'package:flutter_course/src/features/menu/database/categories_database.dart';
import 'package:flutter_course/src/features/menu/database/products_database.dart';
import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'package:flutter_course/src/features/menu/models/tag_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';

class MenuCategoriesDataBase implements AbstractMenuCategoriesRepository {
  final CategoriesDatabase CategoriesDB = CategoriesDatabase();
  final ProductsDatabase ProductsDB = ProductsDatabase();

  void saveCategoriesToDB(List<TagModel> tags) async {
    await CategoriesDB.delete(CategoriesDB.categoriesItems).go();
    for (TagModel tag in tags) {
      await CategoriesDB.into(CategoriesDB.categoriesItems).insert(
        CategoriesItemsCompanion.insert(
          id: tag.id,
          tag: tag.tag,
        ),
      );
    }
  }

  void saveProductsToDB(List<CardModel> cards, int categoryID) async {
    await (ProductsDB.delete(ProductsDB.productsItems)
          ..where((t) => t.categoryID.equals(categoryID)))
        .go();
    for (CardModel card in cards) {
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
    }
  }

  void addProductsToDB(List<CardModel> cards, int categoryID) async {
    for (CardModel card in cards) {
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
    }
  }

  @override
  Future<List<TagModel>> getCategoriesTagsList() async {
    List<CategoriesItem> dbCategories =
        await CategoriesDB.select(CategoriesDB.categoriesItems).get();
    List<TagModel> rawCategories = dbCategories.map((category) {
      return TagModel(
        id: category.id,
        tag: category.tag,
      );
    }).toList();
    return rawCategories;
  }

  @override
  Future<List<CardModel>> getProductsByCategoryList(int id, int page) async {
    List<ProductsItem> dbProducts =
        await (ProductsDB.select(ProductsDB.productsItems)
              ..limit(6, offset: page * 6)
              ..where((p) => p.categoryID.equals(id)))
            .get();

    if (dbProducts.isEmpty) return [];

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
    return false;
  }
}
