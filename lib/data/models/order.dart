class Order {
  int? id;
  final String date;
  final String customerName;

  Order({this.id, required this.date, required this.customerName});

  Map<String, Object?> toMap() => {
    "id": id,
    "date": date,
    "customer_name": customerName,
  };

  @override
  String toString() =>
      "Order{id: $id, date: $date, customer_name: $customerName}";
}
