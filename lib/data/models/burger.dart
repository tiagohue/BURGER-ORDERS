class Burger {
  final int id;
  final String name;
  final String ingredients;
  final double price;

  const Burger({
    required this.id,
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
