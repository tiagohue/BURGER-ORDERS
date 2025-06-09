import 'package:app_de_pedidos_de_hamburguer/data/database/db.dart';
import 'package:app_de_pedidos_de_hamburguer/data/models/burguer.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BurguerRepository extends ChangeNotifier {
  late Database db;
  List<Burguer> burguers = [];

  BurguerRepository() {
    _initRepository();
  }

  Future<void> _initRepository() async {
    db = await DB.instance.database;
    for (Map<String, Object?> row in await db.query("burguers")) {
      burguers.add(
        Burguer(
          id: row["id"] as int,
          name: row["name"] as String,
          ingredients: row["ingredients"] as String,
          price: row["price"] as double,
        ),
      );
    }

    notifyListeners();
  }

  Future create(Burguer burguer) async {
    await db.insert(
      "burguers",
      burguer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    notifyListeners();
  }

  Future retrieve(int id) async {
    List<Map<String, Object?>> burguerMaps = await db.query(
      "burguer",
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
          in burguerMaps)
        Burguer(id: id, name: name, ingredients: ingredients, price: price),
    ];
  }

  List<Burguer> retrieveAll() => burguers;

  Future update(Burguer burguer) async {
    await db.update(
      "burguers",
      burguer.toMap(),
      where: "id = ?",
      whereArgs: [burguer.id],
    );

    notifyListeners();
  }

  Future delete(int id) async {
    await db.delete("burguers", where: "id = ?", whereArgs: [id]);

    notifyListeners();
  }
}
