class CardModel{
  const CardModel({
    required this.id,
    required this.ico,
    required this.name,
    required this.description,
    required this.price
  });

  final int id;
  final String ico;
  final String name;
  final String description;
  final String price;
}