part of 'selected_products_list_bloc.dart';

abstract class SelectedProductsListEvent {}

class PostCategoriesList extends SelectedProductsListEvent {}

class ClearCategoriesList extends SelectedProductsListEvent {}

class AddToCategoriesList extends SelectedProductsListEvent {
  AddToCategoriesList({required this.card});
  final CardModel card;
}

class RemoveFromCategoriesList extends SelectedProductsListEvent {
  RemoveFromCategoriesList({required this.card});
  final CardModel card;
}