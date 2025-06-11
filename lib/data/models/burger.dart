class Burger {
  int? id;
  final String name;
  final String ingredients;
  final double price;

  Burger({
    this.id,
    required this.name,
    required this.ingredients,
    required this.price,
  });

  Map<String, Object?> toMap() => {
    "id": id,
    "name": name,
    "ingredients": ingredients,
    "price": price,
  };

  @override
  String toString() =>
      "Burger{id: $id, name: $name, ingredients: $ingredients, price: $price}";
}
