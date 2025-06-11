import 'package:burger_orders/data/repositories/burger_repository.dart';
import 'package:burger_orders/data/repositories/order_repository.dart';
import 'package:burger_orders/providers/order_update_provider.dart';
import 'package:burger_orders/ui/pages/home_page.dart';
import 'package:burger_orders/providers/color_scheme_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ColorSchemeProvider()),
        ChangeNotifierProvider(create: (context) => BurgerRepository()),
        ChangeNotifierProvider(create: (context) => OrderRepository()),
        ChangeNotifierProvider(create: (context) => OrderUpdateProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSchemeProvider>(
      builder: (context, value, child) => MaterialApp(
        theme: ThemeData(
          fontFamily: "NewRocker",
          colorScheme: value.current,
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontFamily: "NewRocker",
              fontSize: 50,
              height: 0.8,
            ),
            titleMedium: TextStyle(fontFamily: "NewRocker", fontSize: 30),
            titleSmall: TextStyle(fontFamily: "NewRocker", fontSize: 15),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
