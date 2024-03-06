import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'package:flutter_course/src/features/menu/models/category_model.dart';

class DataExample{
  static List<CardModel> cards_db_example =
      [
        const CardModel(
            ico: 'lib/src/assets/images/rrr.png',
            name: 'Айс Кофе',
            price: '100 руб'
        ),
        const CardModel(
            ico: 'lib/src/assets/images/rrr.png',
            name: 'Айс Кофе2',
            price: '120 руб'
        ),
        const CardModel(
            ico: 'lib/src/assets/images/rrr.png',
            name: 'Айс Кофе3',
            price: '130 руб'
        ),
        const CardModel(
            ico: 'lib/src/assets/images/rrr.png',
            name: 'Айс Кофе4',
            price: '140 руб'
        ),
        const CardModel(
            ico: 'lib/src/assets/images/rrr.png',
            name: 'Айс Кофе5',
            price: '150 руб'
        ),
      ];

  static List<String> category_strings_db_example = [
    'Черный кофе',
    'Кофе с молоком',
    'Чай',
    'НеКофе',
  ];

  static List<CategoryModel> category_db_example =
      [
        CategoryModel(
            title: 'Черный кофе',
            card: cards_db_example
        ),
        CategoryModel(
            title: 'Кофе с молоком',
            card: cards_db_example
        ),
        CategoryModel(
            title: 'Чай',
            card: cards_db_example
        ),
        CategoryModel(
            title: 'НеКофе',
            card: cards_db_example
        ),
      ];
}