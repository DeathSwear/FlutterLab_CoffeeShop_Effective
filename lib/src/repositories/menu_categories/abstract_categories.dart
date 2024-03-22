import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'package:flutter_course/src/features/menu/models/tag_model.dart';

abstract class AbstractMenuCategoriesAPI {
  Future<void> getCategoriesList();
  Future<List<TagModel>> getCategoriesTagsList();
  Future<List<CardModel>> getProductsByCategoryList(int id);
  Future<void> postProductsList();
}