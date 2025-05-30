import 'package:app_de_pedidos_de_hamburguer/ui/pages/home_page.dart';
import 'package:app_de_pedidos_de_hamburguer/ui/widgets/current_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
