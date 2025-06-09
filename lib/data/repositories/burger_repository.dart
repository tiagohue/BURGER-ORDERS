import 'package:burger_orders/data/database/db.dart';
import 'package:burger_orders/data/models/burger.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BurgerRepository extends ChangeNotifier {
  late Database db;
  List<Burger> burgers = [];

  BurgerRepository() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    db = await DB.instance.database;
    for (Map<String, Object?> row in await db.query("burgers")) {
      burgers.add(
        Burger(
          id: row["id"] as int,
          name: row["name"] as String,
          ingredients: row["ingredients"] as String,
          price: row["price"] as double,
        ),
      );
    }

    notifyListeners();
  }

  Future create(Burger burger) async {
    await db.insert(
      "burgers",
      burger.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    notifyListeners();
  }

  Future retrieve(int id) async {
    List<Map<String, Object?>> burgerMaps = await db.query(
      "burger",
      where: "id = ?",
      whereArgs: [id],
    );

    return [
      for (final {
            "id": id as int,
            "name": name as String,
            "ingredients": ingredients as String,
            "price": price as double,
          }
          in burgerMaps)
        Burger(id: id, name: name, ingredients: ingredients, price: price),
    ];
  }

  List<Burger> retrieveAll() => burgers;

  Future update(Burger burger) async {
    await db.update(
      "burgers",
      burger.toMap(),
      where: "id = ?",
      whereArgs: [burger.id],
    );

    notifyListeners();
  }

  Future delete(int id) async {
    await db.delete("burgers", where: "id = ?", whereArgs: [id]);

    notifyListeners();
  }
}
