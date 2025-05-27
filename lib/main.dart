import 'package:app_de_pedidos_de_hamburguer/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.red,
          onSecondary: Colors.red,
          error: Colors.red,
          onError: Colors.red,
          surface: const Color.fromARGB(255, 255, 226, 147),
          onSurface: Colors.red,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: "NewRocker",
            fontSize: 50,
            color: Colors.black,
            height: 0.8,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
