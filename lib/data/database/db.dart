import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  // ignore: unused_field
  static Database? _database;

  Future get database async {
    // ignore: unnecessary_null_comparison, recursive_getters
    if (database != null) return database;

    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), "burguerorders.db"),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_burguer);
    await db.execute(_order);
    await db.execute(_orderBurguer);
  }

  String get _burguer => '''
    CREATE TABLE burguer (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      ingredients TEXT,
      price REAL
    );
  ''';

  String get _order => '''
    CREATE TABLE order (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      data DATE
    );
  ''';

  String get _orderBurguer => '''
    CREATE TABLE order_burguer (
      burguer_id INTEGER FOREIGN KEY,
      order_id INTEGER FOREIGN KEY,
      amount INTEGER
    );
  ''';
}
