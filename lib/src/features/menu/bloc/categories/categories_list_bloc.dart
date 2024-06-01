import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/models/tag_model.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';
import 'dart:async';

part 'categories_list_event.dart';
part 'categories_list_state.dart';

class CategoriesListBloc
    extends Bloc<CategoriesListEvent, CategoriesListState> {
  CategoriesListBloc(this.categoriesRepository)
      : super(CategoriesListInitial()) {
    on<LoadCategoriesList>(_load);
    on<DeleteCategory>(_deleteCategory);
  }

  final AbstractMenuCategoriesRepository categoriesRepository;
  List<TagModel> tags = [];

  Future<void> _load(
    LoadCategoriesList event,
    Emitter<CategoriesListState> emit,
  ) async {
    try {
      if (state is! CategoriesListLoaded) {
        emit(CategoriesListLoading());
      }
      tags = await categoriesRepository.getCategoriesTagsList();
      emit(CategoriesListLoaded(tagsList: tags));
    } catch (e) {
      emit(CategoriesListLoadingFailure(exception: e));
    }
  }

  Future<void> _deleteCategory(
    DeleteCategory event,
    Emitter<CategoriesListState> emit,
  ) async {
    tags.remove(event.tag);
    emit(CategoriesListLoaded(tagsList: tags));
  }
}
