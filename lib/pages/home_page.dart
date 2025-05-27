import 'package:app_de_pedidos_de_hamburguer/components/standard_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("lib/images/burguer_logo.png", scale: 1.5),
                Column(
                  children: [
                    Text("BURGUER", style: textTheme.titleLarge),
                    Text("ORDERS", style: textTheme.titleLarge),
                  ],
                ),
              ],
            ),
            StandardButton(text: "Burguers"),
            StandardButton(text: "Orders"),
          ],
        ),
      ),
    );
  }
}
