import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/categories/categories_list_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/products/products_list_bloc.dart';
import 'package:flutter_course/src/features/menu/models/tag_model.dart';
import 'package:flutter_course/src/features/menu/view/widgets/coffee_card.dart';
import 'package:flutter_course/src/features/menu/data/text_styles.dart';
import 'package:flutter_course/src/repositories/menu_categories/abstract_categories.dart';
import 'package:get_it/get_it.dart';

class Category extends StatefulWidget {
  const Category({super.key, required this.data});

  final TagModel data;
  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<Category> {
  final _productsListBloc =
      ProductsListBloc(GetIt.I<AbstractMenuCategoriesRepository>());
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _productsListBloc.add(LoadProductsList(categoryID: widget.data.id));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      _productsListBloc.add(LoadProductsList(categoryID: widget.data.id));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void deleteThisCategory() {
    final _categoriesListBloc = GetIt.I<CategoriesListBloc>();
    _categoriesListBloc.add(DeleteCategory(tag: widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16),
          child: Text(
            widget.data.tag,
            style: AppTextStyles.title,
          ),
        ),
        SizedBox(
          height: 200,
          child: BlocBuilder<ProductsListBloc, ProductsListState>(
            bloc: _productsListBloc,
            builder: (context, state) {
              if (state is ProductsListLoaded) {
                if (state.productsList.isEmpty) deleteThisCategory();
                return ListView.separated(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => index == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: CoffeeCard(data: state.productsList[index]),
                        )
                      : CoffeeCard(data: state.productsList[index]),
                  separatorBuilder: (context, _) => const SizedBox(width: 16),
                  itemCount: state.productsList.length,
                );
              }
              return const SizedBox(height: 180);
            },
          ),
        ),
      ],
    );
  }
}
