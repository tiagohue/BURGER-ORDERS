import 'package:app_de_pedidos_de_hamburguer/components/standard_button.dart';
import 'package:app_de_pedidos_de_hamburguer/pages/burguers_page.dart';
import 'package:app_de_pedidos_de_hamburguer/pages/orders_page.dart';
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
          children: [
            Spacer(flex: 2),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/images/burguer_logo.png", scale: 1.75),
                  Column(
                    children: [
                      Text("BURGUER\nORDERS", style: textTheme.titleLarge),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            StandardButton(
              text: "Burguers",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => BurguersPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            StandardButton(
              text: "Orders",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => OrdersPage(),
                  ),
                );
              },
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
