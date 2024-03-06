import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/category.dart';
import 'package:flutter_course/src/features/menu/view/widgets/nav_category.dart';
import 'package:flutter_course/src/theme/app_colors.dart';

import 'package:flutter_course/src/features/menu/data/data_example.dart';
class MenuScreen extends StatefulWidget {

  @override
  _MenuScreenState createState() => _MenuScreenState();
}
class _MenuScreenState extends State<MenuScreen> {

  /*Future scrollToItem() async {
    final context = 'НеКофе';
    await Scrollable.ensureVisible(context);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            title: PreferredSize(
              preferredSize: const Size.fromHeight((60)),
              child: NavCategory(tags: DataExample.category_strings_db_example, current: 0),
            ),
            backgroundColor: AppColors.white,
            surfaceTintColor: Colors.transparent,
          ),
          SliverPadding(
              padding: const EdgeInsets.only(left: 16),
              sliver:  SliverList.builder(
                  itemBuilder: (context, index) => Category(
                      data: DataExample.category_db_example[index],
                      key: ValueKey(DataExample.category_db_example[index].title),
                  ),
                  itemCount: DataExample.category_db_example.length,
              ),
          )
        ],
      )
    );
  }

}