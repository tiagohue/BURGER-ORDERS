import 'package:app_de_pedidos_de_hamburguer/ui/pages/home_page.dart';
import 'package:app_de_pedidos_de_hamburguer/ui/widgets/current_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), "lib/data/burguers.db"),
    onCreate: (db, version) => db.execute(
      "CREATE TABLE burguers(id INTEGER PRIMARY KEY, name TEXT, ingredients TEXT, price REAL)",
    ),
    version: 1,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentColorScheme(),
      child: Consumer<CurrentColorScheme>(
        builder:
            (BuildContext context, CurrentColorScheme value, Widget? child) =>
                MaterialApp(
                  theme: ThemeData(
                    colorScheme: value.current,
                    textTheme: TextTheme(
                      titleLarge: TextStyle(
                        fontFamily: "NewRocker",
                        fontSize: 50,
                        height: 0.8,
                      ),
                    ),
                  ),
                  home: const HomePage(),
                ),
      ),
    );
  }
}
