import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/data/text_styles.dart';
import 'package:flutter_course/src/features/menu/models/category_model.dart';
import 'package:flutter_course/src/features/menu/view/widgets/category.dart';
import 'package:flutter_course/src/repositories/menu_categories/menu_categories_api.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_course/src/features/menu/data/data_example.dart';

import 'dart:developer' as developer;
class MenuScreen extends StatefulWidget {

  @override
  _MenuScreenState createState() => _MenuScreenState();
}
class _MenuScreenState extends State<MenuScreen> {

  final itemListener = ItemPositionsListener.create();

  bool playingAnimation = false;
  int current = 0;
  void setCurrent(int newCurrent) {
      setState(() {
        current = newCurrent;
      });
  }

  final itemController = ItemScrollController();
  scrollToItem(int ind) async {
    playingAnimation = true;
    itemController.scrollTo(
        index: ind,
      duration: const Duration(milliseconds: 200)
    );
    await Future.delayed(const Duration(milliseconds: 200));
    playingAnimation = false;
  }

  final barItemController = ItemScrollController();
  barScrollToItem(int ind) async {
    barItemController.scrollTo(
        index: ind,
        duration: const Duration(milliseconds: 120)
    );
  }

  bool onBottom = false;

  @override
  void initState() {
    super.initState();
    itemListener.itemPositions.addListener(() {
      final fullVisible = itemListener.itemPositions.value
          .where((item) {
            final isTopVisible = item.itemLeadingEdge >= 0;
            final isBottomVisible = item.itemTrailingEdge < 1.02;
            return isTopVisible && isBottomVisible;
      }).map((item) => item.index).toList();

      if(fullVisible.length == 2) {
        if ((fullVisible[1] == DataExample.category_strings_db_example.length - 1) &&
            playingAnimation != true) {
          if(fullVisible[1] != current)
            {
              onBottom = true;
              setCurrent(fullVisible[1]);
              barScrollToItem(fullVisible[1]);
            }
        }
        else onBottom = false;
      }
      else onBottom = false;

      if(((fullVisible[0] != current) && playingAnimation != true) && onBottom == false) {
        setCurrent(fullVisible[0]);
        barScrollToItem(fullVisible[0]);
      }

      developer.log('(итого): $fullVisible', name: 'top-bot');
      developer.log('curr: $current', name: 'curr');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: PreferredSize(
          preferredSize: const Size.fromHeight((60)),
          child: SizedBox(
            height: 60,
            child: ScrollablePositionedList.separated(
              scrollDirection: Axis.horizontal,
              itemScrollController: barItemController,
              separatorBuilder: (context, _) => SizedBox(width: 16),
              itemCount: DataExample.category_strings_db_example.length,
              itemBuilder: (context, index) =>
                  Container(
                    height: 32,
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => {
                        setCurrent(index),
                        scrollToItem(index),
                        barScrollToItem(index)
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        alignment: Alignment.center,
                        backgroundColor: index == current? AppColors.mainColor : AppColors.white,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      ),
                      child: Text(
                        DataExample.category_strings_db_example[index],
                        style: index == current? AppTextStyles.chipActive : AppTextStyles.chip,
                      ),
                    ),
                  ),
            ),
          )
        ),
      ),
      body: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ScrollablePositionedList.separated(
                separatorBuilder: (context, _) => SizedBox(height: 16),
                itemCount: DataExample.category_db_example.length,
                itemScrollController: itemController,
                itemPositionsListener: itemListener,
                itemBuilder: (context, index) => Category(
                  data: DataExample.category_db_example[index],
                  key: ValueKey(DataExample.category_db_example[index].title),
                  ),
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { MenuCategoriesAPI().getCategoriesList(); },
        child: const Icon(Icons.download),
      ),
          );
  }

}