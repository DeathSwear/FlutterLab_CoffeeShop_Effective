import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';
import 'dart:async';

class SelectedProductsListBloc extends Bloc<SelectedProductsListEvent, List<CardModel>> {
  SelectedProductsListBloc(this.categoriesRepository) : super([]) {
    on<PostCategoriesList>(_post);
    on<AddToCategoriesList>(_add);
    on<ClearCategoriesList>(_clear);
    on<RemoveFromCategoriesList>(_remove);
  }

  void _add(AddToCategoriesList event, Emitter<List<CardModel>> emit) {
    List<CardModel> stateNew = state;
    stateNew.add(event.card);
    emit(stateNew);
    debugPrint(state.toString());
  }

  void _clear(ClearCategoriesList event, Emitter<List<CardModel>> emit) {
    List<CardModel> stateNew = [];
    emit(stateNew);
  }

  void _remove(RemoveFromCategoriesList event, Emitter<List<CardModel>> emit) {
    List<CardModel> stateNew = state;
    stateNew.remove(event.card);
    emit(stateNew);
    debugPrint(state.toString());
  }

  final AbstractMenuCategoriesAPI categoriesRepository;

  Future<void> _post(PostCategoriesList event, Emitter<List<CardModel>> emit) async {

  }

}

//
//events
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
