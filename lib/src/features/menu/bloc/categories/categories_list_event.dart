part of 'categories_list_bloc.dart';

abstract class CategoriesListEvent {}

class LoadCategoriesList extends CategoriesListEvent {}

class DeleteCategory extends CategoriesListEvent {
  DeleteCategory({
    required this.tag,
  });
  TagModel tag;
}
