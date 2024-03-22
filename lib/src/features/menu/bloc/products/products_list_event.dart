part of 'products_list_bloc.dart';

abstract class ProductsListEvent {}

class LoadProductsList extends ProductsListEvent {
  LoadProductsList({
    required this.categoryID,
    this.completer,
  });
  final int categoryID;
  final Completer? completer;

}