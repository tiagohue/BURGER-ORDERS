import 'dart:ffi';

import 'package:app_de_pedidos_de_hamburguer/data/burguer.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class BurguerRepository {
  Future<Database> database;

  BurguerRepository({required this.database});

  Future create(Burguer burguer) async {
    Database db = await database;

    await db.insert(
      "burguers",
      burguer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future retrieve(int id) async {
    Database db = await database;

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

  Future retrieveAll() async {
    Database db = await database;

    final List<Map<String, Object?>> burguerMaps = await db.query("burguers");

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

  Future update(Burguer burguer) async {
    Database db = await database;

    await db.update(
      "burguers",
      burguer.toMap(),
      where: "id = ?",
      whereArgs: [burguer.id],
    );
  }

  Future delete(int id) async {
    Database db = await database;

    await db.delete("burguers", where: "id = ?", whereArgs: [id]);
  }
}
