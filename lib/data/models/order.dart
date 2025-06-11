class Order {
  int? id;
  final String date;
  final String customerName;
  final List<OrderBurger> orderBurgers;

  Order({
    this.id,
    required this.date,
    required this.customerName,
    this.orderBurgers = const [],
  });

  Map<String, Object?> toMap() => {
    "id": id,
    "date": date,
    "customer_name": customerName,
  };

  @override
  String toString() =>
      "Order{id: $id, date: $date, customer_name: $customerName}";
}

class OrderBurger {
  final int burgerId;
  final int quantity;

  OrderBurger({required this.burgerId, required this.quantity});
}
