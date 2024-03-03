import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/category.dart';
import 'package:flutter_course/src/theme/app_colors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            title: Text('test'),
            backgroundColor: theme.primaryColor,
            surfaceTintColor: Colors.transparent,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight((40)),
              child: Text('test'),
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.only(left: 16),
              sliver: SliverList.builder(itemBuilder: (context, index) => Category()),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: (){},
      )
    );
  }

}