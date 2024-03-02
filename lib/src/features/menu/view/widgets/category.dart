import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/coffe_card.dart';

class Category extends StatelessWidget {
  const Category({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Черный кофе'),
              CoffeCard()
            ],
          ),
    );

  }
}
