import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/coffe_card.dart';

import 'package:flutter_course/src/features/menu/data/text_styles.dart';

class Category extends StatelessWidget {
  const Category({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Черный кофе',
                style: AppTextStyles.title,
              ),
              SizedBox(
                height: 200,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CoffeCard(),
                    separatorBuilder: (context, _) => SizedBox(width: 16),
                    itemCount: 6
                ),
              )

            ],
          ),
    );

  }
}
