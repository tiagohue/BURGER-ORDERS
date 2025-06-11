import 'package:burger_orders/data/database/db.dart';
import 'package:burger_orders/data/models/order.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class OrderRepository extends ChangeNotifier {
  late Database db;
  List<Order> orders = [];

  OrderRepository() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    db = await DB.instance.database;
    for (Map<String, Object?> row in await db.query("orders")) {
      orders.add(
        Order(
          id: row["id"] as int,
          date: row["date"] as String,
          customerName: row["customer_name"] as String,
        ),
      );
    }

    notifyListeners();
  }

  Future create(Order order) async {
    int id = await db.insert(
      "orders",
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    order.id = id;

    orders.add(order);

    notifyListeners();
  }

  Future retrieve(int id) async {
    List<Map<String, Object?>> orderMaps = await db.query(
      "order",
      where: "id = ?",
      whereArgs: [id],
    );

    return [
      for (final {
            "id": id as int,
            "date": date as String,
            "customer_name": customerName as String,
          }
          in orderMaps)
        Order(id: id, date: date, customerName: customerName),
    ];
  }

  List<Order> retrieveAll() => orders;

  Future update(Order order) async {
    await db.update(
      "orders",
      order.toMap(),
      where: "id = ?",
      whereArgs: [order.id],
    );

    final index = orders.indexWhere((b) => b.id == order.id);
    orders[index] = order;

    notifyListeners();
  }

  Future delete(int id) async {
    await db.delete("orders", where: "id = ?", whereArgs: [id]);

    orders.removeWhere((order) => order.id == id);

    notifyListeners();
  }
}
