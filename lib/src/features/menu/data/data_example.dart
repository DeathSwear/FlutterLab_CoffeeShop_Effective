import 'package:flutter_course/src/features/menu/models/card_model.dart';
import 'package:flutter_course/src/features/menu/models/category_model.dart';

// представим, что в процессе получения данных были созданы вот такие структуры данных
class DataExample{
  static List<CardModel> cards_db_example =
      [
        const CardModel(
            ico: 'lib/src/assets/images/example_image.png',
            name: 'Айс Кофе',
            price: '100 руб'
        ),
        const CardModel(
            ico: 'lib/src/assets/images/example_image.png',
            name: 'Айс Кофе2',
            price: '120 руб'
        ),
        const CardModel(
            ico: 'lib/src/assets/images/example_image.png',
            name: 'Айс Кофе3',
            price: '130 руб'
        ),
        const CardModel(
            ico: 'lib/src/assets/images/example_image.png',
            name: 'Айс Кофе4',
            price: '140 руб'
        ),
        const CardModel(
            ico: 'lib/src/assets/images/example_image.png',
            name: 'Айс Кофе5',
            price: '150 руб'
        ),
      ];

  static List<String> category_strings_db_example = [
    'Черный кофе',
    'Кофе с молоком',
    'Чай',
    'НеКофе',
    'Чай с молоком',
    'Молочные коктейли',
    'Эклеры',
    'Печенье',
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
        CategoryModel(
            title: 'Чай с молоком',
            card: cards_db_example
        ),
        CategoryModel(
            title: 'Молочные коктейли',
            card: cards_db_example
        ),
        CategoryModel(
            title: 'Эклеры',
            card: cards_db_example
        ),
        CategoryModel(
            title: 'Печенье',
            card: cards_db_example
        ),
      ];
}