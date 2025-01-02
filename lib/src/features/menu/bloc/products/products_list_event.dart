part of 'products_list_bloc.dart';

abstract class ProductsListEvent {}

class LoadProductsList extends ProductsListEvent {
  LoadProductsList({
    required this.categoryID,
  });
  final int categoryID;
}
