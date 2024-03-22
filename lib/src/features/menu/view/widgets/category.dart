import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/models/category_model.dart';
import 'package:flutter_course/src/features/menu/view/widgets/coffee_card.dart';
import 'package:flutter_course/src/features/menu/data/text_styles.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.data});

  final CategoryModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    data.title,
                    style: AppTextStyles.title,
                  ),
              ),
              SizedBox(
                height: 200,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CoffeeCard(data: data.card[index]),
                    separatorBuilder: (context, _) => SizedBox(width: 16),
                    itemCount: data.card.length
                ),
              )

            ],
          ),
    );

  }
}
