import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/selected_products/selected_products_list_bloc.dart';
import 'package:flutter_course/src/features/menu/data/button_styles.dart';
import 'package:flutter_course/src/features/menu/data/text_styles.dart';
import 'package:flutter_course/src/features/menu/view/widgets/selected_product.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuBottomSheet extends StatefulWidget {
  const MenuBottomSheet({super.key});

  @override
  MenuBottomSheetState createState() => MenuBottomSheetState();
}

class MenuBottomSheetState extends State<MenuBottomSheet> {
  final _selectedProductsListBloc = GetIt.I<SelectedProductsListBloc>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      builder: (_, controller) => Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.bottomsheetTitle,
                    style: AppTextStyles.bottomsheetTitle,
                  ),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: TextButton(
                      onPressed: () {
                        _selectedProductsListBloc.add(ClearCategoriesList());
                        Navigator.pop(context);
                      },
                      style: AppButtonStyles.trashButtonStyle,
                      child: const Image(
                        image:
                            AssetImage('lib/src/assets/images/trash_image.png'),
                        height: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: BlocBuilder<SelectedProductsListBloc,
                  SelectedProductsListState>(
                bloc: _selectedProductsListBloc,
                builder: (context, state) {
                  return state.cards.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              SelectedProduct(data: state.cards[index]),
                          itemCount: state.cards.length,
                        )
                      : const SizedBox();
                },
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _selectedProductsListBloc
                      .add(PostCategoriesList(context: context));
                },
                style: AppButtonStyles.buttonStyle,
                child: Text(
                  AppLocalizations.of(context)!.bottomsheetMakeAnOrder,
                  style: AppTextStyles.bottomsheetMakeAnOrder,
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
