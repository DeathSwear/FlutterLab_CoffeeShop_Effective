import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';
import 'dart:async';

part 'products_list_event.dart';
part 'products_list_state.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductsListBloc(this.categoriesRepository) : super(ProductsListInitial()) {
    on<LoadProductsList>(_load);
  }

  final AbstractMenuCategoriesRepository categoriesRepository;
  int page = 0;
  bool stop = false;

  Future<void> _load(
    LoadProductsList event,
    Emitter<ProductsListState> emit,
  ) async {
    try {
      if (stop == false) {
        if (state is ProductsListInitial) {
          emit(ProductsListLoading());
          List<CardModel> productsList = await categoriesRepository
              .getProductsByCategoryList(event.categoryID, page);
          page++;
          List<CardModel> productsList2 = [];
          productsList2.addAll(productsList);
          emit(ProductsListLoaded(productsList: productsList));
        } else if (state is ProductsListLoaded) {
          final currentState = state as ProductsListLoaded;
          List<CardModel> newProductsList = await categoriesRepository
              .getProductsByCategoryList(event.categoryID, page);
          page++;
          List<CardModel> updatedProductsList =
              List.from(currentState.productsList)..addAll(newProductsList);
          emit(ProductsListLoaded(productsList: updatedProductsList));
          if (newProductsList.isEmpty) {
            stop = true;
          }
        }
      }
    } catch (e) {
      emit(ProductsListLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
